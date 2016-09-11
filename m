From: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Sun, 11 Sep 2016 15:17:20 +0000
Subject: [PATCH] video: fbdev: constify fb_fix_screeninfo and fb_var_screeninfo structures
Message-Id: <1473607040-21295-1-git-send-email-Julia.Lawall@lip6.fr>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: kernel-janitors@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Teddy Wang <teddy.wang@siliconmotion.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Kristoffer Ericson <kristoffer.ericson@gmail.com>, Michal Januszewski <spock@gentoo.org>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Hans de Goede <hdegoede@redhat.com>, Jaya Kumar <jayalk@intworks.biz>, Paul Mackerras <paulus@samba.org>, Ferenc Bakonyi <fero@drama.obuda.kando.hu>, linux-nvidia@lists.surfsouth.com, Antonino Daplas <adaplas@gmail.com>

These structures are only used to copy into other structures, so declare
them as const.

The semantic patch that makes this change in the fb_fix_screeninfo case is
as follows (http://coccinelle.lip6.fr/).  The fb_var_screeninfo case is
analogous.

// <smpl>
@r disable optional_qualifier@
identifier i;
position p;
@@
static struct fb_fix_screeninfo i@p = { ... };

@ok@
identifier r.i;
expression e;
position p;
@@
e = i@p

@bad@
position p != {r.p,ok.p};
identifier r.i;
struct fb_fix_screeninfo e;
@@
e@i@p

@depends on !bad disable optional_qualifier@
identifier r.i;
@@
static
+const
 struct fb_fix_screeninfo i = { ... };
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/video/fbdev/arcfb.c                  |    4 ++--
 drivers/video/fbdev/asiliantfb.c             |    4 ++--
 drivers/video/fbdev/aty/aty128fb.c           |    6 +++---
 drivers/video/fbdev/aty/atyfb_base.c         |    2 +-
 drivers/video/fbdev/aty/radeon_monitor.c     |    2 +-
 drivers/video/fbdev/hecubafb.c               |    4 ++--
 drivers/video/fbdev/hgafb.c                  |    2 +-
 drivers/video/fbdev/i740fb.c                 |    2 +-
 drivers/video/fbdev/kyro/fbdev.c             |    2 +-
 drivers/video/fbdev/pm2fb.c                  |    2 +-
 drivers/video/fbdev/s1d13xxxfb.c             |    2 +-
 drivers/video/fbdev/savage/savagefb_driver.c |    2 +-
 drivers/video/fbdev/simplefb.c               |    4 ++--
 drivers/video/fbdev/sm712fb.c                |    2 +-
 drivers/video/fbdev/ssd1307fb.c              |    4 ++--
 drivers/video/fbdev/tdfxfb.c                 |    4 ++--
 drivers/video/fbdev/uvesafb.c                |    2 +-
 drivers/video/fbdev/vfb.c                    |    2 +-
 drivers/video/fbdev/vga16fb.c                |    2 +-
 19 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/video/fbdev/simplefb.c b/drivers/video/fbdev/simplefb.c
index e9cf199..85775df 100644
--- a/drivers/video/fbdev/simplefb.c
+++ b/drivers/video/fbdev/simplefb.c
@@ -33,14 +33,14 @@
 #include <linux/parser.h>
 #include <linux/regulator/consumer.h>
 
-static struct fb_fix_screeninfo simplefb_fix = {
+static const struct fb_fix_screeninfo simplefb_fix = {
 	.id		= "simple",
 	.type		= FB_TYPE_PACKED_PIXELS,
 	.visual		= FB_VISUAL_TRUECOLOR,
 	.accel		= FB_ACCEL_NONE,
 };
 
-static struct fb_var_screeninfo simplefb_var = {
+static const struct fb_var_screeninfo simplefb_var = {
 	.height		= -1,
 	.width		= -1,
 	.activate	= FB_ACTIVATE_NOW,
diff --git a/drivers/video/fbdev/asiliantfb.c b/drivers/video/fbdev/asiliantfb.c
index 7e8ddf0..91eea45 100644
--- a/drivers/video/fbdev/asiliantfb.c
+++ b/drivers/video/fbdev/asiliantfb.c
@@ -474,7 +474,7 @@ static void chips_hw_init(struct fb_info *p)
 		write_fr(chips_init_fr[i].addr, chips_init_fr[i].data);
 }
 
-static struct fb_fix_screeninfo asiliantfb_fix = {
+static const struct fb_fix_screeninfo asiliantfb_fix = {
 	.id =		"Asiliant 69000",
 	.type =		FB_TYPE_PACKED_PIXELS,
 	.visual =	FB_VISUAL_PSEUDOCOLOR,
@@ -483,7 +483,7 @@ static struct fb_fix_screeninfo asiliantfb_fix = {
 	.smem_len =	0x200000,	/* 2MB */
 };
 
-static struct fb_var_screeninfo asiliantfb_var = {
+static const struct fb_var_screeninfo asiliantfb_var = {
 	.xres 		= 640,
 	.yres 		= 480,
 	.xres_virtual 	= 640,
diff --git a/drivers/video/fbdev/aty/atyfb_base.c b/drivers/video/fbdev/aty/atyfb_base.c
index f34ed47f..11026e7 100644
--- a/drivers/video/fbdev/aty/atyfb_base.c
+++ b/drivers/video/fbdev/aty/atyfb_base.c
@@ -212,7 +212,7 @@ struct pci_mmap_map {
 	unsigned long prot_mask;
 };
 
-static struct fb_fix_screeninfo atyfb_fix = {
+static const struct fb_fix_screeninfo atyfb_fix = {
 	.id		= "ATY Mach64",
 	.type		= FB_TYPE_PACKED_PIXELS,
 	.visual		= FB_VISUAL_PSEUDOCOLOR,
diff --git a/drivers/video/fbdev/hecubafb.c b/drivers/video/fbdev/hecubafb.c
index e4031ef..8577195 100644
--- a/drivers/video/fbdev/hecubafb.c
+++ b/drivers/video/fbdev/hecubafb.c
@@ -47,7 +47,7 @@
 #define DPY_W 600
 #define DPY_H 800
 
-static struct fb_fix_screeninfo hecubafb_fix = {
+static const struct fb_fix_screeninfo hecubafb_fix = {
 	.id =		"hecubafb",
 	.type =		FB_TYPE_PACKED_PIXELS,
 	.visual =	FB_VISUAL_MONO01,
@@ -58,7 +58,7 @@ static struct fb_fix_screeninfo hecubafb_fix = {
 	.accel =	FB_ACCEL_NONE,
 };
 
-static struct fb_var_screeninfo hecubafb_var = {
+static const struct fb_var_screeninfo hecubafb_var = {
 	.xres		= DPY_W,
 	.yres		= DPY_H,
 	.xres_virtual	= DPY_W,
diff --git a/drivers/video/fbdev/i740fb.c b/drivers/video/fbdev/i740fb.c
index cf5ccd0..7bc5f60 100644
--- a/drivers/video/fbdev/i740fb.c
+++ b/drivers/video/fbdev/i740fb.c
@@ -82,7 +82,7 @@ struct i740fb_par {
 #define DACSPEED24_SD	128
 #define DACSPEED32	86
 
-static struct fb_fix_screeninfo i740fb_fix = {
+static const struct fb_fix_screeninfo i740fb_fix = {
 	.id =		"i740fb",
 	.type =		FB_TYPE_PACKED_PIXELS,
 	.visual =	FB_VISUAL_TRUECOLOR,
diff --git a/drivers/video/fbdev/kyro/fbdev.c b/drivers/video/fbdev/kyro/fbdev.c
index 5bb0153..f77478f 100644
--- a/drivers/video/fbdev/kyro/fbdev.c
+++ b/drivers/video/fbdev/kyro/fbdev.c
@@ -44,7 +44,7 @@ static struct fb_fix_screeninfo kyro_fix = {
 	.accel		= FB_ACCEL_NONE,
 };
 
-static struct fb_var_screeninfo kyro_var = {
+static const struct fb_var_screeninfo kyro_var = {
 	/* 640x480, 16bpp @ 60 Hz */
 	.xres		= 640,
 	.yres		= 480,
diff --git a/drivers/video/fbdev/pm2fb.c b/drivers/video/fbdev/pm2fb.c
index aa8d288..1a4070f 100644
--- a/drivers/video/fbdev/pm2fb.c
+++ b/drivers/video/fbdev/pm2fb.c
@@ -113,7 +113,7 @@ static struct fb_fix_screeninfo pm2fb_fix = {
 /*
  * Default video mode. In case the modedb doesn't work.
  */
-static struct fb_var_screeninfo pm2fb_var = {
+static const struct fb_var_screeninfo pm2fb_var = {
 	/* "640x480, 8 bpp @ 60 Hz */
 	.xres =			640,
 	.yres =			480,
diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index a9c45c8..1feda0c 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -84,7 +84,7 @@ struct ssd1307fb_array {
 	u8	data[0];
 };
 
-static struct fb_fix_screeninfo ssd1307fb_fix = {
+static const struct fb_fix_screeninfo ssd1307fb_fix = {
 	.id		= "Solomon SSD1307",
 	.type		= FB_TYPE_PACKED_PIXELS,
 	.visual		= FB_VISUAL_MONO10,
@@ -94,7 +94,7 @@ static struct fb_fix_screeninfo ssd1307fb_fix = {
 	.accel		= FB_ACCEL_NONE,
 };
 
-static struct fb_var_screeninfo ssd1307fb_var = {
+static const struct fb_var_screeninfo ssd1307fb_var = {
 	.bits_per_pixel	= 1,
 };
 
diff --git a/drivers/video/fbdev/tdfxfb.c b/drivers/video/fbdev/tdfxfb.c
index 621fa44..d5fa313 100644
--- a/drivers/video/fbdev/tdfxfb.c
+++ b/drivers/video/fbdev/tdfxfb.c
@@ -82,7 +82,7 @@
 #define VOODOO3_MAX_PIXCLOCK 300000
 #define VOODOO5_MAX_PIXCLOCK 350000
 
-static struct fb_fix_screeninfo tdfx_fix = {
+static const struct fb_fix_screeninfo tdfx_fix = {
 	.type =		FB_TYPE_PACKED_PIXELS,
 	.visual =	FB_VISUAL_PSEUDOCOLOR,
 	.ypanstep =	1,
@@ -90,7 +90,7 @@ static struct fb_fix_screeninfo tdfx_fix = {
 	.accel =	FB_ACCEL_3DFX_BANSHEE
 };
 
-static struct fb_var_screeninfo tdfx_var = {
+static const struct fb_var_screeninfo tdfx_var = {
 	/* "640x480, 8 bpp @ 60 Hz */
 	.xres =		640,
 	.yres =		480,
diff --git a/drivers/video/fbdev/vfb.c b/drivers/video/fbdev/vfb.c
index b9c2f81..378bdcb 100644
--- a/drivers/video/fbdev/vfb.c
+++ b/drivers/video/fbdev/vfb.c
@@ -85,7 +85,7 @@ static void rvfree(void *mem, unsigned long size)
 	vfree(mem);
 }
 
-static struct fb_var_screeninfo vfb_default = {
+static const struct fb_var_screeninfo vfb_default = {
 	.xres =		640,
 	.yres =		480,
 	.xres_virtual =	640,
diff --git a/drivers/video/fbdev/vga16fb.c b/drivers/video/fbdev/vga16fb.c
index 283d335..5f0690c 100644
--- a/drivers/video/fbdev/vga16fb.c
+++ b/drivers/video/fbdev/vga16fb.c
@@ -85,7 +85,7 @@ static struct fb_var_screeninfo vga16fb_defined = {
 };
 
 /* name should not depend on EGA/VGA */
-static struct fb_fix_screeninfo vga16fb_fix = {
+static const struct fb_fix_screeninfo vga16fb_fix = {
 	.id		= "VGA16 VGA",
 	.smem_start	= VGA_FB_PHYS,
 	.smem_len	= VGA_FB_PHYS_LEN,
diff --git a/drivers/video/fbdev/uvesafb.c b/drivers/video/fbdev/uvesafb.c
index 178ae93..98af9e0 100644
--- a/drivers/video/fbdev/uvesafb.c
+++ b/drivers/video/fbdev/uvesafb.c
@@ -33,7 +33,7 @@ static struct cb_id uvesafb_cn_id = {
 static char v86d_path[PATH_MAX] = "/sbin/v86d";
 static char v86d_started;	/* has v86d been started by uvesafb? */
 
-static struct fb_fix_screeninfo uvesafb_fix = {
+static const struct fb_fix_screeninfo uvesafb_fix = {
 	.id	= "VESA VGA",
 	.type	= FB_TYPE_PACKED_PIXELS,
 	.accel	= FB_ACCEL_NONE,
diff --git a/drivers/video/fbdev/arcfb.c b/drivers/video/fbdev/arcfb.c
index 1b0b233..1928cb2 100644
--- a/drivers/video/fbdev/arcfb.c
+++ b/drivers/video/fbdev/arcfb.c
@@ -79,7 +79,7 @@ struct arcfb_par {
 	spinlock_t lock;
 };
 
-static struct fb_fix_screeninfo arcfb_fix = {
+static const struct fb_fix_screeninfo arcfb_fix = {
 	.id =		"arcfb",
 	.type =		FB_TYPE_PACKED_PIXELS,
 	.visual =	FB_VISUAL_MONO01,
@@ -89,7 +89,7 @@ static struct fb_fix_screeninfo arcfb_fix = {
 	.accel =	FB_ACCEL_NONE,
 };
 
-static struct fb_var_screeninfo arcfb_var = {
+static const struct fb_var_screeninfo arcfb_var = {
 	.xres		= 128,
 	.yres		= 64,
 	.xres_virtual	= 128,
diff --git a/drivers/video/fbdev/s1d13xxxfb.c b/drivers/video/fbdev/s1d13xxxfb.c
index 96aa46d..9a90452 100644
--- a/drivers/video/fbdev/s1d13xxxfb.c
+++ b/drivers/video/fbdev/s1d13xxxfb.c
@@ -83,7 +83,7 @@ static const char *s1d13xxxfb_prod_names[] = {
 /*
  * here we define the default struct fb_fix_screeninfo
  */
-static struct fb_fix_screeninfo s1d13xxxfb_fix = {
+static const struct fb_fix_screeninfo s1d13xxxfb_fix = {
 	.id		= S1D_FBID,
 	.type		= FB_TYPE_PACKED_PIXELS,
 	.visual		= FB_VISUAL_PSEUDOCOLOR,
diff --git a/drivers/video/fbdev/aty/aty128fb.c b/drivers/video/fbdev/aty/aty128fb.c
index 0a46268..fa07242 100644
--- a/drivers/video/fbdev/aty/aty128fb.c
+++ b/drivers/video/fbdev/aty/aty128fb.c
@@ -93,7 +93,7 @@
 
 #ifndef CONFIG_PPC_PMAC
 /* default mode */
-static struct fb_var_screeninfo default_var = {
+static const struct fb_var_screeninfo default_var = {
 	/* 640x480, 60 Hz, Non-Interlaced (25.175 MHz dotclock) */
 	640, 480, 640, 480, 0, 0, 8, 0,
 	{0, 8, 0}, {0, 8, 0}, {0, 8, 0}, {0, 0, 0},
@@ -104,7 +104,7 @@ static struct fb_var_screeninfo default_var = {
 #else /* CONFIG_PPC_PMAC */
 /* default to 1024x768 at 75Hz on PPC - this will work
  * on the iMac, the usual 640x480 @ 60Hz doesn't. */
-static struct fb_var_screeninfo default_var = {
+static const struct fb_var_screeninfo default_var = {
 	/* 1024x768, 75 Hz, Non-Interlaced (78.75 MHz dotclock) */
 	1024, 768, 1024, 768, 0, 0, 8, 0,
 	{0, 8, 0}, {0, 8, 0}, {0, 8, 0}, {0, 0, 0},
@@ -375,7 +375,7 @@ static const struct aty128_meminfo ddr_sgram = {
 	.name = "64-bit DDR SGRAM",
 };
 
-static struct fb_fix_screeninfo aty128fb_fix = {
+static const struct fb_fix_screeninfo aty128fb_fix = {
 	.id		= "ATY Rage128",
 	.type		= FB_TYPE_PACKED_PIXELS,
 	.visual		= FB_VISUAL_PSEUDOCOLOR,
diff --git a/drivers/video/fbdev/sm712fb.c b/drivers/video/fbdev/sm712fb.c
index 86ae1d4..73cb4ff 100644
--- a/drivers/video/fbdev/sm712fb.c
+++ b/drivers/video/fbdev/sm712fb.c
@@ -56,7 +56,7 @@ struct smtcfb_info {
 
 void __iomem *smtc_regbaseaddress;	/* Memory Map IO starting address */
 
-static struct fb_var_screeninfo smtcfb_var = {
+static const struct fb_var_screeninfo smtcfb_var = {
 	.xres           = 1024,
 	.yres           = 600,
 	.xres_virtual   = 1024,
diff --git a/drivers/video/fbdev/hgafb.c b/drivers/video/fbdev/hgafb.c
index 15d3ccf..4630285 100644
--- a/drivers/video/fbdev/hgafb.c
+++ b/drivers/video/fbdev/hgafb.c
@@ -106,7 +106,7 @@ static DEFINE_SPINLOCK(hga_reg_lock);
 
 /* Framebuffer driver structures */
 
-static struct fb_var_screeninfo hga_default_var = {
+static const struct fb_var_screeninfo hga_default_var = {
 	.xres		= 720,
 	.yres 		= 348,
 	.xres_virtual 	= 720,
diff --git a/drivers/video/fbdev/aty/radeon_monitor.c b/drivers/video/fbdev/aty/radeon_monitor.c
index f1ce229..278b421 100644
--- a/drivers/video/fbdev/aty/radeon_monitor.c
+++ b/drivers/video/fbdev/aty/radeon_monitor.c
@@ -4,7 +4,7 @@
 
 #include "../edid.h"
 
-static struct fb_var_screeninfo radeonfb_default_var = {
+static const struct fb_var_screeninfo radeonfb_default_var = {
 	.xres		= 640,
 	.yres		= 480,
 	.xres_virtual	= 640,
diff --git a/drivers/video/fbdev/savage/savagefb_driver.c b/drivers/video/fbdev/savage/savagefb_driver.c
index 6c77ab0..c30a91c 100644
--- a/drivers/video/fbdev/savage/savagefb_driver.c
+++ b/drivers/video/fbdev/savage/savagefb_driver.c
@@ -1660,7 +1660,7 @@ static struct fb_ops savagefb_ops = {
 
 /* --------------------------------------------------------------------- */
 
-static struct fb_var_screeninfo savagefb_var800x600x8 = {
+static const struct fb_var_screeninfo savagefb_var800x600x8 = {
 	.accel_flags =	FB_ACCELF_TEXT,
 	.xres =		800,
 	.yres =		600,

