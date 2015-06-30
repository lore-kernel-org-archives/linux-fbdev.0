From: "K. Y. Srinivasan" <kys@microsoft.com>
Date: Tue, 30 Jun 2015 21:12:05 +0000
Subject: [PATCH 1/2] drivers:hv: Modify hv_vmbus to search for all MMIO ranges available.
Message-Id: <1435703702-23525-1-git-send-email-kys@microsoft.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1435703668-23486-1-git-send-email-kys@microsoft.com>
In-Reply-To: <1435703668-23486-1-git-send-email-kys@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com, vkuznets@redhat.com, jasowang@redhat.com, hdegoede@redhat.com, linux-fbdev@vger.kernel.org, haiyangz@microsoft.com
Cc: "jakeo@microsoft.com" <jakeo@microsoft.com>, "K. Y. Srinivasan" <kys@microsoft.com>

From: jakeo@microsoft.com <jakeo@microsoft.com>

This patch changes the logic in hv_vmbus to record all of the ranges in the
VM's firmware (BIOS or UEFI) that offer regions of memory-mapped I/O space for
use by paravirtual front-end drivers.  The old logic just found one range
above 4GB and called it good.  This logic will find any ranges above 1MB.

It would have been possible with this patch to just use existing resource
allocation functions, rather than keep track of the entire set of Hyper-V
related MMIO regions in VMBus.  This strategy, however, is not sufficient
when the resource allocator needs to be aware of the constraints of a
Hyper-V virtual machine, which is what happens in the next patch in the series.
So this first patch exists to show the first steps in reworking the MMIO
allocation paths for Hyper-V front-end drivers.

Signed-off-by: Jake Oshins <jakeo@microsoft.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---
 drivers/hv/vmbus_drv.c          |  116 ++++++++++++++++++++++++++++++---------
 drivers/video/fbdev/hyperv_fb.c |    2 +-
 include/linux/hyperv.h          |    2 +-
 3 files changed, 92 insertions(+), 28 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index b6114cc..21bb287 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -102,10 +102,7 @@ static struct notifier_block hyperv_panic_block = {
 	.notifier_call = hyperv_panic_event,
 };
 
-struct resource hyperv_mmio = {
-	.name  = "hyperv mmio",
-	.flags = IORESOURCE_MEM,
-};
+struct resource *hyperv_mmio;
 EXPORT_SYMBOL_GPL(hyperv_mmio);
 
 static int vmbus_exists(void)
@@ -1013,30 +1010,105 @@ void vmbus_device_unregister(struct hv_device *device_obj)
 
 
 /*
- * VMBUS is an acpi enumerated device. Get the the information we
+ * VMBUS is an acpi enumerated device. Get the information we
  * need from DSDT.
  */
-
+#define VTPM_BASE_ADDRESS 0xfed40000
 static acpi_status vmbus_walk_resources(struct acpi_resource *res, void *ctx)
 {
+	resource_size_t start = 0;
+	resource_size_t end = 0;
+	struct resource *new_res;
+	struct resource **old_res = &hyperv_mmio;
+	struct resource **prev_res = NULL;
+
 	switch (res->type) {
 	case ACPI_RESOURCE_TYPE_IRQ:
 		irq = res->data.irq.interrupts[0];
+		return AE_OK;
+
+	/*
+	 * "Address" descriptors are for bus windows. Ignore
+	 * "memory" descriptors, which are for registers on
+	 * devices.
+	 */
+	case ACPI_RESOURCE_TYPE_ADDRESS32:
+		start = res->data.address32.address.minimum;
+		end = res->data.address32.address.maximum;
 		break;
 
 	case ACPI_RESOURCE_TYPE_ADDRESS64:
-		hyperv_mmio.start = res->data.address64.address.minimum;
-		hyperv_mmio.end = res->data.address64.address.maximum;
+		start = res->data.address64.address.minimum;
+		end = res->data.address64.address.maximum;
 		break;
+
+	default:
+		/* Unused resource type */
+		return AE_OK;
+
 	}
+	/*
+	 * Ignore ranges that are below 1MB, as they're not
+	 * necessary or useful here.
+	 */
+	if (end < 0x100000)
+		return AE_OK;
+
+	new_res = kzalloc(sizeof(*new_res), GFP_ATOMIC);
+	if (!new_res)
+		return AE_NO_MEMORY;
+
+	/* If this range overlaps the virtual TPM, truncate it. */
+	if (end > VTPM_BASE_ADDRESS && start < VTPM_BASE_ADDRESS)
+		end = VTPM_BASE_ADDRESS;
+
+	new_res->name = "hyperv mmio";
+	new_res->flags = IORESOURCE_MEM;
+	new_res->start = start;
+	new_res->end = end;
+
+	do {
+		if (!*old_res) {
+			*old_res = new_res;
+			break;
+		}
+
+		if ((*old_res)->end < new_res->start) {
+			new_res->sibling = *old_res;
+			if (prev_res)
+				(*prev_res)->sibling = new_res;
+			*old_res = new_res;
+			break;
+		}
+
+		prev_res = old_res;
+		old_res = &(*old_res)->sibling;
+
+	} while (1);
 
 	return AE_OK;
 }
 
