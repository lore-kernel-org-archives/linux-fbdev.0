From: Kronos <kronos@kronoz.cjb.net>
Subject: [PATCH] maxinefb: New framebuffer_alloc API and class_dev changes
Date: Mon, 15 Sep 2003 22:27:42 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030915202742.GW16370@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19yzxp-0007oO-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 15 Sep 2003 13:28:49 -0700
Received: from mail-4.tiscali.it ([195.130.225.150])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19yzxo-0006E6-JO
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 15 Sep 2003 13:28:48 -0700
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
this patch converts driver/video/maxinefb.c to framebuffer_alloc:

======== drivers/video/maxinefb.c 1.20 ========
D 1.20 03/09/13 23:57:10+02:00 kronos@kronoz.cjb.net 21 20 15/9/172
P drivers/video/maxinefb.c
C switch to framebuffer_alloc
------------------------------------------------

===== drivers/video/maxinefb.c 1.19 vs 1.20 =====
--- 1.19/drivers/video/maxinefb.c	Thu Apr 24 12:30:41 2003
+++ 1.20/drivers/video/maxinefb.c	Sat Sep 13 23:57:10 2003
@@ -40,7 +40,7 @@
 /* whether are really running on a maxine, KM                       */
 #include <asm/bootinfo.h>
 
-static struct fb_info fb_info;
+static struct fb_info *fb_info;
 
 static struct fb_var_screeninfo maxinefb_defined = {
 	.xres 		= 1024,
@@ -131,6 +131,10 @@
 		return -EINVAL;
 	}
 
+	fb_info = framebuffer_alloc(0, NULL);
+	if (!fb_info)
+		return -ENOMEM;
+
 	printk(KERN_INFO "Maxinefb: Personal DECstation detected\n");
 	printk(KERN_INFO "Maxinefb: initializing onboard framebuffer\n");
 
@@ -155,22 +159,24 @@
 		 */
 	}
 
-	fb_info.fbops = &maxinefb_ops;
-	fb_info.screen_base = (char *) maxinefb_fix.smem_start;
-	fb_info.var = maxinefb_defined;
-	fb_info.fix = maxinefb_fix;
-	fb_info.flags = FBINFO_FLAG_DEFAULT;
+	fb_info->fbops = &maxinefb_ops;
+	fb_info->screen_base = (char *) maxinefb_fix.smem_start;
+	fb_info->var = maxinefb_defined;
+	fb_info->fix = maxinefb_fix;
+	fb_info->flags = FBINFO_FLAG_DEFAULT;
 
-	fb_alloc_cmap(&fb_info.cmap, 256, 0);
+	fb_alloc_cmap(&fb_info->cmap, 256, 0);
 
-	if (register_framebuffer(&fb_info) < 0)
+	if (register_framebuffer(fb_info) < 0) {
+		kfree(fb_info);
 		return 1;
+	}
 	return 0;
 }
 
 static void __exit maxinefb_exit(void)
 {
-	unregister_framebuffer(&fb_info);
+	unregister_framebuffer(fb_info);
 }
 
 #ifdef MODULE


Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
La vasca da bagno fu inventata nel 1850, il telefono nel 1875.
Se fossi vissuto nel 1850, avrei potuto restare in vasca per 25 anni
senza sentir squillare il telefono


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
