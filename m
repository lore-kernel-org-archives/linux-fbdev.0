From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH] macmodes: Fix section warning
Date: Sun, 18 Jun 2006 23:41:43 +0800
Message-ID: <44957437.4040200@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Fs0LB-0006VF-PL for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 18 Jun 2006 09:41:37 -0700
Received: from py-out-1112.google.com ([64.233.166.182])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FrzW7-0000XY-KF
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 18 Jun 2006 08:48:52 -0700
Received: by py-out-1112.google.com with SMTP id i49so1055622pye
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 18 Jun 2006 08:48:51 -0700 (PDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Fix the following warning:

WARNING: drivers/video/macmodes.o - Section mismatch: reference to
.init.text:mac_find_mode from __ksymtab after '__ksymtab_mac_find_mode' (at
offset 0x10)

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/aty/aty128fb.c |   36 ++++++++++++++++++------------------
 drivers/video/macmodes.c     |    5 +++--
 drivers/video/macmodes.h     |    7 ++++---
 3 files changed, 25 insertions(+), 23 deletions(-)

diff --git a/drivers/video/aty/aty128fb.c b/drivers/video/aty/aty128fb.c
index db878fd..11cf7fc 100644
--- a/drivers/video/aty/aty128fb.c
+++ b/drivers/video/aty/aty128fb.c
@@ -100,7 +100,7 @@ #endif
 
 #ifndef CONFIG_PPC_PMAC
 /* default mode */
-static struct fb_var_screeninfo default_var __initdata = {
+static struct fb_var_screeninfo default_var __devinitdata = {
 	/* 640x480, 60 Hz, Non-Interlaced (25.175 MHz dotclock) */
 	640, 480, 640, 480, 0, 0, 8, 0,
 	{0, 8, 0}, {0, 8, 0}, {0, 8, 0}, {0, 0, 0},
@@ -123,7 +123,7 @@ #endif /* CONFIG_PPC_PMAC */
 
 /* default modedb mode */
 /* 640x480, 60 Hz, Non-Interlaced (25.172 MHz dotclock) */
-static struct fb_videomode defaultmode __initdata = {
+static struct fb_videomode defaultmode __devinitdata = {
 	.refresh =	60,
 	.xres =		640,
 	.yres =		480,
@@ -335,7 +335,7 @@ static const struct aty128_meminfo sdr_s
 static const struct aty128_meminfo ddr_sgram =
 	{ 4, 4, 3, 3, 2, 3, 1, 16, 31, 16, "64-bit DDR SGRAM" };
 
-static struct fb_fix_screeninfo aty128fb_fix __initdata = {
+static struct fb_fix_screeninfo aty128fb_fix __devinitdata = {
 	.id		= "ATY Rage128",
 	.type		= FB_TYPE_PACKED_PIXELS,
 	.visual		= FB_VISUAL_PSEUDOCOLOR,
@@ -345,15 +345,15 @@ static struct fb_fix_screeninfo aty128fb
 	.accel		= FB_ACCEL_ATI_RAGE128,
 };
 
-static char *mode_option __initdata = NULL;
+static char *mode_option __devinitdata = NULL;
 
 #ifdef CONFIG_PPC_PMAC
-static int default_vmode __initdata = VMODE_1024_768_60;
-static int default_cmode __initdata = CMODE_8;
+static int default_vmode __devinitdata = VMODE_1024_768_60;
+static int default_cmode __devinitdata = CMODE_8;
 #endif
 
-static int default_crt_on __initdata = 0;
-static int default_lcd_on __initdata = 1;
+static int default_crt_on __devinitdata = 0;
+static int default_lcd_on __devinitdata = 1;
 
 #ifdef CONFIG_MTRR
 static int mtrr = 1;
@@ -445,9 +445,9 @@ static int aty128_encode_var(struct fb_v
 static int aty128_decode_var(struct fb_var_screeninfo *var,
                              struct aty128fb_par *par);
 #if 0
-static void __init aty128_get_pllinfo(struct aty128fb_par *par,
+static void __devinit aty128_get_pllinfo(struct aty128fb_par *par,
 				      void __iomem *bios);
-static void __init __iomem *aty128_map_ROM(struct pci_dev *pdev, const struct aty128fb_par *par);
+static void __devinit __iomem *aty128_map_ROM(struct pci_dev *pdev, const struct aty128fb_par *par);
 #endif
 static void aty128_timings(struct aty128fb_par *par);
 static void aty128_init_engine(struct aty128fb_par *par);
@@ -573,7 +573,7 @@ static void aty_pll_writeupdate(const st
 
 
 /* write to the scratch register to test r/w functionality */
-static int __init register_test(const struct aty128fb_par *par)
+static int __devinit register_test(const struct aty128fb_par *par)
 {
 	u32 val;
 	int flag = 0;
@@ -772,7 +772,7 @@ static u32 depth_to_dst(u32 depth)
 
 
 #ifndef __sparc__
-static void __iomem * __init aty128_map_ROM(const struct aty128fb_par *par, struct pci_dev *dev)
+static void __iomem * __devinit aty128_map_ROM(const struct aty128fb_par *par, struct pci_dev *dev)
 {
 	u16 dptr;
 	u8 rom_type;
@@ -856,7 +856,7 @@ static void __iomem * __init aty128_map_
 	return NULL;
 }
 
-static void __init aty128_get_pllinfo(struct aty128fb_par *par, unsigned char __iomem *bios)
+static void __devinit aty128_get_pllinfo(struct aty128fb_par *par, unsigned char __iomem *bios)
 {
 	unsigned int bios_hdr;
 	unsigned int bios_pll;
@@ -903,7 +903,7 @@ #endif
 #endif /* ndef(__sparc__) */
 
 /* fill in known card constants if pll_block is not available */
-static void __init aty128_timings(struct aty128fb_par *par)
+static void __devinit aty128_timings(struct aty128fb_par *par)
 {
 #ifdef CONFIG_PPC_OF
 	/* instead of a table lookup, assume OF has properly
@@ -1645,7 +1645,7 @@ static int aty128fb_sync(struct fb_info 
 }
 
 #ifndef MODULE
-static int __init aty128fb_setup(char *options)
+static int __devinit aty128fb_setup(char *options)
 {
 	char *this_opt;
 
@@ -1893,7 +1893,7 @@ static void aty128_early_resume(void *da
 }
 #endif /* CONFIG_PPC_PMAC */
 
-static int __init aty128_init(struct pci_dev *pdev, const struct pci_device_id *ent)
+static int __devinit aty128_init(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	struct fb_info *info = pci_get_drvdata(pdev);
 	struct aty128fb_par *par = info->par;
@@ -2037,7 +2037,7 @@ #endif
 
 #ifdef CONFIG_PCI
 /* register a card    ++ajoshi */
-static int __init aty128_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
+static int __devinit aty128_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	unsigned long fb_addr, reg_addr;
 	struct aty128fb_par *par;
@@ -2556,7 +2556,7 @@ static int aty128_pci_resume(struct pci_
 }
 
 
-static int __init aty128fb_init(void)
+static int __devinit aty128fb_init(void)
 {
 #ifndef MODULE
 	char *option = NULL;
diff --git a/drivers/video/macmodes.c b/drivers/video/macmodes.c
index 95f5fc6..d21321c 100644
--- a/drivers/video/macmodes.c
+++ b/drivers/video/macmodes.c
@@ -370,8 +370,9 @@ EXPORT_SYMBOL(mac_map_monitor_sense);
  *
  */
 
-int __init mac_find_mode(struct fb_var_screeninfo *var, struct fb_info *info,
-			 const char *mode_option, unsigned int default_bpp)
+int __devinit mac_find_mode(struct fb_var_screeninfo *var,
+			    struct fb_info *info, const char *mode_option,
+			    unsigned int default_bpp)
 {
     const struct fb_videomode *db = NULL;
     unsigned int dbsize = 0;
diff --git a/drivers/video/macmodes.h b/drivers/video/macmodes.h
index 232f5a0..babeb81 100644
--- a/drivers/video/macmodes.h
+++ b/drivers/video/macmodes.h
@@ -55,9 +55,10 @@ extern int mac_vmode_to_var(int vmode, i
 extern int mac_var_to_vmode(const struct fb_var_screeninfo *var, int *vmode,
 			    int *cmode);
 extern int mac_map_monitor_sense(int sense);
-extern int __init mac_find_mode(struct fb_var_screeninfo *var,
-				struct fb_info *info, const char *mode_option,
-				unsigned int default_bpp);
+extern int __devinit mac_find_mode(struct fb_var_screeninfo *var,
+				   struct fb_info *info,
+				   const char *mode_option,
+				   unsigned int default_bpp);
 
 
     /*
