From: Kronos <kronos@kronoz.cjb.net>
Subject: [PATCH] neofb: New framebuffer_alloc API and class_dev changes
Date: Mon, 15 Sep 2003 22:27:49 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030915202749.GX16370@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19yzxd-0007nk-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 15 Sep 2003 13:28:37 -0700
Received: from mail-8.tiscali.it ([195.130.225.154])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19yzxc-000656-1g
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 15 Sep 2003 13:28:36 -0700
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
To: dok@directfb.org
Cc: linux-fbdev-devel@lists.sourceforge.net, James Simmons <jsimmons@infradead.org>

Hi,
this patch converts driver/video/neofb.c to framebuffer_alloc:

======== drivers/video/neofb.c 1.34 ========
D 1.34 03/09/13 23:59:03+02:00 kronos@kronoz.cjb.net 41 40 10/11/2303
P drivers/video/neofb.c
C switch to framebuffer_alloc
------------------------------------------------

===== drivers/video/neofb.c 1.33 vs 1.34 =====
--- 1.33/drivers/video/neofb.c	Fri Aug 22 08:27:08 2003
+++ 1.34/drivers/video/neofb.c	Sat Sep 13 23:59:03 2003
@@ -2001,15 +2001,12 @@
 	struct fb_info *info;
 	struct neofb_par *par;
 
-	info = kmalloc(sizeof(struct fb_info) + sizeof(struct neofb_par) + 
-		       sizeof(u32) * 17, GFP_KERNEL);
+	info = framebuffer_alloc(sizeof(struct neofb_par) + sizeof(u32) * 17, &dev->dev);
 
 	if (!info)
 		return NULL;
 
-	memset(info, 0, sizeof(struct fb_info) + sizeof(struct neofb_par) + sizeof(u32) * 17);
-
-	par = (struct neofb_par *) (info + 1);
+	par = info->par;
 
 	info->fix.accel = id->driver_data;
 
@@ -2059,9 +2056,8 @@
 
 	info->fbops = &neofb_ops;
 	info->flags = FBINFO_FLAG_DEFAULT;
-	info->par = par;
 	info->pseudo_palette = (void *) (par + 1);
-	info->dev = &dev->dev;
+	info->release = &release_neofb_par;
 
 	fb_alloc_cmap(&info->cmap, NR_PALETTE, 0);
 
@@ -2156,6 +2152,13 @@
 	return err;
 }
 
+static void release_neofb_par(struct fb_info *info) {
+	fb_alloc_cmap(&info->cmap, 0, 0);
+
+	neo_unmap_video(info);
+	neo_unmap_mmio(info);
+}
+
 static void __devexit neofb_remove(struct pci_dev *dev)
 {
 	struct fb_info *info = pci_get_drvdata(dev);
@@ -2171,10 +2174,6 @@
 		if (unregister_framebuffer(info))
 			printk(KERN_WARNING
 			       "neofb: danger danger!  Oopsen imminent!\n");
-
-		neo_unmap_video(info);
-		neo_unmap_mmio(info);
-		neo_free_fb_info(info);
 
 		/*
 		 * Ensure that the driver data is no longer


======== include/video/neomagic.h 1.6 ========
D 1.6 03/09/14 18:25:54+02:00 kronos@kronoz.cjb.net 7 6 4/0/206
P include/video/neomagic.h
C add prototype of release_neofb_par
------------------------------------------------

===== include/video/neomagic.h 1.5 vs 1.6 =====
--- 1.5/include/video/neomagic.h	Mon Aug 11 21:46:24 2003
+++ 1.6/include/video/neomagic.h	Sun Sep 14 18:25:54 2003
@@ -71,6 +71,8 @@
 
 #ifdef __KERNEL__
 
+#include <linux/fb.h>
+
 #ifdef NEOFB_DEBUG
 # define DBG(x)		printk (KERN_DEBUG "neofb: %s\n", (x));
 #else
@@ -202,5 +204,7 @@
 	int y_res;
 	int mode;
 } biosMode;
+
+static void release_neofb_par(struct fb_info *);
 
 #endif


Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
La differenza fra l'intelligenza e la stupidita`?
All'intelligenza c'e` un limite.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
