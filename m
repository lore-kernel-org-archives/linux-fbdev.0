From: Adrian Bunk <bunk@stusta.de>
Subject: [2.6 patch] matroxfb_base.c: make some code static
Date: Sun, 21 Nov 2004 16:36:09 +0100
Message-ID: <20041121153608.GP2829@stusta.de>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261713AbUKUQmE@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: Antonino Daplas <adaplas@pol.net>, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

The patch below makes some needlessly global code in 
drivers/video/matrox/matroxfb_base.c static.


diffstat output:
 drivers/video/matrox/matroxfb_base.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm2-full/drivers/video/matrox/matroxfb_base.c.old	2004-11-21 14:40:28.000000000 +0100
+++ linux-2.6.10-rc2-mm2-full/drivers/video/matrox/matroxfb_base.c	2004-11-21 14:41:35.000000000 +0100
@@ -1908,8 +1908,8 @@
 	return err;
 }
 
-LIST_HEAD(matroxfb_list);
-LIST_HEAD(matroxfb_driver_list);
+static LIST_HEAD(matroxfb_list);
+static LIST_HEAD(matroxfb_driver_list);
 
 #define matroxfb_l(x) list_entry(x, struct matrox_fb_info, next_fb)
 #define matroxfb_driver_l(x) list_entry(x, struct matroxfb_driver, node)
@@ -2287,7 +2287,7 @@
 
 /* ************************* init in-kernel code ************************** */
 
-int __init matroxfb_setup(char *options) {
+static int __init matroxfb_setup(char *options) {
 	char *this_opt;
 
 	DBG(__FUNCTION__)
@@ -2428,7 +2428,7 @@
 
 static int __initdata initialized = 0;
 
-int __init matroxfb_init(void)
+static int __init matroxfb_init(void)
 {
 	char *option = NULL;
 
