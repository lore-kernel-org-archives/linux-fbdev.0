From: Kronos <kronos@kronoz.cjb.net>
Subject: [PATCH] igafb: New framebuffer_alloc API and class_dev changes
Date: Mon, 15 Sep 2003 22:15:30 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030915201530.GR16370@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19yzli-0006oL-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 15 Sep 2003 13:16:18 -0700
Received: from mail-2.tiscali.it ([195.130.225.148])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19yzlh-00057b-Ts
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 15 Sep 2003 13:16:18 -0700
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
this patch converts driver/video/igafb.c to framebuffer_alloc. It also
has some compilation fixes:

======== drivers/video/igafb.c 1.20 ========
D 1.20 03/09/12 00:06:04+02:00 kronos@kronoz.cjb.net 21 20 12/14/562
P drivers/video/igafb.c
C - remove useless static struct fb_info
C - switch to framebuffer_alloc
C - compilation fixes
------------------------------------------------

===== drivers/video/igafb.c 1.19 vs 1.20 =====
--- 1.19/drivers/video/igafb.c	Fri Aug 22 08:27:08 2003
+++ 1.20/drivers/video/igafb.c	Fri Sep 12 00:06:04 2003
@@ -66,12 +66,10 @@
 	unsigned long io_base;
 };
 
-struct fb_info fb_info;
-
 struct fb_fix_screeninfo igafb_fix __initdata = {
         .id		= "IGA 1682",
-	.type		= FB_TYPE_PACKED_PIXELS;
-	.mmio_len 	= 1000;
+	.type		= FB_TYPE_PACKED_PIXELS,
+	.mmio_len 	= 1000,
 };
 
 struct fb_var_screeninfo default_var = {
@@ -300,17 +298,17 @@
 	if (regno < 16) {
 		switch (info->var.bits_per_pixel) {
 		case 16:
-			info->pseudo_palette[regno] = 
+			((u32 *)info->pseudo_palette)[regno] = 
 				(regno << 10) | (regno << 5) | regno;
 			break;
 		case 24:
-			info->pseudo_palette[regno] = 
+			((u32 *)info->pseudo_palette)[regno] = 
 				(regno << 16) | (regno << 8) | regno;
 		break;
 		case 32:
 			{ int i;
 			i = (regno << 8) | regno;
-			info->pseudo_palette[regno] = (i << 16) | i;
+			((u32 *)info->pseudo_palette)[regno] = (i << 16) | i;
 			}
 			break;
 		}
@@ -358,12 +356,13 @@
 
 	info->fbops = &igafb_ops;
 	info->flags = FBINFO_FLAG_DEFAULT;
-	info->dev = &dev->dev;
 
-	fb_alloc_cmap(info->cmap, video_cmap_len, 0);
+	fb_alloc_cmap(&info->cmap, video_cmap_len, 0);
 
-	if (register_framebuffer(info) < 0)
+	if (register_framebuffer(info) < 0) {
+		kfree(info);
 		return 0;
+	}
 
 	printk("fb%d: %s frame buffer device at 0x%08lx [%dMB VRAM]\n",
 	       info->node, info->fix.id, 
@@ -400,16 +399,15 @@
 		iga2000 = 1;
 	}
 	
-	size = sizeof(struct fb_info) + sizeof(struct iga_par) + sizeof(u32)*16;
+	size = sizeof(struct iga_par) + sizeof(u32)*16;
 
-        info = kmalloc(size, GFP_ATOMIC);
+        info = framebuffer_alloc(size, &pdev->dev);
         if (!info) {
                 printk("igafb_init: can't alloc fb_info\n");
                 return -ENOMEM;
         }
-        memset(info, 0, size);
 
-	par = (struct iga_par *) (info + 1);
+	par = info->par;
 	
 
 	if ((addr = pdev->resource[0].start) == 0) {


Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
Do, or do not. There is no try.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
