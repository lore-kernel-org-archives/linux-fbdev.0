From: Kronos <kronos@kronoz.cjb.net>
Subject: [PATCH] pvr2fb: New framebuffer_alloc API and class_dev changes
Date: Mon, 15 Sep 2003 23:51:50 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030915215150.GA27662@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19z1Gv-000638-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 15 Sep 2003 14:52:37 -0700
Received: from mail-5.tiscali.it ([195.130.225.151])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19z1Gu-0001fN-M9
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 15 Sep 2003 14:52:36 -0700
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
To: lethal@linux-sh.org
Cc: linux-fbdev-devel@lists.sourceforge.net, James Simmons <jsimmons@infradead.org>

Hi,
this patch converts driver/video/amifb.c to framebuffer_alloc. Also,
something went wrong in the last merge, this patch makes it compile
again:

======== drivers/video/pvr2fb.c 1.17 ========
D 1.17 03/09/12 22:26:04+02:00 kronos@kronoz.cjb.net 19 18 4/8/796
P drivers/video/pvr2fb.c
C - make it compile again. something went wrong in the merge from 1.14.1.1 to 1.6
C - switch to framebuffer_alloc
------------------------------------------------

===== drivers/video/pvr2fb.c 1.16 vs 1.17 =====
--- 1.16/drivers/video/pvr2fb.c	Mon Jul 14 20:09:25 2003
+++ 1.17/drivers/video/pvr2fb.c	Fri Sep 12 22:26:04 2003
@@ -419,7 +419,7 @@
 
 	if (var->vmode & FB_VMODE_YWRAP) {
 		if (var->xoffset || var->yoffset < 0 || 
-		    var->yoffset >= var->yres_virtual)
+		    var->yoffset >= var->yres_virtual) {
 			var->xoffset = var->yoffset = 0;
 		} else {
 			if (var->xoffset > var->xres_virtual - var->xres ||
@@ -461,6 +461,7 @@
 				DPRINTK("invalid hsync total for NTSC\n");
 				return -EINVAL;
 			}
+		}
 	}
 	/* Check memory sizes */
 	line_length = get_line_length(var->xres_virtual, var->bits_per_pixel);
@@ -609,17 +610,14 @@
 	if (!MACH_DREAMCAST)
 		return -ENXIO;
 
-	fb_info = kmalloc(sizeof(struct fb_info) + sizeof(struct pvr2fb_par) +
-			  sizeof(u32) * 16, GFP_KERNEL);
+	fb_info = framebuffer_alloc(sizeof(struct pvr2fb_par) + sizeof(u32) * 16, NULL);
 	
 	if (!fb_info) {
 		printk(KERN_ERR "Failed to allocate memory for fb_info\n");
 		return -ENOMEM;
 	}
 
-	memset(fb_info, 0, sizeof(fb_info) + sizeof(struct pvr2fb_par) + sizeof(u32) * 16);
-
-	currentpar = (struct pvr2fb_par *)(fb_info + 1);
+	currentpar = fb_info->par;
 
 	/* Make a guess at the monitor based on the attached cable */
 	if (pvr2_init_cable() == CT_VGA) {
@@ -665,7 +663,6 @@
 
 	fb_info->fbops		= &pvr2fb_ops;
 	fb_info->fix		= pvr2_fix;
-	fb_info->par		= currentpar;
 	fb_info->pseudo_palette	= (void *)(fb_info->par + 1);
 	fb_info->flags		= FBINFO_FLAG_DEFAULT;
 
@@ -723,7 +720,6 @@
 	}
 #endif
 	unregister_framebuffer(fb_info);
-	kfree(fb_info);
 }
 
 static int __init pvr2_get_param(const struct pvr2_params *p, const char *s,


Luca 
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
Non sempre quello che viene dopo e` progresso.
Alessandro Manzoni


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
