From: Kronos <kronos@kronoz.cjb.net>
Subject: [PATCH] hpfb: New framebuffer_alloc API and class_dev changes
Date: Mon, 15 Sep 2003 22:02:37 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030915200237.GP16370@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19yzZI-0005pU-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 15 Sep 2003 13:03:28 -0700
Received: from mail-1.tiscali.it ([195.130.225.147])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19yzZI-0002GX-5Y
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 15 Sep 2003 13:03:28 -0700
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
To: philb@gnu.org
Cc: linux-fbdev-devel@lists.sourceforge.net, James Simmons <jsimmons@infradead.org>

Hi,
this patch converts driver/video/hpfb.c to framebuffer_alloc:

======== drivers/video/hpfb.c 1.21 ========
D 1.21 03/09/13 23:33:59+02:00 kronos@kronoz.cjb.net 24 23 14/8/206
P drivers/video/hpfb.c
C switch to framebuffer_alloc
------------------------------------------------

===== drivers/video/hpfb.c 1.20 vs 1.21 =====
--- 1.20/drivers/video/hpfb.c	Thu Apr 24 12:30:41 2003
+++ 1.21/drivers/video/hpfb.c	Sat Sep 13 23:33:59 2003
@@ -19,7 +19,7 @@
 #include <asm/blinken.h>
 #include <asm/hwtest.h>
 
-static struct fb_info fb_info;
+static struct fb_info *fb_info;
 
 unsigned long fb_regs;
 unsigned char fb_bitmask;
@@ -115,6 +115,10 @@
 {
 	unsigned long fboff;
 
+	fb_info = framebuffer_alloc(0, NULL);
+	if (!fb_info)
+		return -ENOMEM;
+
 	fboff = (in_8(base + TOPCAT_FBOMSB) << 8) | in_8(base + TOPCAT_FBOLSB);
 
 	hpfb_fix.smem_start = 0xf0000000 | (in_8(base + fboff) << 16);
@@ -150,16 +154,18 @@
 	/*
 	 *	Let there be consoles..
 	 */
-	fb_info.fbops = &hpfb_ops;
-	fb_info.flags = FBINFO_FLAG_DEFAULT;
-	fb_info.var   = hpfb_defined;
-	fb_info.fix   = hpfb_fix;
-	fb_info.screen_base = (char *)hpfb_fix.smem_start;	// FIXME
+	fb_info->fbops = &hpfb_ops;
+	fb_info->flags = FBINFO_FLAG_DEFAULT;
+	fb_info->var   = hpfb_defined;
+	fb_info->fix   = hpfb_fix;
+	fb_info->screen_base = (char *)hpfb_fix.smem_start;	// FIXME
 
-	fb_alloc_cmap(&fb_info.cmap, 256, 0);
+	fb_alloc_cmap(&fb_info->cmap, 256, 0);
 
-	if (register_framebuffer(&fb_info) < 0)
+	if (register_framebuffer(fb_info) < 0) {
+		kfree(fb_info);
 		return 1;
+	}
 	return 0;
 }
 


Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
Runtime error 6D at f000:a12f : user incompetente


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
