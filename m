From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] fb: Remove redundant tests on unsigneds
Date: Tue, 21 Apr 2009 16:58:57 +0200
Message-ID: <49EDDF31.1050902@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <roel.kluin@gmail.com>) id 1LwHR9-0007MW-JX
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 21 Apr 2009 14:59:03 +0000
Received: from ey-out-1920.google.com ([74.125.78.150])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LwHR6-0000Ze-1W for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 21 Apr 2009 14:59:03 +0000
Received: by ey-out-1920.google.com with SMTP id 13so545696eye.4
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 21 Apr 2009 07:58:57 -0700 (PDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: adaplas@gmail.com, linux-fbdev-devel@lists.sourceforge.net

vi include/linux/fb.h +236
struct fb_var_screeninfo {
...
        __u32 xoffset;                  /* offset from virtual to visible */
        __u32 yoffset;                  /* resolution                   */
...
        __u32 upper_margin;             /* time from sync to picture    */
        __u32 lower_margin;
...
};

vi include/linux/fb.h +353
struct fb_image {
        __u32 dx;               /* Where to place image */
        __u32 dy;
...
};

// vi include/linux/fb.h +284
struct fb_con2fbmap {
        __u32 console;
        __u32 framebuffer;
};
------------------------------>8-------------8<---------------------------------
Remove redundant tests on unsigned

Signed-off-by: Roel Kluin <roel.kluin@gmail.com> 
---
diff --git a/drivers/video/amifb.c b/drivers/video/amifb.c
index 82bedd7..8c95d56 100644
--- a/drivers/video/amifb.c
+++ b/drivers/video/amifb.c
@@ -1326,8 +1326,7 @@ static int amifb_pan_display(struct fb_var_screeninfo *var,
 			     struct fb_info *info)
 {
 	if (var->vmode & FB_VMODE_YWRAP) {
-		if (var->yoffset < 0 ||
-		    var->yoffset >= info->var.yres_virtual || var->xoffset)
+		if (var->yoffset >= info->var.yres_virtual || var->xoffset)
 			return -EINVAL;
 	} else {
 		/*
diff --git a/drivers/video/aty/radeon_base.c b/drivers/video/aty/radeon_base.c
index 6c37e8e..92ce49e 100644
--- a/drivers/video/aty/radeon_base.c
+++ b/drivers/video/aty/radeon_base.c
@@ -819,11 +819,6 @@ static int radeonfb_check_var (struct fb_var_screeninfo *var, struct fb_info *in
 	if (v.xres_virtual < v.xres)
 		v.xres = v.xres_virtual;
 
-	if (v.xoffset < 0)
-                v.xoffset = 0;
-        if (v.yoffset < 0)
-                v.yoffset = 0;
-         
         if (v.xoffset > v.xres_virtual - v.xres)
                 v.xoffset = v.xres_virtual - v.xres - 1;
                         
diff --git a/drivers/video/cirrusfb.c b/drivers/video/cirrusfb.c
index 4c2bf92..746dcb2 100644
--- a/drivers/video/cirrusfb.c
+++ b/drivers/video/cirrusfb.c
@@ -591,11 +591,6 @@ static int cirrusfb_check_var(struct fb_var_screeninfo *var,
 		return -EINVAL;
 	}
 
-	if (var->xoffset < 0)
-		var->xoffset = 0;
-	if (var->yoffset < 0)
-		var->yoffset = 0;
-
 	/* truncate xoffset and yoffset to maximum if too high */
 	if (var->xoffset > var->xres_virtual - var->xres)
 		var->xoffset = var->xres_virtual - var->xres - 1;
diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index d412a1d..08dd683 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -404,7 +404,7 @@ static void fb_do_show_logo(struct fb_info *info, struct fb_image *image,
 			image->dx += image->width + 8;
 		}
 	} else if (rotate == FB_ROTATE_UD) {
-		for (x = 0; x < num && image->dx >= 0; x++) {
+		for (x = 0; x < num; x++) {
 			info->fbops->fb_imageblit(info, image);
 			image->dx -= image->width + 8;
 		}
@@ -416,7 +416,7 @@ static void fb_do_show_logo(struct fb_info *info, struct fb_image *image,
 			image->dy += image->height + 8;
 		}
 	} else if (rotate == FB_ROTATE_CCW) {
-		for (x = 0; x < num && image->dy >= 0; x++) {
+		for (x = 0; x < num; x++) {
 			info->fbops->fb_imageblit(info, image);
 			image->dy -= image->height + 8;
 		}
@@ -1109,7 +1109,7 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
 			return -EFAULT;
 		if (con2fb.console < 1 || con2fb.console > MAX_NR_CONSOLES)
 			return -EINVAL;
-		if (con2fb.framebuffer < 0 || con2fb.framebuffer >= FB_MAX)
+		if (con2fb.framebuffer >= FB_MAX)
 			return -EINVAL;
 		if (!registered_fb[con2fb.framebuffer])
 			request_module("fb%d", con2fb.framebuffer);
diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
index f153c58..27de31f 100644
--- a/drivers/video/fsl-diu-fb.c
+++ b/drivers/video/fsl-diu-fb.c
@@ -555,12 +555,6 @@ static int fsl_diu_check_var(struct fb_var_screeninfo *var,
 	if (var->yres_virtual < var->yres)
 		var->yres_virtual = var->yres;
 
-	if (var->xoffset < 0)
-		var->xoffset = 0;
-
-	if (var->yoffset < 0)
-		var->yoffset = 0;
-
 	if (var->xoffset + info->var.xres > info->var.xres_virtual)
 		var->xoffset = info->var.xres_virtual - info->var.xres;
 
@@ -928,8 +922,7 @@ static int fsl_diu_pan_display(struct fb_var_screeninfo *var,
 	    (info->var.yoffset == var->yoffset))
 		return 0;	/* No change, do nothing */
 
-	if (var->xoffset < 0 || var->yoffset < 0
-	    || var->xoffset + info->var.xres > info->var.xres_virtual
+	if (var->xoffset + info->var.xres > info->var.xres_virtual
 	    || var->yoffset + info->var.yres > info->var.yres_virtual)
 		return -EINVAL;
 
diff --git a/drivers/video/hgafb.c b/drivers/video/hgafb.c
index 0129c04..b0f558c 100644
--- a/drivers/video/hgafb.c
+++ b/drivers/video/hgafb.c
@@ -418,8 +418,7 @@ static int hgafb_pan_display(struct fb_var_screeninfo *var,
 			     struct fb_info *info)
 {
 	if (var->vmode & FB_VMODE_YWRAP) {
-		if (var->yoffset < 0 || 
-		    var->yoffset >= info->var.yres_virtual ||
+		if (var->yoffset >= info->var.yres_virtual ||
 		    var->xoffset)
 			return -EINVAL;
 	} else {
diff --git a/drivers/video/intelfb/intelfbdrv.c b/drivers/video/intelfb/intelfbdrv.c
index ace14fe..fb7de8a 100644
--- a/drivers/video/intelfb/intelfbdrv.c
+++ b/drivers/video/intelfb/intelfbdrv.c
@@ -1330,11 +1330,6 @@ static int intelfb_check_var(struct fb_var_screeninfo *var,
 		break;
 	}
 
-	if (v.xoffset < 0)
-		v.xoffset = 0;
-	if (v.yoffset < 0)
-		v.yoffset = 0;
-
 	if (v.xoffset > v.xres_virtual - v.xres)
 		v.xoffset = v.xres_virtual - v.xres;
 	if (v.yoffset > v.yres_virtual - v.yres)
diff --git a/drivers/video/pvr2fb.c b/drivers/video/pvr2fb.c
index 53f8f11..bb3479b 100644
--- a/drivers/video/pvr2fb.c
+++ b/drivers/video/pvr2fb.c
@@ -460,13 +460,11 @@ static int pvr2fb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 	set_color_bitfields(var);
 
 	if (var->vmode & FB_VMODE_YWRAP) {
-		if (var->xoffset || var->yoffset < 0 ||
-		    var->yoffset >= var->yres_virtual) {
+		if (var->xoffset || var->yoffset >= var->yres_virtual) {
 			var->xoffset = var->yoffset = 0;
 		} else {
 			if (var->xoffset > var->xres_virtual - var->xres ||
-			    var->yoffset > var->yres_virtual - var->yres ||
-			    var->xoffset < 0 || var->yoffset < 0)
+			    var->yoffset > var->yres_virtual - var->yres)
 				var->xoffset = var->yoffset = 0;
 		}
 	} else {
diff --git a/drivers/video/riva/fbdev.c b/drivers/video/riva/fbdev.c
index d94c57f..62cb99b 100644
--- a/drivers/video/riva/fbdev.c
+++ b/drivers/video/riva/fbdev.c
@@ -1181,11 +1181,6 @@ static int rivafb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 	if (rivafb_do_maximize(info, var, nom, den) < 0)
 		return -EINVAL;
 
-	if (var->xoffset < 0)
-		var->xoffset = 0;
-	if (var->yoffset < 0)
-		var->yoffset = 0;
-
 	/* truncate xoffset and yoffset to maximum if too high */
 	if (var->xoffset > var->xres_virtual - var->xres)
 		var->xoffset = var->xres_virtual - var->xres - 1;
diff --git a/drivers/video/sa1100fb.c b/drivers/video/sa1100fb.c
index 10ddad8..c017b49 100644
--- a/drivers/video/sa1100fb.c
+++ b/drivers/video/sa1100fb.c
@@ -891,10 +891,10 @@ static int sa1100fb_activate_var(struct fb_var_screeninfo *var, struct sa1100fb_
 	if (var->vsync_len < 1    || var->vsync_len > 64)
 		printk(KERN_ERR "%s: invalid vsync_len %d\n",
 			fbi->fb.fix.id, var->vsync_len);
-	if (var->upper_margin < 0 || var->upper_margin > 255)
+	if (var->upper_margin > 255)
 		printk(KERN_ERR "%s: invalid upper_margin %d\n",
 			fbi->fb.fix.id, var->upper_margin);
-	if (var->lower_margin < 0 || var->lower_margin > 255)
+	if (var->lower_margin > 255)
 		printk(KERN_ERR "%s: invalid lower_margin %d\n",
 			fbi->fb.fix.id, var->lower_margin);
 #endif
diff --git a/drivers/video/sis/sis_main.c b/drivers/video/sis/sis_main.c
index 7e17ee9..650b155 100644
--- a/drivers/video/sis/sis_main.c
+++ b/drivers/video/sis/sis_main.c
@@ -1577,10 +1577,6 @@ sisfb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 	/* Adapt RGB settings */
 	sisfb_bpp_to_var(ivideo, var);
 
-	/* Sanity check for offsets */
-	if(var->xoffset < 0) var->xoffset = 0;
-	if(var->yoffset < 0) var->yoffset = 0;
-
 	if(var->xres > var->xres_virtual)
 		var->xres_virtual = var->xres;
 

------------------------------------------------------------------------------
Stay on top of everything new and different, both inside and 
around Java (TM) technology - register by April 22, and save
$200 on the JavaOne (SM) conference, June 2-5, 2009, San Francisco.
300 plus technical and hands-on sessions. Register today. 
Use priority code J9JMT32. http://p.sf.net/sfu/p
