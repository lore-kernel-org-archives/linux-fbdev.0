From: Lucas Correia Villa Real <lucasvr@gobolinux.org>
Subject: [PATCH] skeletonfb
Date: Sun, 30 Jan 2005 19:11:17 -0200
Message-ID: <200501301911.17552.lucasvr@gobolinux.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_11U/BhIqezd0xo9"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CvMJr-0000Io-FJ
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 30 Jan 2005 13:09:19 -0800
Received: from linares.terra.com.br ([200.154.55.228])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CvMJp-0005qg-MR
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 30 Jan 2005 13:09:19 -0800
Content-Disposition: inline
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Geert Uytterhoeven <geert@linux-m68k.org>


--Boundary-00=_11U/BhIqezd0xo9
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

This patch just fixes some typos and adds retval documentation for some 
functions that were missing it.

I've also a question here: skeletonfb says that  xxxfb_setcolreg() should 
return a negative errno on error. However, if the register number being 
accessed is out of bounds, 1 is returned. Shouldn't it be better to return 
-EINVAL instead?  By looking at fbcmap.c, the retval isn't being checked 
against positive/negative values, so it doesn't make sense to return 1. 

Thanks,

-- 
Lucas
powered by /dev/dsp

--Boundary-00=_11U/BhIqezd0xo9
Content-Type: text/x-diff;
  charset="us-ascii";
  name="skeletonfb.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="skeletonfb.patch"

--- linux-2.6.10-lucasvr/drivers/video/skeletonfb.c.orig	2005-01-25 23:02:56.000000000 -0200
+++ linux-2.6.10-lucasvr/drivers/video/skeletonfb.c	2005-01-30 19:07:32.000000000 -0200
@@ -120,7 +120,7 @@
 static struct fb_info info;
 
     /* 
-     * Each one represents the a state of the hardware. Most hardware have 
+     * Each one represents the state of the hardware. Most hardware have 
      * just one hardware state. These here represent the default state(s). 
      */
 static struct xxx_par __initdata current_par;
@@ -139,6 +139,8 @@
  *	Usually you don't need to provide this function. The case where it 
  *	is used is to change from a text mode hardware state to a graphics
  * 	mode state. 
+ * 	
+ *	Returns negative errno on error, or zero on success.
  */
 static int xxxfb_open(const struct fb_info *info, int user)
 {
@@ -156,6 +158,8 @@
  *	console system is released. Usually you don't need this function.
  *	The case where it is usually used is to go from a graphics state
  *	to a text mode state.
+ *
+ *	Returns negative errno on error, or zero on success.
  */
 static int xxxfb_release(const struct fb_info *info, int user)
 {
@@ -201,8 +205,9 @@
  *	fb_info since we are using that data. This means we depend on the
  *	data in var inside fb_info to be supported by the hardware. 
  *	xxxfb_check_var is always called before xxxfb_set_par to ensure this.
- *	Again if you can't can't the resolution you don't need this function.
- *
+ *	Again if you can't change the resolution you don't need this function.
+ *	
+ *	Returns negative errno on error, or zero on success.
  */
 static int xxxfb_set_par(struct fb_info *info)
 {
@@ -217,14 +222,14 @@
  *      @red: The red value which can be up to 16 bits wide 
  *	@green: The green value which can be up to 16 bits wide 
  *	@blue:  The blue value which can be up to 16 bits wide.
- *	@transp: If supported the alpha value which can be up to 16 bits wide.	
+ *	@transp: If supported, the alpha value which can be up to 16 bits wide.	
  *      @info: frame buffer info structure
  * 
  *  	Set a single color register. The values supplied have a 16 bit
  *  	magnitude which needs to be scaled in this function for the hardware. 
  *	Things to take into consideration are how many color registers, if
  *	any, are supported with the current color visual. With truecolor mode
- *	no color palettes are supported. Here a psuedo palette is created 
+ *	no color palettes are supported. Here a pseudo palette is created 
  *	which we store the value in pseudo_palette in struct fb_info. For
  *	pseudocolor mode we have a limited color palette. To deal with this
  *	we can program what color is displayed for a particular pixel value.
@@ -238,7 +243,7 @@
 			   const struct fb_info *info)
 {
     if (regno >= 256)  /* no. of hw registers */
-       return 1;
+       return -EINVAL;
     /*
      * Program hardware... do anything you want with transp
      */
@@ -295,7 +300,7 @@
        u32 v;
 
        if (regno >= 16)
-           return 1;
+           return -EINVAL;
 
        v = (red << info->var.red.offset) |
            (green << info->var.green.offset) |
@@ -563,7 +568,7 @@
 #endif
 
     /* 
-     * Here we set the screen_base to the vitrual memory address
+     * Here we set the screen_base to the virtual memory address
      * for the framebuffer. Usually we obtain the resource address
      * from the bus layer and then translate it to virtual memory
      * space via ioremap. Consult ioport.h. 
@@ -621,6 +626,7 @@
      */
 
     unregister_framebuffer(info);
+    fb_dealloc_cmap(&info.cmap);
     /* ... */
 }
 

--Boundary-00=_11U/BhIqezd0xo9--


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
