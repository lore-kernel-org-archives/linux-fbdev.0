From: Antonino Daplas <adaplas@pol.net>
Subject: [Patch 3] Console Rotation
Date: 09 Sep 2002 22:22:49 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1031580881.632.13.camel@daplas>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [203.167.79.9] (helo=willow.compass.com.ph)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17oPQP-0003J4-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 09 Sep 2002 07:22:01 -0700
Received: from AP-202-70-99-9.compass.com.ph (AP-202-70-99-9.compass.com.ph [202.70.99.9])
	by willow.compass.com.ph (8.9.3/8.9.3) with ESMTP id WAA90385
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 9 Sep 2002 22:21:57 +0800 (PHT)
	(envelope-from adaplas@pol.net)
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: fbdev <linux-fbdev-devel@lists.sourceforge.net>

The patch (vesafb_rotate.diff) adds console rotation support to vesafb. 
The main change is addition of vesafb_check_var to check for the flags,
and swapping xres, yres, etc where appropriate. 

ypan should work okay, I'm not so sure about ywrap. 

Tony 

<<------------------------------------------------------------------------>> 
diff -Naur linux-2.5.33/drivers/video/Config.in linux/drivers/video/Config.in
--- linux-2.5.33/drivers/video/Config.in	Sun Sep  8 19:47:38 2002
+++ linux/drivers/video/Config.in	Sun Sep  8 19:50:38 2002
@@ -370,6 +370,13 @@
 	    define_tristate CONFIG_FBCON_ACCEL m
          fi       
       fi
+      if [ "$CONFIG_FB_VESA" = "y" ]; then
+	 define_tristate CONFIG_FBCON_ROTATE y
+      else
+	 if [ "$CONFIG_FB_VESA" = "m" ]; then 
+	    define_tristate CONFIG_FBCON_ROTATE m
+         fi       
+      fi
       if [ "$CONFIG_FB_AMIGA" = "y" ]; then
 	 define_tristate CONFIG_FBCON_AFB y
 	 define_tristate CONFIG_FBCON_ILBM y
diff -Naur linux-2.5.33/drivers/video/vesafb.c linux/drivers/video/vesafb.c
--- linux-2.5.33/drivers/video/vesafb.c	Sun Sep  8 19:34:40 2002
+++ linux/drivers/video/vesafb.c	Sun Sep  8 19:49:11 2002
@@ -27,6 +27,8 @@
 
 #include <video/fbcon.h>
 
+#include "fbcon-rotate.h"
+
 #define dac_reg	(0x3c8)
 #define dac_val	(0x3c9)
 
@@ -62,12 +64,18 @@
 static void            (*pmi_start)(void);
 static void            (*pmi_pal)(void);
 
+#ifdef FBCON_HAS_ROTATE
+static u32             xres;
+static u32             yres;
+static u32             vxres;
+static u32             vyres;
+#endif
 /* --------------------------------------------------------------------- */
 
 static int vesafb_pan_display(struct fb_var_screeninfo *var, int con,
                               struct fb_info *info)
 {
-	int offset;
+	int offset, depth = (var->bits_per_pixel + 7)/8;
 
 	if (!ypan)
 		return -EINVAL;
@@ -78,7 +86,19 @@
 	if ((ypan==1) && var->yoffset+var->yres > var->yres_virtual)
 		return -EINVAL;
 
-	offset = (var->yoffset * info->fix.line_length + var->xoffset) / 4;
+#ifdef FBCON_HAS_ROTATE
+	if (var->vmode & FB_VMODE_ROTATE_CW) 
+		offset = ((var->xoffset * info->fix.line_length) +
+			  ((var->yres_virtual - (var->yoffset + var->yres))) * depth) / 4;
+	else if (var->vmode & FB_VMODE_ROTATE_CCW)
+		offset = (((var->xres_virtual - (var->xoffset + var->xres)) * info->fix.line_length) +
+			  (var->yoffset * depth)) / 4;
+	else if (var->vmode & FB_VMODE_ROTATE_UD) 
+		offset = (((var->yres_virtual - (var->yoffset + var->yres)) * info->fix.line_length) +
+			  ((var->xres_virtual - (var->xoffset + var->xres))) * depth) / 4;
+	else
+#endif
+		offset = (var->yoffset * info->fix.line_length + var->xoffset) / 4;
 
         __asm__ __volatile__(
                 "call *(%%edi)"
@@ -173,11 +193,43 @@
     return 0;
 }
 
+static int vesafb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
+{
+#ifdef FBCON_HAS_ROTATE
+	u32 vmode;
+
+	vmode = var->vmode;
+	*var = info->var;
+	if (vmode & (FB_VMODE_ROTATE_CW | FB_VMODE_ROTATE_CCW)) {
+		var->xres = yres;
+		var->yres = xres;
+		var->xres_virtual = vyres;
+		var->yres_virtual = vxres;
+	}
+	else {
+		var->xres = xres;
+		var->yres = yres;
+		var->xres_virtual = vxres;
+		var->yres_virtual = vyres;
+	}		
+	vmode &= FB_ROTATE_MASK;
+	vmode |= info->var.vmode & ~FB_ROTATE_MASK;
+	var->vmode = vmode;
+#else
+	*var = info->var;
+#endif
+
+	var->xoffset = 0;
+	var->yoffset = 0;
+	return 0;
+}
+
 static struct fb_ops vesafb_ops = {
 	.owner		= THIS_MODULE,
 	.fb_set_var	= gen_set_var,
 	.fb_get_cmap	= gen_get_cmap,
 	.fb_set_cmap	= gen_set_cmap,
+	.fb_check_var   = vesafb_check_var,
 	.fb_setcolreg	= vesafb_setcolreg,
 	.fb_pan_display	= vesafb_pan_display,
 	.fb_fillrect	= cfb_fillrect,
@@ -300,6 +352,19 @@
 		ypan = 0;
 	}
 	
+#ifdef FBCON_HAS_ROTATE
+	xres = vesafb_defined.xres;
+	yres = vesafb_defined.yres;
+	vxres = vesafb_defined.xres_virtual;
+	vyres = vesafb_defined.yres_virtual;
+	if (vesafb_defined.vmode & (FB_VMODE_ROTATE_CW | FB_VMODE_ROTATE_CCW)) {
+		vesafb_defined.xres = yres;
+		vesafb_defined.yres = xres;
+		vesafb_defined.xres_virtual = vyres;
+		vesafb_defined.yres_virtual = vxres;
+	}
+#endif
+
 	/* some dummy values for timing to make fbset happy */
 	vesafb_defined.pixclock     = 10000000 / vesafb_defined.xres * 1000 / vesafb_defined.yres;
 	vesafb_defined.left_margin  = (vesafb_defined.xres / 8) & 0xf8;



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
