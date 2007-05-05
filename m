From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 11/20] pm2fb: accelerated fillrect and
	copyarea
Date: Sat, 05 May 2007 22:56:31 +0800
Message-ID: <463C9B1F.40908@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HkMDt-00005p-3u for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 05 May 2007 08:31:01 -0700
Received: from py-out-1112.google.com ([64.233.166.180])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HkMDs-0008EN-IT
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 05 May 2007 08:31:01 -0700
Received: by py-out-1112.google.com with SMTP id a29so906538pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 05 May 2007 08:31:00 -0700 (PDT)
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

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This is port of accelerated functions from 2.4 kernel. Only
fillrect and copyarea are accelerated. Fillrect is not
accelerated in 24-bit mode.

[adaplas]
Add appropriate flags

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/pm2fb.c |  132 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 128 insertions(+), 4 deletions(-)

diff --git a/drivers/video/pm2fb.c b/drivers/video/pm2fb.c
index 5395419..5693da5 100644
--- a/drivers/video/pm2fb.c
+++ b/drivers/video/pm2fb.c
@@ -103,7 +103,7 @@ static struct fb_fix_screeninfo pm2fb_fi
 	.xpanstep =	1,
 	.ypanstep =	1,
 	.ywrapstep =	0, 
-	.accel =	FB_ACCEL_NONE,
+	.accel =	FB_ACCEL_3DLABS_PERMEDIA2,
 };
 
 /*
@@ -206,6 +206,17 @@ static inline void WAIT_FIFO(struct pm2f
 }
 #endif
 
+static void wait_pm2(struct pm2fb_par* par) {
+
+	WAIT_FIFO(par, 1);
+	pm2_WR(par, PM2R_SYNC, 0);
+	mb();
+	do {
+		while (pm2_RD(par, PM2R_OUT_FIFO_WORDS) == 0);
+		rmb();
+	} while (pm2_RD(par, PM2R_OUT_FIFO) != PM2TAG(PM2R_SYNC));
+}
+
 /*
  * partial products for the supported horizontal resolutions.
  */
@@ -1041,6 +1052,117 @@ static int pm2fb_blank(int blank_mode, s
 	return 0;
 }
 
