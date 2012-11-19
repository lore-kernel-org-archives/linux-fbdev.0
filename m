From: Bill Pemberton <wfp5p@virginia.edu>
Date: Mon, 19 Nov 2012 18:25:21 +0000
Subject: [PATCH 372/493] video: remove use of __devinitconst
Message-Id: <1353349642-3677-372-git-send-email-wfp5p@virginia.edu>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

CONFIG_HOTPLUG is going away as an option so __devinitconst is no
longer needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Paul Mackerras <paulus@samba.org> 
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de> 
Cc: Antonino Daplas <adaplas@gmail.com> 
Cc: Thomas Winischhofer <thomas@winischhofer.net> 
Cc: linux-fbdev@vger.kernel.org 
Cc: linux-geode@lists.infradead.org 
---
 drivers/video/aty/aty128fb.c     |  2 +-
 drivers/video/cirrusfb.c         | 14 +++++++-------
 drivers/video/geode/gx1fb_core.c |  2 +-
 drivers/video/gxt4500.c          |  4 ++--
 drivers/video/i810/i810_main.c   |  2 +-
 drivers/video/jz4740_fb.c        |  2 +-
 drivers/video/sh_mobile_lcdcfb.c |  2 +-
 drivers/video/sis/sis_main.c     |  2 +-
 8 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/video/aty/aty128fb.c b/drivers/video/aty/aty128fb.c
index 4d02267..e63fc9d 100644
--- a/drivers/video/aty/aty128fb.c
+++ b/drivers/video/aty/aty128fb.c
@@ -149,7 +149,7 @@ enum {
 };
 
 /* Must match above enum */
