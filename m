From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Apollo framebuffer sysfs
Date: Mon, 23 Feb 2004 21:00:57 +0100 (MET)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.GSO.4.58.0402201402080.23753@waterleaf.sonytel.be>
References: <Pine.LNX.4.44.0402181910540.10389-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0402181910540.10389-100000@phoenix.infradead.org>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 18 Feb 2004, James Simmons wrote:
>   Another driver adapted to sysfs. Please test.

Wow, the first platform_device on m68k ;-)

  - Fix compilation (missing semicolon)
  - Use __devinit* where appropriate
  - Remove superfluous whitespace (hurts my eyes with let c_space_errors=1)

--- drivers/video/dnfb.c.orig	2004-02-19 18:55:35.000000000 +0100
+++ drivers/video/dnfb.c	2004-02-23 20:59:20.000000000 +0100
@@ -117,7 +117,7 @@
 	.fb_cursor	= soft_cursor,
 };

-struct fb_var_screeninfo dnfb_var __initdata = {
+struct fb_var_screeninfo dnfb_var __devinitdata = {
 	.xres		1280,
 	.yres		1024,
 	.xres_virtual	2048,
@@ -128,7 +128,7 @@
 	.vmode		FB_VMODE_NONINTERLACED,
 };

-static struct fb_fix_screeninfo dnfb_fix __initdata = {
+static struct fb_fix_screeninfo dnfb_fix __devinitdata = {
 	.id		"Apollo Mono",
 	.smem_start	(FRAME_BUFFER_START + IO_BASE),
 	.smem_len	FRAME_BUFFER_LEN,
@@ -146,7 +146,7 @@
 	return 0;
 }

-static
+static
 void dnfb_copyarea(struct fb_info *info, const struct fb_copyarea *area)
 {

@@ -226,7 +226,7 @@
  * Initialization
  */

-static int __init dnfb_probe(struct device *device)
+static int __devinit dnfb_probe(struct device *device)
 {
 	struct platform_device *dev = to_platform_device(device);
 	struct fb_info *info;
@@ -235,18 +235,18 @@
 	info = framebuffer_alloc(0, &dev->dev);
 	if (!info)
 		return -ENOMEM;
-
+
 	info->fbops = &dn_fb_ops;
 	info->fix = dnfb_fix;
 	info->var = dnfb_var;
 	info->screen_base = (u_char *) info->fix.smem_start;

-	err = fb_alloc_cmap(&info->cmap, 2, 0)
-	if (err < 0) {
+	err = fb_alloc_cmap(&info->cmap, 2, 0);
+	if (err < 0) {
 		framebuffer_release(info);
 		return err;
-	}
-
+	}
+
 	err = register_framebuffer(info);
 	if (err < 0) {
 		fb_dealloc_cmap(&info->cmap);
@@ -254,7 +254,7 @@
 		return err;
 	}
 	dev_set_drvdata(&dev->dev, info);
-
+
 	/* now we have registered we can safely setup the hardware */
 	out_8(AP_CONTROL_3A, RESET_CREG);
 	out_be16(AP_WRITE_ENABLE, 0x0);
@@ -271,12 +271,11 @@
 	.name	= "dnfb",
 	.bus	= &platform_bus_type,
 	.probe	= dnfb_probe,
-};
+};

 static struct platform_device dnfb_device = {
 	.name	= "dnfb",
-	.id	= 0,
-};
+};

 int __init dnfb_init(void)
 {

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
