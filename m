From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Thu, 23 Apr 2015 13:50:16 +0000
Subject: [PATCH 1/2] staging: sm7xxfb: use framebuffer_alloc and release
Message-Id: <1429796297-11750-1-git-send-email-sudipm.mukherjee@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

use the standard framebuffer_alloc() and framebuffer_release() instead
of custom defined function. for making that change we had to change a
member of the private structure from a variable to pointer and had to
touch almost all places of the file. since fb was changed into a pointer
so all instance of "sfb->fb." has been changed into "sfb->fb->".
now we will get build warning about smtc_alloc_fb_info() and
smtc_free_fb_info() to be unused which will be removed in the next
patch of the series.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---

tested on hardware.

 drivers/staging/sm7xxfb/sm7xxfb.c | 208 ++++++++++++++++++++------------------
 1 file changed, 110 insertions(+), 98 deletions(-)

diff --git a/drivers/staging/sm7xxfb/sm7xxfb.c b/drivers/staging/sm7xxfb/sm7xxfb.c
index 77f51a0..27f339f 100644
--- a/drivers/staging/sm7xxfb/sm7xxfb.c
+++ b/drivers/staging/sm7xxfb/sm7xxfb.c
@@ -39,7 +39,7 @@
 */
 struct smtcfb_info {
 	struct pci_dev *pdev;
-	struct fb_info fb;
+	struct fb_info *fb;
 	u16 chip_id;
 	u8  chip_rev_id;
 
@@ -249,19 +249,20 @@ static int smtc_setcolreg(unsigned regno, unsigned red, unsigned green,
 	if (regno > 255)
 		return 1;
 
-	switch (sfb->fb.fix.visual) {
+	switch (sfb->fb->fix.visual) {
 	case FB_VISUAL_DIRECTCOLOR:
 	case FB_VISUAL_TRUECOLOR:
 		/*
 		 * 16/32 bit true-colour, use pseudo-palette for 16 base color
 		 */
 		if (regno < 16) {
-			if (sfb->fb.var.bits_per_pixel = 16) {
-				u32 *pal = sfb->fb.pseudo_palette;
+			if (sfb->fb->var.bits_per_pixel = 16) {
+				u32 *pal = sfb->fb->pseudo_palette;
 
-				val = chan_to_field(red, &sfb->fb.var.red);
-				val |= chan_to_field(green, &sfb->fb.var.green);
-				val |= chan_to_field(blue, &sfb->fb.var.blue);
+				val = chan_to_field(red, &sfb->fb->var.red);
+				val |= chan_to_field(green,
+						     &sfb->fb->var.green);
+				val |= chan_to_field(blue, &sfb->fb->var.blue);
 #ifdef __BIG_ENDIAN
 				pal[regno]  				    ((red & 0xf800) >> 8) |
@@ -272,11 +273,12 @@ static int smtc_setcolreg(unsigned regno, unsigned red, unsigned green,
 				pal[regno] = val;
 #endif
 			} else {
-				u32 *pal = sfb->fb.pseudo_palette;
+				u32 *pal = sfb->fb->pseudo_palette;
 
-				val = chan_to_field(red, &sfb->fb.var.red);
-				val |= chan_to_field(green, &sfb->fb.var.green);
-				val |= chan_to_field(blue, &sfb->fb.var.blue);
+				val = chan_to_field(red, &sfb->fb->var.red);
+				val |= chan_to_field(green,
+						     &sfb->fb->var.green);
+				val |= chan_to_field(blue, &sfb->fb->var.blue);
 #ifdef __BIG_ENDIAN
 				val  				    (val & 0xff00ff00 >> 8) |
@@ -472,13 +474,13 @@ static void sm7xx_set_timing(struct smtcfb_info *sfb)
 	u32 m_nscreenstride;
 
 	dev_dbg(&sfb->pdev->dev,
-		"sfb->width=%d sfb->height=%d sfb->fb.var.bits_per_pixel=%d sfb->hz=%d\n",
-		sfb->width, sfb->height, sfb->fb.var.bits_per_pixel, sfb->hz);
+		"sfb->width=%d sfb->height=%d sfb->fb->var.bits_per_pixel=%d sfb->hz=%d\n",
+		sfb->width, sfb->height, sfb->fb->var.bits_per_pixel, sfb->hz);
 
 	for (j = 0; j < numvgamodes; j++) {
 		if (vgamode[j].mmsizex = sfb->width &&
 		    vgamode[j].mmsizey = sfb->height &&
-		    vgamode[j].bpp = sfb->fb.var.bits_per_pixel &&
+		    vgamode[j].bpp = sfb->fb->var.bits_per_pixel &&
 		    vgamode[j].hz = sfb->hz) {
 			dev_dbg(&sfb->pdev->dev,
 				"vgamode[j].mmsizex=%d vgamode[j].mmSizeY=%d vgamode[j].bpp=%d vgamode[j].hz=%d\n",
@@ -551,8 +553,8 @@ static void sm7xx_set_timing(struct smtcfb_info *sfb)
 
 	/* set data width */
 	m_nscreenstride -		(sfb->width * sfb->fb.var.bits_per_pixel) / 64;
-	switch (sfb->fb.var.bits_per_pixel) {
+		(sfb->width * sfb->fb->var.bits_per_pixel) / 64;
+	switch (sfb->fb->var.bits_per_pixel) {
 	case 8:
 		writel(0x0, sfb->vp_regs + 0x0);
 		break;
@@ -583,52 +585,52 @@ static void smtc_set_timing(struct smtcfb_info *sfb)
 
 static void smtcfb_setmode(struct smtcfb_info *sfb)
 {
-	switch (sfb->fb.var.bits_per_pixel) {
+	switch (sfb->fb->var.bits_per_pixel) {
 	case 32:
-		sfb->fb.fix.visual       = FB_VISUAL_TRUECOLOR;
-		sfb->fb.fix.line_length  = sfb->fb.var.xres * 4;
-		sfb->fb.var.red.length   = 8;
-		sfb->fb.var.green.length = 8;
-		sfb->fb.var.blue.length  = 8;
-		sfb->fb.var.red.offset   = 16;
-		sfb->fb.var.green.offset = 8;
-		sfb->fb.var.blue.offset  = 0;
+		sfb->fb->fix.visual       = FB_VISUAL_TRUECOLOR;
+		sfb->fb->fix.line_length  = sfb->fb->var.xres * 4;
+		sfb->fb->var.red.length   = 8;
+		sfb->fb->var.green.length = 8;
+		sfb->fb->var.blue.length  = 8;
+		sfb->fb->var.red.offset   = 16;
+		sfb->fb->var.green.offset = 8;
+		sfb->fb->var.blue.offset  = 0;
 		break;
 	case 24:
-		sfb->fb.fix.visual       = FB_VISUAL_TRUECOLOR;
-		sfb->fb.fix.line_length  = sfb->fb.var.xres * 3;
-		sfb->fb.var.red.length   = 8;
-		sfb->fb.var.green.length = 8;
-		sfb->fb.var.blue.length  = 8;
-		sfb->fb.var.red.offset   = 16;
-		sfb->fb.var.green.offset = 8;
-		sfb->fb.var.blue.offset  = 0;
+		sfb->fb->fix.visual       = FB_VISUAL_TRUECOLOR;
+		sfb->fb->fix.line_length  = sfb->fb->var.xres * 3;
+		sfb->fb->var.red.length   = 8;
+		sfb->fb->var.green.length = 8;
+		sfb->fb->var.blue.length  = 8;
+		sfb->fb->var.red.offset   = 16;
+		sfb->fb->var.green.offset = 8;
+		sfb->fb->var.blue.offset  = 0;
 		break;
 	case 8:
-		sfb->fb.fix.visual       = FB_VISUAL_PSEUDOCOLOR;
-		sfb->fb.fix.line_length  = sfb->fb.var.xres;
-		sfb->fb.var.red.length   = 3;
-		sfb->fb.var.green.length = 3;
-		sfb->fb.var.blue.length  = 2;
-		sfb->fb.var.red.offset   = 5;
-		sfb->fb.var.green.offset = 2;
-		sfb->fb.var.blue.offset  = 0;
+		sfb->fb->fix.visual       = FB_VISUAL_PSEUDOCOLOR;
+		sfb->fb->fix.line_length  = sfb->fb->var.xres;
+		sfb->fb->var.red.length   = 3;
+		sfb->fb->var.green.length = 3;
+		sfb->fb->var.blue.length  = 2;
+		sfb->fb->var.red.offset   = 5;
+		sfb->fb->var.green.offset = 2;
+		sfb->fb->var.blue.offset  = 0;
 		break;
 	case 16:
 	default:
-		sfb->fb.fix.visual       = FB_VISUAL_TRUECOLOR;
-		sfb->fb.fix.line_length  = sfb->fb.var.xres * 2;
-		sfb->fb.var.red.length   = 5;
-		sfb->fb.var.green.length = 6;
-		sfb->fb.var.blue.length  = 5;
-		sfb->fb.var.red.offset   = 11;
-		sfb->fb.var.green.offset = 5;
-		sfb->fb.var.blue.offset  = 0;
+		sfb->fb->fix.visual       = FB_VISUAL_TRUECOLOR;
+		sfb->fb->fix.line_length  = sfb->fb->var.xres * 2;
+		sfb->fb->var.red.length   = 5;
+		sfb->fb->var.green.length = 6;
+		sfb->fb->var.blue.length  = 5;
+		sfb->fb->var.red.offset   = 11;
+		sfb->fb->var.green.offset = 5;
+		sfb->fb->var.blue.offset  = 0;
 		break;
 	}
 
-	sfb->width  = sfb->fb.var.xres;
-	sfb->height = sfb->fb.var.yres;
+	sfb->width  = sfb->fb->var.xres;
+	sfb->height = sfb->fb->var.yres;
 	sfb->hz = 60;
 	smtc_set_timing(sfb);
 }
@@ -686,12 +688,12 @@ static struct smtcfb_info *smtc_alloc_fb_info(struct pci_dev *pdev)
 
 	sfb->pdev = pdev;
 
-	sfb->fb.flags          = FBINFO_FLAG_DEFAULT;
-	sfb->fb.fbops          = &smtcfb_ops;
-	sfb->fb.fix            = smtcfb_fix;
-	sfb->fb.var            = smtcfb_var;
-	sfb->fb.pseudo_palette = sfb->colreg;
-	sfb->fb.par            = sfb;
+	sfb->fb->flags          = FBINFO_FLAG_DEFAULT;
+	sfb->fb->fbops          = &smtcfb_ops;
+	sfb->fb->fix            = smtcfb_fix;
+	sfb->fb->var            = smtcfb_var;
+	sfb->fb->pseudo_palette = sfb->colreg;
+	sfb->fb->par            = sfb;
 
 	return sfb;
 }
@@ -721,20 +723,20 @@ static void smtc_unmap_mmio(struct smtcfb_info *sfb)
 static int smtc_map_smem(struct smtcfb_info *sfb,
 			 struct pci_dev *pdev, u_long smem_len)
 {
-	sfb->fb.fix.smem_start = pci_resource_start(pdev, 0);
+	sfb->fb->fix.smem_start = pci_resource_start(pdev, 0);
 
 #ifdef __BIG_ENDIAN
-	if (sfb->fb.var.bits_per_pixel = 32)
-		sfb->fb.fix.smem_start += 0x800000;
+	if (sfb->fb->var.bits_per_pixel = 32)
+		sfb->fb->fix.smem_start += 0x800000;
 #endif
 
-	sfb->fb.fix.smem_len = smem_len;
+	sfb->fb->fix.smem_len = smem_len;
 
-	sfb->fb.screen_base = sfb->lfb;
+	sfb->fb->screen_base = sfb->lfb;
 
-	if (!sfb->fb.screen_base) {
+	if (!sfb->fb->screen_base) {
 		dev_err(&pdev->dev,
-			"%s: unable to map screen memory\n", sfb->fb.fix.id);
+			"%s: unable to map screen memory\n", sfb->fb->fix.id);
 		return -ENOMEM;
 	}
 
@@ -747,9 +749,9 @@ static int smtc_map_smem(struct smtcfb_info *sfb,
  */
 static void smtc_unmap_smem(struct smtcfb_info *sfb)
 {
-	if (sfb && sfb->fb.screen_base) {
-		iounmap(sfb->fb.screen_base);
-		sfb->fb.screen_base = NULL;
+	if (sfb && sfb->fb->screen_base) {
+		iounmap(sfb->fb->screen_base);
+		sfb->fb->screen_base = NULL;
 	}
 }
 
@@ -766,6 +768,7 @@ static int smtcfb_pci_probe(struct pci_dev *pdev,
 			    const struct pci_device_id *ent)
 {
 	struct smtcfb_info *sfb;
+	struct fb_info *info;
 	u_long smem_size = 0x00800000;	/* default 8MB */
 	int err;
 	unsigned long mmio_base;
@@ -784,14 +787,23 @@ static int smtcfb_pci_probe(struct pci_dev *pdev,
 
 	sprintf(smtcfb_fix.id, "sm%Xfb", ent->device);
 
-	sfb = smtc_alloc_fb_info(pdev);
-
-	if (!sfb) {
+	info = framebuffer_alloc(sizeof(*sfb), &pdev->dev);
+	if (!info) {
+		dev_err(&pdev->dev, "framebuffer_alloc failed\n");
 		err = -ENOMEM;
 		goto failed_free;
 	}
 
+	sfb = info->par;
+	sfb->fb = info;
 	sfb->chip_id = ent->device;
+	sfb->pdev = pdev;
+	info->flags = FBINFO_FLAG_DEFAULT;
+	info->fbops = &smtcfb_ops;
+	info->fix = smtcfb_fix;
+	info->var = smtcfb_var;
+	info->pseudo_palette = sfb->colreg;
+	info->par = sfb;
 
 	pci_set_drvdata(pdev, sfb);
 
@@ -799,19 +811,19 @@ static int smtcfb_pci_probe(struct pci_dev *pdev,
 
 	/* get mode parameter from smtc_scr_info */
 	if (smtc_scr_info.lfb_width != 0) {
-		sfb->fb.var.xres = smtc_scr_info.lfb_width;
-		sfb->fb.var.yres = smtc_scr_info.lfb_height;
-		sfb->fb.var.bits_per_pixel = smtc_scr_info.lfb_depth;
+		sfb->fb->var.xres = smtc_scr_info.lfb_width;
+		sfb->fb->var.yres = smtc_scr_info.lfb_height;
+		sfb->fb->var.bits_per_pixel = smtc_scr_info.lfb_depth;
 	} else {
 		/* default resolution 1024x600 16bit mode */
-		sfb->fb.var.xres = SCREEN_X_RES;
-		sfb->fb.var.yres = SCREEN_Y_RES;
-		sfb->fb.var.bits_per_pixel = SCREEN_BPP;
+		sfb->fb->var.xres = SCREEN_X_RES;
+		sfb->fb->var.yres = SCREEN_Y_RES;
+		sfb->fb->var.bits_per_pixel = SCREEN_BPP;
 	}
 
 #ifdef __BIG_ENDIAN
-	if (sfb->fb.var.bits_per_pixel = 24)
-		sfb->fb.var.bits_per_pixel = (smtc_scr_info.lfb_depth = 32);
+	if (sfb->fb->var.bits_per_pixel = 24)
+		sfb->fb->var.bits_per_pixel = (smtc_scr_info.lfb_depth = 32);
 #endif
 	/* Map address and memory detection */
 	mmio_base = pci_resource_start(pdev, 0);
@@ -820,8 +832,8 @@ static int smtcfb_pci_probe(struct pci_dev *pdev,
 	switch (sfb->chip_id) {
 	case 0x710:
 	case 0x712:
-		sfb->fb.fix.mmio_start = mmio_base + 0x00400000;
-		sfb->fb.fix.mmio_len = 0x00400000;
+		sfb->fb->fix.mmio_start = mmio_base + 0x00400000;
+		sfb->fb->fix.mmio_len = 0x00400000;
 		smem_size = SM712_VIDEOMEMORYSIZE;
 #ifdef __BIG_ENDIAN
 		sfb->lfb = ioremap(mmio_base, 0x00c00000);
@@ -833,7 +845,7 @@ static int smtcfb_pci_probe(struct pci_dev *pdev,
 		sfb->dp_regs = sfb->lfb + 0x00408000;
 		sfb->vp_regs = sfb->lfb + 0x0040c000;
 #ifdef __BIG_ENDIAN
-		if (sfb->fb.var.bits_per_pixel = 32) {
+		if (sfb->fb->var.bits_per_pixel = 32) {
 			sfb->lfb += 0x800000;
 			dev_info(&pdev->dev, "sfb->lfb=%p", sfb->lfb);
 		}
@@ -841,7 +853,7 @@ static int smtcfb_pci_probe(struct pci_dev *pdev,
 		if (!smtc_regbaseaddress) {
 			dev_err(&pdev->dev,
 				"%s: unable to map memory mapped IO!",
-				sfb->fb.fix.id);
+				sfb->fb->fix.id);
 			err = -ENOMEM;
 			goto failed_fb;
 		}
@@ -854,13 +866,13 @@ static int smtcfb_pci_probe(struct pci_dev *pdev,
 		smtc_seqw(0x17, 0x20);
 		/* enable word swap */
 #ifdef __BIG_ENDIAN
-		if (sfb->fb.var.bits_per_pixel = 32)
+		if (sfb->fb->var.bits_per_pixel = 32)
 			smtc_seqw(0x17, 0x30);
 #endif
 		break;
 	case 0x720:
-		sfb->fb.fix.mmio_start = mmio_base;
-		sfb->fb.fix.mmio_len = 0x00200000;
+		sfb->fb->fix.mmio_start = mmio_base;
+		sfb->fb->fix.mmio_len = 0x00200000;
 		smem_size = SM722_VIDEOMEMORYSIZE;
 		sfb->dp_regs = ioremap(mmio_base, 0x00a00000);
 		sfb->lfb = sfb->dp_regs + 0x00200000;
@@ -880,25 +892,25 @@ static int smtcfb_pci_probe(struct pci_dev *pdev,
 	}
 
 	/* can support 32 bpp */
-	if (15 = sfb->fb.var.bits_per_pixel)
-		sfb->fb.var.bits_per_pixel = 16;
+	if (15 = sfb->fb->var.bits_per_pixel)
+		sfb->fb->var.bits_per_pixel = 16;
 
-	sfb->fb.var.xres_virtual = sfb->fb.var.xres;
-	sfb->fb.var.yres_virtual = sfb->fb.var.yres;
+	sfb->fb->var.xres_virtual = sfb->fb->var.xres;
+	sfb->fb->var.yres_virtual = sfb->fb->var.yres;
 	err = smtc_map_smem(sfb, pdev, smem_size);
 	if (err)
 		goto failed;
 
 	smtcfb_setmode(sfb);
 
-	err = register_framebuffer(&sfb->fb);
+	err = register_framebuffer(info);
 	if (err < 0)
 		goto failed;
 
 	dev_info(&pdev->dev,
 		 "Silicon Motion SM%X Rev%X primary display mode %dx%d-%d Init Complete.",
-		 sfb->chip_id, sfb->chip_rev_id, sfb->fb.var.xres,
-		 sfb->fb.var.yres, sfb->fb.var.bits_per_pixel);
+		 sfb->chip_id, sfb->chip_rev_id, sfb->fb->var.xres,
+		 sfb->fb->var.yres, sfb->fb->var.bits_per_pixel);
 
 	return 0;
 
@@ -908,7 +920,7 @@ failed:
 	smtc_unmap_smem(sfb);
 	smtc_unmap_mmio(sfb);
 failed_fb:
-	smtc_free_fb_info(sfb);
+	framebuffer_release(info);
 
 failed_free:
 	pci_release_region(pdev, 0);
@@ -940,8 +952,8 @@ static void smtcfb_pci_remove(struct pci_dev *pdev)
 	sfb = pci_get_drvdata(pdev);
 	smtc_unmap_smem(sfb);
 	smtc_unmap_mmio(sfb);
-	unregister_framebuffer(&sfb->fb);
-	smtc_free_fb_info(sfb);
+	unregister_framebuffer(sfb->fb);
+	framebuffer_release(sfb->fb);
 	pci_release_region(pdev, 0);
 	pci_disable_device(pdev);
 }
@@ -961,7 +973,7 @@ static int smtcfb_pci_suspend(struct device *device)
 	smtc_seqw(0x69, (smtc_seqr(0x69) & 0xf7));
 
 	console_lock();
-	fb_set_suspend(&sfb->fb, 1);
+	fb_set_suspend(sfb->fb, 1);
 	console_unlock();
 
 	/* additionally turn off all function blocks including internal PLLs */
@@ -989,7 +1001,7 @@ static int smtcfb_pci_resume(struct device *device)
 		/* enable PCI burst */
 		smtc_seqw(0x17, 0x20);
 #ifdef __BIG_ENDIAN
-		if (sfb->fb.var.bits_per_pixel = 32)
+		if (sfb->fb->var.bits_per_pixel = 32)
 			smtc_seqw(0x17, 0x30);
 #endif
 		break;
@@ -1006,7 +1018,7 @@ static int smtcfb_pci_resume(struct device *device)
 	smtcfb_setmode(sfb);
 
 	console_lock();
-	fb_set_suspend(&sfb->fb, 0);
+	fb_set_suspend(sfb->fb, 0);
 	console_unlock();
 
 	return 0;
-- 
1.8.1.2

