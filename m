From: Wei Hu <weh@microsoft.com>
Date: Tue, 22 Oct 2019 11:10:39 +0000
Subject: [PATCH] video: hyperv: hyperv_fb: Use physical memory for fb on HyperV Gen 1 VMs.
Message-Id: <20191022110905.4032-1-weh@microsoft.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "b.zolnierkie@samsung.com" <b.zolnierkie@samsung.com>, KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, "sashal@kernel.org" <sashal@kernel.org>, "hch@lst.de" <hch@lst.de>, "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>, "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>, "sam@ravnborg.org" <sam@ravnborg.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>, "info@metux.net" <info@metux.net>, "arnd@arndb.de" <arnd@arndb.de>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, linux-kernel@vger.k
Cc: Wei Hu <weh@microsoft.com>

On Hyper-V, Generation 1 VMs can directly use VM's physical memory for
their framebuffers. This can improve the efficiency of framebuffer and
overall performence for VM. The physical memory assigned to framebuffer
must be contiguous. We use CMA allocator to get contiguouse physicial
memory when the framebuffer size is greater than 4MB. For size under
4MB, we use alloc_pages to achieve this.

To enable framebuffer memory allocation from CMA, supply a kernel
parameter to give enough space to CMA allocator at boot time. For
example:
    cma=130m
This gives 130MB memory to CAM allocator that can be allocated to
framebuffer. If this fails, we fall back to the old way of using
mmio for framebuffer.

Signed-off-by: Wei Hu <weh@microsoft.com>
---
 drivers/video/fbdev/Kconfig     |   1 +
 drivers/video/fbdev/hyperv_fb.c | 179 +++++++++++++++++++++++++-------
 kernel/dma/contiguous.c         |   2 +
 3 files changed, 147 insertions(+), 35 deletions(-)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index aa9541bf964b..f534059461ee 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -2215,6 +2215,7 @@ config FB_HYPERV
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
 	select FB_DEFERRED_IO
+	select DMA_CMA
 	help
 	  This framebuffer driver supports Microsoft Hyper-V Synthetic Video.
 
diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv_fb.c
index 3f60b7bc8589..ea2fd3481225 100644
--- a/drivers/video/fbdev/hyperv_fb.c
+++ b/drivers/video/fbdev/hyperv_fb.c
@@ -31,6 +31,16 @@
  * "set-vmvideo" command. For example
  *     set-vmvideo -vmname name -horizontalresolution:1920 \
  * -verticalresolution:1200 -resolutiontype single
+ *
+ * Gen 1 VMs also support directly using VM's phyiscal memory for framebuffer.
+ * It could improve the efficiency and performance for framebuffer and VM.
+ * This requires to allocate contiguous physical memory from Linux kernel's
+ * CMA memory allocator. To enable this, supply a kernel parameter to give
+ * enough memory space to CMA allocator for framebuffer. For example:
+ *    cma=130m
+ * This gives 130MB memory to CMA allocator that can be allocated to
+ * framebuffer. For reference, 8K resolution (7680x4320) takes about
+ * 127MB memory.
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
@@ -42,6 +52,7 @@
 #include <linux/fb.h>
 #include <linux/pci.h>
 #include <linux/efi.h>
+#include <linux/dma-contiguous.h>
 
 #include <linux/hyperv.h>
 
@@ -227,7 +238,6 @@ struct synthvid_msg {
 } __packed;
 
 
-
 /* FB driver definitions and structures */
 #define HVFB_WIDTH 1152 /* default screen width */
 #define HVFB_HEIGHT 864 /* default screen height */
