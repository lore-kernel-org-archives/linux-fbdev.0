From: Adrian Bunk <bunk@stusta.de>
Subject: [2.6 patch] asiliantfb.c: make some code static
Date: Sun, 21 Nov 2004 16:36:12 +0100
Message-ID: <20041121153611.GQ2829@stusta.de>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261675AbUKUQmD@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Antonino Daplas <adaplas@pol.net>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

The patch below make some needlesly global code static.


diffstat output:
 drivers/video/asiliantfb.c |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)



Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm2-full/drivers/video/asiliantfb.c.old	2004-11-21 15:08:17.000000000 +0100
+++ linux-2.6.10-rc2-mm2-full/drivers/video/asiliantfb.c	2004-11-21 15:08:58.000000000 +0100
@@ -46,7 +46,7 @@
 #include <asm/io.h>
 
 /* Built in clock of the 69030 */
-const unsigned Fref = 14318180;
+static const unsigned Fref = 14318180;
 
 #define mmio_base (p->screen_base + 0x400000)
 
@@ -91,11 +91,6 @@
 }
 #define write_ar(num, val)	mm_write_ar(p, num, val)
 
-/*
- * Exported functions
- */
-int asiliantfb_init(void);
-
 static int asiliantfb_pci_init(struct pci_dev *dp, const struct pci_device_id *);
 static int asiliantfb_check_var(struct fb_var_screeninfo *var,
 				struct fb_info *info);
@@ -604,7 +599,7 @@
 	.remove =	__devexit_p(asiliantfb_remove),
 };
 
-int __init asiliantfb_init(void)
+static int __init asiliantfb_init(void)
 {
 	if (fb_get_options("asiliantfb", NULL))
 		return -ENODEV;
