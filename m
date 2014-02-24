From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 24 Feb 2014 13:17:09 +0000
Subject: [PATCH v3 2/4] vmbus: use resource for hyperv mmio region
Message-Id: <1393247831-5271-3-git-send-email-kraxel@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1393247831-5271-1-git-send-email-kraxel@redhat.com>
In-Reply-To: <1393247831-5271-1-git-send-email-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, kys@microsoft.com, abgupta@microsoft.com, haiyangz@microsoft.com, jasowang@redhat.com, tomi.valkeinen@ti.com, devel@linuxdriverproject.org, Gerd Hoffmann <kraxel@redhat.com>

Use a resource for the hyperv mmio region instead of start/size
variables.  Register the region properly so it shows up in
/proc/iomem.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/hv/vmbus_drv.c | 16 ++++++++++------
 include/linux/hyperv.h |  3 +--
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 2352ae48..a14f603 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -43,10 +43,12 @@ static struct acpi_device  *hv_acpi_dev;
 static struct tasklet_struct msg_dpc;
 static struct completion probe_event;
 static int irq;
-u64 hyperv_mmio_start;
-EXPORT_SYMBOL_GPL(hyperv_mmio_start);
-u64 hyperv_mmio_size;
-EXPORT_SYMBOL_GPL(hyperv_mmio_size);
+
+struct resource hyperv_mmio = {
+	.name  = "hyperv mmio",
+	.flags = IORESOURCE_MEM,
+};
+EXPORT_SYMBOL_GPL(hyperv_mmio);
 
 static int vmbus_exists(void)
 {
@@ -902,8 +904,8 @@ static acpi_status vmbus_walk_resources(struct acpi_resource *res, void *ctx)
 		break;
 
 	case ACPI_RESOURCE_TYPE_ADDRESS64:
-		hyperv_mmio_start = res->data.address64.minimum;
-		hyperv_mmio_size = res->data.address64.address_length;
+		hyperv_mmio.start = res->data.address64.minimum;
+		hyperv_mmio.end = res->data.address64.maximum;
 		break;
 	}
 
@@ -933,6 +935,8 @@ static int vmbus_acpi_add(struct acpi_device *device)
 
 		if (ACPI_FAILURE(result))
 			goto acpi_walk_err;
+		if (hyperv_mmio.start && hyperv_mmio.end)
+			request_resource(&iomem_resource, &hyperv_mmio);
 	}
 	ret_val = 0;
 
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index be3028f..c93e342 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -1459,8 +1459,7 @@ int hv_vss_init(struct hv_util_service *);
 void hv_vss_deinit(void);
 void hv_vss_onchannelcallback(void *);
 
-extern u64 hyperv_mmio_start;
-extern u64 hyperv_mmio_size;
+extern struct resource hyperv_mmio;
 
 /*
  * Negotiated version with the Host.
-- 
1.8.3.1

