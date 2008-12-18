From: "Eric Miao" <eric.y.miao@gmail.com>
Subject: [PATCH] pxafb: cleanup of the timing checking
	code
Date: Thu, 18 Dec 2008 22:56:19 +0800
Message-ID: <f17812d70812180656x4542ceb2h86c790d70361ed2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <eric.y.miao@gmail.com>) id 1LDKIa-0007Cd-8P
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 18 Dec 2008 14:56:24 +0000
Received: from rv-out-0708.google.com ([209.85.198.246])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LDKIW-0002UM-Of for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 18 Dec 2008 14:56:24 +0000
Received: by rv-out-0708.google.com with SMTP id f25so425854rvb.22
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 18 Dec 2008 06:56:19 -0800 (PST)
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: ARM Linux <linux-arm-kernel@lists.arm.linux.org.uk>
Cc: linux-fbdev-devel@lists.sourceforge.net

Sorry, this should be part of the previous two patches, but left here
alone.

Introduce pxafb_adjust_timing() to adjust the 'var' a bit, and remove
the ugly #ifdef DEBUG_VAR .. #endif stuff in pxafb_activate_var(),
if we are not able to do that out-of-limit timing, let's keep the minimum
or maximum value that we can do. (instead of giving warnings and
go ahead with bit-truncated)

Signed-off-by: Eric Miao <eric.miao@marvell.com>
---
 drivers/video/pxafb.c |  108 ++++++++++++++++++++-----------------------------
 drivers/video/pxafb.h |    6 +++
 2 files changed, 50 insertions(+), 64 deletions(-)

diff --git a/drivers/video/pxafb.c b/drivers/video/pxafb.c
index a322374..f3e32e1 100644
--- a/drivers/video/pxafb.c
+++ b/drivers/video/pxafb.c
@@ -388,6 +388,46 @@ static void pxafb_setmode(struct fb_var_screeninfo *var,
 	pxafb_set_pixfmt(var, mode->depth);
 }

+static int pxafb_adjust_timing(struct pxafb_info *fbi,
+			       struct fb_var_screeninfo *var)
+{
+	int line_length;
+
+	var->xres = max_t(int, var->xres, MIN_XRES);
+	var->yres = max_t(int, var->yres, MIN_YRES);
+
+	if (!(fbi->lccr0 & LCCR0_LCDT)) {
+		clamp_val(var->hsync_len, 1, 64);
+		clamp_val(var->vsync_len, 1, 64);
+		clamp_val(var->left_margin,  1, 255);
+		clamp_val(var->right_margin, 1, 255);
+		clamp_val(var->upper_margin, 1, 255);
+		clamp_val(var->lower_margin, 1, 255);
+	}
+
+	/* make sure each line is aligned on word boundary */
+	line_length = var->xres * var->bits_per_pixel / 8;
+	line_length = ALIGN(line_length, 4);
+	var->xres = line_length * 8 / var->bits_per_pixel;
+
+	/* we don't support xpan, force xres_virtual to be equal to xres */
+	var->xres_virtual = var->xres;
+
+	if (var->accel_flags & FB_ACCELF_TEXT)
+		var->yres_virtual = fbi->fb.fix.smem_len / line_length;
+	else
+		var->yres_virtual = max(var->yres_virtual, var->yres);
+
+	/* check for limits */
+	if (var->xres > MAX_XRES || var->yres > MAX_YRES)
+		return -EINVAL;
+
+	if (var->yres > var->yres_virtual)
+		return -EINVAL;
+
+	return 0;
+}
+
 /*
  *  pxafb_check_var():
  *    Get the video params out of 'var'. If a value doesn't fit, round it up,
@@ -403,11 +443,6 @@ static int pxafb_check_var(struct
fb_var_screeninfo *var, struct fb_info *info)
 	struct pxafb_mach_info *inf = fbi->dev->platform_data;
 	int err;

-	if (var->xres < MIN_XRES)
-		var->xres = MIN_XRES;
-	if (var->yres < MIN_YRES)
-		var->yres = MIN_YRES;
-
 	if (inf->fixed_modes) {
 		struct pxafb_mode_info *mode;

@@ -415,24 +450,8 @@ static int pxafb_check_var(struct
fb_var_screeninfo *var, struct fb_info *info)
 		if (!mode)
 			return -EINVAL;
 		pxafb_setmode(var, mode);
-	} else {
-		if (var->xres > inf->modes->xres)
-			return -EINVAL;
-		if (var->yres > inf->modes->yres)
-			return -EINVAL;
-		if (var->bits_per_pixel > inf->modes->bpp)
-			return -EINVAL;
 	}

-	/* we don't support xpan, force xres_virtual to be equal to xres */
-	var->xres_virtual = var->xres;
-
-	if (var->accel_flags & FB_ACCELF_TEXT)
-		var->yres_virtual = fbi->fb.fix.smem_len /
-			(var->xres_virtual * var->bits_per_pixel / 8);
-	else
-		var->yres_virtual = max(var->yres_virtual, var->yres);
-
 	/* do a test conversion to BPP fields to check the color formats */
 	err = pxafb_var_to_bpp(var);
 	if (err < 0)
