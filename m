From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH] skeletonfb: Documentation update
Date: Sun, 11 Dec 2005 15:14:28 +0800
Message-ID: <439BD1D4.40309@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ElLSG-000769-AE
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 10 Dec 2005 23:17:08 -0800
Received: from zproxy.gmail.com ([64.233.162.203])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1ElLSE-0003EB-Pc
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 10 Dec 2005 23:17:08 -0800
Received: by zproxy.gmail.com with SMTP id z3so1180668nzf
        for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 10 Dec 2005 23:17:06 -0800 (PST)
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
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Update skeletonfb so it reflects recent (and somewhat old) changes
of the framebuffer layer.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/skeletonfb.c |  484 +++++++++++++++++++++++++++++++++++---------
 1 files changed, 384 insertions(+), 100 deletions(-)

diff --git a/drivers/video/skeletonfb.c b/drivers/video/skeletonfb.c
index a01e7ec..9b70777 100644
--- a/drivers/video/skeletonfb.c
+++ b/drivers/video/skeletonfb.c
@@ -115,7 +115,8 @@ static struct fb_fix_screeninfo xxxfb_fi
     /*
      *  If your driver supports multiple boards or it supports multiple 
      *  framebuffers, you should make these arrays, or allocate them 
-     *  dynamically (using kmalloc()). 
+     *  dynamically using framebuffer_alloc() and free them with
+     *  framebuffer_release().
      */ 
 static struct fb_info info;
 
