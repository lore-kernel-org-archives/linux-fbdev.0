From: Kronos <kronos@kronoz.cjb.net>
Subject: [PATCH] macfb: New framebuffer_alloc API and class_dev changes
Date: Mon, 15 Sep 2003 22:16:23 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030915201623.GU16370@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19yzm4-0006q6-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 15 Sep 2003 13:16:40 -0700
Received: from mail-4.tiscali.it ([195.130.225.150])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19yzm2-0005CL-7J
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 15 Sep 2003 13:16:38 -0700
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
To: dhd@debian.org
Cc: linux-fbdev-devel@lists.sourceforge.net, James Simmons <jsimmons@infradead.org>

Hi,
this patch converts driver/video/macfb.c to framebuffer_alloc:

======== drivers/video/macfb.c 1.30 ========
D 1.30 03/09/13 23:47:13+02:00 kronos@kronoz.cjb.net 34 33 17/11/950
P drivers/video/macfb.c
C switch to framebuffer_alloc
------------------------------------------------

===== drivers/video/macfb.c 1.29 vs 1.30 =====
--- 1.29/drivers/video/macfb.c	Mon Aug 18 06:52:28 2003
+++ 1.30/drivers/video/macfb.c	Sat Sep 13 23:47:13 2003
@@ -171,7 +171,7 @@
 	.accel	= FB_ACCEL_NONE,
 };
 
-static struct fb_info fb_info;
+static struct fb_info *fb_info;
 static u32 pseudo_palette[17];
 static int inverse   = 0;
 static int vidtest   = 0;
@@ -618,6 +618,10 @@
 	if (!MACH_IS_MAC) 
 		return;
 
+	fb_info = framebuffer_alloc(0, NULL);
+	if (!fb_info)
+		return;
+
 	/* There can only be one internal video controller anyway so
 	   we're not too worried about this */
 	macfb_defined.xres = mac_bi_data.dimensions & 0xFFFF;
@@ -632,10 +636,10 @@
 	   those mappings are set up, so this is in fact the safest
 	   way to ensure that this driver will work on every possible
 	   Mac */
-	fb_info.screen_base = ioremap(mac_bi_data.videoaddr, macfb_fix.smem_len);
+	fb_info->screen_base = ioremap(mac_bi_data.videoaddr, macfb_fix.smem_len);
 	
 	printk("macfb: framebuffer at 0x%08lx, mapped to 0x%p, size %dk\n",
-	       macfb_fix.smem_start, fb_info.screen_base, macfb_fix.smem_len/1024);
+	       macfb_fix.smem_start, fb_info->screen_base, macfb_fix.smem_len/1024);
 	printk("macfb: mode is %dx%dx%d, linelength=%d\n",
 	       macfb_defined.xres, macfb_defined.yres, macfb_defined.bits_per_pixel, macfb_fix.line_length);
 	
@@ -943,19 +947,21 @@
 			break;
 		}
 
-	fb_info.fbops		= &macfb_ops;
-	fb_info.var		= macfb_defined;
-	fb_info.fix		= macfb_fix;
-	fb_info.pseudo_palette	= pseudo_palette;
-	fb_info.flags		= FBINFO_FLAG_DEFAULT;
+	fb_info->fbops		= &macfb_ops;
+	fb_info->var		= macfb_defined;
+	fb_info->fix		= macfb_fix;
+	fb_info->pseudo_palette	= pseudo_palette;
+	fb_info->flags		= FBINFO_FLAG_DEFAULT;
 
-	fb_alloc_cmap(&fb_info.cmap, video_cmap_len, 0);
+	fb_alloc_cmap(&fb_info->cmap, video_cmap_len, 0);
 	
-	if (register_framebuffer(&fb_info) < 0)
+	if (register_framebuffer(fb_info) < 0) {
+		kfree(fb_info);
 		return;
+	}
 
 	printk("fb%d: %s frame buffer device\n",
-	       fb_info.node, fb_info.fix.id);
+	       fb_info->node, fb_info->fix.id);
 }
 
 MODULE_LICENSE("GPL");


Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
#include <stdio.h> 
int main(void) {printf("\t\t\b\b\b\b\b\b");
printf("\t\t\b\b\b\b\b\b");return 0;}


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
