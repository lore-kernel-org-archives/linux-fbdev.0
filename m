From: David Eger <eger@havoc.gtf.org>
Subject: [PATCH] sisfb accel capabilities
Date: Wed, 2 Jun 2004 22:44:12 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040603024412.GE20951@havoc.gtf.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BViDp-0002zb-VU
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 02 Jun 2004 19:44:49 -0700
Received: from havoc.gtf.org ([216.162.42.101])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BViDp-0003Jf-GO
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 02 Jun 2004 19:44:49 -0700
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Winischhofer <thomas@winischhofer.net>
Cc: linux-fbdev-devel@lists.sourceforge.net


Dear Thomas,

The following patch updates sisfb for the new fb accel capabilities
patch I'm sending upstream.  By default, this patch will rely on your
copyarea() and fillrect() accel functions instead of the panning. 
Please test the core patch + this patch, and let me know your console
works.  I'm interested to hear what speeds you see :-)

Also, using fbset to turn acceleration on and off ought to work, though
i still think this is better done via sysfs... just don't have time to
learn that ATM...

-dte

sisfb: update to new fbinfo.flags accel capabilities

Signed-off-by: David Eger <eger@havoc.gtf.org>
 
# drivers/video/sis/sis_main.h
#   2004/06/02 22:49:50+02:00 eger@rosencrantz.theboonies.us +1 -1
#   get rid of referece to setup variable
# 
# drivers/video/sis/sis_main.c
#   2004/06/02 22:49:49+02:00 eger@rosencrantz.theboonies.us +33 -35
#   migrate to new fbinfo->flags hwaccel semantics;
#   
#   get rid of attempt to do "wrap" in pan_display, 
#   as the code doesn't seem to indicate it actually ever worked.
#   wrap is just a weird amiga thing anyways ;-)
# 
# drivers/video/sis/sis_accel.h
#   2004/06/02 22:49:49+02:00 eger@rosencrantz.theboonies.us +0 -1
#   get rid of referece to setup variable
# 
# drivers/video/sis/sis_accel.c
#   2004/06/02 22:49:49+02:00 eger@rosencrantz.theboonies.us +0 -1
#   get rid of referece to setup variable
# 
diff -Nru a/drivers/video/sis/sis_accel.c b/drivers/video/sis/sis_accel.c
--- a/drivers/video/sis/sis_accel.c	Wed Jun  2 22:51:34 2004
+++ b/drivers/video/sis/sis_accel.c	Wed Jun  2 22:51:34 2004
@@ -79,7 +79,6 @@
 
 extern struct     video_info ivideo;
 extern VGA_ENGINE sisvga_engine;
-extern int sisfb_accel;
 
 static const int sisALUConv[] =
 {
diff -Nru a/drivers/video/sis/sis_accel.h b/drivers/video/sis/sis_accel.h
--- a/drivers/video/sis/sis_accel.h	Wed Jun  2 22:51:34 2004
+++ b/drivers/video/sis/sis_accel.h	Wed Jun  2 22:51:34 2004
@@ -525,7 +525,6 @@
                        int srcx, int height, int width);
 #endif
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,34)
-extern int sisfb_accel;
 void fbcon_sis_fillrect(struct fb_info *info, const struct fb_fillrect *rect);
 void fbcon_sis_copyarea(struct fb_info *info, const struct fb_copyarea *area);
 #endif
diff -Nru a/drivers/video/sis/sis_main.c b/drivers/video/sis/sis_main.c
--- a/drivers/video/sis/sis_main.c	Wed Jun  2 22:51:34 2004
+++ b/drivers/video/sis/sis_main.c	Wed Jun  2 22:51:34 2004
@@ -1104,10 +1104,19 @@
 		ivideo.org_x = ivideo.org_y = 0;
 		ivideo.video_linelength = ivideo.video_width * (ivideo.video_bpp >> 3);
 		ivideo.accel = 0;
+#if defined(STUPID_ACCELF_TEXT_SHIT) || LINUX_VERSION_CODE < KERNEL_VERSION(2,6,5)
+	if (var->accel_flags == FB_ACCELF_TEXT)
+		info->flags &= ~FBINFO_HWACCEL_DISABLED;
+	else
+		info->flags |= FBINFO_HWACCEL_DISABLED;
+#endif
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,5)
+		ivideo.accel = !(info->flags & FBINFO_HWACCEL_DISABLED);
+#else
 		if(sisfb_accel) {
 		   ivideo.accel = (var->accel_flags & FB_ACCELF_TEXT) ? -1 : 0;
 		}
-
+#endif
 		sisfb_set_vparms();
 
 		ivideo.current_width = ivideo.video_width;
