From: Adrian Bunk <bunk@stusta.de>
Subject: [2.6 patch] tdfxfb.c: make some code static
Date: Sun, 21 Nov 2004 16:36:39 +0100
Message-ID: <20041121153639.GY2829@stusta.de>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261686AbUKUPn6@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hannu Mallat <hmallat@cc.hut.fi>
Cc: Antonino Daplas <adaplas@pol.net>, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

The patch below makes some needlesly global code static.


diffstat output:
 drivers/video/tdfxfb.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm2-full/drivers/video/tdfxfb.c.old	2004-11-21 15:00:22.000000000 +0100
+++ linux-2.6.10-rc2-mm2-full/drivers/video/tdfxfb.c	2004-11-21 15:00:55.000000000 +0100
@@ -154,8 +154,8 @@
 /*
  *  Frame buffer device API
  */
-int tdfxfb_init(void);
-void tdfxfb_setup(char *options);
+static int tdfxfb_init(void);
+static void tdfxfb_setup(char *options);
 
 static int tdfxfb_check_var(struct fb_var_screeninfo *var, struct fb_info *fb); 
 static int tdfxfb_set_par(struct fb_info *info); 
@@ -1356,7 +1356,7 @@
 	framebuffer_release(info);
 }
 
-int __init tdfxfb_init(void)
+static int __init tdfxfb_init(void)
 {
 #ifndef MODULE
 	char *option = NULL;
@@ -1383,7 +1383,7 @@
 
 
 #ifndef MODULE
-void tdfxfb_setup(char *options)
+static void tdfxfb_setup(char *options)
 { 
 	char* this_opt;
 
