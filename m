From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 5/5] pm2fb: fb_sync added
Date: Thu, 10 May 2007 07:48:12 +0800
Message-ID: <46425DBC.7040206@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hlvuq-0002Mk-RJ for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 09 May 2007 16:49:52 -0700
Received: from py-out-1112.google.com ([64.233.166.182])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Hlvuq-0005Lu-DM
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 09 May 2007 16:49:52 -0700
Received: by py-out-1112.google.com with SMTP id a29so322085pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 09 May 2007 16:49:52 -0700 (PDT)
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

This patch converts internal wait_pm2() function to fb API
fb_sync() method.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/pm2fb.c |   38 +++++++++++++++++++++-----------------
 1 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/drivers/video/pm2fb.c b/drivers/video/pm2fb.c
index 1ac5264..ab5e668 100644
--- a/drivers/video/pm2fb.c
+++ b/drivers/video/pm2fb.c
@@ -204,17 +204,6 @@ static inline void WAIT_FIFO(struct pm2f
 }
 #endif
 
-static void wait_pm2(struct pm2fb_par* par) {
-
-	WAIT_FIFO(par, 1);
-	pm2_WR(par, PM2R_SYNC, 0);
-	mb();
-	do {
-		while (pm2_RD(par, PM2R_OUT_FIFO_WORDS) == 0);
-		rmb();
-	} while (pm2_RD(par, PM2R_OUT_FIFO) != PM2TAG(PM2R_SYNC));
-}
-
 /*
  * partial products for the supported horizontal resolutions.
  */
@@ -1050,13 +1039,30 @@ static int pm2fb_blank(int blank_mode, s
 	return 0;
 }
 
+static int pm2fb_sync(struct fb_info *info)
+{
+	struct pm2fb_par *par = info->par;
+
+	WAIT_FIFO(par, 1);
+	pm2_WR(par, PM2R_SYNC, 0);
+	mb();
+	do {
+		while (pm2_RD(par, PM2R_OUT_FIFO_WORDS) == 0)
+			udelay(10);
+		rmb();
+	} while (pm2_RD(par, PM2R_OUT_FIFO) != PM2TAG(PM2R_SYNC));
+
+	return 0;
+}
+
 /*
  * block operation. copy=0: rectangle fill, copy=1: rectangle copy.
  */
-static void pm2fb_block_op(struct pm2fb_par* par, int copy,
+static void pm2fb_block_op(struct fb_info* info, int copy,
 				s32 xsrc, s32 ysrc,
 				s32 x, s32 y, s32 w, s32 h,
 				u32 color) {
+	struct pm2fb_par *par = info->par;
 
 	if (!w || !h)
 		return;
@@ -1076,13 +1082,11 @@ static void pm2fb_block_op(struct pm2fb_
 				(x<xsrc ? PM2F_INCREASE_X : 0) |
 				(y<ysrc ? PM2F_INCREASE_Y : 0) |
 				(copy ? 0 : PM2F_RENDER_FASTFILL));
-	wait_pm2(par);
 }
 
 static void pm2fb_fillrect (struct fb_info *info,
 				const struct fb_fillrect *region)
 {
-	struct pm2fb_par *par = info->par;
 	struct fb_fillrect modded;
 	int vxres, vyres;
 	u32 color = (info->fix.visual == FB_VISUAL_TRUECOLOR) ?
@@ -1116,7 +1120,7 @@ static void pm2fb_fillrect (struct fb_in
 		color |= color << 16;
 
 	if(info->var.bits_per_pixel != 24)
-		pm2fb_block_op(par, 0, 0, 0,
+		pm2fb_block_op(info, 0, 0, 0,
 				modded.dx, modded.dy,
 				modded.width, modded.height, color);
 	else
@@ -1126,7 +1130,6 @@ static void pm2fb_fillrect (struct fb_in
 static void pm2fb_copyarea(struct fb_info *info,
 				const struct fb_copyarea *area)
 {
-	struct pm2fb_par *par = info->par;
 	struct fb_copyarea modded;
 	u32 vxres, vyres;
 
@@ -1156,7 +1159,7 @@ static void pm2fb_copyarea(struct fb_inf
 	if(modded.dy + modded.height > vyres)
 		modded.height = vyres - modded.dy;
 
-	pm2fb_block_op(par, 1, modded.sx, modded.sy,
+	pm2fb_block_op(info, 1, modded.sx, modded.sy,
 			modded.dx, modded.dy,
 			modded.width, modded.height, 0);
 }
@@ -1177,6 +1180,7 @@ static struct fb_ops pm2fb_ops = {
 	.fb_fillrect	= pm2fb_fillrect,
 	.fb_copyarea	= pm2fb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
+	.fb_sync	= pm2fb_sync,
 };
 
 /*


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
