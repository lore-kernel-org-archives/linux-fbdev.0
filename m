From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 09 Jun 2011 04:26:38 +0000
Subject: [PATCH] [resend] video: s3c-fb: fix virtual resolution checking
Message-Id: <1307593598-4539-1-git-send-email-jg1.han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This patch fixes mishandling in virtual resolution checking.
Previously, virtual resolution is changed to virtual_x and virtual_y
which mean the size for buffer allocation, when s3c_fb_check_var is
called by fb_check_var. However, it is meaningless, since virtual_x
and virtual_y are fixed and user cannot change virtual resolution.
Therefore, virtual resolution should be more than resolution
such as xres and yres.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/s3c-fb.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
index 0352afa..e48129a 100644
--- a/drivers/video/s3c-fb.c
+++ b/drivers/video/s3c-fb.c
@@ -235,13 +235,12 @@ static int s3c_fb_check_var(struct fb_var_screeninfo *var,
 			    struct fb_info *info)
 {
 	struct s3c_fb_win *win = info->par;
-	struct s3c_fb_pd_win *windata = win->windata;
 	struct s3c_fb *sfb = win->parent;
 
 	dev_dbg(sfb->dev, "checking parameters\n");
 
-	var->xres_virtual = max((unsigned int)windata->virtual_x, var->xres);
-	var->yres_virtual = max((unsigned int)windata->virtual_y, var->yres);
+	var->xres_virtual = max(var->xres_virtual, var->xres);
+	var->yres_virtual = max(var->yres_virtual, var->yres);
 
 	if (!s3c_fb_validate_win_bpp(win, var->bits_per_pixel)) {
 		dev_dbg(sfb->dev, "win %d: unsupported bpp %d\n",
-- 
1.7.1