@@ -256,6 +266,9 @@ struct hvfb_par {
 	/* If true, the VSC notifies the VSP on every framebuffer change */
 	bool synchronous_fb;
 
+	/* If true, need to copy from deferred IO mem to framebuffer mem */
+	bool need_docopy;
+
 	struct notifier_block hvfb_panic_nb;
 
 	/* Memory for deferred IO and frame buffer itself */
@@ -432,7 +445,7 @@ static void synthvid_deferred_io(struct fb_info *p,
 		maxy = max_t(int, maxy, y2);
 
 		/* Copy from dio space to mmio address */
-		if (par->fb_ready)
+		if (par->fb_ready && par->need_docopy)
 			hvfb_docopy(par, start, PAGE_SIZE);
 	}
 
@@ -749,12 +762,12 @@ static void hvfb_update_work(struct work_struct *w)
 		return;
 
 	/* Copy the dirty rectangle to frame buffer memory */
-	for (j = y1; j < y2; j++) {
-		hvfb_docopy(par,
-			    j * info->fix.line_length +
-			    (x1 * screen_depth / 8),
-			    (x2 - x1) * screen_depth / 8);
-	}
+	if (par->need_docopy)
+		for (j = y1; j < y2; j++)
+			hvfb_docopy(par,
+				    j * info->fix.line_length +
+				    (x1 * screen_depth / 8),
+				    (x2 - x1) * screen_depth / 8);
 
 	/* Refresh */
 	if (par->fb_ready && par->update)
@@ -799,7 +812,8 @@ static int hvfb_on_panic(struct notifier_block *nb,
 	par = container_of(nb, struct hvfb_par, hvfb_panic_nb);
 	par->synchronous_fb = true;
 	info = par->info;
-	hvfb_docopy(par, 0, dio_fb_size);
+	if (par->need_docopy)
+		hvfb_docopy(par, 0, dio_fb_size);
 	synthvid_update(info, 0, 0, INT_MAX, INT_MAX);
 
 	return NOTIFY_DONE;
@@ -938,6 +952,62 @@ static void hvfb_get_option(struct fb_info *info)
 	return;
 }
 
+/*
+ * Allocate enough contiguous physical memory.
+ * Return physical address if succeeded or -1 if failed.
+ */
+static unsigned long hvfb_get_phymem(unsigned int request_size)
+{
+	struct page *page = NULL;
+	unsigned int request_pages;
+	unsigned long paddr = 0;
+	unsigned int order = get_order(request_size);
+
+	if (request_size == 0)
+		return -1;
+
+	/* Try call alloc_pages if the size is less than 2^MAX_ORDER */
+	if (order < MAX_ORDER) {
+		page = alloc_pages(GFP_KERNEL | __GFP_ZERO, order);
+		if (!page)
+			return -1;
+
+		request_pages = (1 << order);
+		goto get_phymem1;
+	}
+
+	/* Allocate from CMA */
+	// request_pages = (request_size >> PAGE_SHIFT) + 1;
+	request_pages = (round_up(request_size, PAGE_SIZE) >> PAGE_SHIFT);
+	page = dma_alloc_from_contiguous(NULL, request_pages, 0, false);
+
+	if (page == NULL)
+		return -1;
+
+get_phymem1:
+	paddr = (page_to_pfn(page) << PAGE_SHIFT);
+
+	pr_info("Allocated %d pages starts at physical addr 0x%lx\n",
+		request_pages, paddr);
+
+	return paddr;
+}
+
+/* Release contiguous physical memory */
+static void hvfb_release_phymem(unsigned long paddr, unsigned int size)
+{
+	unsigned int order = get_order(size);
+
+	if (order < MAX_ORDER)
+		__free_pages(pfn_to_page(paddr >> PAGE_SHIFT), order);
+	else
+		dma_release_from_contiguous(NULL,
+					    pfn_to_page(paddr >> PAGE_SHIFT),
+					    (round_up(size, PAGE_SIZE) >>
+					     PAGE_SHIFT));
+					    // (size >> PAGE_SHIFT) + 1);
+}
+
 
 /* Get framebuffer memory from Hyper-V video pci space */
 static int hvfb_getmem(struct hv_device *hdev, struct fb_info *info)
@@ -947,8 +1017,58 @@ static int hvfb_getmem(struct hv_device *hdev, struct fb_info *info)
 	void __iomem *fb_virt;
 	int gen2vm = efi_enabled(EFI_BOOT);
 	resource_size_t pot_start, pot_end;
+	unsigned long paddr;
 	int ret;
 
+	if (!gen2vm) {
+		pdev = pci_get_device(PCI_VENDOR_ID_MICROSOFT,
+			PCI_DEVICE_ID_HYPERV_VIDEO, NULL);
+		if (!pdev) {
+			pr_err("Unable to find PCI Hyper-V video\n");
+			return -ENODEV;
+		}
+	}
+
+	info->apertures = alloc_apertures(1);
+	if (!info->apertures)
+		goto err1;
+
+	if (gen2vm) {
+		info->apertures->ranges[0].base = screen_info.lfb_base;
+		info->apertures->ranges[0].size = screen_info.lfb_size;
+	} else {
+		info->apertures->ranges[0].base = pci_resource_start(pdev, 0);
+		info->apertures->ranges[0].size = pci_resource_len(pdev, 0);
+	}
+
+	/*
+	 * For Gen 1 VM, we can directly use the contiguous memory
+	 * from VM. If we success, deferred IO happens directly
+	 * on this allocated framebuffer memory, avoiding extra
+	 * memory copy.
+	 */
+	if (!gen2vm) {
+		paddr = hvfb_get_phymem(screen_fb_size);
+		if (paddr != (unsigned long) -1) {
+			par->mmio_pp = paddr;
+			par->mmio_vp = par->dio_vp = __va(paddr);
+
+			info->fix.smem_start = paddr;
+			info->fix.smem_len = screen_fb_size;
+			info->screen_base = par->mmio_vp;
+			info->screen_size = screen_fb_size;
+
+			par->need_docopy = false;
+			goto getmem1;
+		} else {
+			pr_info("Unable to allocate enough contiguous physical memory on Gen 1 VM. Use MMIO instead.\n");
+		}
+	}
+
+	/*
+	 * Cannot use the contiguous physical memory.
+	 * Allocate mmio space for framebuffer.
+	 */
 	dio_fb_size =
 		screen_width * screen_height * screen_depth / 8;
 
@@ -956,13 +1076,6 @@ static int hvfb_getmem(struct hv_device *hdev, struct fb_info *info)
 		pot_start = 0;
 		pot_end = -1;
 	} else {
-		pdev = pci_get_device(PCI_VENDOR_ID_MICROSOFT,
-			      PCI_DEVICE_ID_HYPERV_VIDEO, NULL);
-		if (!pdev) {
-			pr_err("Unable to find PCI Hyper-V video\n");
-			return -ENODEV;
-		}
-
 		if (!(pci_resource_flags(pdev, 0) & IORESOURCE_MEM) ||
 		    pci_resource_len(pdev, 0) < screen_fb_size) {
 			pr_err("Resource not available or (0x%lx < 0x%lx)\n",
@@ -991,20 +1104,6 @@ static int hvfb_getmem(struct hv_device *hdev, struct fb_info *info)
 	if (par->dio_vp == NULL)
 		goto err3;
 
-	info->apertures = alloc_apertures(1);
-	if (!info->apertures)
-		goto err4;
-
-	if (gen2vm) {
-		info->apertures->ranges[0].base = screen_info.lfb_base;
-		info->apertures->ranges[0].size = screen_info.lfb_size;
-		remove_conflicting_framebuffers(info->apertures,
-						KBUILD_MODNAME, false);
-	} else {
-		info->apertures->ranges[0].base = pci_resource_start(pdev, 0);
-		info->apertures->ranges[0].size = pci_resource_len(pdev, 0);
-	}
-
 	/* Physical address of FB device */
 	par->mmio_pp = par->mem->start;
 	/* Virtual address of FB device */
@@ -1015,13 +1114,17 @@ static int hvfb_getmem(struct hv_device *hdev, struct fb_info *info)
 	info->screen_base = par->dio_vp;
 	info->screen_size = dio_fb_size;
 
+	par->need_docopy = true;
+
+getmem1:
+	remove_conflicting_framebuffers(info->apertures,
+					KBUILD_MODNAME, false);
+
 	if (!gen2vm)
 		pci_dev_put(pdev);
 
 	return 0;
 
-err4:
-	vfree(par->dio_vp);
 err3:
 	iounmap(fb_virt);
 err2:
@@ -1039,9 +1142,14 @@ static void hvfb_putmem(struct fb_info *info)
 {
 	struct hvfb_par *par = info->par;
 
-	vfree(par->dio_vp);
-	iounmap(info->screen_base);
-	vmbus_free_mmio(par->mem->start, screen_fb_size);
+	if (par->need_docopy) {
+		vfree(par->dio_vp);
+		iounmap(info->screen_base);
+		vmbus_free_mmio(par->mem->start, screen_fb_size);
+	} else {
+		hvfb_release_phymem(info->fix.smem_start, screen_fb_size);
+	}
+
 	par->mem = NULL;
 }
 
@@ -1060,6 +1168,7 @@ static int hvfb_probe(struct hv_device *hdev,
 	par = info->par;
 	par->info = info;
 	par->fb_ready = false;
+	par->need_docopy = false;
 	init_completion(&par->wait);
 	INIT_DELAYED_WORK(&par->dwork, hvfb_update_work);
 
diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 69cfb4345388..4553f4cca80e 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -197,6 +197,7 @@ struct page *dma_alloc_from_contiguous(struct device *dev, size_t count,
 
 	return cma_alloc(dev_get_cma_area(dev), count, align, no_warn);
 }
+EXPORT_SYMBOL(dma_alloc_from_contiguous);
 
 /**
  * dma_release_from_contiguous() - release allocated pages
@@ -213,6 +214,7 @@ bool dma_release_from_contiguous(struct device *dev, struct page *pages,
 {
 	return cma_release(dev_get_cma_area(dev), pages, count);
 }
+EXPORT_SYMBOL(dma_release_from_contiguous);
 
 /**
  * dma_alloc_contiguous() - allocate contiguous pages
-- 
2.20.1
