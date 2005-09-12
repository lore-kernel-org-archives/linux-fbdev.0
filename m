From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 3/4] i810fb: Change option ext_vga to extvga to match documentation
Date: Mon, 12 Sep 2005 09:16:47 +0800
Message-ID: <4324D6FF.5080407@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EEd0d-00043C-LE
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 11 Sep 2005 18:21:23 -0700
Received: from zproxy.gmail.com ([64.233.162.201])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EEd0c-0007Ei-9V
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 11 Sep 2005 18:21:23 -0700
Received: by zproxy.gmail.com with SMTP id i11so168172nzh
        for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 11 Sep 2005 18:21:16 -0700 (PDT)
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

Reported by: Manuel Lauss <mano@roarinelk.homelinux.net>

He was getting random initial video modes depending on the kernel
configuration.  His option line includes 'extvga'.

The i810fb documentation describes the option 'extvga', however the
driver accepts 'ext_vga'.  Besides 'extvga' being ignored by i810fb,
it also confuses the option parser of i810fb and assigns 'extvga' to
'mode_option'.  This leads to an incorrect video mode at boot time.

Signed-off-by: Antonino Daplas <adaplas@pol.net>

---
 i810_main.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)


diff --git a/drivers/video/i810/i810_main.c b/drivers/video/i810/i810_main.c
--- a/drivers/video/i810/i810_main.c
+++ b/drivers/video/i810/i810_main.c
@@ -105,7 +105,7 @@ static int xres       __devinitdata;
 static int yres       __devinitdata;
 static int vyres      __devinitdata;
 static int sync       __devinitdata;
-static int ext_vga    __devinitdata;
+static int extvga     __devinitdata;
 static int dcolor     __devinitdata;
 
 /*------------------------------------------------------------*/
@@ -1766,7 +1766,7 @@ static void __devinit i810_init_device(s
 	i810_init_cursor(par);
 
 	/* mvo: enable external vga-connector (for laptops) */
-	if (ext_vga) {
+	if (extvga) {
 		i810_writel(HVSYNC, mmio, 0);
 		i810_writel(PWR_CLKC, mmio, 3);
 	}
@@ -1921,8 +1921,8 @@ static int __devinit i810fb_setup(char *
 			mtrr = 1;
 		else if (!strncmp(this_opt, "accel", 5))
 			accel = 1;
-		else if (!strncmp(this_opt, "ext_vga", 7))
-			ext_vga = 1;
+		else if (!strncmp(this_opt, "extvga", 6))
+			extvga = 1;
 		else if (!strncmp(this_opt, "sync", 4))
 			sync = 1;
 		else if (!strncmp(this_opt, "vram:", 5))
@@ -2151,8 +2151,8 @@ module_param(accel, bool, 0);
 MODULE_PARM_DESC(accel, "Use Acceleration (BLIT) engine (default = 0)");
 module_param(mtrr, bool, 0);
 MODULE_PARM_DESC(mtrr, "Use MTRR (default = 0)");
-module_param(ext_vga, bool, 0);
-MODULE_PARM_DESC(ext_vga, "Enable external VGA connector (default = 0)");
+module_param(extvga, bool, 0);
+MODULE_PARM_DESC(extvga, "Enable external VGA connector (default = 0)");
 module_param(sync, bool, 0);
 MODULE_PARM_DESC(sync, "wait for accel engine to finish drawing"
 		 " (default = 0)");



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
