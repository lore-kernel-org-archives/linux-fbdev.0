From: Ajay Kumar <ajaykumar.rs@samsung.com>
Date: Tue, 20 Sep 2011 09:29:04 +0000
Subject: [PATCH 3/3] video: s3c-fb: Modify s3c-fb driver to support window
Message-Id: <1316532641-2657-4-git-send-email-ajaykumar.rs@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1316532641-2657-1-git-send-email-ajaykumar.rs@samsung.com>
In-Reply-To: <1316532641-2657-1-git-send-email-ajaykumar.rs@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Positions the framebuffer window during driver initialization,
using the platform data.It also adds an ioctl definition
to change window position dynamically.

Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
Signed-off-by: Banajit Goswami <banajit.g@samsung.com>
Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/video/s3c-fb.c |   37 ++++++++++++++++++++++++++++++++-----
 1 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
index 0fda252..b087a12 100644
--- a/drivers/video/s3c-fb.c
+++ b/drivers/video/s3c-fb.c
@@ -441,6 +441,7 @@ static int s3c_fb_set_par(struct fb_info *info)
 {
 	struct fb_var_screeninfo *var = &info->var;
 	struct s3c_fb_win *win = info->par;
+	struct fb_overlay_win_pos *winpos = &win->windata->winpos;
 	struct s3c_fb *sfb = win->parent;
 	void __iomem *regs = sfb->regs;
 	void __iomem *buf = regs;
@@ -539,12 +540,13 @@ static int s3c_fb_set_par(struct fb_info *info)
 
 	/* write 'OSD' registers to control position of framebuffer */
 
-	data = VIDOSDxA_TOPLEFT_X(0) | VIDOSDxA_TOPLEFT_Y(0);
+	data = VIDOSDxA_TOPLEFT_X(winpos->win_pos_x) |
+	       VIDOSDxA_TOPLEFT_Y(winpos->win_pos_y);
 	writel(data, regs + VIDOSD_A(win_no, sfb->variant));
 
-	data = VIDOSDxB_BOTRIGHT_X(s3c_fb_align_word(var->bits_per_pixel,
-						     var->xres - 1)) |
-	       VIDOSDxB_BOTRIGHT_Y(var->yres - 1);
+	data = VIDOSDxB_BOTRIGHT_X((s3c_fb_align_word(var->bits_per_pixel,
+	       (winpos->win_pos_x + var->xres - 1)))) |
+	       VIDOSDxB_BOTRIGHT_Y((winpos->win_pos_y + var->yres - 1));
 
 	writel(data, regs + VIDOSD_B(win_no, sfb->variant));
 
@@ -998,9 +1000,11 @@ static int s3c_fb_ioctl(struct fb_info *info, unsigned int cmd,
 			unsigned long arg)
 {
 	struct s3c_fb_win *win = info->par;
+	struct fb_overlay_win_pos *winpos = &win->windata->winpos;
 	struct s3c_fb *sfb = win->parent;
-	int ret;
+	int ret = 0;
 	u32 crtc;
+	u32 data;
 
 	switch (cmd) {
 	case FBIO_WAITFORVSYNC:
@@ -1011,6 +1015,29 @@ static int s3c_fb_ioctl(struct fb_info *info, unsigned int cmd,
 
 		ret = s3c_fb_wait_for_vsync(sfb, crtc);
 		break;
+	case FBIOPOS_OVERLAY_WIN:
+		if (copy_from_user(winpos, (u32 __user *)arg,
+					sizeof(struct fb_overlay_win_pos))) {
+			ret = -EFAULT;
+			break;
+		}
+
+		shadow_protect_win(win, 1);
+
+		/* write 'OSD' registers to set position of the window */
+		data = VIDOSDxA_TOPLEFT_X(winpos->win_pos_x) |
+		       VIDOSDxA_TOPLEFT_Y(winpos->win_pos_y);
+		writel(data, sfb->regs + VIDOSD_A(win->index, sfb->variant));
+
+		data = VIDOSDxB_BOTRIGHT_X(
+				s3c_fb_align_word(info->var.bits_per_pixel,
+				(winpos->win_pos_x + info->var.xres - 1)));
+		data |=	VIDOSDxB_BOTRIGHT_Y(winpos->win_pos_y +
+				info->var.yres - 1);
+		writel(data, sfb->regs + VIDOSD_B(win->index, sfb->variant));
+
+		shadow_protect_win(win, 0);
+		break;
 	default:
 		ret = -ENOTTY;
 	}
-- 
1.7.0.4

