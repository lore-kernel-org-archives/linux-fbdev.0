From: Adrian Bunk <bunk@stusta.de>
Subject: [2.6 patch] pm2fb.c: make some code static
Date: Sun, 21 Nov 2004 16:36:32 +0100
Message-ID: <20041121153632.GW2829@stusta.de>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261739AbUKUQNx@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: jim.hague@acm.org
Cc: Antonino Daplas <adaplas@pol.net>, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

The patch below makes some needlessly global code static.


diffstat output:
 drivers/video/pm2fb.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm2-full/drivers/video/pm2fb.c.old	2004-11-21 14:56:25.000000000 +0100
+++ linux-2.6.10-rc2-mm2-full/drivers/video/pm2fb.c	2004-11-21 14:56:49.000000000 +0100
@@ -1215,9 +1215,9 @@
  *  Initialization
  */
 
-int __init pm2fb_setup(char *options);
+static int __init pm2fb_setup(char *options);
 
-int __init pm2fb_init(void)
+static int __init pm2fb_init(void)
 {
 #ifndef MODULE
 	char *option = NULL;
@@ -1248,7 +1248,7 @@
  *
  * This is, comma-separated options following `video=pm2fb:'.
  */
-int __init pm2fb_setup(char *options)
+static int __init pm2fb_setup(char *options)
 {
 	char* this_opt;
 
