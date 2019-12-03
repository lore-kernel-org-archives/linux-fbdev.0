From: Jani Nikula <jani.nikula@intel.com>
Date: Tue, 03 Dec 2019 16:38:44 +0000
Subject: [PATCH v3 02/12] video: fbdev: mb862xx: modify the static fb_ops directly
Message-Id: <51f55c02ea4057cc46335ca5c447b92a55383f77.1575390740.git.jani.nikula@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1575390740.git.jani.nikula@intel.com>
In-Reply-To: <cover.1575390740.git.jani.nikula@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc: jani.nikula@intel.com, intel-gfx@lists.freedesktop.org

Avoid modifying the fb_ops via info->fbops to let us make the pointer
const in the future. Drop the unnecessary EXPORT_SYMBOL() while at it.

Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/video/fbdev/mb862xx/mb862xxfb.h       |  2 +-
 drivers/video/fbdev/mb862xx/mb862xxfb_accel.c | 15 +++++++--------
 drivers/video/fbdev/mb862xx/mb862xxfbdrv.c    |  4 +++-
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/video/fbdev/mb862xx/mb862xxfb.h b/drivers/video/fbdev/mb862xx/mb862xxfb.h
index 50bc9b584ca1..52a77ea4e849 100644
--- a/drivers/video/fbdev/mb862xx/mb862xxfb.h
+++ b/drivers/video/fbdev/mb862xx/mb862xxfb.h
@@ -89,7 +89,7 @@ struct mb862xxfb_par {
 	u32			pseudo_palette[16];
 };
 
-extern void mb862xxfb_init_accel(struct fb_info *info, int xres);
+extern void mb862xxfb_init_accel(struct fb_info *info, struct fb_ops *fbops, int xres);
 #ifdef CONFIG_FB_MB862XX_I2C
 extern int mb862xx_i2c_init(struct mb862xxfb_par *par);
 extern void mb862xx_i2c_exit(struct mb862xxfb_par *par);
diff --git a/drivers/video/fbdev/mb862xx/mb862xxfb_accel.c b/drivers/video/fbdev/mb862xx/mb862xxfb_accel.c
index f58ff900e82a..42569264801f 100644
--- a/drivers/video/fbdev/mb862xx/mb862xxfb_accel.c
+++ b/drivers/video/fbdev/mb862xx/mb862xxfb_accel.c
@@ -303,19 +303,19 @@ static void mb86290fb_fillrect(struct fb_info *info,
 	mb862xxfb_write_fifo(7, cmd, info);
 }
 
-void mb862xxfb_init_accel(struct fb_info *info, int xres)
+void mb862xxfb_init_accel(struct fb_info *info, struct fb_ops *fbops, int xres)
 {
 	struct mb862xxfb_par *par = info->par;
 
 	if (info->var.bits_per_pixel = 32) {
-		info->fbops->fb_fillrect = cfb_fillrect;
-		info->fbops->fb_copyarea = cfb_copyarea;
-		info->fbops->fb_imageblit = cfb_imageblit;
+		fbops->fb_fillrect = cfb_fillrect;
+		fbops->fb_copyarea = cfb_copyarea;
+		fbops->fb_imageblit = cfb_imageblit;
 	} else {
 		outreg(disp, GC_L0EM, 3);
-		info->fbops->fb_fillrect = mb86290fb_fillrect;
-		info->fbops->fb_copyarea = mb86290fb_copyarea;
-		info->fbops->fb_imageblit = mb86290fb_imageblit;
+		fbops->fb_fillrect = mb86290fb_fillrect;
+		fbops->fb_copyarea = mb86290fb_copyarea;
+		fbops->fb_imageblit = mb86290fb_imageblit;
 	}
 	outreg(draw, GDC_REG_DRAW_BASE, 0);
 	outreg(draw, GDC_REG_MODE_MISC, 0x8000);
@@ -326,6 +326,5 @@ void mb862xxfb_init_accel(struct fb_info *info, int xres)
 	    FBINFO_HWACCEL_IMAGEBLIT;
 	info->fix.accel = 0xff;	/*FIXME: add right define */
 }
-EXPORT_SYMBOL(mb862xxfb_init_accel);
 
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/video/fbdev/mb862xx/mb862xxfbdrv.c b/drivers/video/fbdev/mb862xx/mb862xxfbdrv.c
index 962c0171d271..52755b591c14 100644
--- a/drivers/video/fbdev/mb862xx/mb862xxfbdrv.c
+++ b/drivers/video/fbdev/mb862xx/mb862xxfbdrv.c
@@ -194,6 +194,8 @@ static int mb862xxfb_check_var(struct fb_var_screeninfo *var,
 	return 0;
 }
 
+static struct fb_ops mb862xxfb_ops;
+
 /*
  * set display parameters
  */
@@ -204,7 +206,7 @@ static int mb862xxfb_set_par(struct fb_info *fbi)
 
 	dev_dbg(par->dev, "%s\n", __func__);
 	if (par->type = BT_CORALP)
-		mb862xxfb_init_accel(fbi, fbi->var.xres);
+		mb862xxfb_init_accel(fbi, &mb862xxfb_ops, fbi->var.xres);
 
 	if (par->pre_init)
 		return 0;
-- 
2.20.1
