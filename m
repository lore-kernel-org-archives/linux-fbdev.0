From: Kronos <kronos@kronoz.cjb.net>
Subject: [PATCH] pmag*: New framebuffer_alloc API and class_dev changes
Date: Mon, 15 Sep 2003 22:47:16 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030915204716.GD23294@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19z0GW-0000pa-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 15 Sep 2003 13:48:08 -0700
Received: from mail-8.tiscali.it ([195.130.225.154])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19z0GV-00017u-PX
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 15 Sep 2003 13:48:07 -0700
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
To: engel@unix-ag.org
Cc: linux-fbdev-devel@lists.sourceforge.net, James Simmons <jsimmons@infradead.org>

Hi,
this patch converts driver/video/pmag-ba-fb.c and
driver/video/pmagb-b-fb.c to framebuffer_alloc. There are also some
compilation fixes:

======== drivers/video/pmag-ba-fb.c 1.18 ========
D 1.18 03/09/12 22:08:13+02:00 kronos@kronoz.cjb.net 19 18 12/5/170
P drivers/video/pmag-ba-fb.c
C - make the drive compile
C - move to framebuffer_alloc
------------------------------------------------

===== drivers/video/pmag-ba-fb.c 1.17 vs 1.18 =====
--- 1.17/drivers/video/pmag-ba-fb.c	Thu Apr 24 12:30:41 2003
+++ 1.18/drivers/video/pmag-ba-fb.c	Fri Sep 12 22:08:13 2003
@@ -49,7 +49,6 @@
 /*
  * Max 3 TURBOchannel slots -> max 3 PMAG-BA :)
  */
-static struct fb_info pmagba_fb_info[3];
 
 static struct fb_var_screeninfo pmagbafb_defined = {
 	.xres 		= 1024,
@@ -63,7 +62,7 @@
 	.activate 	= FB_ACTIVATE_NOW, 
 	.height 	= 274,	
 	.width 		= 195,
-	.accel 		= FB_ACCEL_NONE,
+	.accel_flags	= FB_ACCEL_NONE,
 	.vmode 		= FB_VMODE_NONINTERLACED,
 };
 
@@ -121,7 +120,13 @@
 int __init pmagbafb_init_one(int slot)
 {
 	unsigned long base_addr = get_tc_base_addr(slot);
-	struct fb_info *info = &pmagba_fb_info[slot]; 
+	struct fb_info *info;
+
+	info = framebuffer_alloc(0, NULL);
+	if (!info) {
+		printk(KERN_ERR "pmag: Cannot allocate memory.\n");
+		return -ENOMEM;
+	}
 
 	printk("PMAG-BA framebuffer in slot %d\n", slot);
 	/*
@@ -144,10 +149,12 @@
 	info->screen_base = pmagbafb_fix.smem_start;
 	info->flags = FBINFO_FLAG_DEFAULT;
 
-	fb_alloc_cmap(&fb_info.cmap, 256, 0);
+	fb_alloc_cmap(&info->cmap, 256, 0);
 	
-	if (register_framebuffer(info) < 0)
+	if (register_framebuffer(info) < 0) {
+		kfree(info);
 		return 1;
+	}
 	return 0;
 }
 


======== drivers/video/pmagb-b-fb.c 1.17 ========
D 1.17 03/09/14 00:08:38+02:00 kronos@kronoz.cjb.net 18 17 13/6/172
P drivers/video/pmagb-b-fb.c
C - make it compile
C - switch to framebuffer_alloc
------------------------------------------------

===== drivers/video/pmagb-b-fb.c 1.16 vs 1.17 =====
--- 1.16/drivers/video/pmagb-b-fb.c	Thu Apr 24 12:30:41 2003
+++ 1.17/drivers/video/pmagb-b-fb.c	Sun Sep 14 00:08:38 2003
@@ -52,7 +52,6 @@
 /*
  * Max 3 TURBOchannel slots -> max 3 PMAGB-B :)
  */
-static struct fb_info pmagbb_fb_info[3];
 
 static struct fb_var_screeninfo pmagbbfb_defined = {
 	.xres 		= 1280,
@@ -70,13 +69,13 @@
 	.vmode 		= FB_VMODE_NONINTERLACED,
 };
 
-static struct fb_fix_screeninfo pmagbafb_fix = {
+static struct fb_fix_screeninfo pmagbbfb_fix = {
 	.id 		= "PMAGB-BA",
 	.smem_len 	= (1280 * 1024),
 	.type 		= FB_TYPE_PACKED_PIXELS,
 	.visual 	= FB_VISUAL_PSEUDOCOLOR,
 	.line_length 	= 1280,
-}
+};
 
 /*
  * Turn hardware cursor off
@@ -124,7 +123,13 @@
 int __init pmagbbfb_init_one(int slot)
 {
 	unsigned long base_addr = get_tc_base_addr(slot);
-	struct fb_info *info = &pmagbb_fb_info[slot];
+	struct fb_info *info;
+
+	info = framebuffer_alloc(0, NULL);
+	if (!info) {
+		printk(KERN_ERR "pmagb: Cannot allocate memory.\n");
+		return -ENOMEM;
+	}
 
 	printk("PMAGB-BA framebuffer in slot %d\n", slot);
 	/*
@@ -147,10 +152,12 @@
 	info->screen_base = pmagbbfb_fix.smem_start; 
 	info->flags = FBINFO_FLAG_DEFAULT;
 
-	fb_alloc_cmap(&fb_info.cmap, 256, 0);
+	fb_alloc_cmap(&info->cmap, 256, 0);
 
-	if (register_framebuffer(info) < 0)
+	if (register_framebuffer(info) < 0) {
+		kfree(info);
 		return 1;
+	}
 	return 0;
 }
 



Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
"Di tutte le perversioni sessuali, la castita` e` la piu` strana".
Anatole France


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
