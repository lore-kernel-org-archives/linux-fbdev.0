From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 1/8] fbdev: Reduce pixmap memory allocation size
Date: Wed, 20 Oct 2004 08:15:15 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200410200815.15395.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CK42D-00028i-B7
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 19 Oct 2004 17:08:57 -0700
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CK42C-000835-IN
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 19 Oct 2004 17:08:57 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 2ED009323C3
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 20 Oct 2004 00:08:50 +0000 (UTC)
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

  - Reduce pixmap size allocated by fbmem, i810fb and rivafb from 16-64K to
    8K.  This size is sufficient that a single putcs call can be accomodated
    by a single imageblit

  - Replace NR_FB_DRIVERS with FB_MAX

  - Trivial code, Kconfig and Documentation cleanup

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---
 Kconfig          |    6 +++---
 console/fbcon.c  |   12 ++++++------
 fbmem.c          |    9 ++++-----
 i810/i810_main.c |    6 +++---
 riva/fbdev.c     |    6 +++---
 5 files changed, 19 insertions(+), 20 deletions(-)

diff -Nru a/drivers/video/Kconfig b/drivers/video/Kconfig
--- a/drivers/video/Kconfig	2004-10-19 20:21:08 +08:00
+++ b/drivers/video/Kconfig	2004-10-17 14:02:58 +08:00
@@ -41,7 +41,7 @@
 config FB_MODE_HELPERS
         bool "Enable Video Mode Handling Helpers"
         depends on FB
-	default y
+	default n
 	---help---
 	  This enables functions for handling video modes using the
 	  Generalized Timing Formula and the EDID parser. A few drivers rely
@@ -61,10 +61,10 @@
 	 parameters in terms of number of tiles instead of number of pixels.
 	 For example, to draw a single character, instead of using bitmaps,
 	 an index to an array of bitmaps will be used.  To clear or move a
-	 rectangular section of a screen, the rectangle willbe described in
+	 rectangular section of a screen, the rectangle will be described in
 	 terms of number of tiles in the x- and y-axis.
 
-	 This is particularly important to one driver, the matroxfb.  If
+	 This is particularly important to one driver, matroxfb.  If
 	 unsure, say N.
 
 config FB_CIRRUS
diff -Nru a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
--- a/drivers/video/console/fbcon.c	2004-10-19 20:23:00 +08:00
+++ b/drivers/video/console/fbcon.c	2004-10-17 14:01:02 +08:00
@@ -337,24 +337,24 @@
 
 static int search_fb_in_map(int idx)
 {
-	int i;
+	int i, retval = 0;
 
 	for (i = 0; i < MAX_NR_CONSOLES; i++) {
 		if (con2fb_map[i] == idx)
-			return 1;
+			retval = 1;
 	}
-	return 0;
+	return retval;
 }
 
 static int search_for_mapped_con(void)
 {
-	int i;
+	int i, retval = 0;
 
 	for (i = 0; i < MAX_NR_CONSOLES; i++) {
 		if (con2fb_map[i] != -1)
-			return 1;
+			retval = 1;
 	}
-	return 0;
+	return retval;
 }
 
 static int fbcon_takeover(int show_logo)
diff -Nru a/drivers/video/fbmem.c b/drivers/video/fbmem.c
--- a/drivers/video/fbmem.c	2004-10-19 20:21:40 +08:00
+++ b/drivers/video/fbmem.c	2004-10-17 13:37:00 +08:00
@@ -51,7 +51,7 @@
      *  Frame buffer device initialization and setup routines
      */
 
-#define FBPIXMAPSIZE	16384
+#define FBPIXMAPSIZE	(1024 * 8)
 
 static struct notifier_block *fb_notifier_list;
 struct fb_info *registered_fb[FB_MAX];
@@ -1307,8 +1307,7 @@
 }
 module_init(fbmem_init);
 
-#define NR_FB_DRIVERS 64
-static char *video_options[NR_FB_DRIVERS];
+static char *video_options[FB_MAX];
 static int ofonly;
 
 /**
@@ -1329,7 +1328,7 @@
 		retval = 1;
 
 	if (name_len && !retval) {
-		for (i = 0; i < NR_FB_DRIVERS; i++) {
+		for (i = 0; i < FB_MAX; i++) {
 			if (video_options[i] == NULL)
 				continue;
 			opt_len = strlen(video_options[i]);
@@ -1371,7 +1370,7 @@
 	if (!options || !*options)
 		return 0;
 
-	for (i = 0; i < NR_FB_DRIVERS; i++) {
+	for (i = 0; i < FB_MAX; i++) {
 		if (!strncmp(options, "ofonly", 6))
 			ofonly = 1;
 		if (video_options[i] == NULL) {
diff -Nru a/drivers/video/i810/i810_main.c b/drivers/video/i810/i810_main.c
--- a/drivers/video/i810/i810_main.c	2004-10-19 20:23:23 +08:00
+++ b/drivers/video/i810/i810_main.c	2004-10-17 13:37:00 +08:00
@@ -1874,12 +1874,12 @@
 	par = (struct i810fb_par *) info->par;
 	par->dev = dev;
 
-	if (!(info->pixmap.addr = kmalloc(64*1024, GFP_KERNEL))) {
+	if (!(info->pixmap.addr = kmalloc(8*1024, GFP_KERNEL))) {
 		i810fb_release_resource(info, par);
 		return -ENOMEM;
 	}
-	memset(info->pixmap.addr, 0, 64*1024);
-	info->pixmap.size = 64*1024;
+	memset(info->pixmap.addr, 0, 8*1024);
+	info->pixmap.size = 8*1024;
 	info->pixmap.buf_align = 8;
 	info->pixmap.flags = FB_PIXMAP_SYSTEM;
 
diff -Nru a/drivers/video/riva/fbdev.c b/drivers/video/riva/fbdev.c
--- a/drivers/video/riva/fbdev.c	2004-10-19 20:24:10 +08:00
+++ b/drivers/video/riva/fbdev.c	2004-10-17 13:37:00 +08:00
@@ -1679,7 +1679,7 @@
 	cmap_len = riva_get_cmap_len(&info->var);
 	fb_alloc_cmap(&info->cmap, cmap_len, 0);	
 
-	info->pixmap.size = 64 * 1024;
+	info->pixmap.size = 8 * 1024;
 	info->pixmap.buf_align = 4;
 	info->pixmap.scan_align = 4;
 	info->pixmap.flags = FB_PIXMAP_SYSTEM;
@@ -1866,10 +1866,10 @@
 	default_par = (struct riva_par *) info->par;
 	default_par->pdev = pd;
 
-	info->pixmap.addr = kmalloc(64 * 1024, GFP_KERNEL);
+	info->pixmap.addr = kmalloc(8 * 1024, GFP_KERNEL);
 	if (info->pixmap.addr == NULL)
 		goto err_out_kfree;
-	memset(info->pixmap.addr, 0, 64 * 1024);
+	memset(info->pixmap.addr, 0, 8 * 1024);
 
 	if (pci_enable_device(pd)) {
 		printk(KERN_ERR PFX "cannot enable PCI device\n");




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