@@ -1654,14 +1663,11 @@
 {
 	int err;
 
-	if (var->vmode & FB_VMODE_YWRAP) {
-		if (var->yoffset < 0 || var->yoffset >= fb_display[con].var.yres_virtual || var->xoffset)
-			return -EINVAL;
-	} else {
-		if (var->xoffset+fb_display[con].var.xres > fb_display[con].var.xres_virtual ||
-		    var->yoffset+fb_display[con].var.yres > fb_display[con].var.yres_virtual)
-			return -EINVAL;
-	}
+	if (var->vmode & FB_VMODE_YWRAP)
+		return -EINVAL;
+	if (var->xoffset+fb_display[con].var.xres > fb_display[con].var.xres_virtual ||
+	    var->yoffset+fb_display[con].var.yres > fb_display[con].var.yres_virtual)
+		return -EINVAL;
 
         if(con == currcon) {
 	   if((err = sisfb_pan_var(var)) < 0) return err;
@@ -1669,10 +1675,6 @@
 
 	fb_display[con].var.xoffset = var->xoffset;
 	fb_display[con].var.yoffset = var->yoffset;
-	if (var->vmode & FB_VMODE_YWRAP)
-		fb_display[con].var.vmode |= FB_VMODE_YWRAP;
-	else
-		fb_display[con].var.vmode &= ~FB_VMODE_YWRAP;
 
 	return 0;
 }
@@ -2060,30 +2062,21 @@
 {
 	int err;
 
+	if (var->vmode & FB_VMODE_YWRAP) 
+	    	return -EINVAL;
 	if (var->xoffset > (var->xres_virtual - var->xres))
 		return -EINVAL;
 	if (var->yoffset > (var->yres_virtual - var->yres))
 		return -EINVAL;
 
-	if (var->vmode & FB_VMODE_YWRAP) {
-		if (var->yoffset < 0 ||
-		    var->yoffset >= info->var.yres_virtual ||
-		    var->xoffset)
-		    	return -EINVAL;
-	} else {
-		if (var->xoffset + info->var.xres > info->var.xres_virtual ||
-		    var->yoffset + info->var.yres > info->var.yres_virtual)
-			return -EINVAL;
-	}
+	if (var->xoffset + info->var.xres > info->var.xres_virtual ||
+	    var->yoffset + info->var.yres > info->var.yres_virtual)
+		return -EINVAL;
     
 	if((err = sisfb_pan_var(var)) < 0) return err;
 
 	info->var.xoffset = var->xoffset;
 	info->var.yoffset = var->yoffset;
-	if (var->vmode & FB_VMODE_YWRAP)
-		info->var.vmode |= FB_VMODE_YWRAP;
-	else
-		info->var.vmode &= ~FB_VMODE_YWRAP;
 
 	return 0;
 }
@@ -2111,7 +2104,7 @@
 	mmio_off = PAGE_ALIGN((start & ~PAGE_MASK) + ivideo.heapstart);
 	if(off >= mmio_off) {
 		off -= mmio_off;		
-		if(info->var.accel_flags) return -EINVAL;
+		if (!(info->flags & FBINFO_HWACCEL_DISABLED)) return -EINVAL;
 
 		start = (unsigned long) ivideo.mmio_base;
 		len = PAGE_ALIGN((start & ~PAGE_MASK) + sisfb_mmio_size);
@@ -4897,12 +4890,12 @@
 	   	   }
 	        }
 
-		ivideo.accel = 0;
-		if(sisfb_accel) {
-		   ivideo.accel = -1;
-		   default_var.accel_flags |= FB_ACCELF_TEXT;
-		   sisfb_initaccel();
-		}
+		ivideo.accel = sisfb_accel;
+		sisfb_initaccel();
+
+#ifdef STUPID_ACCELF_TEXT_SHIT
+		default_var.accel_flags = sisfb_accel ? FB_ACCELF_TEXT : 0;
+#endif
 
 		if(sisfb_ypan) {
 		   /* Maximize regardless of sisfb_max at startup */
@@ -4914,7 +4907,12 @@
 	    	   }
 		}
 
-		sis_fb_info->flags = FBINFO_FLAG_DEFAULT;
+		sis_fb_info->flags = FBINFO_DEFAULT
+				   | FBINFO_HWACCEL_YPAN
+				   | FBINFO_HWACCEL_XPAN
+				   | FBINFO_HWACCEL_COPYAREA
+				   | FBINFO_HWACCEL_FILLRECT
+				   | ((sisfb_accel) ? 0 : FBINFO_HWACCEL_DISABLED);
 		sis_fb_info->var = default_var;
 		sis_fb_info->fix = sisfb_fix;
 		sis_fb_info->par = &ivideo;
diff -Nru a/drivers/video/sis/sis_main.h b/drivers/video/sis/sis_main.h
--- a/drivers/video/sis/sis_main.h	Wed Jun  2 22:51:34 2004
+++ b/drivers/video/sis/sis_main.h	Wed Jun  2 22:51:34 2004
@@ -402,7 +402,7 @@
 static int sisfb_fstn = 0;
 
 VGA_ENGINE sisvga_engine = UNKNOWN_VGA;
-int 	   sisfb_accel = -1;
+static int sisfb_accel = -1; /* synced to !(info.flags & FBINFO_HWACCEL_DISABLED */
 
 /* These are to adapted according to VGA_ENGINE type */
 static int sisfb_hwcursor_size = 0;


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
