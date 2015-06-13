From: Joe Perches <joe@perches.com>
Date: Sat, 13 Jun 2015 16:57:05 +0000
Subject: Re: doubt about sm7xxfb (was: Re: [PATCH v4 0/7] staging: fsl-mc: New functionality to the MC bus dr
Message-Id: <1434214625.2507.9.camel@perches.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1433887148-2310-1-git-send-email-German.Rivera@freescale.com>
	 <20150613001849.GB5234@kroah.com> <20150613084618.GA6492@sudip-PC>
	 <20150613162839.GA14842@kroah.com>
In-Reply-To: <20150613162839.GA14842@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, tomi.valkeinen@ti.com, linux-kernel@vger.kernel.org, dan.carpenter@oracle.com

On Sat, 2015-06-13 at 09:28 -0700, Greg KH wrote:
> On Sat, Jun 13, 2015 at 02:16:18PM +0530, Sudip Mukherjee wrote:
[]
> > Your reply above was for a different thread but my doubt started from
> > this. I was working on adding the Dual-Head support to sm7xxfb. So that
> > is also a new functionality which is not in the current driver as of now.
> > Then should i instead concentrate on getting that out of staging? If yes,
> > can you please have a look (when you are free) at it to see if anything
> > else needs to be done.
> 
> Yes, please work on getting it out of staging.
> 
> If you think it's ready, then submit a patch that moves it, copying the
> proper maintainers, and I'll be glad to review it.

It seems ready to me.

As far as I can tell, there's just a few niggles
that could be done:

Something like (too lazy to separate them into multiple patches)

o reduce indentation a couple of places
o add newlines to logging messages
o add const to static array
o use consistent function declaration style

It's unfortunate there are so many #ifdef __BIG_ENDIAN uses.

---
 drivers/staging/sm7xxfb/sm7xxfb.c | 203 ++++++++++++++++++--------------------
 1 file changed, 96 insertions(+), 107 deletions(-)

diff --git a/drivers/staging/sm7xxfb/sm7xxfb.c b/drivers/staging/sm7xxfb/sm7xxfb.c
index 5db26f1..5be2560 100644
--- a/drivers/staging/sm7xxfb/sm7xxfb.c
+++ b/drivers/staging/sm7xxfb/sm7xxfb.c
@@ -94,7 +94,7 @@ struct vesa_mode {
 	u16  lfb_depth;
 };
 
-static struct vesa_mode vesa_mode_table[] = {
+static const struct vesa_mode vesa_mode_table[] = {
 	{"0x301", 640,  480,  8},
 	{"0x303", 800,  600,  8},
 	{"0x305", 1024, 768,  8},
@@ -255,37 +255,32 @@ static int smtc_setcolreg(unsigned regno, unsigned red, unsigned green,
 		/*
 		 * 16/32 bit true-colour, use pseudo-palette for 16 base color
 		 */
-		if (regno < 16) {
-			if (sfb->fb->var.bits_per_pixel = 16) {
-				u32 *pal = sfb->fb->pseudo_palette;
-
-				val = chan_to_field(red, &sfb->fb->var.red);
-				val |= chan_to_field(green,
-						     &sfb->fb->var.green);
-				val |= chan_to_field(blue, &sfb->fb->var.blue);
+		if (regno >= 16)
+			break;
+		if (sfb->fb->var.bits_per_pixel = 16) {
+			u32 *pal = sfb->fb->pseudo_palette;
+
+			val = chan_to_field(red, &sfb->fb->var.red);
+			val |= chan_to_field(green, &sfb->fb->var.green);
+			val |= chan_to_field(blue, &sfb->fb->var.blue);
 #ifdef __BIG_ENDIAN
-				pal[regno] -				    ((red & 0xf800) >> 8) |
-				    ((green & 0xe000) >> 13) |
-				    ((green & 0x1c00) << 3) |
-				    ((blue & 0xf800) >> 3);
+			pal[regno] = (((red & 0xf800) >> 8) |
+				      ((green & 0xe000) >> 13) |
+				      ((green & 0x1c00) << 3) |
+				      ((blue & 0xf800) >> 3));
 #else
-				pal[regno] = val;
+			pal[regno] = val;
 #endif
-			} else {
-				u32 *pal = sfb->fb->pseudo_palette;
+		} else {
+			u32 *pal = sfb->fb->pseudo_palette;
 
-				val = chan_to_field(red, &sfb->fb->var.red);
-				val |= chan_to_field(green,
-						     &sfb->fb->var.green);
-				val |= chan_to_field(blue, &sfb->fb->var.blue);
+			val = chan_to_field(red, &sfb->fb->var.red);
+			val |= chan_to_field(green, &sfb->fb->var.green);
+			val |= chan_to_field(blue, &sfb->fb->var.blue);
 #ifdef __BIG_ENDIAN
-				val -				    (val & 0xff00ff00 >> 8) |
-				    (val & 0x00ff00ff << 8);
+			val = (val & 0xff00ff00 >> 8) | (val & 0x00ff00ff << 8);
 #endif
-				pal[regno] = val;
-			}
+			pal[regno] = val;
 		}
 		break;
 
@@ -302,8 +297,8 @@ static int smtc_setcolreg(unsigned regno, unsigned red, unsigned green,
 }
 
 #ifdef __BIG_ENDIAN
-static ssize_t smtcfb_read(struct fb_info *info, char __user *buf, size_t
-				count, loff_t *ppos)
+static ssize_t smtcfb_read(struct fb_info *info, char __user *buf,
+			   size_t count, loff_t *ppos)
 {
 	unsigned long p = *ppos;
 
@@ -346,9 +341,8 @@ static ssize_t smtcfb_read(struct fb_info *info, char __user *buf, size_t
 		dst = buffer;
 		for (i = c >> 2; i--;) {
 			*dst = fb_readl(src++);
-			*dst -			    (*dst & 0xff00ff00 >> 8) |
-			    (*dst & 0x00ff00ff << 8);
+			*dst = (*dst & 0xff00ff00 >> 8) |
+			       (*dst & 0x00ff00ff << 8);
 			dst++;
 		}
 		if (c & 3) {
@@ -381,9 +375,8 @@ static ssize_t smtcfb_read(struct fb_info *info, char __user *buf, size_t
 	return (err) ? err : cnt;
 }
 
-static ssize_t
-smtcfb_write(struct fb_info *info, const char __user *buf, size_t count,
-	     loff_t *ppos)
+static ssize_t smtcfb_write(struct fb_info *info, const char __user *buf,
+			    size_t count, loff_t *ppos)
 {
 	unsigned long p = *ppos;
 
@@ -478,72 +471,69 @@ static void sm7xx_set_timing(struct smtcfb_info *sfb)
 		sfb->width, sfb->height, sfb->fb->var.bits_per_pixel, sfb->hz);
 
 	for (j = 0; j < numvgamodes; j++) {
-		if (vgamode[j].mmsizex = sfb->width &&
-		    vgamode[j].mmsizey = sfb->height &&
-		    vgamode[j].bpp = sfb->fb->var.bits_per_pixel &&
-		    vgamode[j].hz = sfb->hz) {
-			dev_dbg(&sfb->pdev->dev,
-				"vgamode[j].mmsizex=%d vgamode[j].mmSizeY=%d vgamode[j].bpp=%d vgamode[j].hz=%d\n",
-				vgamode[j].mmsizex, vgamode[j].mmsizey,
-				vgamode[j].bpp, vgamode[j].hz);
-
-			dev_dbg(&sfb->pdev->dev, "vgamode index=%d\n", j);
-
-			smtc_mmiowb(0x0, 0x3c6);
-
-			smtc_seqw(0, 0x1);
-
-			smtc_mmiowb(vgamode[j].init_misc, 0x3c2);
-
-			/* init SEQ register SR00 - SR04 */
-			for (i = 0; i < SIZE_SR00_SR04; i++)
-				smtc_seqw(i, vgamode[j].init_sr00_sr04[i]);
-
-			/* init SEQ register SR10 - SR24 */
-			for (i = 0; i < SIZE_SR10_SR24; i++)
-				smtc_seqw(i + 0x10,
-					  vgamode[j].init_sr10_sr24[i]);
-
-			/* init SEQ register SR30 - SR75 */
-			for (i = 0; i < SIZE_SR30_SR75; i++)
-				if ((i + 0x30) != 0x62 &&
-				    (i + 0x30) != 0x6a &&
-				    (i + 0x30) != 0x6b)
-					smtc_seqw(i + 0x30,
-						  vgamode[j].init_sr30_sr75[i]);
-
-			/* init SEQ register SR80 - SR93 */
-			for (i = 0; i < SIZE_SR80_SR93; i++)
-				smtc_seqw(i + 0x80,
-					  vgamode[j].init_sr80_sr93[i]);
-
-			/* init SEQ register SRA0 - SRAF */
-			for (i = 0; i < SIZE_SRA0_SRAF; i++)
-				smtc_seqw(i + 0xa0,
-					  vgamode[j].init_sra0_sraf[i]);
-
-			/* init Graphic register GR00 - GR08 */
-			for (i = 0; i < SIZE_GR00_GR08; i++)
-				smtc_grphw(i, vgamode[j].init_gr00_gr08[i]);
-
-			/* init Attribute register AR00 - AR14 */
-			for (i = 0; i < SIZE_AR00_AR14; i++)
-				smtc_attrw(i, vgamode[j].init_ar00_ar14[i]);
-
-			/* init CRTC register CR00 - CR18 */
-			for (i = 0; i < SIZE_CR00_CR18; i++)
-				smtc_crtcw(i, vgamode[j].init_cr00_cr18[i]);
-
-			/* init CRTC register CR30 - CR4D */
-			for (i = 0; i < SIZE_CR30_CR4D; i++)
-				smtc_crtcw(i + 0x30,
-					   vgamode[j].init_cr30_cr4d[i]);
-
-			/* init CRTC register CR90 - CRA7 */
-			for (i = 0; i < SIZE_CR90_CRA7; i++)
-				smtc_crtcw(i + 0x90,
-					   vgamode[j].init_cr90_cra7[i]);
+		if (vgamode[j].mmsizex != sfb->width ||
+		    vgamode[j].mmsizey != sfb->height ||
+		    vgamode[j].bpp != sfb->fb->var.bits_per_pixel ||
+		    vgamode[j].hz != sfb->hz)
+			continue;
+
+		dev_dbg(&sfb->pdev->dev,
+			"vgamode[j].mmsizex=%d vgamode[j].mmSizeY=%d vgamode[j].bpp=%d vgamode[j].hz=%d\n",
+			vgamode[j].mmsizex, vgamode[j].mmsizey,
+			vgamode[j].bpp, vgamode[j].hz);
+
+		dev_dbg(&sfb->pdev->dev, "vgamode index=%d\n", j);
+
+		smtc_mmiowb(0x0, 0x3c6);
+
+		smtc_seqw(0, 0x1);
+
+		smtc_mmiowb(vgamode[j].init_misc, 0x3c2);
+
+		/* init SEQ register SR00 - SR04 */
+		for (i = 0; i < SIZE_SR00_SR04; i++)
+			smtc_seqw(i, vgamode[j].init_sr00_sr04[i]);
+
+		/* init SEQ register SR10 - SR24 */
+		for (i = 0; i < SIZE_SR10_SR24; i++)
+			smtc_seqw(i + 0x10, vgamode[j].init_sr10_sr24[i]);
+
+		/* init SEQ register SR30 - SR75 */
+		for (i = 0; i < SIZE_SR30_SR75; i++) {
+			if ((i + 0x30) != 0x62 &&
+			    (i + 0x30) != 0x6a &&
+			    (i + 0x30) != 0x6b)
+				smtc_seqw(i + 0x30,
+					  vgamode[j].init_sr30_sr75[i]);
 		}
+
+		/* init SEQ register SR80 - SR93 */
+		for (i = 0; i < SIZE_SR80_SR93; i++)
+			smtc_seqw(i + 0x80, vgamode[j].init_sr80_sr93[i]);
+
+		/* init SEQ register SRA0 - SRAF */
+		for (i = 0; i < SIZE_SRA0_SRAF; i++)
+			smtc_seqw(i + 0xa0, vgamode[j].init_sra0_sraf[i]);
+
+		/* init Graphic register GR00 - GR08 */
+		for (i = 0; i < SIZE_GR00_GR08; i++)
+			smtc_grphw(i, vgamode[j].init_gr00_gr08[i]);
+
+		/* init Attribute register AR00 - AR14 */
+		for (i = 0; i < SIZE_AR00_AR14; i++)
+			smtc_attrw(i, vgamode[j].init_ar00_ar14[i]);
+
+		/* init CRTC register CR00 - CR18 */
+		for (i = 0; i < SIZE_CR00_CR18; i++)
+			smtc_crtcw(i, vgamode[j].init_cr00_cr18[i]);
+
+		/* init CRTC register CR30 - CR4D */
+		for (i = 0; i < SIZE_CR30_CR4D; i++)
+			smtc_crtcw(i + 0x30, vgamode[j].init_cr30_cr4d[i]);
+
+		/* init CRTC register CR90 - CRA7 */
+		for (i = 0; i < SIZE_CR90_CRA7; i++)
+			smtc_crtcw(i + 0x90, vgamode[j].init_cr90_cra7[i]);
 	}
 	smtc_mmiowb(0x67, 0x3c2);
 
@@ -552,8 +542,7 @@ static void sm7xx_set_timing(struct smtcfb_info *sfb)
 	writel(0x0, sfb->vp_regs + 0x40);
 
 	/* set data width */
-	m_nscreenstride -		(sfb->width * sfb->fb->var.bits_per_pixel) / 64;
+	m_nscreenstride = (sfb->width * sfb->fb->var.bits_per_pixel) / 64;
 	switch (sfb->fb->var.bits_per_pixel) {
 	case 8:
 		writel(0x0, sfb->vp_regs + 0x0);
@@ -741,7 +730,7 @@ static int smtcfb_pci_probe(struct pci_dev *pdev,
 	int err;
 	unsigned long mmio_base;
 
-	dev_info(&pdev->dev, "Silicon Motion display driver.");
+	dev_info(&pdev->dev, "Silicon Motion display driver\n");
 
 	err = pci_enable_device(pdev);	/* enable SMTC chip */
 	if (err)
@@ -815,12 +804,12 @@ static int smtcfb_pci_probe(struct pci_dev *pdev,
 #ifdef __BIG_ENDIAN
 		if (sfb->fb->var.bits_per_pixel = 32) {
 			sfb->lfb += 0x800000;
-			dev_info(&pdev->dev, "sfb->lfb=%p", sfb->lfb);
+			dev_info(&pdev->dev, "sfb->lfb=%p\n", sfb->lfb);
 		}
 #endif
 		if (!smtc_regbaseaddress) {
 			dev_err(&pdev->dev,
-				"%s: unable to map memory mapped IO!",
+				"%s: unable to map memory mapped IO!\n",
 				sfb->fb->fix.id);
 			err = -ENOMEM;
 			goto failed_fb;
@@ -854,7 +843,7 @@ static int smtcfb_pci_probe(struct pci_dev *pdev,
 		break;
 	default:
 		dev_err(&pdev->dev,
-			"No valid Silicon Motion display chip was detected!");
+			"No valid Silicon Motion display chip was detected!\n");
 
 		goto failed_fb;
 	}
@@ -876,14 +865,14 @@ static int smtcfb_pci_probe(struct pci_dev *pdev,
 		goto failed;
 
 	dev_info(&pdev->dev,
-		 "Silicon Motion SM%X Rev%X primary display mode %dx%d-%d Init Complete.",
+		 "Silicon Motion SM%X Rev%X primary display mode %dx%d-%d Init Complete\n",
 		 sfb->chip_id, sfb->chip_rev_id, sfb->fb->var.xres,
 		 sfb->fb->var.yres, sfb->fb->var.bits_per_pixel);
 
 	return 0;
 
 failed:
-	dev_err(&pdev->dev, "Silicon Motion, Inc. primary display init fail.");
+	dev_err(&pdev->dev, "Silicon Motion, Inc. primary display init failed\n");
 
 	smtc_unmap_smem(sfb);
 	smtc_unmap_mmio(sfb);