-static char * const r128_family[] __devinitconst = {
+static char * const r128_family[] = {
 	"AGP",
 	"PCI",
 	"PRO AGP",
diff --git a/drivers/video/cirrusfb.c b/drivers/video/cirrusfb.c
index 55037b1..f8961c3 100644
--- a/drivers/video/cirrusfb.c
+++ b/drivers/video/cirrusfb.c
@@ -290,34 +290,34 @@ struct zorrocl {
 	zorro_id ramid2;	/* Zorro ID of optional second RAM device */
 };
 
-static const struct zorrocl zcl_sd64 __devinitconst = {
+static const struct zorrocl zcl_sd64 = {
 	.type		= BT_SD64,
 	.ramid		= ZORRO_PROD_HELFRICH_SD64_RAM,
 };
 
-static const struct zorrocl zcl_piccolo __devinitconst = {
+static const struct zorrocl zcl_piccolo = {
 	.type		= BT_PICCOLO,
 	.ramid		= ZORRO_PROD_HELFRICH_PICCOLO_RAM,
 };
 
-static const struct zorrocl zcl_picasso __devinitconst = {
+static const struct zorrocl zcl_picasso = {
 	.type		= BT_PICASSO,
 	.ramid		= ZORRO_PROD_VILLAGE_TRONIC_PICASSO_II_II_PLUS_RAM,
 };
 
-static const struct zorrocl zcl_spectrum __devinitconst = {
+static const struct zorrocl zcl_spectrum = {
 	.type		= BT_SPECTRUM,
 	.ramid		= ZORRO_PROD_GVP_EGS_28_24_SPECTRUM_RAM,
 };
 
-static const struct zorrocl zcl_picasso4_z3 __devinitconst = {
+static const struct zorrocl zcl_picasso4_z3 = {
 	.type		= BT_PICASSO4,
 	.regoffset	= 0x00600000,
 	.ramsize	= 4 * MB_,
 	.ramoffset	= 0x01000000,	/* 0x02000000 for 64 MiB boards */
 };
 
-static const struct zorrocl zcl_picasso4_z2 __devinitconst = {
+static const struct zorrocl zcl_picasso4_z2 = {
 	.type		= BT_PICASSO4,
 	.regoffset	= 0x10000,
 	.ramid		= ZORRO_PROD_VILLAGE_TRONIC_PICASSO_IV_Z2_RAM1,
@@ -325,7 +325,7 @@ static const struct zorrocl zcl_picasso4_z2 __devinitconst = {
 };
 
 
-static const struct zorro_device_id cirrusfb_zorro_table[] __devinitconst = {
+static const struct zorro_device_id cirrusfb_zorro_table[] = {
 	{
 		.id		= ZORRO_PROD_HELFRICH_SD64_REG,
 		.driver_data	= (unsigned long)&zcl_sd64,
diff --git a/drivers/video/geode/gx1fb_core.c b/drivers/video/geode/gx1fb_core.c
index 4bdd47f..cf97a70 100644
--- a/drivers/video/geode/gx1fb_core.c
+++ b/drivers/video/geode/gx1fb_core.c
@@ -29,7 +29,7 @@ static int  crt_option = 1;
 static char panel_option[32] = "";
 
 /* Modes relevant to the GX1 (taken from modedb.c) */
-static const struct fb_videomode __devinitconst gx1_modedb[] = {
+static const struct fb_videomode gx1_modedb[] = {
 	/* 640x480-60 VESA */
 	{ NULL, 60, 640, 480, 39682,  48, 16, 33, 10, 96, 2,
 	  0, FB_VMODE_NONINTERLACED, FB_MODE_IS_VESA },
diff --git a/drivers/video/gxt4500.c b/drivers/video/gxt4500.c
index c0130a4..58d3543 100644
--- a/drivers/video/gxt4500.c
+++ b/drivers/video/gxt4500.c
@@ -159,7 +159,7 @@ struct gxt4500_par {
 static char *mode_option;
 
 /* default mode: 1280x1024 @ 60 Hz, 8 bpp */
-static const struct fb_videomode defaultmode __devinitconst = {
+static const struct fb_videomode defaultmode = {
 	.refresh = 60,
 	.xres = 1280,
 	.yres = 1024,
@@ -588,7 +588,7 @@ static int gxt4500_blank(int blank, struct fb_info *info)
 	return 0;
 }
 
-static const struct fb_fix_screeninfo gxt4500_fix __devinitconst = {
+static const struct fb_fix_screeninfo gxt4500_fix = {
 	.id = "IBM GXT4500P",
 	.type = FB_TYPE_PACKED_PIXELS,
 	.visual = FB_VISUAL_PSEUDOCOLOR,
diff --git a/drivers/video/i810/i810_main.c b/drivers/video/i810/i810_main.c
index 7f93dd8..2699909 100644
--- a/drivers/video/i810/i810_main.c
+++ b/drivers/video/i810/i810_main.c
@@ -97,7 +97,7 @@ static int i810fb_blank      (int blank_mode, struct fb_info *info);
 static void i810fb_release_resource       (struct fb_info *info, struct i810fb_par *par);
 
 /* PCI */
-static const char * const i810_pci_list[] __devinitconst = {
+static const char * const i810_pci_list[] = {
 	"Intel(R) 810 Framebuffer Device"                                 ,
 	"Intel(R) 810-DC100 Framebuffer Device"                           ,
 	"Intel(R) 810E Framebuffer Device"                                ,
diff --git a/drivers/video/jz4740_fb.c b/drivers/video/jz4740_fb.c
index f5c645a..9f5003f 100644
--- a/drivers/video/jz4740_fb.c
+++ b/drivers/video/jz4740_fb.c
@@ -136,7 +136,7 @@ struct jzfb {
 	uint32_t pseudo_palette[16];
 };
 
-static const struct fb_fix_screeninfo jzfb_fix __devinitconst = {
+static const struct fb_fix_screeninfo jzfb_fix = {
 	.id		= "JZ4740 FB",
 	.type		= FB_TYPE_PACKED_PIXELS,
 	.visual		= FB_VISUAL_TRUECOLOR,
diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index d776bfe..94ba640 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -2396,7 +2396,7 @@ static int sh_mobile_lcdc_notify(struct notifier_block *nb,
  * Probe/remove and driver init/exit
  */
 
-static const struct fb_videomode default_720p __devinitconst = {
+static const struct fb_videomode default_720p = {
 	.name = "HDMI 720p",
 	.xres = 1280,
 	.yres = 720,
diff --git a/drivers/video/sis/sis_main.c b/drivers/video/sis/sis_main.c
index 820a002..e60df84 100644
--- a/drivers/video/sis/sis_main.c
+++ b/drivers/video/sis/sis_main.c
@@ -4220,7 +4220,7 @@ sisfb_post_300_buswidth(struct sis_video_info *ivideo)
 	return 1;			/* 32bit */
 }
 
-static const unsigned short __devinitconst SiS_DRAMType[17][5] = {
+static const unsigned short SiS_DRAMType[17][5] = {
 	{0x0C,0x0A,0x02,0x40,0x39},
 	{0x0D,0x0A,0x01,0x40,0x48},
 	{0x0C,0x09,0x02,0x20,0x35},
-- 
1.8.0

