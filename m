From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Fri, 22 Jun 2018 07:52:50 +0000
Subject: [PATCH v2 2/2] fbdev/efifb: honour UEFI memory map attributes when mapping the fb
Message-Id: <20180622075250.14075-3-ard.biesheuvel@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

If the framebuffer address provided by the Graphics Output Protocol
(GOP) is covered by the UEFI memory map, it will tell us which memory
attributes are permitted when mapping this region. In some cases,
(KVM guest on ARM), violating this will result in loss of coherency,
which means that updates sent to the framebuffer by the guest will
not be observeable by the host, and the emulated display simply does
not work.

So if the memory map contains such a description, take the attributes
field into account, and add support for creating WT or WB mappings of
the framebuffer region.

Cc: linux-fbdev@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Peter Jones <pjones@redhat.com>
Tested-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/video/fbdev/efifb.c | 52 ++++++++++++++++----
 1 file changed, 42 insertions(+), 10 deletions(-)

diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
index 46a4484e3da7..d5e0a74e6124 100644
--- a/drivers/video/fbdev/efifb.c
+++ b/drivers/video/fbdev/efifb.c
@@ -20,7 +20,7 @@
 #include <drm/drm_connector.h>  /* For DRM_MODE_PANEL_ORIENTATION_* */
 
 static bool request_mem_succeeded = false;
-static bool nowc = false;
+static u64 mem_flags = EFI_MEMORY_WC | EFI_MEMORY_UC;
 
 static struct fb_var_screeninfo efifb_defined = {
 	.activate		= FB_ACTIVATE_NOW,
@@ -68,8 +68,12 @@ static int efifb_setcolreg(unsigned regno, unsigned red, unsigned green,
 
 static void efifb_destroy(struct fb_info *info)
 {
-	if (info->screen_base)
-		iounmap(info->screen_base);
+	if (info->screen_base) {
+		if (mem_flags & (EFI_MEMORY_WT | EFI_MEMORY_WB))
+			memunmap(info->screen_base);
+		else
+			iounmap(info->screen_base);
+	}
 	if (request_mem_succeeded)
 		release_mem_region(info->apertures->ranges[0].base,
 				   info->apertures->ranges[0].size);
@@ -104,7 +108,7 @@ static int efifb_setup(char *options)
 			else if (!strncmp(this_opt, "width:", 6))
 				screen_info.lfb_width = simple_strtoul(this_opt+6, NULL, 0);
 			else if (!strcmp(this_opt, "nowc"))
-				nowc = true;
+				mem_flags &= ~EFI_MEMORY_WC;
 		}
 	}
 
@@ -164,6 +168,8 @@ static int efifb_probe(struct platform_device *dev)
 	unsigned int size_remap;
 	unsigned int size_total;
 	char *option = NULL;
+	efi_memory_desc_t md;
+
 
 	if (screen_info.orig_video_isVGA != VIDEO_TYPE_EFI || pci_dev_disabled)
 		return -ENODEV;
@@ -272,12 +278,35 @@ static int efifb_probe(struct platform_device *dev)
 	info->apertures->ranges[0].base = efifb_fix.smem_start;
 	info->apertures->ranges[0].size = size_remap;
 
-	if (nowc)
-		info->screen_base = ioremap(efifb_fix.smem_start, efifb_fix.smem_len);
-	else
-		info->screen_base = ioremap_wc(efifb_fix.smem_start, efifb_fix.smem_len);
+	if (!efi_mem_desc_lookup(efifb_fix.smem_start, &md)) {
+		if ((efifb_fix.smem_start + efifb_fix.smem_len) >
+		    (md.phys_addr + (md.num_pages << EFI_PAGE_SHIFT))) {
+			pr_err("efifb: video memory @ 0x%lx spans multiple EFI memory regions\n",
+			       efifb_fix.smem_start);
+			err = -EIO;
+			goto err_release_fb;
+		}
+		/*
+		 * If the UEFI memory map covers the efifb region, we may only
+		 * remap it using the attributes the memory map prescribes.
+		 */
+		mem_flags |= EFI_MEMORY_WT | EFI_MEMORY_WB;
+		mem_flags &= md.attribute;
+	}
+	if (mem_flags & EFI_MEMORY_WC)
+		info->screen_base = ioremap_wc(efifb_fix.smem_start,
+					       efifb_fix.smem_len);
+	else if (mem_flags & EFI_MEMORY_UC)
+		info->screen_base = ioremap(efifb_fix.smem_start,
+					    efifb_fix.smem_len);
+	else if (mem_flags & EFI_MEMORY_WT)
+		info->screen_base = memremap(efifb_fix.smem_start,
+					     efifb_fix.smem_len, MEMREMAP_WT);
+	else if (mem_flags & EFI_MEMORY_WB)
+		info->screen_base = memremap(efifb_fix.smem_start,
+					     efifb_fix.smem_len, MEMREMAP_WB);
 	if (!info->screen_base) {
-		pr_err("efifb: abort, cannot ioremap video memory 0x%x @ 0x%lx\n",
+		pr_err("efifb: abort, cannot remap video memory 0x%x @ 0x%lx\n",
 			efifb_fix.smem_len, efifb_fix.smem_start);
 		err = -EIO;
 		goto err_release_fb;
@@ -371,7 +400,10 @@ static int efifb_probe(struct platform_device *dev)
 err_groups:
 	sysfs_remove_groups(&dev->dev.kobj, efifb_groups);
 err_unmap:
-	iounmap(info->screen_base);
+	if (mem_flags & (EFI_MEMORY_WT | EFI_MEMORY_WB))
+		memunmap(info->screen_base);
+	else
+		iounmap(info->screen_base);
 err_release_fb:
 	framebuffer_release(info);
 err_release_mem:
-- 
2.17.1

