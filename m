From: Zhou Zhu <zzhu3@marvell.com>
Date: Fri, 13 Sep 2013 06:59:49 +0000
Subject: [PATCH V5 5/5] video: mmp: add pitch info in mmp_win structure
Message-Id: <1379055589-26132-6-git-send-email-zzhu3@marvell.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Jing Xiang <jxiang@marvell.com>

Add pitch length info of graphics/video layer, pitch is used
to represent line length in byte, the usage depends on pix_fmt.
If the fmt is YUV, the pitch[0] will be Y length,pitch[1]
will be U length, pitch[2] will be V lenth.
If the fmt is RGB, the picth[0] will be line lenth, and
pitch[1]/pitch[2] will be 0 and not be used.

Signed-off-by: Jing Xiang <jxiang@marvell.com>
Signed-off-by: Jett.Zhou <jtzhou@marvell.com>
Signed-off-by: Zhou Zhu <zzhu3@marvell.com>
Reviewed-by: Daniel Drake <dsd@laptop.org>
---
 drivers/video/mmp/fb/mmpfb.c    |    6 ++++++
 drivers/video/mmp/hw/mmp_ctrl.c |   30 +++++++++++++++++++++++-------
 include/video/mmp_disp.h        |    5 +++++
 3 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/drivers/video/mmp/fb/mmpfb.c b/drivers/video/mmp/fb/mmpfb.c
index 19fd913..7ab31eb 100644
--- a/drivers/video/mmp/fb/mmpfb.c
+++ b/drivers/video/mmp/fb/mmpfb.c
@@ -395,12 +395,18 @@ static int var_update(struct fb_info *info)
 static void mmpfb_set_win(struct fb_info *info)
 {
 	struct mmpfb_info *fbi = info->par;
+	struct fb_var_screeninfo *var = &info->var;
 	struct mmp_win win;
+	u32 stride;
 
 	memset(&win, 0, sizeof(win));
 	win.xsrc = win.xdst = fbi->mode.xres;
 	win.ysrc = win.ydst = fbi->mode.yres;
 	win.pix_fmt = fbi->pix_fmt;
+	stride = pixfmt_to_stride(win.pix_fmt);
+	win.pitch[0] = var->xres_virtual * stride;
+	win.pitch[1] = win.pitch[2] +		(stride = 1) ? (var->xres_virtual >> 1) : 0;
 	mmp_overlay_set_win(fbi->overlay, &win);
 }
 
diff --git a/drivers/video/mmp/hw/mmp_ctrl.c b/drivers/video/mmp/hw/mmp_ctrl.c
index c0eb8bc..ae724aa 100644
--- a/drivers/video/mmp/hw/mmp_ctrl.c
+++ b/drivers/video/mmp/hw/mmp_ctrl.c
@@ -142,17 +142,27 @@ static void dmafetch_set_fmt(struct mmp_overlay *overlay)
 static void overlay_set_win(struct mmp_overlay *overlay, struct mmp_win *win)
 {
 	struct lcd_regs *regs = path_regs(overlay->path);
-	u32 pitch;
 
 	/* assert win supported */
 	memcpy(&overlay->win, win, sizeof(struct mmp_win));
 
 	mutex_lock(&overlay->access_ok);
-	pitch = win->xsrc * pixfmt_to_stride(win->pix_fmt);
-	writel_relaxed(pitch, &regs->g_pitch);
-	writel_relaxed((win->ysrc << 16) | win->xsrc, &regs->g_size);
-	writel_relaxed((win->ydst << 16) | win->xdst, &regs->g_size_z);
-	writel_relaxed(0, &regs->g_start);
+
+	if (overlay_is_vid(overlay)) {
+		writel_relaxed(win->pitch[0], &regs->v_pitch_yc);
+		writel_relaxed(win->pitch[2] << 16 |
+				win->pitch[1], &regs->v_pitch_uv);
+
+		writel_relaxed((win->ysrc << 16) | win->xsrc, &regs->v_size);
+		writel_relaxed((win->ydst << 16) | win->xdst, &regs->v_size_z);
+		writel_relaxed(win->ypos << 16 | win->xpos, &regs->v_start);
+	} else {
+		writel_relaxed(win->pitch[0], &regs->g_pitch);
+
+		writel_relaxed((win->ysrc << 16) | win->xsrc, &regs->g_size);
+		writel_relaxed((win->ydst << 16) | win->xdst, &regs->g_size_z);
+		writel_relaxed(win->ypos << 16 | win->xpos, &regs->g_start);
+	}
 
 	dmafetch_set_fmt(overlay);
 	mutex_unlock(&overlay->access_ok);
@@ -234,7 +244,13 @@ static int overlay_set_addr(struct mmp_overlay *overlay, struct mmp_addr *addr)
 
 	/* FIXME: assert addr supported */
 	memcpy(&overlay->addr, addr, sizeof(struct mmp_addr));
-	writel(addr->phys[0], &regs->g_0);
+
+	if (overlay_is_vid(overlay)) {
+		writel_relaxed(addr->phys[0], &regs->v_y0);
+		writel_relaxed(addr->phys[1], &regs->v_u0);
+		writel_relaxed(addr->phys[2], &regs->v_v0);
+	} else
+		writel_relaxed(addr->phys[0], &regs->g_0);
 
 	return overlay->addr.phys[0];
 }
diff --git a/include/video/mmp_disp.h b/include/video/mmp_disp.h
index 32094c0..9fd9398 100644
--- a/include/video/mmp_disp.h
+++ b/include/video/mmp_disp.h
@@ -91,6 +91,11 @@ struct mmp_win {
 	u16	up_crop;
 	u16	bottom_crop;
 	int	pix_fmt;
+	/*
+	 * pitch[0]: graphics/video layer line length or y pitch
+	 * pitch[1]/pitch[2]: video u/v pitch if non-zero
+	 */
+	u32	pitch[3];
 };
 
 struct mmp_addr {
-- 
1.7.9.5

