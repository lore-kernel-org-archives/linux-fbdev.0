From: Adrian Bunk <bunk@stusta.de>
Subject: [2.6 patch] savagefb.c: make some code static
Date: Sun, 21 Nov 2004 16:36:35 +0100
Message-ID: <20041121153635.GX2829@stusta.de>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261702AbUKUPn7@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Denis Oliver Kropp <dok@directfb.org>, Sven Neumann <neo@directfb.org>
Cc: Antonino Daplas <adaplas@pol.net>, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

The patch below makes some needlessly global code static.


diffstat output:
 drivers/video/savage/savagefb.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm2-full/drivers/video/savage/savagefb.c.old	2004-11-21 14:57:29.000000000 +0100
+++ linux-2.6.10-rc2-mm2-full/drivers/video/savage/savagefb.c	2004-11-21 14:58:53.000000000 +0100
@@ -1458,7 +1458,7 @@
 }
 
 
-void savage_disable_mmio (struct savagefb_par *par)
+static void savage_disable_mmio (struct savagefb_par *par)
 {
 	unsigned char val;
 
@@ -2241,7 +2241,7 @@
 
 /* ************************* init in-kernel code ************************** */
 
-int __init savagefb_setup(char *options)
+static int __init savagefb_setup(char *options)
 {
 #ifndef MODULE
 	char *this_opt;
@@ -2256,7 +2256,7 @@
 	return 0;
 }
 
-int __init savagefb_init(void)
+static int __init savagefb_init(void)
 {
 	char *option;
 
