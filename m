From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 24 Mar 2020 13:45:06 +0000
Subject: [PATCH v2 4/6] video: fbdev: controlfb: remove function prototypes part #1
Message-Id: <20200324134508.25120-5-b.zolnierkie@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200324134508.25120-1-b.zolnierkie@samsung.com>
 <CGME20200324134519eucas1p1e9b54c01e452330425f49c442e4c1b4e@eucas1p1.samsung.com>
In-Reply-To: <20200324134508.25120-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Andrzej Hajda <a.hajda@samsung.com>, Sam Ravnborg <sam@ravnborg.org>, b.zolnierkie@samsung.com

Reorder code a bit and then remove no longer needed function
prototypes.

Acked-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/video/fbdev/controlfb.c | 41 +++++++++++----------------------
 1 file changed, 13 insertions(+), 28 deletions(-)

diff --git a/drivers/video/fbdev/controlfb.c b/drivers/video/fbdev/controlfb.c
index 92cffd2d0219..83b7a219f557 100644
--- a/drivers/video/fbdev/controlfb.c
+++ b/drivers/video/fbdev/controlfb.c
@@ -141,20 +141,6 @@ struct fb_info_control {
 #define CNTRL_REG(INFO,REG) (&(((INFO)->control_regs->REG).r))
 
 
-/******************** Prototypes for exported functions ********************/
-/*
- * struct fb_ops
- */
-static int controlfb_pan_display(struct fb_var_screeninfo *var,
-	struct fb_info *info);
-static int controlfb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
-	u_int transp, struct fb_info *info);
-static int controlfb_blank(int blank_mode, struct fb_info *info);
-static int controlfb_mmap(struct fb_info *info,
-	struct vm_area_struct *vma);
-static int controlfb_set_par (struct fb_info *info);
-static int controlfb_check_var (struct fb_var_screeninfo *var, struct fb_info *info);
-
 /******************** Prototypes for internal functions **********************/
 
 static void set_control_clock(unsigned char *params);
@@ -181,20 +167,6 @@ static int default_vmode __initdata = VMODE_NVRAM;
 static int default_cmode __initdata = CMODE_NVRAM;
 
 
-static const struct fb_ops controlfb_ops = {
-	.owner		= THIS_MODULE,
-	.fb_check_var	= controlfb_check_var,
-	.fb_set_par	= controlfb_set_par,
-	.fb_setcolreg	= controlfb_setcolreg,
-	.fb_pan_display = controlfb_pan_display,
-	.fb_blank	= controlfb_blank,
-	.fb_mmap	= controlfb_mmap,
-	.fb_fillrect	= cfb_fillrect,
-	.fb_copyarea	= cfb_copyarea,
-	.fb_imageblit	= cfb_imageblit,
-};
-
-
 /********************  The functions for controlfb_ops ********************/
 
 /*
@@ -1012,6 +984,19 @@ static inline void control_par_to_var(struct fb_par_control *par,
 	var->pixclock >>= par->regvals.clock_params[2];
 }
 
+static const struct fb_ops controlfb_ops = {
+	.owner		= THIS_MODULE,
+	.fb_check_var	= controlfb_check_var,
+	.fb_set_par	= controlfb_set_par,
+	.fb_setcolreg	= controlfb_setcolreg,
+	.fb_pan_display = controlfb_pan_display,
+	.fb_blank	= controlfb_blank,
+	.fb_mmap	= controlfb_mmap,
+	.fb_fillrect	= cfb_fillrect,
+	.fb_copyarea	= cfb_copyarea,
+	.fb_imageblit	= cfb_imageblit,
+};
+
 /*
  * Set misc info vars for this driver
  */
-- 
2.24.1
