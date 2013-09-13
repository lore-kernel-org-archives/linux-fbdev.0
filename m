From: Zhou Zhu <zzhu3@marvell.com>
Date: Fri, 13 Sep 2013 06:59:48 +0000
Subject: [PATCH V5 4/5] video: mmp: calculate pitch value when fb set win
Message-Id: <1379055589-26132-5-git-send-email-zzhu3@marvell.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Jing Xiang <jxiang@marvell.com>

Add new func mmpfb_set_win to make code clean, it will do resolution
and fmt setting of win in mmpfb_set_win.

Signed-off-by: Jing Xiang <jxiang@marvell.com>
Signed-off-by: Jett.Zhou <jtzhou@marvell.com>
Signed-off-by: Zhou Zhu <zzhu3@marvell.com>
Reviewed-by: Daniel Drake <dsd@laptop.org>
---
 drivers/video/mmp/fb/mmpfb.c |   28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/video/mmp/fb/mmpfb.c b/drivers/video/mmp/fb/mmpfb.c
index 4ab95b8..19fd913 100644
--- a/drivers/video/mmp/fb/mmpfb.c
+++ b/drivers/video/mmp/fb/mmpfb.c
@@ -392,12 +392,23 @@ static int var_update(struct fb_info *info)
 	return 0;
 }
 
+static void mmpfb_set_win(struct fb_info *info)
+{
+	struct mmpfb_info *fbi = info->par;
+	struct mmp_win win;
+
+	memset(&win, 0, sizeof(win));
+	win.xsrc = win.xdst = fbi->mode.xres;
+	win.ysrc = win.ydst = fbi->mode.yres;
+	win.pix_fmt = fbi->pix_fmt;
+	mmp_overlay_set_win(fbi->overlay, &win);
+}
+
 static int mmpfb_set_par(struct fb_info *info)
 {
 	struct mmpfb_info *fbi = info->par;
 	struct fb_var_screeninfo *var = &info->var;
 	struct mmp_addr addr;
-	struct mmp_win win;
 	struct mmp_mode mode;
 	int ret;
 
@@ -409,11 +420,8 @@ static int mmpfb_set_par(struct fb_info *info)
 	fbmode_to_mmpmode(&mode, &fbi->mode, fbi->output_fmt);
 	mmp_path_set_mode(fbi->path, &mode);
 
-	memset(&win, 0, sizeof(win));
-	win.xsrc = win.xdst = fbi->mode.xres;
-	win.ysrc = win.ydst = fbi->mode.yres;
-	win.pix_fmt = fbi->pix_fmt;
-	mmp_overlay_set_win(fbi->overlay, &win);
+	/* set window related info */
+	mmpfb_set_win(info);
 
 	/* set address always */
 	memset(&addr, 0, sizeof(addr));
@@ -427,16 +435,12 @@ static int mmpfb_set_par(struct fb_info *info)
 static void mmpfb_power(struct mmpfb_info *fbi, int power)
 {
 	struct mmp_addr addr;
-	struct mmp_win win;
 	struct fb_var_screeninfo *var = &fbi->fb_info->var;
 
 	/* for power on, always set address/window again */
 	if (power) {
-		memset(&win, 0, sizeof(win));
-		win.xsrc = win.xdst = fbi->mode.xres;
-		win.ysrc = win.ydst = fbi->mode.yres;
-		win.pix_fmt = fbi->pix_fmt;
-		mmp_overlay_set_win(fbi->overlay, &win);
+		/* set window related info */
+		mmpfb_set_win(fbi->fb_info);
 
 		/* set address always */
 		memset(&addr, 0, sizeof(addr));
-- 
1.7.9.5

