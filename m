From: Kronos <kronos@kronoz.cjb.net>
Subject: [PATCH] hitfb: New framebuffer_alloc API and class_dev changes
Date: Mon, 15 Sep 2003 22:02:30 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030915200230.GO16370@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19yzZ5-0005oi-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 15 Sep 2003 13:03:15 -0700
Received: from mail-5.tiscali.it ([195.130.225.151])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19yzZ5-0002EA-2T
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 15 Sep 2003 13:03:15 -0700
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
To: James Simmons <jsimmons@infradead.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

Hi,
this patch converts driver/video/hitfb.c to framebuffer_alloc. It also
has some compilation fixes:

======== drivers/video/hitfb.c 1.22 ========
D 1.22 03/09/11 23:44:18+02:00 kronos@kronoz.cjb.net 23 22 20/13/187
P drivers/video/hitfb.c
C - switch to framebuffer_alloc
C - compilation fixes
------------------------------------------------

===== drivers/video/hitfb.c 1.21 vs 1.22 =====
--- 1.21/drivers/video/hitfb.c	Thu Apr 24 12:30:41 2003
+++ 1.22/drivers/video/hitfb.c	Thu Sep 11 23:44:18 2003
@@ -40,11 +40,11 @@
 	.id =		"Hitachi HD64461",
 	.type =		FB_TYPE_PACKED_PIXELS,
 	.visual =	FB_VISUAL_TRUECOLOR,
-	.accel_flags =	FB_ACCEL_NONE,
+	.accel =	FB_ACCEL_NONE,
 };
 
 static u16 pseudo_palette[17];
-struct fb_info fb_info;
+struct fb_info *fb_info;
 
 static int hitfb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 {
@@ -132,6 +132,11 @@
 int __init hitfb_init(void)
 {
 	unsigned short lcdclor, ldr3, ldvntr;
+	int size;
+
+	fb_info = framebuffer_alloc(0, NULL);
+	if (!fb_info)
+		return -ENOMEM;
 
 	hitfb_fix.smem_start = CONFIG_HD64461_IOBASE + 0x02000000;
 	hitfb_fix.smem_len = (MACH_HP680 || MACH_HP690) ? 1024*1024 : 512*1024;
@@ -153,22 +158,24 @@
 	}
 	hitfb_var.yres = ldvntr+1;
 
-	fb_info.fbops 		= &hitfb_ops;
-	fb_info.var 		= hitfb_var;
-	fb_info.fix 		= hitfb_fix;
-	fb_info.pseudo_palette 	= pseudo_palette;	
-	fb_info.flags 		= FBINFO_FLAG_DEFAULT;
+	fb_info->fbops 		= &hitfb_ops;
+	fb_info->var 		= hitfb_var;
+	fb_info->fix 		= hitfb_fix;
+	fb_info->pseudo_palette	= pseudo_palette;	
+	fb_info->flags 		= FBINFO_FLAG_DEFAULT;
     	
-	fb_info.screen_base = (void *) hitfb_fix.smem_start;
+	fb_info->screen_base = (void *) hitfb_fix.smem_start;
 
-	size = (fb_info.var.bits_per_pixel == 8) ? 256 : 16;
-	fb_alloc_cmap(&fb_info.cmap, size, 0); 	
+	size = (fb_info->var.bits_per_pixel == 8) ? 256 : 16;
+	fb_alloc_cmap(&fb_info->cmap, size, 0); 	
 
-	if (register_framebuffer(&fb_info) < 0)
+	if (register_framebuffer(fb_info) < 0) {
+		kfree(fb_info);
 		return -EINVAL;
+	}
     
 	printk(KERN_INFO "fb%d: %s frame buffer device\n",
-			fb_info.node, fb_info.fix.id);
+			fb_info->node, fb_info->fix.id);
 	return 0;
 }
 
@@ -189,7 +196,7 @@
 
 void cleanup_module(void)
 {
-  hitfb_cleanup(void);
+  hitfb_cleanup(fb_info);
 }
 #endif
 


Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
Todo list:
 1: Feed Cat.
 2: Take over the world.
 3: Feed Cat.
 4: Get lots of cookies.
 5: Eat the cookies.
 6: Feed Cat.
 7: Escape from jail.
 8: Feed Cat.
 9: Take over the world again.
10: goto #6


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
