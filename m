From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 4/4] fbdev: Convert a few drivers to use the fb_find_best_display
 helper
Date: Wed, 26 Oct 2005 20:04:30 +0800
Message-ID: <435F70CE.1070207@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EUk2e-0001rj-0m
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 26 Oct 2005 05:06:04 -0700
Received: from zproxy.gmail.com ([64.233.162.200])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EUk2d-00084U-MS
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 26 Oct 2005 05:06:04 -0700
Received: by zproxy.gmail.com with SMTP id 14so104212nzn
        for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 26 Oct 2005 05:06:03 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Convert i810fb, nvidiafb and savagefb to use the fb_find_best_display
helper when searching for the initial video mode.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---
 i810/i810_main.c         |   17 ++++-------------
 nvidia/nvidia.c          |   18 +++---------------
 savage/savagefb_driver.c |   21 ++++-----------------
 3 files changed, 11 insertions(+), 45 deletions(-)


diff --git a/drivers/video/i810/i810_main.c b/drivers/video/i810/i810_main.c
index 96f5f62..c0c974b 100644
--- a/drivers/video/i810/i810_main.c
+++ b/drivers/video/i810/i810_main.c
@@ -1871,27 +1871,18 @@ static void __devinit i810fb_find_init_m
 	fb_videomode_to_modelist(specs->modedb, specs->modedb_len,
 				 &info->modelist);
 	if (specs->modedb != NULL) {
-		if (xres && yres) {
-			struct fb_videomode *m;
+		struct fb_videomode *m;
 
+		if (xres && yres) {
 			if ((m = fb_find_best_mode(&var, &info->modelist))) {
 				mode = *m;
 				found  = 1;
 			}
 		}
 
-		if (!found && specs->misc & FB_MISC_1ST_DETAIL) {
-			for (i = 0; i < specs->modedb_len; i++) {
-				if (specs->modedb[i].flag & FB_MODE_IS_FIRST) {
-					mode = specs->modedb[i];
-					found = 1;
-					break;
-				}
-			}
-		}
-
 		if (!found) {
-			mode = specs->modedb[0];
+			m = fb_find_best_display(&info->monspecs, &info->modelist);
+			mode = *m;
 			found = 1;
 		}
 
diff --git a/drivers/video/nvidia/nvidia.c b/drivers/video/nvidia/nvidia.c
index 3ceb74e..8c4cc36 100644
--- a/drivers/video/nvidia/nvidia.c
+++ b/drivers/video/nvidia/nvidia.c
@@ -1375,22 +1375,10 @@ static int __devinit nvidia_set_fbinfo(s
 	fb_var_to_videomode(&modedb, &nvidiafb_default_var);
 
 	if (specs->modedb != NULL) {
-		/* get preferred timing */
-		if (specs->misc & FB_MISC_1ST_DETAIL) {
-			int i;
-
-			for (i = 0; i < specs->modedb_len; i++) {
-				if (specs->modedb[i].flag & FB_MODE_IS_FIRST) {
-					modedb = specs->modedb[i];
-					break;
-				}
-			}
-		} else {
-			/* otherwise, get first mode in database */
-			modedb = specs->modedb[0];
-		}
+		struct fb_videomode *modedb;
 
-		fb_videomode_to_var(&nvidiafb_default_var, &modedb);
+		modedb = fb_find_best_display(specs, &info->modelist);
+		fb_videomode_to_var(&nvidiafb_default_var, modedb);
 		nvidiafb_default_var.bits_per_pixel = 8;
 	} else if (par->fpWidth && par->fpHeight) {
 		char buf[16];
diff --git a/drivers/video/savage/savagefb_driver.c b/drivers/video/savage/savagefb_driver.c
index 46b1a9c..62c47ea 100644
--- a/drivers/video/savage/savagefb_driver.c
+++ b/drivers/video/savage/savagefb_driver.c
@@ -2052,24 +2052,11 @@ static int __devinit savagefb_probe (str
 			     info->monspecs.modedb, info->monspecs.modedb_len,
 			     NULL, 8);
 	} else if (info->monspecs.modedb != NULL) {
-		struct fb_monspecs *specs = &info->monspecs;
-		struct fb_videomode modedb;
+		struct fb_videomode *modedb;
 
-		if (info->monspecs.misc & FB_MISC_1ST_DETAIL) {
-			int i;
-
-			for (i = 0; i < specs->modedb_len; i++) {
-				if (specs->modedb[i].flag & FB_MODE_IS_FIRST) {
-					modedb = specs->modedb[i];
-					break;
-				}
-			}
-		} else {
-			/* otherwise, get first mode in database */
-			modedb = specs->modedb[0];
-		}
-
-		savage_update_var(&info->var, &modedb);
+		modedb = fb_find_best_display(&info->monspecs,
+					      &info->modelist);
+		savage_update_var(&info->var, modedb);
 	}
 
 	/* maximize virtual vertical length */



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
