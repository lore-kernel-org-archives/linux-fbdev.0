From: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
Subject: [PATCH] sh: sh7760fb: Fix color pallette setting
Date: Fri, 21 Nov 2008 14:34:25 +0900
Message-ID: <49264861.6030205@renesas.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Linux-sh <linux-sh@vger.kernel.org>

The setting of the color palette was wrong, fixed it.
And removed fb_setcmap, and added fb_setcolreg function.

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
---
 drivers/video/sh7760fb.c |   94 +++++++++++----------------------------------
 1 files changed, 23 insertions(+), 71 deletions(-)

diff --git a/drivers/video/sh7760fb.c b/drivers/video/sh7760fb.c
index 8d0212d..653bdfe 100644
--- a/drivers/video/sh7760fb.c
+++ b/drivers/video/sh7760fb.c
@@ -13,6 +13,8 @@
  *
  * Thanks to Siegfried Schaefer <s.schaefer at schaefer-edv.de>
  *     for his original source and testing!
+ *
+ * sh7760_setcolreg get from drivers/video/sh_mobile_lcdcfb.c
  */

 #include <linux/completion.h>
@@ -53,29 +55,6 @@ static irqreturn_t sh7760fb_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }

-static void sh7760fb_wait_vsync(struct fb_info *info)
-{
-	struct sh7760fb_par *par = info->par;
-
-	if (par->pd->novsync)
-		return;
-
-	iowrite16(ioread16(par->base + LDINTR) & ~VINT_CHECK,
-		  par->base + LDINTR);
-
-	if (par->irq < 0) {
-		/* poll for vert. retrace: status bit is sticky */
-		while (!(ioread16(par->base + LDINTR) & VINT_CHECK))
-			cpu_relax();
-	} else {
-		/* a "wait_for_irq_event(par->irq)" would be extremely nice */
-		init_completion(&par->vsync);
-		enable_irq(par->irq);
-		wait_for_completion(&par->vsync);
-		disable_irq_nosync(par->irq);
-	}
-}
-
 /* wait_for_lps - wait until power supply has reached a certain state. */
 static int wait_for_lps(struct sh7760fb_par *par, int val)
 {
@@ -117,55 +96,28 @@ static int sh7760fb_blank(int blank, struct fb_info *info)
 	return wait_for_lps(par, lps);
 }

-/* set color registers */
-static int sh7760fb_setcmap(struct fb_cmap *cmap, struct fb_info *info)
+static int sh7760_setcolreg (u_int regno,
+	u_int red, u_int green, u_int blue,
+	u_int transp, struct fb_info *info)
 {
-	struct sh7760fb_par *par = info->par;
-	u32 s = cmap->start;
-	u32 l = cmap->len;
-	u16 *r = cmap->red;
-	u16 *g = cmap->green;
-	u16 *b = cmap->blue;
-	u32 col, tmo;
-	int ret;
+	u32 *palette = info->pseudo_palette;

-	ret = 0;
+	if (regno >= 16)
+		return -EINVAL;

-	sh7760fb_wait_vsync(info);
+	/* only FB_VISUAL_TRUECOLOR supported */

-	/* request palette access */
-	iowrite16(LDPALCR_PALEN, par->base + LDPALCR);
+	red >>= 16 - info->var.red.length;
+	green >>= 16 - info->var.green.length;
+	blue >>= 16 - info->var.blue.length;
+	transp >>= 16 - info->var.transp.length;

-	/* poll for access grant */
-	tmo = 100;
-	while (!(ioread16(par->base + LDPALCR) & LDPALCR_PALS) && (--tmo))
-		cpu_relax();
+	palette[regno] = (red << info->var.red.offset) |
+		(green << info->var.green.offset) |
+		(blue << info->var.blue.offset) |
+		(transp << info->var.transp.offset);

-	if (!tmo) {
-		ret = 1;
-		dev_dbg(info->dev, "no palette access!\n");
-		goto out;
-	}
-
-	while (l && (s < 256)) {
-		col = ((*r) & 0xff) << 16;
-		col |= ((*g) & 0xff) << 8;
-		col |= ((*b) & 0xff);
-		col &= SH7760FB_PALETTE_MASK;
-		iowrite32(col, par->base + LDPR(s));
-
-		if (s < 16)
-			((u32 *) (info->pseudo_palette))[s] = s;
-
-		s++;
-		l--;
-		r++;
-		g++;
-		b++;
-	}
-out:
-	iowrite16(0, par->base + LDPALCR);
-	return ret;
+	return 0;
 }

 static void encode_fix(struct fb_fix_screeninfo *fix, struct fb_info *info,
@@ -406,7 +358,7 @@ static struct fb_ops sh7760fb_ops = {
 	.owner = THIS_MODULE,
 	.fb_blank = sh7760fb_blank,
 	.fb_check_var = sh7760fb_check_var,
-	.fb_setcmap = sh7760fb_setcmap,
+	.fb_setcolreg = sh7760_setcolreg,
 	.fb_set_par = sh7760fb_set_par,
 	.fb_fillrect = cfb_fillrect,
 	.fb_copyarea = cfb_copyarea,
-- 
1.5.6.5