@@ -440,6 +459,10 @@ static int pxafb_check_var(struct
fb_var_screeninfo *var, struct fb_info *info)

 	pxafb_set_pixfmt(var, var_to_depth(var));

+	err = pxafb_adjust_timing(fbi, var);
+	if (err)
+		return err;
+
 #ifdef CONFIG_CPU_FREQ
 	pr_debug("pxafb: dma period = %d ps\n",
 		 pxafb_display_dma_period(var));
@@ -955,49 +978,6 @@ static int pxafb_activate_var(struct
fb_var_screeninfo *var,
 {
 	u_long flags;

-#if DEBUG_VAR
-	if (!(fbi->lccr0 & LCCR0_LCDT)) {
-		if (var->xres < 16 || var->xres > 1024)
-			printk(KERN_ERR "%s: invalid xres %d\n",
-				fbi->fb.fix.id, var->xres);
-		switch (var->bits_per_pixel) {
-		case 1:
-		case 2:
-		case 4:
-		case 8:
-		case 16:
-		case 24:
-		case 32:
-			break;
-		default:
-			printk(KERN_ERR "%s: invalid bit depth %d\n",
-			       fbi->fb.fix.id, var->bits_per_pixel);
-			break;
-		}
-
-		if (var->hsync_len < 1 || var->hsync_len > 64)
-			printk(KERN_ERR "%s: invalid hsync_len %d\n",
-				fbi->fb.fix.id, var->hsync_len);
-		if (var->left_margin < 1 || var->left_margin > 255)
-			printk(KERN_ERR "%s: invalid left_margin %d\n",
-				fbi->fb.fix.id, var->left_margin);
-		if (var->right_margin < 1 || var->right_margin > 255)
-			printk(KERN_ERR "%s: invalid right_margin %d\n",
-				fbi->fb.fix.id, var->right_margin);
-		if (var->yres < 1 || var->yres > 1024)
-			printk(KERN_ERR "%s: invalid yres %d\n",
-				fbi->fb.fix.id, var->yres);
-		if (var->vsync_len < 1 || var->vsync_len > 64)
-			printk(KERN_ERR "%s: invalid vsync_len %d\n",
-				fbi->fb.fix.id, var->vsync_len);
-		if (var->upper_margin < 0 || var->upper_margin > 255)
-			printk(KERN_ERR "%s: invalid upper_margin %d\n",
-				fbi->fb.fix.id, var->upper_margin);
-		if (var->lower_margin < 0 || var->lower_margin > 255)
-			printk(KERN_ERR "%s: invalid lower_margin %d\n",
-				fbi->fb.fix.id, var->lower_margin);
-	}
-#endif
 	/* Update shadow copy atomically */
 	local_irq_save(flags);

diff --git a/drivers/video/pxafb.h b/drivers/video/pxafb.h
index e0f90f4..ae3cbc1 100644
--- a/drivers/video/pxafb.h
+++ b/drivers/video/pxafb.h
@@ -145,4 +145,10 @@ struct pxafb_info {
 #define MIN_XRES	64
 #define MIN_YRES	64

+/* maximum X and Y resolutions - note these are limits from the register
+ * bits length instead of the real ones
+ */
+#define MAX_XRES	1024
+#define MAX_YRES	1024
+
 #endif /* __PXAFB_H__ */
-- 
1.6.0.4

------------------------------------------------------------------------------
SF.Net email is Sponsored by MIX09, March 18-20, 2009 in Las Vegas, Nevada.
The future of the web can't happen without you.  Join us at MIX09 to help
pave the way to the Next Web now. Learn more and register at
http://ad.doubleclick.net/clk;208669438;13503038;i?http://2009.visitmix.com/
