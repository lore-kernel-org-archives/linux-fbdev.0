From: Kronos <kronos@kronoz.cjb.net>
Subject: [PATCH] q40fb: New framebuffer_alloc API and class_dev changes
Date: Mon, 15 Sep 2003 23:06:55 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030915210655.GI23294@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19z0ZQ-0002UT-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 15 Sep 2003 14:07:40 -0700
Received: from mail-3.tiscali.it ([195.130.225.149])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19z0ZP-0001tW-KQ
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 15 Sep 2003 14:07:39 -0700
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
To: Richard.Zidlicky@stud.informatik.uni-erlangen.de
Cc: linux-fbdev-devel@lists.sourceforge.net, James Simmons <jsimmons@infradead.org>

Hi,
this patch converts driver/video/q40fb.c to framebuffer_alloc:

======== drivers/video/q40fb.c 1.24 ========
D 1.24 03/09/14 00:09:28+02:00 kronos@kronoz.cjb.net 26 25 14/10/117
P drivers/video/q40fb.c
C switch to framebuffer_alloc
------------------------------------------------

===== drivers/video/q40fb.c 1.23 vs 1.24 =====
--- 1.23/drivers/video/q40fb.c	Thu Apr 24 12:30:41 2003
+++ 1.24/drivers/video/q40fb.c	Sun Sep 14 00:09:28 2003
@@ -31,7 +31,7 @@
 #define Q40_PHYS_SCREEN_ADDR 0xFE800000
 
 static u32 pseudo_palette[17];
-static struct fb_info fb_info;
+static struct fb_info *fb_info;
 
 static struct fb_fix_screeninfo q40fb_fix __initdata = {
 	.id		= "Q40",
@@ -100,27 +100,31 @@
         if ( !MACH_IS_Q40)
 	  return -ENXIO;
 
+	fb_info = framebuffer_alloc(0, NULL);
+	if (!fb_info)
+		return -ENOMEM;
+
 	/* mapped in q40/config.c */
 	q40fb_fix.smem_start = Q40_PHYS_SCREEN_ADDR;
 	
-	fb_info.var = q40fb_var;
-	fb_info.fix = q40fb_fix;
-	fb_info.fbops = &q40fb_ops;
-	fb_info.flags = FBINFO_FLAG_DEFAULT;  /* not as module for now */
-	fb_info.pseudo_palette = pseudo_palette;	
-   	fb_info.screen_base = (char *) q40fb_fix.smem_start;
+	fb_info->var = q40fb_var;
+	fb_info->fix = q40fb_fix;
+	fb_info->fbops = &q40fb_ops;
+	fb_info->flags = FBINFO_FLAG_DEFAULT;  /* not as module for now */
+	fb_info->pseudo_palette = pseudo_palette;	
+   	fb_info->screen_base = (char *) q40fb_fix.smem_start;
 
-	fb_alloc_cmap(&fb_info.cmap, 16, 0);
+	fb_alloc_cmap(&fb_info->cmap, 16, 0);
 
 	master_outb(3, DISPLAY_CONTROL_REG);
 
-	if (register_framebuffer(&fb_info) < 0) {
+	if (register_framebuffer(fb_info) < 0) {
 		printk(KERN_ERR "Unable to register Q40 frame buffer\n");
 		return -EINVAL;
 	}
 
         printk(KERN_INFO "fb%d: Q40 frame buffer alive and kicking !\n",
-	       fb_info.node);
+	       fb_info->node);
 	return 0;
 }
 


Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
"Fare l'amore con dieci donne e` fantastico, soprattutto perche` ti
 presentano un sacco di amiche." -- Fabio Di Iorio


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
