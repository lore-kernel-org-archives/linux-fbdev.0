From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 4/5] Video Mode Handling - Reduce memory footprint of fbdev
Date: Mon, 9 Aug 2004 09:46:30 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200408090946.30692.adaplas@hotpop.com>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BtzIK-0001Vl-1U
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 08 Aug 2004 18:49:48 -0700
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1BtzIJ-0005dJ-AT
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 08 Aug 2004 18:49:47 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 53612776B17
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon,  9 Aug 2004 00:56:22 +0000 (UTC)
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
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
Cc: Andrew Morton <akpm@osdl.org>

Hi,

This patch is entirely optional.  Its only advantage is reduction of kernel
size by ~5-6K.

a. Mark modedb as __init.
b. Add CONFIG_FB_MODE_HELPERS.  Unselecting this will uninclude the code for 
Generalized Timing Formula and the EDID parser on kernel compilation.  These
are used only by radeonfb, rivafb and i810fb.

The diff is against 2.6.8-rc3-mm1 but should apply cleanly to 2.6.8-rc3-mm2
as well.

Tony

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 Kconfig  |   11 +++++++++++
 fbmon.c  |   31 +++++++++++++++++++++++++++++++
 modedb.c |    8 +++++---
 3 files changed, 47 insertions(+), 3 deletions(-)

diff -uprN linux-2.6.8-rc3-mm1-orig/drivers/video/fbmon.c linux-2.6.8-rc3-mm1/drivers/video/fbmon.c
--- linux-2.6.8-rc3-mm1-orig/drivers/video/fbmon.c	2004-08-08 22:56:32.990329720 +0800
+++ linux-2.6.8-rc3-mm1/drivers/video/fbmon.c	2004-08-08 22:55:15.680082664 +0800
@@ -51,6 +51,7 @@
 
 #define FBMON_FIX_HEADER 1
 
+#ifdef CONFIG_FB_MODE_HELPERS
 struct broken_edid {
 	u8  manufacturer[4];
 	u32 model;
@@ -1156,6 +1157,36 @@ int fb_get_mode(int flags, u32 val, stru
 	
 	return 0;
 }
+#else
+int fb_parse_edid(unsigned char *edid, struct fb_var_screeninfo *var)
+{
+	return 1;
+}
+void fb_edid_to_monspecs(unsigned char *edid, struct fb_monspecs *specs)
+{
+	specs = NULL;
+}
+char *get_EDID_from_firmware(struct device *dev)
+{
+	return NULL;
+}
+struct fb_videomode *fb_create_modedb(unsigned char *edid, int *dbsize)
+{
+	return NULL;
+}
+void fb_destroy_modedb(struct fb_videomode *modedb)
+{
+}
+int fb_get_monitor_limits(unsigned char *edid, struct fb_monspecs *specs)
+{
+	return 1;
+}
+int fb_get_mode(int flags, u32 val, struct fb_var_screeninfo *var,
+		struct fb_info *info)
+{
+	return -EINVAL;
+}
+#endif /* CONFIG_FB_MODE_HELPERS */
 	
 /*
  * fb_validate_mode - validates var against monitor capabilities
diff -uprN linux-2.6.8-rc3-mm1-orig/drivers/video/Kconfig linux-2.6.8-rc3-mm1/drivers/video/Kconfig
--- linux-2.6.8-rc3-mm1-orig/drivers/video/Kconfig	2004-08-08 22:55:37.046834424 +0800
+++ linux-2.6.8-rc3-mm1/drivers/video/Kconfig	2004-08-08 22:55:09.143076440 +0800
@@ -38,6 +38,17 @@ config FB
 	  (e.g. an accelerated X server) and that are not frame buffer
 	  device-aware may cause unexpected results. If unsure, say N.
 
+config FB_MODE_HELPERS
+        bool "Enable Video Mode Handling Helpers"
+        depends on FB
+	default y
+	---help---
+	  This enables functions for handling video modes using the
+	  Generalized Timing Formula and the EDID parser. A few drivers rely
+          on this feature such as the radeonfb, rivafb, and the i810fb. If
+	  your driver does not take advantage of this feature, choosing Y will
+	  just increase the kernel size by about 5K.   
+
 config FB_CIRRUS
 	tristate "Cirrus Logic support"
 	depends on FB && (ZORRO || PCI)
diff -uprN linux-2.6.8-rc3-mm1-orig/drivers/video/modedb.c linux-2.6.8-rc3-mm1/drivers/video/modedb.c
--- linux-2.6.8-rc3-mm1-orig/drivers/video/modedb.c	2004-08-08 22:03:39.000000000 +0800
+++ linux-2.6.8-rc3-mm1/drivers/video/modedb.c	2004-08-08 22:55:20.635329352 +0800
@@ -39,7 +39,7 @@ const char *global_mode_option = NULL;
 
 #define DEFAULT_MODEDB_INDEX	0
 
-static const struct fb_videomode modedb[] = {
+static const __init struct fb_videomode modedb[] = {
     {
 	/* 640x400 @ 70 Hz, 31.5 kHz hsync */
 	NULL, 70, 640, 400, 39721, 40, 24, 39, 9, 96, 2,
@@ -251,6 +251,7 @@ static const struct fb_videomode modedb[
     },
 };
 
+#ifdef CONFIG_FB_MODE_HELPERS
 const struct fb_videomode vesa_modes[] = {
 	/* 0 640x350-85 VESA */
 	{ NULL, 85, 640, 350, 31746,  96, 32, 60, 32, 64, 3,
@@ -374,6 +375,8 @@ const struct fb_videomode vesa_modes[] =
 	{ NULL, 60, 1920, 1440, 3367, 352, 144, 56, 1, 224, 3,
 	  FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED, FB_MODE_IS_VESA },
 };
+EXPORT_SYMBOL(vesa_modes);
+#endif /* CONFIG_FB_MODE_HELPERS */
 
 static int my_atoi(const char *name)
 {
@@ -404,7 +407,7 @@ static int my_atoi(const char *name)
  */
 
 int fb_try_mode(struct fb_var_screeninfo *var, struct fb_info *info,
-		  const struct fb_videomode *mode, unsigned int bpp)
+		const struct fb_videomode *mode, unsigned int bpp)
 {
     int err = 0;
 
@@ -826,5 +829,4 @@ EXPORT_SYMBOL(fb_destroy_modelist);
 EXPORT_SYMBOL(fb_match_mode);
 EXPORT_SYMBOL(fb_find_best_mode);
 EXPORT_SYMBOL(fb_videomode_to_modelist);
-EXPORT_SYMBOL(vesa_modes);
 EXPORT_SYMBOL(fb_find_mode);





-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
