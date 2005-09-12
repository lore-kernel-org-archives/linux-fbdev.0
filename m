From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 2/4] i810fb: Restore xres and yres option parameters
Date: Mon, 12 Sep 2005 09:15:16 +0800
Message-ID: <4324D6A4.8080304@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EEd0V-000434-NZ
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 11 Sep 2005 18:21:15 -0700
Received: from zproxy.gmail.com ([64.233.162.206])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EEd0U-0007DB-DQ
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 11 Sep 2005 18:21:15 -0700
Received: by zproxy.gmail.com with SMTP id i11so168161nzh
        for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 11 Sep 2005 18:21:08 -0700 (PDT)
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
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

If i810fb successfully probed for the EDID, it will disregard the
boot option parameters 'xres' and 'yres'.  Fix this regression.

Excellent testing done by Manuel Lauss <mano@roarinelk.homelinux.net>.

Signed-off-by: Antonino Daplas <adaplas@pol.net>

---
 i810_main.c |   52 +++++++++++++++++++++++++++++++++++-----------------
 1 files changed, 35 insertions(+), 17 deletions(-)


diff --git a/drivers/video/i810/i810_main.c b/drivers/video/i810/i810_main.c
--- a/drivers/video/i810/i810_main.c
+++ b/drivers/video/i810/i810_main.c
@@ -95,18 +95,18 @@ static struct pci_driver i810fb_driver =
 static char *mode_option __devinitdata = NULL;
 static int vram       __devinitdata = 4;
 static int bpp        __devinitdata = 8;
-static int mtrr       __devinitdata = 0;
-static int accel      __devinitdata = 0;
-static int hsync1     __devinitdata = 0;
-static int hsync2     __devinitdata = 0;
-static int vsync1     __devinitdata = 0;
-static int vsync2     __devinitdata = 0;
-static int xres       __devinitdata = 640;
-static int yres       __devinitdata = 480;
-static int vyres      __devinitdata = 0;
-static int sync       __devinitdata = 0;
-static int ext_vga    __devinitdata = 0;
-static int dcolor     __devinitdata = 0;
+static int mtrr       __devinitdata;
+static int accel      __devinitdata;
+static int hsync1     __devinitdata;
+static int hsync2     __devinitdata;
+static int vsync1     __devinitdata;
+static int vsync2     __devinitdata;
+static int xres       __devinitdata;
+static int yres       __devinitdata;
+static int vyres      __devinitdata;
+static int sync       __devinitdata;
+static int ext_vga    __devinitdata;
+static int dcolor     __devinitdata;
 
 /*------------------------------------------------------------*/
 
@@ -1725,12 +1725,21 @@ static void __devinit i810_init_defaults
 	if (bpp < 8)
 		bpp = 8;
 	
+	par->i810fb_ops = i810fb_ops;
+
+	if (xres)
+		info->var.xres = xres;
+	else
+		info->var.xres = 640;
+
+	if (yres)
+		info->var.yres = yres;
+	else
+		info->var.yres = 480;
+
 	if (!vyres) 
-		vyres = (vram << 20)/(xres*bpp >> 3);
+		vyres = (vram << 20)/(info->var.xres*bpp >> 3);
 
-	par->i810fb_ops = i810fb_ops;
-	info->var.xres = xres;
-	info->var.yres = yres;
 	info->var.yres_virtual = vyres;
 	info->var.bits_per_pixel = bpp;
 
@@ -1862,7 +1871,16 @@ static void __devinit i810fb_find_init_m
 	fb_videomode_to_modelist(specs->modedb, specs->modedb_len,
 				 &info->modelist);
 	if (specs->modedb != NULL) {
-		if (specs->misc & FB_MISC_1ST_DETAIL) {
+		if (xres && yres) {
+			struct fb_videomode *m;
+
+			if ((m = fb_find_best_mode(&var, &info->modelist))) {
+				mode = *m;
+				found  = 1;
+			}
+		}
+
+		if (!found && specs->misc & FB_MISC_1ST_DETAIL) {
 			for (i = 0; i < specs->modedb_len; i++) {
 				if (specs->modedb[i].flag & FB_MODE_IS_FIRST) {
 					mode = specs->modedb[i];



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