+static int vmbus_acpi_remove(struct acpi_device *device)
+{
+	struct resource *cur_res;
+	struct resource *next_res;
+
+	if (hyperv_mmio) {
+		for (cur_res = hyperv_mmio; cur_res; cur_res = next_res) {
+			next_res = cur_res->sibling;
+			kfree(cur_res);
+		}
+	}
+
+	return 0;
+}
+
 static int vmbus_acpi_add(struct acpi_device *device)
 {
 	acpi_status result;
 	int ret_val = -ENODEV;
+	struct acpi_device *ancestor;
 
 	hv_acpi_dev = device;
 
@@ -1046,35 +1118,27 @@ static int vmbus_acpi_add(struct acpi_device *device)
 	if (ACPI_FAILURE(result))
 		goto acpi_walk_err;
 	/*
-	 * The parent of the vmbus acpi device (Gen2 firmware) is the VMOD that
-	 * has the mmio ranges. Get that.
+	 * Some ancestor of the vmbus acpi device (Gen1 or Gen2
+	 * firmware) is the VMOD that has the mmio ranges. Get that.
 	 */
-	if (device->parent) {
-		result = acpi_walk_resources(device->parent->handle,
-					METHOD_NAME__CRS,
-					vmbus_walk_resources, NULL);
+	for (ancestor = device->parent; ancestor; ancestor = ancestor->parent) {
+		result = acpi_walk_resources(ancestor->handle, METHOD_NAME__CRS,
+					     vmbus_walk_resources, NULL);
 
 		if (ACPI_FAILURE(result))
-			goto acpi_walk_err;
-		if (hyperv_mmio.start && hyperv_mmio.end)
-			request_resource(&iomem_resource, &hyperv_mmio);
+			continue;
+		if (hyperv_mmio)
+			break;
 	}
 	ret_val = 0;
 
 acpi_walk_err:
 	complete(&probe_event);
+	if (ret_val)
+		vmbus_acpi_remove(device);
 	return ret_val;
 }
 
-static int vmbus_acpi_remove(struct acpi_device *device)
-{
-	int ret = 0;
-
-	if (hyperv_mmio.start && hyperv_mmio.end)
-		ret = release_resource(&hyperv_mmio);
-	return ret;
-}
-
 static const struct acpi_device_id vmbus_acpi_device_ids[] = {
 	{"VMBUS", 0},
 	{"VMBus", 0},
diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv_fb.c
index 807ee22..b54ee1c 100644
--- a/drivers/video/fbdev/hyperv_fb.c
+++ b/drivers/video/fbdev/hyperv_fb.c
@@ -688,7 +688,7 @@ static int hvfb_getmem(struct fb_info *info)
 	par->mem.name = KBUILD_MODNAME;
 	par->mem.flags = IORESOURCE_MEM | IORESOURCE_BUSY;
 	if (gen2vm) {
-		ret = allocate_resource(&hyperv_mmio, &par->mem,
+		ret = allocate_resource(hyperv_mmio, &par->mem,
 					screen_fb_size,
 					0, -1,
 					screen_fb_size,
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 30d3a1f..217e14b 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -1233,7 +1233,7 @@ extern bool vmbus_prep_negotiate_resp(struct icmsg_hdr *,
 
 void hv_process_channel_removal(struct vmbus_channel *channel, u32 relid);
 
-extern struct resource hyperv_mmio;
+extern struct resource *hyperv_mmio;
 
 /*
  * Negotiated version with the Host.
-- 
1.7.4.1

