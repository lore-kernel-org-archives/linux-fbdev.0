From: Ajay Kumar <ajaykumar.rs@samsung.com>
Date: Thu, 25 Aug 2011 13:54:51 +0000
Subject: [PATCH 2/2] video: s3c-fb: Modify s3c-fb driver to support window
Message-Id: <1314301917-9938-3-git-send-email-ajaykumar.rs@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1314301917-9938-1-git-send-email-ajaykumar.rs@samsung.com>
In-Reply-To: <1314301917-9938-1-git-send-email-ajaykumar.rs@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This patch modifies the existing s3c-fb driver to provide
flexibility to the user to reposition the framebuffer windows.

Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
Signed-off-by: Banajit Goswami <banajit.g@samsung.com>
---
 drivers/video/s3c-fb.c |   37 ++++++++++++++++++++++++++++++++-----
 1 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
index 0fda252..41179d7 100644
--- a/drivers/video/s3c-fb.c
+++ b/drivers/video/s3c-fb.c
@@ -442,6 +442,7 @@ static int s3c_fb_set_par(struct fb_info *info)
 	struct fb_var_screeninfo *var = &info->var;
 	struct s3c_fb_win *win = info->par;
 	struct s3c_fb *sfb = win->parent;
+	struct s3cfb_window_pos *winpos = &win->windata->winpos;
 	void __iomem *regs = sfb->regs;
 	void __iomem *buf = regs;
 	int win_no = win->index;
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
 
@@ -999,8 +1001,10 @@ static int s3c_fb_ioctl(struct fb_info *info, unsigned int cmd,
 {
 	struct s3c_fb_win *win = info->par;
 	struct s3c_fb *sfb = win->parent;
-	int ret;
+	struct s3cfb_window_pos *winpos = &win->windata->winpos;
+	int ret = 0;
 	u32 crtc;
+	u32 data;
 
 	switch (cmd) {
 	case FBIO_WAITFORVSYNC:
@@ -1011,6 +1015,29 @@ static int s3c_fb_ioctl(struct fb_info *info, unsigned int cmd,
 
 		ret = s3c_fb_wait_for_vsync(sfb, crtc);
 		break;
+	case S3CFB_WIN_POSITION:
+		if (copy_from_user(winpos, (u32 __user *)arg,
+					sizeof(struct s3cfb_window_pos))) {
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

