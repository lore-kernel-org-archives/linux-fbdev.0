From: Adrian Bunk <bunk@stusta.de>
Subject: [2.6 patch] neofb.c: make some code static
Date: Sun, 21 Nov 2004 16:36:24 +0100
Message-ID: <20041121153624.GU2829@stusta.de>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261647AbUKUQQm@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Denis Oliver Kropp <dok@directfb.org>
Cc: Antonino Daplas <adaplas@pol.net>, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

The patch below makes some needlessly global code static.


diffstat output:
 drivers/video/neofb.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm2-full/drivers/video/neofb.c.old	2004-11-21 14:54:11.000000000 +0100
+++ linux-2.6.10-rc2-mm2-full/drivers/video/neofb.c	2004-11-21 14:55:53.000000000 +0100
@@ -405,21 +405,21 @@
  */
 static int paletteEnabled = 0;
 
-inline void VGAenablePalette(void)
+static inline void VGAenablePalette(void)
 {
 	vga_r(NULL, VGA_IS1_RC);
 	vga_w(NULL, VGA_ATT_W, 0x00);
 	paletteEnabled = 1;
 }
 
-inline void VGAdisablePalette(void)
+static inline void VGAdisablePalette(void)
 {
 	vga_r(NULL, VGA_IS1_RC);
 	vga_w(NULL, VGA_ATT_W, 0x20);
 	paletteEnabled = 0;
 }
 
-inline void VGAwATTR(u8 index, u8 value)
+static inline void VGAwATTR(u8 index, u8 value)
 {
 	if (paletteEnabled)
 		index &= ~0x20;
@@ -430,7 +430,7 @@
 	vga_wattr(NULL, index, value);
 }
 
-void vgaHWProtect(int on)
+static void vgaHWProtect(int on)
 {
 	unsigned char tmp;
 
@@ -1320,7 +1320,7 @@
 /*
  *    (Un)Blank the display.
  */
-int neofb_blank(int blank_mode, struct fb_info *info)
+static int neofb_blank(int blank_mode, struct fb_info *info)
 {
 	/*
 	 *  Blank the screen if blank_mode != 0, else unblank.
@@ -2236,7 +2236,7 @@
 
 /* ************************* init in-kernel code ************************** */
 
-int __init neofb_setup(char *options)
+static int __init neofb_setup(char *options)
 {
 	char *this_opt;
 
@@ -2265,7 +2265,7 @@
 	return 0;
 }
 
-int __init neofb_init(void)
+static int __init neofb_init(void)
 {
 #ifndef MODULE
 	char *option = NULL;
