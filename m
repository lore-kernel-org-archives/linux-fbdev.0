From: Kronos <kronos@kronoz.cjb.net>
Subject: [PATCH] hgafb: New framebuffer_alloc API and class_dev changes
Date: Mon, 15 Sep 2003 22:02:17 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030915200217.GN16370@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19yzZO-0005qH-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 15 Sep 2003 13:03:34 -0700
Received: from mail-6.tiscali.it ([195.130.225.152])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19yzZN-0002Hd-7L
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 15 Sep 2003 13:03:33 -0700
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: fero@drama.obuda.kando.hu
Cc: linux-fbdev-devel@lists.sourceforge.net, James Simmons <jsimmons@infradead.org>

Hi,
this patch converts driver/video/hgafb.c to framebuffer_alloc:

======== drivers/video/hgafb.c 1.26 ========
D 1.26 03/09/13 23:33:20+02:00 kronos@kronoz.cjb.net 27 26 23/15/592
P drivers/video/hgafb.c
C switch to framebuffer_alloc
------------------------------------------------

===== drivers/video/hgafb.c 1.25 vs 1.26 =====
--- 1.25/drivers/video/hgafb.c	Thu Apr 24 12:30:41 2003
+++ 1.26/drivers/video/hgafb.c	Sat Sep 13 23:33:20 2003
@@ -131,7 +131,7 @@
 	.accel 		= FB_ACCEL_NONE
 };
 
-static struct fb_info fb_info;
+static struct fb_info *fb_info;
 
 /* Don't assume that tty1 will be the initial current console. */
 static int release_io_port = 0;
@@ -546,25 +546,32 @@
 	printk(KERN_INFO "hgafb: %s with %ldK of memory detected.\n",
 		hga_type_name, hga_vram_len/1024);
 
+	fb_info = framebuffer_alloc(0, NULL);
+	if (!fb_info)
+		return -ENOMEM;
+
 	hga_fix.smem_start = VGA_MAP_MEM(hga_vram_base);
 	hga_fix.smem_len = hga_vram_len;
 
-	fb_info.flags = FBINFO_FLAG_DEFAULT;
-	fb_info.var = hga_default_var;
-	fb_info.fix = hga_fix;
-	fb_info.monspecs.hfmin = 0;
-	fb_info.monspecs.hfmax = 0;
-	fb_info.monspecs.vfmin = 10000;
-	fb_info.monspecs.vfmax = 10000;
-	fb_info.monspecs.dpms = 0;
-	fb_info.fbops = &hgafb_ops;
-	fb_info.screen_base = (char *)hga_fix.smem_start;
-
-        if (register_framebuffer(&fb_info) < 0)
+	fb_info->flags = FBINFO_FLAG_DEFAULT;
+	fb_info->var = hga_default_var;
+	fb_info->fix = hga_fix;
+	fb_info->monspecs.hfmin = 0;
+	fb_info->monspecs.hfmax = 0;
+	fb_info->monspecs.vfmin = 10000;
+	fb_info->monspecs.vfmax = 10000;
+	fb_info->monspecs.dpms = 0;
+	fb_info->fbops = &hgafb_ops;
+	fb_info->screen_base = (char *)hga_fix.smem_start;
+
+        if (register_framebuffer(fb_info) < 0) {
+		kfree(fb_info);
+		fb_info = NULL;
                 return -EINVAL;
+	}
 
         printk(KERN_INFO "fb%d: %s frame buffer device\n",
-               fb_info.node, fb_info.fix.id);
+               fb_info->node, fb_info->fix.id);
 	return 0;
 }
 
@@ -582,7 +589,8 @@
 {
 	hga_txt_mode();
 	hga_clear_screen();
-	unregister_framebuffer(&fb_info);
+	unregister_framebuffer(fb_info);
+	fb_info = NULL;
 	if (release_io_ports) release_region(0x3b0, 12);
 	if (release_io_port) release_region(0x3bf, 1);
 }


Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
Non capisco tutta questa eccitazione per il Multitasking: 
io sono anni che leggo in bagno.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
