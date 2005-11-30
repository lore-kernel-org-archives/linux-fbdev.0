From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 7/16] hgafb: Convert to platform device
Date: Wed, 30 Nov 2005 09:30:19 +0800
Message-ID: <438D00AB.8020800@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EhGoT-0002Mz-Cn
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 29 Nov 2005 17:31:13 -0800
Received: from zproxy.gmail.com ([64.233.162.201])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EhGoS-0002py-VM
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 29 Nov 2005 17:31:13 -0800
Received: by zproxy.gmail.com with SMTP id r28so881935nza
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 29 Nov 2005 17:31:12 -0800 (PST)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, fero@drama.obuda.kando.hu

- convert to platform device

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/hgafb.c |  105 ++++++++++++++++++++++++++++++++++++-------------
 1 files changed, 77 insertions(+), 28 deletions(-)

diff --git a/drivers/video/hgafb.c b/drivers/video/hgafb.c
index b37cea7..4e39035 100644
--- a/drivers/video/hgafb.c
+++ b/drivers/video/hgafb.c
@@ -42,6 +42,7 @@
 #include <linux/fb.h>
 #include <linux/init.h>
 #include <linux/ioport.h>
+#include <linux/platform_device.h>
 #include <asm/io.h>
 #include <asm/vga.h>
 
@@ -107,7 +108,7 @@ static DEFINE_SPINLOCK(hga_reg_lock);
 
 /* Framebuffer driver structures */
 
-static struct fb_var_screeninfo hga_default_var = {
+static struct fb_var_screeninfo __initdata hga_default_var = {
 	.xres		= 720,
 	.yres 		= 348,
 	.xres_virtual 	= 720,
@@ -121,7 +122,7 @@ static struct fb_var_screeninfo hga_defa
 	.width 		= -1,
 };
 
-static struct fb_fix_screeninfo hga_fix = {
+static struct fb_fix_screeninfo __initdata hga_fix = {
 	.id 		= "HGA",
 	.type 		= FB_TYPE_PACKED_PIXELS,	/* (not sure) */
 	.visual 	= FB_VISUAL_MONO10,
@@ -131,8 +132,6 @@ static struct fb_fix_screeninfo hga_fix 
 	.accel 		= FB_ACCEL_NONE
 };
 
-static struct fb_info fb_info;
-
 /* Don't assume that tty1 will be the initial current console. */
 static int release_io_port = 0;
 static int release_io_ports = 0;
@@ -549,10 +548,9 @@ static struct fb_ops hgafb_ops = {
 	 *  Initialization
 	 */
 
-static int __init hgafb_init(void)
+static int __init hgafb_probe(struct device *device)
 {
-	if (fb_get_options("hgafb", NULL))
-		return -ENODEV;
+	struct fb_info *info;
 
 	if (! hga_card_detect()) {
 		printk(KERN_INFO "hgafb: HGA card not detected.\n");
@@ -564,41 +562,95 @@ static int __init hgafb_init(void)
 	printk(KERN_INFO "hgafb: %s with %ldK of memory detected.\n",
 		hga_type_name, hga_vram_len/1024);
 
+	info = framebuffer_alloc(0, NULL);
+	if (!info) {
+		iounmap(hga_vram);
+		return -ENOMEM;
+	}
+
 	hga_fix.smem_start = (unsigned long)hga_vram;
 	hga_fix.smem_len = hga_vram_len;
 
-	fb_info.flags = FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN;
-	fb_info.var = hga_default_var;
-	fb_info.fix = hga_fix;
-	fb_info.monspecs.hfmin = 0;
-	fb_info.monspecs.hfmax = 0;
-	fb_info.monspecs.vfmin = 10000;
-	fb_info.monspecs.vfmax = 10000;
-	fb_info.monspecs.dpms = 0;
-	fb_info.fbops = &hgafb_ops;
-	fb_info.screen_base = hga_vram;
+	info->flags = FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN;
+	info->var = hga_default_var;
+	info->fix = hga_fix;
+	info->monspecs.hfmin = 0;
+	info->monspecs.hfmax = 0;
+	info->monspecs.vfmin = 10000;
+	info->monspecs.vfmax = 10000;
+	info->monspecs.dpms = 0;
+	info->fbops = &hgafb_ops;
+	info->screen_base = hga_vram;
 
-        if (register_framebuffer(&fb_info) < 0) {
+        if (register_framebuffer(info) < 0) {
+		framebuffer_release(info);
 		iounmap(hga_vram);
 		return -EINVAL;
 	}
 
         printk(KERN_INFO "fb%d: %s frame buffer device\n",
-               fb_info.node, fb_info.fix.id);
+               info->node, info->fix.id);
+	dev_set_drvdata(device, info);
 	return 0;
 }
 
-#ifdef MODULE
-static void __exit hgafb_exit(void)
+static int hgafb_remove(struct device *device)
 {
+	struct fb_info *info = dev_get_drvdata(device);
+
 	hga_txt_mode();
 	hga_clear_screen();
-	unregister_framebuffer(&fb_info);
+
+	if (info) {
+		unregister_framebuffer(info);
+		framebuffer_release(info);
+	}
+
 	iounmap(hga_vram);
-	if (release_io_ports) release_region(0x3b0, 12);
-	if (release_io_port) release_region(0x3bf, 1);
+
+	if (release_io_ports)
+		release_region(0x3b0, 12);
+
+	if (release_io_port)
+		release_region(0x3bf, 1);
+
+	return 0;
+}
+
+static struct device_driver hgafb_driver = {
+	.name = "hgafb",
+	.bus  = &platform_bus_type,
+	.probe = hgafb_probe,
+	.remove = hgafb_remove,
+};
+
+static struct platform_device hgafb_device = {
+	.name = "hgafb",
+};
+
+static int __init hgafb_init(void)
+{
+	int ret;
+
+	if (fb_get_options("hgafb", NULL))
+		return -ENODEV;
+
+	ret = driver_register(&hgafb_driver);
+
+	if (!ret) {
+		ret = platform_device_register(&hgafb_device);
+		if (ret)
+			driver_unregister(&hgafb_driver);
+	}
+
+	return ret;
+}
+
+static void __exit hgafb_exit(void)
+{
+	platform_device_unregister(&hgafb_device);
+	driver_unregister(&hgafb_driver);
 }
-#endif
 
 /* -------------------------------------------------------------------------
  *
@@ -613,7 +665,4 @@ MODULE_LICENSE("GPL");
 module_param(nologo, bool, 0);
 MODULE_PARM_DESC(nologo, "Disables startup logo if != 0 (default=0)");
 module_init(hgafb_init);
-
-#ifdef MODULE
 module_exit(hgafb_exit);
-#endif



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
