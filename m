From: Kronos <kronos@kronoz.cjb.net>
Subject: [PATCH] dnfb: New framebuffer_alloc API and class_dev changes
Date: Mon, 15 Sep 2003 21:43:44 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030915194344.GJ16370@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19yzH9-0004AH-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 15 Sep 2003 12:44:43 -0700
Received: from mail-2.tiscali.it ([195.130.225.148])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19yzH9-0005qF-6W
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 15 Sep 2003 12:44:43 -0700
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
this patch converts driver/video/dnfb.c to framebuffer_alloc:

======== drivers/video/dnfb.c 1.24 ========
D 1.24 03/09/13 23:22:59+02:00 kronos@kronoz.cjb.net 27 26 11/7/248
P drivers/video/dnfb.c
C switch to framebuffer_alloc
------------------------------------------------

===== drivers/video/dnfb.c 1.23 vs 1.24 =====
--- 1.23/drivers/video/dnfb.c	Thu Apr 24 12:30:41 2003
+++ 1.24/drivers/video/dnfb.c	Sat Sep 13 23:22:59 2003
@@ -103,7 +103,7 @@
 
 #define SWAP(A) ((A>>8) | ((A&0xff) <<8))
 
-static struct fb_info fb_info;
+static struct fb_info *fb_info;
 
 /* frame buffer operations */
 
@@ -229,14 +229,18 @@
 {
 	int err;
 
-	fb_info.fbops = &dn_fb_ops;
-	fb_info.fix = dnfb_fix;
-	fb_info.var = dnfb_var;
-	fb_info.screen_base = (u_char *) fb_info.fix.smem_start;
+	fb_info = framebuffer_alloc(0, NULL);
+	if (!fb_info)
+		return -ENOMEM;
+
+	fb_info->fbops = &dn_fb_ops;
+	fb_info->fix = dnfb_fix;
+	fb_info->var = dnfb_var;
+	fb_info->screen_base = (u_char *) fb_info->fix.smem_start;
 
-	fb_alloc_cmap(&fb_info.cmap, 2, 0);
+	fb_alloc_cmap(&fb_info->cmap, 2, 0);
 
-	err = register_framebuffer(&fb_info);
+	err = register_framebuffer(fb_info);
 	if (err < 0)
 		panic("unable to register apollo frame buffer\n");
 



Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
Una donna sposa un uomo sperando che cambi, e lui non cambiera`. Un
uomo sposa una donna sperando che non cambi, e lei cambiera`.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
