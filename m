From: Kronos <kronos@kronoz.cjb.net>
Subject: [PATCH] offb: New framebuffer_alloc API and class_dev changes
Date: Mon, 15 Sep 2003 22:27:56 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030915202756.GY16370@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19yzy8-0007pu-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 15 Sep 2003 13:29:09 -0700
Received: from mail-7.tiscali.it ([195.130.225.153])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19yzy8-0006Pm-Ac
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 15 Sep 2003 13:29:08 -0700
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
To: geert@linux-m68k.org
Cc: linux-fbdev-devel@lists.sourceforge.net, James Simmons <jsimmons@infradead.org>

Hi,
this patch converts driver/video/amifb.c to framebuffer_alloc:

======== drivers/video/offb.c 1.27 ========
D 1.27 03/09/14 00:00:15+02:00 kronos@kronoz.cjb.net 28 27 5/9/535
P drivers/video/offb.c
C - switch to framebuffer_alloc
C - remove global default_par
------------------------------------------------

===== drivers/video/offb.c 1.26 vs 1.27 =====
--- 1.26/drivers/video/offb.c	Thu Apr 24 12:30:41 2003
+++ 1.27/drivers/video/offb.c	Sun Sep 14 00:00:15 2003
@@ -52,8 +52,6 @@
 	int blanked;
 };
 
-struct offb_par default_par;
-
 #ifdef __powerpc__
 #define mach_eieio()	eieio()
 #else
@@ -388,7 +386,7 @@
 				struct device_node *dp)
 {
 	unsigned long res_size = pitch * height * depth / 8;
-	struct offb_par *par = &default_par;
+	struct offb_par *par;
 	unsigned long res_start = address;
 	struct fb_fix_screeninfo *fix;
 	struct fb_var_screeninfo *var;
@@ -408,16 +406,14 @@
 		return;
 	}
 
-	size = sizeof(struct fb_info) + sizeof(u32) * 17;
+	size = sizeof(struct offb_par) + sizeof(u32) * 17;
 
-	info = kmalloc(size, GFP_ATOMIC);
-	
+	info = framebuffer_alloc(size, NULL);	
 	if (info == 0) {
 		release_mem_region(res_start, res_size);
 		return;
 	}
-	memset(info, 0, size);
-
+	par = info->par;
 	fix = &info->fix;
 	var = &info->var;
 
@@ -526,7 +522,7 @@
 	info->fbops = &offb_ops;
 	info->screen_base = ioremap(address, fix->smem_len);
 	info->par = par;
-	info->pseudo_palette = (void *) (info + 1);
+	info->pseudo_palette = (void *) (par + 1);
 	info->flags = FBINFO_FLAG_DEFAULT;
 
 	fb_alloc_cmap(&info->cmap, 256, 0);


Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
La vispa candela bruciava l'erbetta
creando un'essenza alquanto sospetta;
sembrava l'odore di una sacrestia
ma presto mi accorsi che era maria.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