+/*
+ * block operation. copy=0: rectangle fill, copy=1: rectangle copy.
+ */
+static void pm2fb_block_op(struct pm2fb_par* par, int copy,
+				s32 xsrc, s32 ysrc,
+				s32 x, s32 y, s32 w, s32 h,
+				u32 color) {
+
+	if (!w || !h)
+		return;
+	WAIT_FIFO(par, 6);
+	pm2_WR(par, PM2R_CONFIG, PM2F_CONFIG_FB_WRITE_ENABLE |
+		PM2F_CONFIG_FB_READ_SOURCE_ENABLE);
+	pm2_WR(par, PM2R_FB_PIXEL_OFFSET, 0);
+	if (copy)
+		pm2_WR(par, PM2R_FB_SOURCE_DELTA,
+			((ysrc-y) & 0xfff) << 16 | ((xsrc-x) & 0xfff));
+	else
+		pm2_WR(par, PM2R_FB_BLOCK_COLOR, color);
+	pm2_WR(par, PM2R_RECTANGLE_ORIGIN, (y << 16) | x);
+	pm2_WR(par, PM2R_RECTANGLE_SIZE, (h << 16) | w);
+	wmb();
+	pm2_WR(par, PM2R_RENDER,PM2F_RENDER_RECTANGLE |
+				(x<xsrc ? PM2F_INCREASE_X : 0) |
+				(y<ysrc ? PM2F_INCREASE_Y : 0) |
+				(copy ? 0 : PM2F_RENDER_FASTFILL));
+	wait_pm2(par);
+}
+
+static void pm2fb_fillrect (struct fb_info *info,
+				const struct fb_fillrect *region)
+{
+	struct pm2fb_par *par = info->par;
+	struct fb_fillrect modded;
+	int vxres, vyres;
+	u32 color = (info->fix.visual == FB_VISUAL_TRUECOLOR) ?
+		((u32*)info->pseudo_palette)[region->color] : region->color;
+
+	if (info->state != FBINFO_STATE_RUNNING)
+		return;
+	if ((info->flags & FBINFO_HWACCEL_DISABLED) ||
+		region->rop != ROP_COPY ) {
+		cfb_fillrect(info, region);
+		return;
+	}
+
+	vxres = info->var.xres_virtual;
+	vyres = info->var.yres_virtual;
+
+	memcpy(&modded, region, sizeof(struct fb_fillrect));
+
+	if(!modded.width || !modded.height ||
+	   modded.dx >= vxres || modded.dy >= vyres)
+		return;
+
+	if(modded.dx + modded.width  > vxres)
+		modded.width  = vxres - modded.dx;
+	if(modded.dy + modded.height > vyres)
+		modded.height = vyres - modded.dy;
+
+	if(info->var.bits_per_pixel == 8)
+		color |= color << 8;
+	if(info->var.bits_per_pixel <= 16)
+		color |= color << 16;
+
+	if(info->var.bits_per_pixel != 24)
+		pm2fb_block_op(par, 0, 0, 0,
+				modded.dx, modded.dy,
+				modded.width, modded.height, color);
+	else
+		cfb_fillrect(info, region);
+}
+
+static void pm2fb_copyarea(struct fb_info *info,
+				const struct fb_copyarea *area)
+{
+	struct pm2fb_par *par = info->par;
+	struct fb_copyarea modded;
+	u32 vxres, vyres;
+
+	if (info->state != FBINFO_STATE_RUNNING)
+		return;
+	if (info->flags & FBINFO_HWACCEL_DISABLED) {
+		cfb_copyarea(info, area);
+		return;
+	}
+
+	memcpy(&modded, area, sizeof(struct fb_copyarea));
+
+	vxres = info->var.xres_virtual;
+	vyres = info->var.yres_virtual;
+
+	if(!modded.width || !modded.height ||
+	   modded.sx >= vxres || modded.sy >= vyres ||
+	   modded.dx >= vxres || modded.dy >= vyres)
+		return;
+
+	if(modded.sx + modded.width > vxres)
+		modded.width = vxres - modded.sx;
+	if(modded.dx + modded.width > vxres)
+		modded.width = vxres - modded.dx;
+	if(modded.sy + modded.height > vyres)
+		modded.height = vyres - modded.sy;
+	if(modded.dy + modded.height > vyres)
+		modded.height = vyres - modded.dy;
+
+	pm2fb_block_op(par, 1, modded.sx, modded.sy,
+			modded.dx, modded.dy,
+			modded.width, modded.height, 0);
+}
+
 /* ------------ Hardware Independent Functions ------------ */
 
 /*
@@ -1054,8 +1176,8 @@ static struct fb_ops pm2fb_ops = {
 	.fb_setcolreg	= pm2fb_setcolreg,
 	.fb_blank	= pm2fb_blank,
 	.fb_pan_display	= pm2fb_pan_display,
-	.fb_fillrect	= cfb_fillrect,
-	.fb_copyarea	= cfb_copyarea,
+	.fb_fillrect	= pm2fb_fillrect,
+	.fb_copyarea	= pm2fb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
 };
 
@@ -1204,7 +1326,9 @@ #endif
 	info->fix		= pm2fb_fix; 	
 	info->pseudo_palette	= default_par->palette;
 	info->flags		= FBINFO_DEFAULT |
-                                  FBINFO_HWACCEL_YPAN;
+                                  FBINFO_HWACCEL_YPAN |
+	                          FBINFO_HWACCEL_COPYAREA |
+	                          FBINFO_HWACCEL_FILLRECT;
 
 	if (!mode)
 		mode = "640x480@60";


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
