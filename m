From: Adrian Bunk <bunk@stusta.de>
Subject: [2.6 patch] drivers/video/i810/: make some code static
Date: Sun, 21 Nov 2004 16:36:20 +0100
Message-ID: <20041121153620.GT2829@stusta.de>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261653AbUKUQbe@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Antonino Daplas <adaplas@pol.net>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

The patch below makes some needlessly global code static.


diffstat output:
 drivers/video/i810/i810_gtf.c  |   12 ++++++------
 drivers/video/i810/i810_main.c |   12 +++++++-----
 2 files changed, 13 insertions(+), 11 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm2-full/drivers/video/i810/i810_gtf.c.old	2004-11-21 15:13:59.000000000 +0100
+++ linux-2.6.10-rc2-mm2-full/drivers/video/i810/i810_gtf.c	2004-11-21 15:15:02.000000000 +0100
@@ -26,7 +26,7 @@
    u32  wm;
 };
 
-struct wm_info i810_wm_8_100[] = {
+static struct wm_info i810_wm_8_100[] = {
 	{ 15, 0x0070c000 },  { 19, 0x0070c000 },  { 25, 0x22003000 },
 	{ 28, 0x22003000 },  { 31, 0x22003000 },  { 36, 0x22007000 },
 	{ 40, 0x22007000 },  { 45, 0x22007000 },  { 49, 0x22008000 },
@@ -40,7 +40,7 @@
 	{ 218, 0x2220f000 }, { 229, 0x22210000 }, { 234, 0x22210000 }, 
 };
 
-struct wm_info i810_wm_16_100[] = {
+static struct wm_info i810_wm_16_100[] = {
 	{ 15, 0x0070c000 },  { 19, 0x0020c000 },  { 25, 0x22006000 },
 	{ 28, 0x22006000 },  { 31, 0x22007000 },  { 36, 0x22007000 },
 	{ 40, 0x22007000 },  { 45, 0x22007000 },  { 49, 0x22009000 },
@@ -54,7 +54,7 @@
 	{ 218, 0x22416000 }, { 229, 0x22416000 },
 };
 
-struct wm_info i810_wm_24_100[] = {
+static struct wm_info i810_wm_24_100[] = {
 	{ 15, 0x0020c000 },  { 19, 0x0040c000 },  { 25, 0x22009000 },
 	{ 28, 0x22009000 },  { 31, 0x2200a000 },  { 36, 0x2210c000 },
 	{ 40, 0x2210c000 },  { 45, 0x2210c000 },  { 49, 0x22111000 },
@@ -67,7 +67,7 @@
 	{ 195, 0x44419000 }, { 202, 0x44419000 }, { 204, 0x44419000 },
 };
 
-struct wm_info i810_wm_8_133[] = {
+static struct wm_info i810_wm_8_133[] = {
 	{ 15, 0x0070c000 },  { 19, 0x0070c000 },  { 25, 0x22003000 },
 	{ 28, 0x22003000 },  { 31, 0x22003000 },  { 36, 0x22007000 },
 	{ 40, 0x22007000 },  { 45, 0x22007000 },  { 49, 0x22008000 },
@@ -81,7 +81,7 @@
 	{ 218, 0x2220f000 }, { 229, 0x22210000 }, { 234, 0x22210000 }, 
 };
 
-struct wm_info i810_wm_16_133[] = {
+static struct wm_info i810_wm_16_133[] = {
 	{ 15, 0x0020c000 },  { 19, 0x0020c000 },  { 25, 0x22006000 },
 	{ 28, 0x22006000 },  { 31, 0x22007000 },  { 36, 0x22007000 },
 	{ 40, 0x22007000 },  { 45, 0x22007000 },  { 49, 0x22009000 },
@@ -95,7 +95,7 @@
 	{ 218, 0x22416000 }, { 229, 0x22416000 },
 };
 
-struct wm_info i810_wm_24_133[] = {
+static struct wm_info i810_wm_24_133[] = {
 	{ 15, 0x0020c000 },  { 19, 0x00408000 },  { 25, 0x22009000 },
 	{ 28, 0x22009000 },  { 31, 0x2200a000 },  { 36, 0x2210c000 },
 	{ 40, 0x2210c000 },  { 45, 0x2210c000 },  { 49, 0x22111000 },
--- linux-2.6.10-rc2-mm2-full/drivers/video/i810/i810_main.c.old	2004-11-21 15:15:22.000000000 +0100
+++ linux-2.6.10-rc2-mm2-full/drivers/video/i810/i810_main.c	2004-11-21 15:16:57.000000000 +0100
@@ -635,7 +635,7 @@
  * DESCRIPTION:
  * Calculates buffer pitch in bytes.  
  */
-u32 get_line_length(struct i810fb_par *par, int xres_virtual, int bpp)
+static u32 get_line_length(struct i810fb_par *par, int xres_virtual, int bpp)
 {
    	u32 length;
 	
@@ -724,7 +724,7 @@
  * Description:
  * Shows or hides the hardware cursor
  */
-void i810_enable_cursor(u8 __iomem *mmio, int mode)
+static void i810_enable_cursor(u8 __iomem *mmio, int mode)
 {
 	u32 temp;
 	
@@ -1804,8 +1804,9 @@
 
 	return 0;
 }
-	
-int __init i810fb_setup(char *options)
+
+#ifndef MODULE
+static int __init i810fb_setup(char *options)
 {
 	char *this_opt, *suffix = NULL;
 
@@ -1850,6 +1851,7 @@
 	}
 	return 0;
 }
+#endif
 
 static int __devinit i810fb_init_pci (struct pci_dev *dev, 
 				   const struct pci_device_id *entry)
@@ -1976,7 +1978,7 @@
 }                                                	
 
 #ifndef MODULE
-int __init i810fb_init(void)
+static int __init i810fb_init(void)
 {
 	char *option = NULL;
 
