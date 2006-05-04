From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 3/9] intelfb: Use firmware EDID for mode database
Date: Thu, 04 May 2006 20:30:20 +0800
Message-ID: <4459F3DC.9090208@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Fbd5W-0007mF-Ty
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 04 May 2006 05:37:46 -0700
Received: from wx-out-0102.google.com ([66.249.82.202])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Fbd5W-0002Pa-Oh
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 04 May 2006 05:37:47 -0700
Received: by wx-out-0102.google.com with SMTP id h26so310349wxd
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 04 May 2006 05:37:46 -0700 (PDT)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Sylvain Meyer <sylvain.meyer@worldonline.fr>

Use firmware EDID for the driver's private mode database. Untested.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/intelfb/intelfbdrv.c |   36 +++++++++++++++++++++++++++++++++---
 1 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/drivers/video/intelfb/intelfbdrv.c b/drivers/video/intelfb/intelfbdrv.c
index 2aba6a4..66bd6ab 100644
--- a/drivers/video/intelfb/intelfbdrv.c
+++ b/drivers/video/intelfb/intelfbdrv.c
@@ -132,6 +132,7 @@
 
 #include "intelfb.h"
 #include "intelfbhw.h"
+#include "../edid.h"
 
 static void __devinit get_initial_mode(struct intelfb_info *dinfo);
 static void update_dinfo(struct intelfb_info *dinfo,
@@ -1031,13 +1032,42 @@ intelfb_init_var(struct intelfb_info *di
 		       sizeof(struct fb_var_screeninfo));
 		msrc = 5;
 	} else {
+		const u8 *edid_s = fb_firmware_edid(&dinfo->pdev->dev);
+		u8 *edid_d = NULL;
+
+		if (edid_s) {
+			edid_d = kmalloc(128, GFP_KERNEL);
+
+			if (edid_d) {
+				memcpy(edid_d, edid_s, 128);
+				fb_edid_to_monspecs(edid_d,
+						    &dinfo->info->monspecs);
+				kfree(edid_d);
+			}
+		}
+
 		if (mode) {
+			printk("intelfb: Looking for mode in private "
+			       "database\n");
 			msrc = fb_find_mode(var, dinfo->info, mode,
-					    vesa_modes, VESA_MODEDB_SIZE,
+					    dinfo->info->monspecs.modedb,
+					    dinfo->info->monspecs.modedb_len,
 					    NULL, 0);
-			if (msrc)
-				msrc |= 8;
+
+			if (msrc && msrc > 1) {
+				printk("intelfb: No mode in private database, "
+				       "intelfb: looking for mode in global "
+				       "database ");
+				msrc = fb_find_mode(var, dinfo->info, mode,
+						    vesa_modes,
+						    VESA_MODEDB_SIZE, NULL, 0);
+
+				if (msrc)
+					msrc |= 8;
+			}
+
 		}
+
 		if (!msrc) {
 			msrc = fb_find_mode(var, dinfo->info, PREFERRED_MODE,
 					    vesa_modes, VESA_MODEDB_SIZE,



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
