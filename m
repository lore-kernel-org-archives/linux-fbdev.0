From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 3/9] nvidiafb: Add boot option 'bpp'
Date: Tue, 20 Dec 2005 20:49:11 +0800
Message-ID: <43A7FDC7.9040707@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EoyEj-0002BF-TL
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 20 Dec 2005 23:18:09 -0800
Received: from zproxy.gmail.com ([64.233.162.201])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EoyEi-0005tJ-7E
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 20 Dec 2005 23:18:09 -0800
Received: by zproxy.gmail.com with SMTP id r28so82174nza
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 20 Dec 2005 23:18:05 -0800 (PST)
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

Add boot/module option 'bpp' so user can specify at what color
depth to boot into.
    
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/nvidia/nvidia.c |   25 +++++++++++++++++++++----
 1 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/video/nvidia/nvidia.c b/drivers/video/nvidia/nvidia.c
index 099d64a..ae6f2ff 100644
--- a/drivers/video/nvidia/nvidia.c
+++ b/drivers/video/nvidia/nvidia.c
@@ -428,6 +428,7 @@ static int noaccel __devinitdata = 0;
 static int noscale __devinitdata = 0;
 static int paneltweak __devinitdata = 0;
 static int vram __devinitdata = 0;
+static int bpp __devinitdata = 8;
 #ifdef CONFIG_MTRR
 static int nomtrr __devinitdata = 0;
 #endif
@@ -1392,24 +1393,36 @@ static int __devinit nvidia_set_fbinfo(s
 				 info->monspecs.modedb_len, &info->modelist);
 	fb_var_to_videomode(&modedb, &nvidiafb_default_var);
 
+	switch (bpp) {
+	case 0 ... 8:
+		bpp = 8;
+		break;
+	case 9 ... 16:
+		bpp = 16;
+		break;
+	default:
+		bpp = 32;
+		break;
+	}
+
 	if (specs->modedb != NULL) {
 		struct fb_videomode *modedb;
 
 		modedb = fb_find_best_display(specs, &info->modelist);
 		fb_videomode_to_var(&nvidiafb_default_var, modedb);
-		nvidiafb_default_var.bits_per_pixel = 8;
+		nvidiafb_default_var.bits_per_pixel = bpp;
 	} else if (par->fpWidth && par->fpHeight) {
 		char buf[16];
 
 		memset(buf, 0, 16);
 		snprintf(buf, 15, "%dx%dMR", par->fpWidth, par->fpHeight);
 		fb_find_mode(&nvidiafb_default_var, info, buf, specs->modedb,
-			     specs->modedb_len, &modedb, 8);
+			     specs->modedb_len, &modedb, bpp);
 	}
 
 	if (mode_option)
 		fb_find_mode(&nvidiafb_default_var, info, mode_option,
-			     specs->modedb, specs->modedb_len, &modedb, 8);
+			     specs->modedb, specs->modedb_len, &modedb, bpp);
 
 	info->var = nvidiafb_default_var;
 	info->fix.visual = (info->var.bits_per_pixel == 8) ?
@@ -1769,6 +1782,8 @@ static int __devinit nvidiafb_setup(char
 #endif
 		} else if (!strncmp(this_opt, "fpdither:", 9)) {
 			fpdither = simple_strtol(this_opt+9, NULL, 0);
+		} else if (!strncmp(this_opt, "bpp:", 4)) {
+			bpp = simple_strtoul(this_opt+4, NULL, 0);
 		} else
 			mode_option = this_opt;
 	}
@@ -1846,7 +1861,9 @@ MODULE_PARM_DESC(vram,
 		 "(default=0 - remap entire memory)");
 module_param(mode_option, charp, 0);
 MODULE_PARM_DESC(mode_option, "Specify initial video mode");
-
+module_param(bpp, int, 0);
+MODULE_PARM_DESC(bpp, "pixel width in bits"
+		 "(default=8)");
 #ifdef CONFIG_MTRR
 module_param(nomtrr, bool, 0);
 MODULE_PARM_DESC(nomtrr, "Disables MTRR support (0 or 1=disabled) "




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