@@ -179,18 +180,31 @@ static int xxxfb_release(const struct fb
  *	intent to only test a mode and not actually set it. The stuff in 
  *	modedb.c is a example of this. If the var passed in is slightly 
  *	off by what the hardware can support then we alter the var PASSED in
- *	to what we can do. If the hardware doesn't support mode change 
- * 	a -EINVAL will be returned by the upper layers. You don't need to 
- *	implement this function then. If you hardware doesn't support 
- *	changing the resolution then this function is not needed. In this
- *	case the driver woudl just provide a var that represents the static
- *	state the screen is in.
+ *	to what we can do.
+ *
+ *      For values that are off, this function must round them _up_ to the
+ *      next value that is supported by the hardware.  If the value is
+ *      greater than the highest value supported by the hardware, then this
+ *      function must return -EINVAL.
+ *
+ *      Exception to the above rule:  Some drivers have a fixed mode, ie,
+ *      the hardware is already set at boot up, and cannot be changed.  In
+ *      this case, it is more acceptable that this function just return
+ *      a copy of the currently working var (info->var). Better is to not
+ *      implement this function, as the upper layer will do the copying
+ *      of the current var for you.
+ *
+ *      Note:  This is the only function where the contents of var can be
+ *      freely adjusted after the driver has been registered. If you find
+ *      that you have code outside of this function that alters the content
+ *      of var, then you are doing something wrong.  Note also that the
+ *      contents of info->var must be left untouched at all times after
+ *      driver registration.
  *
  *	Returns negative errno on error, or zero on success.
  */
 static int xxxfb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 {
-    const struct xxx_par *par = (const struct xxx_par *) info->par;
     /* ... */
     return 0;	   	
 }
@@ -204,14 +218,39 @@ static int xxxfb_check_var(struct fb_var
  *	fb_fix_screeninfo stored in fb_info. It doesn't not alter var in 
  *	fb_info since we are using that data. This means we depend on the
  *	data in var inside fb_info to be supported by the hardware. 
- *	xxxfb_check_var is always called before xxxfb_set_par to ensure this.
+ *
+ *      This function is also used to recover/restore the hardware to a
+ *      known working state.
+ *
+ *	xxxfb_check_var is always called before xxxfb_set_par to ensure that
+ *      the contents of var is always valid.
+ *
  *	Again if you can't change the resolution you don't need this function.
  *
+ *      However, even if your hardware does not support mode changing,
+ *      a set_par might be needed to at least initialize the hardware to
+ *      a known working state, especially if it came back from another
+ *      process that also modifies the same hardware, such as X.
+ *
+ *      If this is the case, a combination such as the following should work:
+ *
+ *      static int xxxfb_check_var(struct fb_var_screeninfo *var,
+ *                                struct fb_info *info)
+ *      {
+ *              *var = info->var;
+ *              return 0;
+ *      }
+ *
+ *      static int xxxfb_set_par(struct fb_info *info)
+ *      {
+ *              init your hardware here
+ *      }
+ *
  *	Returns negative errno on error, or zero on success.
  */
 static int xxxfb_set_par(struct fb_info *info)
 {
-    struct xxx_par *par = (struct xxx_par *) info->par;
+    struct xxx_par *par = info->par;
     /* ... */
     return 0;	
 }
@@ -258,70 +297,110 @@ static int xxxfb_setcolreg(unsigned regn
      *   var->{color}.offset contains start of bitfield
      *   var->{color}.length contains length of bitfield
      *   {hardwarespecific} contains width of DAC
-     *   cmap[X] is programmed to (X << red.offset) | (X << green.offset) | (X << blue.offset)
+     *   pseudo_palette[X] is programmed to (X << red.offset) |
+     *                                      (X << green.offset) |
+     *                                      (X << blue.offset)
      *   RAMDAC[X] is programmed to (red, green, blue)
+     *   color depth = SUM(var->{color}.length)
      *
      * Pseudocolor:
-     *    uses offset = 0 && length = DAC register width.
      *    var->{color}.offset is 0
-     *    var->{color}.length contains widht of DAC
-     *    cmap is not used
-     *    DAC[X] is programmed to (red, green, blue)
+     *    var->{color}.length contains width of DAC or the number of unique
+     *                        colors available (color depth)
+     *    pseudo_palette is not used
+     *    RAMDAC[X] is programmed to (red, green, blue)
+     *    color depth = var->{color}.length
+     *
+     * Static pseudocolor:
+     *    same as Pseudocolor, but the RAMDAC is not programmed (read-only)
+     *
+     * Mono01/Mono10:
+     *    Has only 2 values, black on white or white on black (fg on bg),
+     *    var->{color}.offset is 0
+     *    white = (1 << var->{color}.length) - 1, black = 0
+     *    pseudo_palette is not used
+     *    RAMDAC does not exist
+     *    color depth is always 2
+     *
      * Truecolor:
      *    does not use RAMDAC (usually has 3 of them).
      *    var->{color}.offset contains start of bitfield
      *    var->{color}.length contains length of bitfield
-     *    cmap is programmed to (red << red.offset) | (green << green.offset) |
-     *                      (blue << blue.offset) | (transp << transp.offset)
+     *    pseudo_palette is programmed to (red << red.offset) |
+     *                                    (green << green.offset) |
+     *                                    (blue << blue.offset) |
+     *                                    (transp << transp.offset)
      *    RAMDAC does not exist
+     *    color depth = SUM(var->{color}.length})
+     *
+     *  The color depth is used by fbcon for choosing the logo and also
+     *  for color palette transformation if color depth < 4
+     *
+     *  As can be seen from the above, the field bits_per_pixel is _NOT_
+     *  a criteria for describing the color visual.
+     *
+     *  A common mistake is assuming that bits_per_pixel <= 8 is pseudocolor,
+     *  and higher than that, true/directcolor.  This is incorrect, one needs
+     *  to look at the fix->visual.
+     *
+     *  Another common mistake is using bits_per_pixel to calculate the color
+     *  depth.  The bits_per_pixel field does not directly translate to color
+     *  depth. You have to compute for the color depth (using the color
+     *  bitfields) and fix->visual as seen above.
+     */
+
+    /*
+     * This is the point where the color is converted to something that
+     * is acceptable by the hardware.
      */
 #define CNVT_TOHW(val,width) ((((val)<<(width))+0x7FFF-(val))>>16)
-    switch (info->fix.visual) {
-       case FB_VISUAL_TRUECOLOR:
-       case FB_VISUAL_PSEUDOCOLOR:
-               red = CNVT_TOHW(red, info->var.red.length);
-               green = CNVT_TOHW(green, info->var.green.length);
-               blue = CNVT_TOHW(blue, info->var.blue.length);
-               transp = CNVT_TOHW(transp, info->var.transp.length);
-               break;
-       case FB_VISUAL_DIRECTCOLOR:
-	       /* example here assumes 8 bit DAC. Might be different 
-		* for your hardware */	
-               red = CNVT_TOHW(red, 8);       
-               green = CNVT_TOHW(green, 8);
-               blue = CNVT_TOHW(blue, 8);
-               /* hey, there is bug in transp handling... */
-               transp = CNVT_TOHW(transp, 8);
-               break;
-    }
+    red = CNVT_TOHW(red, info->var.red.length);
+    green = CNVT_TOHW(green, info->var.green.length);
+    blue = CNVT_TOHW(blue, info->var.blue.length);
+    transp = CNVT_TOHW(transp, info->var.transp.length);
 #undef CNVT_TOHW
-    /* Truecolor has hardware independent palette */
-    if (info->fix.visual == FB_VISUAL_TRUECOLOR) {
-       u32 v;
-
-       if (regno >= 16)
-           return -EINVAL;
-
-       v = (red << info->var.red.offset) |
-           (green << info->var.green.offset) |
-           (blue << info->var.blue.offset) |
-           (transp << info->var.transp.offset);
-
-       switch (info->var.bits_per_pixel) {
-		case 8:
-			/* Yes some hand held devices have this. */ 
-           		((u8*)(info->pseudo_palette))[regno] = v;
-			break;	
-   		case 16:
-           		((u16*)(info->pseudo_palette))[regno] = v;
-			break;
-		case 24:
-		case 32:	
-           		((u32*)(info->pseudo_palette))[regno] = v;
-			break;
-       }
-       return 0;
+    /*
+     * This is the point where the function feeds the color to the hardware
+     * palette after converting the colors to something acceptable by
+     * the hardware. Note, only FB_VISUAL_DIRECTCOLOR and
+     * FB_VISUAL_PSEUDOCOLOR visuals need to write to the hardware palette.
+     * If you have code that writes to the hardware CLUT, and it's not
+     * any of the above visuals, then you are doing something wrong.
+     */
+    if (info->fix.visual == FB_VISUAL_DIRECTCOLOR ||
+	info->fix.visual == FB_VISUAL_TRUECOLOR)
+	    write_{red|green|blue|transp}_to_clut();
+
+    /* This is the point were you need to fill up the contents of
+     * info->pseudo_palette. This structure is used _only_ by fbcon, thus
+     * it only contains 16 entries to match the number of colors supported
+     * by the console. The pseudo_palette is used only if the visual is
+     * in directcolor or truecolor mode.  With other visuals, the
+     * pseudo_palette is not used. (This might change in the future.)
+     *
+     * The contents of the pseudo_palette is in raw pixel format.  Ie, each
+     * entry can be written directly to the framebuffer without any conversion.
+     * The pseudo_palette is (void *).  However, if using the generic
+     * drawing functions (cfb_imageblit, cfb_fillrect), the pseudo_palette
+     * must be casted to (u32 *) _regardless_ of the bits per pixel. If the
+     * driver is using its own drawing functions, then it can use whatever
+     * size it wants.
+     */
+    if (info->fix.visual == FB_VISUAL_TRUECOLOR ||
+	info->fix.visual == FB_VISUAL_DIRECTCOLOR) {
+	    u32 v;
+
+	    if (regno >= 16)
+		    return -EINVAL;
+
+	    v = (red << info->var.red.offset) |
+		    (green << info->var.green.offset) |
+		    (blue << info->var.blue.offset) |
+		    (transp << info->var.transp.offset);
+
+	    ((u32*)(info->pseudo_palette))[regno] = v;
     }
+
     /* ... */
     return 0;
 }
@@ -340,6 +419,17 @@ static int xxxfb_setcolreg(unsigned regn
 static int xxxfb_pan_display(struct fb_var_screeninfo *var,
 			     const struct fb_info *info)
 {
+    /*
+     * If your hardware does not support panning, _do_ _not_ implement this
+     * function. Creating a dummy function will just confuse user apps.
+     */
+
+    /*
+     * Note that even if this function is fully functional, a setting of
+     * 0 in both xpanstep and ypanstep means that this function will never
+     * get called.
+     */
+
     /* ... */
     return 0;
 }
@@ -349,15 +439,20 @@ static int xxxfb_pan_display(struct fb_v
  *      @blank_mode: the blank mode we want. 
  *      @info: frame buffer structure that represents a single frame buffer
  *
- *      Blank the screen if blank_mode != 0, else unblank. Return 0 if
- *      blanking succeeded, != 0 if un-/blanking failed due to e.g. a 
- *      video mode which doesn't support it. Implements VESA suspend
- *      and powerdown modes on hardware that supports disabling hsync/vsync:
- *      blank_mode == 2: suspend vsync
- *      blank_mode == 3: suspend hsync
- *      blank_mode == 4: powerdown
+ *      Blank the screen if blank_mode != FB_BLANK_UNBLANK, else unblank.
+ *      Return 0 if blanking succeeded, != 0 if un-/blanking failed due to
+ *      e.g. a video mode which doesn't support it.
+ *
+ *      Implements VESA suspend and powerdown modes on hardware that supports
+ *      disabling hsync/vsync:
+ *
+ *      FB_BLANK_NORMAL = display is blanked, syncs are on.
+ *      FB_BLANK_HSYNC_SUSPEND = hsync off
+ *      FB_BLANK_VSYNC_SUSPEND = vsync off
+ *      FB_BLANK_POWERDOWN =  hsync and vsync off
  *
- *      Returns negative errno on error, or zero on success.
+ *      If implementing this function, at least support FB_BLANK_UNBLANK.
+ *      Return !0 for any modes that are unimplemented.
  *
  */
 static int xxxfb_blank(int blank_mode, const struct fb_info *info)
@@ -454,6 +549,14 @@ void xxxfb_imageblit(struct fb_info *p, 
  *	@data: The actual data used to construct the image on the display.
  *	@cmap: The colormap used for color images.   
  */
+
+/*
+ * The generic function, cfb_imageblit, expects that the bitmap scanlines are
+ * padded to the next byte.  Most hardware accelerators may require padding to
+ * the next u16 or the next u32.  If that is the case, the driver can specify
+ * this by setting info->pixmap.scan_align = 2 or 4.  See a more
+ * comprehensive description of the pixmap below.
+ */
 }
 
 /**
@@ -517,6 +620,7 @@ int xxxfb_cursor(struct fb_info *info, s
  */
 void xxxfb_rotate(struct fb_info *info, int angle)
 {
+/* Will be deprecated */
 }
 
 /**
@@ -540,6 +644,9 @@ void xxxfb_poll(struct fb_info *info, po
  *		     so we can have consistent display output. 
  *
  *      @info: frame buffer structure that represents a single frame buffer
+ *
+ *      If the driver has implemented its own hardware-based drawing function,
+ *      implementing this function is highly recommended.
  */
 void xxxfb_sync(struct fb_info *info)
 {
@@ -549,20 +656,25 @@ void xxxfb_sync(struct fb_info *info)
      *  Initialization
      */
 
-int __init xxxfb_init(void)
-{
+/* static int __init xxfb_probe (struct device *device) -- for platform devs */
+static int __init xxxfb_probe(struct pci_dev *dev,
+			      const_struct pci_device_id *ent)
+{
+    struct fb_info *info;
+    struct xxx_par *par;
+    struct device = &dev->dev; /* for pci drivers */
     int cmap_len, retval;	
    
     /*
-     *  For kernel boot options (in 'video=xxxfb:<options>' format)
+     * Dynamically allocate info and par
      */
-#ifndef MODULE
-    char *option = NULL;
+    info = framebuffer_alloc(sizeof(struct xxx_par), device);
 
-    if (fb_get_options("xxxfb", &option))
-	    return -ENODEV;
-    xxxfb_setup(option);
-#endif
+    if (!info) {
+	    /* goto error path */
+    }
+
+    par = info->par;
 
     /* 
      * Here we set the screen_base to the virtual memory address
@@ -570,18 +682,87 @@ int __init xxxfb_init(void)
      * from the bus layer and then translate it to virtual memory
      * space via ioremap. Consult ioport.h. 
      */
-    info.screen_base = framebuffer_virtual_memory;	
-    info.fbops = &xxxfb_ops;
-    info.fix = xxxfb_fix;
-    info.pseudo_palette = pseudo_palette;
-
+    info->screen_base = framebuffer_virtual_memory;
+    info->fbops = &xxxfb_ops;
+    info->fix = xxxfb_fix; /* this will be the only time xxxfb_fix will be
+			    * used, so mark it as __initdata
+			    */
+    info->pseudo_palette = pseudo_palette; /* The pseudopalette is an
+					    * 16-member array
+					    */
     /*
      * Set up flags to indicate what sort of acceleration your
      * driver can provide (pan/wrap/copyarea/etc.) and whether it
      * is a module -- see FBINFO_* in include/linux/fb.h
+     *
+     * If your hardware can support any of the hardware accelerated functions
+     * fbcon performance will improve if info->flags is set properly.
+     *
+     * FBINFO_HWACCEL_COPYAREA - hardware moves
+     * FBINFO_HWACCEL_FILLRECT - hardware fills
+     * FBINFO_HWACCEL_IMAGEBLIT - hardware mono->color expansion
+     * FBINFO_HWACCEL_YPAN - hardware can pan display in y-axis
+     * FBINFO_HWACCEL_YWRAP - hardware can wrap display in y-axis
+     * FBINFO_HWACCEL_DISABLED - supports hardware accels, but disabled
+     * FBINFO_READS_FAST - if set, prefer moves over mono->color expansion
+     * FBINFO_MISC_TILEBLITTING - hardware can do tile blits
+     *
+     * NOTE: These are for fbcon use only.
+     */
+    info->flags = FBINFO_DEFAULT;
+
+/********************* This stage is optional ******************************/
+     /*
+     * The struct pixmap is a scratch pad for the drawing functions. This
+     * is where the monochrome bitmap is constructed by the higher layers
+     * and then passed to the accelerator.  For drivers that uses
+     * cfb_imageblit, you can skip this part.  For those that have a more
+     * rigorous requirement, this stage is needed
+     */
+
+    /* PIXMAP_SIZE should be small enough to optimize drawing, but not
+     * large enough that memory is wasted.  A safe size is
+     * (max_xres * max_font_height/8). max_xres is driver dependent,
+     * max_font_height is 32.
+     */
+    info->pixmap.addr = kmalloc(PIXMAP_SIZE, GFP_KERNEL);
+    if (!info->pixmap.addr) {
+	    /* goto error */
+    }
+
+    info->pixmap.size = PIXMAP_SIZE;
+
+    /*
+     * FB_PIXMAP_SYSTEM - memory is in system ram
+     * FB_PIXMAP_IO     - memory is iomapped
+     * FB_PIXMAP_SYNC   - if set, will call fb_sync() per access to pixmap,
+     *                    usually if FB_PIXMAP_IO is set.
+     *
+     * Currently, FB_PIXMAP_IO is unimplemented.
      */
-    info.flags = FBINFO_DEFAULT;
-    info.par = current_par;
+    info->pixmap.flags = FB_PIXMAP_SYSTEM;
+
+    /*
+     * scan_align is the number of padding for each scanline.  It is in bytes.
+     * Thus for accelerators that need padding to the next u32, put 4 here.
+     */
+    info->pixmap.scan_align = 4;
+
+    /*
+     * buf_align is the amount to be padded for the buffer. For example,
+     * the i810fb needs a scan_align of 2 but expects it to be fed with
+     * dwords, so a buf_align = 4 is required.
+     */
+    info->pixmap.buf_align = 4;
+
+    /* access_align is how many bits can be accessed from the framebuffer
+     * ie. some epson cards allow 16-bit access only.  Most drivers will
+     * be safe with u32 here.
+     *
+     * NOTE: This field is currently unused.
+     */
+    info->pixmap.scan_align = 32
+/***************************** End optional stage ***************************/
 
     /*
      * This should give a reasonable default video mode. The following is
@@ -590,42 +771,145 @@ int __init xxxfb_init(void)
     if (!mode_option)
 	mode_option = "640x480@60";	 	
 
-    retval = fb_find_mode(&info.var, &info, mode_option, NULL, 0, NULL, 8);
+    retval = fb_find_mode(info->var, info, mode_option, NULL, 0, NULL, 8);
   
     if (!retval || retval == 4)
 	return -EINVAL;			
 
     /* This has to been done !!! */	
-    fb_alloc_cmap(&info.cmap, cmap_len, 0);
+    fb_alloc_cmap(info->cmap, cmap_len, 0);
 	
     /* 
      * The following is done in the case of having hardware with a static 
      * mode. If we are setting the mode ourselves we don't call this. 
      */	
-    info.var = xxxfb_var;
-	
-    if (register_framebuffer(&info) < 0)
+    info->var = xxxfb_var;
+
+    /*
+     * For drivers that can...
+     */
+    xxxfb_check_var(&info->var, info);
+
+    /*
+     * Does a call to fb_set_par() before register_framebuffer needed?  This
+     * will depend on you and the hardware.  If you are sure that your driver
+     * is the only device in the system, a call to fb_set_par() is safe.
+     *
+     * Hardware in x86 systems has a VGA core.  Calling set_par() at this
+     * point will corrupt the VGA console, so it might be safer to skip a
+     * call to set_par here and just allow fbcon to do it for you.
+     */
+    /* xxxfb_set_par(info); */
+
+    if (register_framebuffer(info) < 0)
 	return -EINVAL;
-    printk(KERN_INFO "fb%d: %s frame buffer device\n", info.node,
-	   info.fix.id);
+    printk(KERN_INFO "fb%d: %s frame buffer device\n", info->node,
+	   info->fix.id);
+    pci_set_drvdata(dev, info); /* or dev_set_drvdata(device, info) */
     return 0;
 }
 
     /*
      *  Cleanup
      */
+/* static void __exit xxxfb_remove(struct device *device) */
+static void __exit xxxfb_remove(struct pci_dev *dev)
+{
+	struct fb_info *info = pci_get_drv_data(dev);
+	/* or dev_get_drv_data(device); */
 
-static void __exit xxxfb_cleanup(void)
+	if (info) {
+		unregister_framebuffer(info);
+		fb_dealloc_cmap(&info.cmap);
+		/* ... */
+		framebuffer_release(info);
+	}
+
+	return 0;
+}
+
+#if CONFIG_PCI
+/* For PCI drivers */
+static struct pci_driver xxxfb_driver = {
+	.name =		"xxxfb",
+	.id_table =	xxxfb_devices,
+	.probe =	xxxfb_probe,
+	.remove =	__devexit_p(xxxfb_remove),
+	.suspend =      xxxfb_suspend, /* optional */
+	.resume =       xxxfb_resume,  /* optional */
+};
+
+static int __init xxxfb_init(void)
 {
-    /*
-     *  If your driver supports multiple boards, you should unregister and
-     *  clean up all instances.
-     */
+	/*
+	 *  For kernel boot options (in 'video=xxxfb:<options>' format)
+	 */
+#ifndef MODULE
+	char *option = NULL;
 
-    unregister_framebuffer(info);
-    fb_dealloc_cmap(&info.cmap);
-    /* ... */
+	if (fb_get_options("xxxfb", &option))
+		return -ENODEV;
+	xxxfb_setup(option);
+#endif
+
+	return pci_register_driver(&xxxfb_driver);
+}
+
+static void __exit xxxfb_exit(void)
+{
+	pci_unregister_driver(&xxxfb_driver);
+}
+#else
+#include <linux/platform_device.h>
+/* for platform devices */
+static struct device_driver xxxfb_driver = {
+	.name = "xxxfb",
+	.bus  = &platform_bus_type,
+	.probe = xxxfb_probe,
+	.remove = xxxfb_remove,
+	.suspend = xxxfb_suspend, /* optional */
+	.resume = xxxfb_resume,   /* optional */
+};
+
+static struct platform_device xxxfb_device = {
+	.name = "xxxfb",
+};
+
+static int __init xxxfb_init(void)
+{
+	int ret;
+	/*
+	 *  For kernel boot options (in 'video=xxxfb:<options>' format)
+	 */
+#ifndef MODULE
+	char *option = NULL;
+
+	if (fb_get_options("xxxfb", &option))
+		return -ENODEV;
+	xxxfb_setup(option);
+#endif
+	ret = driver_register(&xxxfb_driver);
+
+	if (!ret) {
+		ret = platform_device_register(&xxxfb_device);
+		if (ret)
+			driver_unregister(&xxxfb_driver);
+	}
+
+	return ret;
+}
+
+static void __exit xxxfb_exit(void)
+{
+	platform_device_unregister(&xxxfb_device);
+	driver_unregister(&xxxfb_driver);
 }
+#endif
+
+MODULE_LICENSE("GPL");
+module_init(xxxfb_init);
+module_exit(xxxfb_exit);
+
 
     /*
      *  Setup



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
