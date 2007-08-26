From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 18/20] pm2fb: hardware cursor support
	for the Permedia2
Date: Sun, 26 Aug 2007 22:10:17 +0800
Message-ID: <46D189C9.4010605@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IPJdZ-0000V3-EY for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 26 Aug 2007 08:02:49 -0700
Received: from nz-out-0506.google.com ([64.233.162.237])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IPJ2j-00088d-55
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 26 Aug 2007 07:24:45 -0700
Received: by nz-out-0506.google.com with SMTP id f1so2918589nzc
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 26 Aug 2007 07:24:44 -0700 (PDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch adds hardware cursor support for the
Permedia 2 chip.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/pm2fb.c     |  125 +++++++++++++++++++++++++++++++++++++++++----
 include/video/permedia2.h |    7 +++
 2 files changed, 120 insertions(+), 12 deletions(-)

diff --git a/drivers/video/pm2fb.c b/drivers/video/pm2fb.c
index 53dd639..20476f4 100644
--- a/drivers/video/pm2fb.c
+++ b/drivers/video/pm2fb.c
@@ -1257,18 +1257,8 @@ static const u8 cursor_bits_lookup[16] =
 static int pm2vfb_cursor(struct fb_info *info, struct fb_cursor *cursor)
 {
 	struct pm2fb_par *par = info->par;
-	u8 mode;
-
-	if (!hwcursor)
-		return -EINVAL;	/* just to force soft_cursor() call */
-
-	/* Too large of a cursor or wrong bpp :-( */
-	if (cursor->image.width > 64 ||
-	    cursor->image.height > 64 ||
-	    cursor->image.depth > 1)
-		return -EINVAL;
+	u8 mode = PM2F_CURSORMODE_TYPE_X;
 
-	mode = PM2F_CURSORMODE_TYPE_X;
 	if (cursor->enable)
 		mode |= PM2F_CURSORMODE_CURSOR_ENABLE;
 
@@ -1369,11 +1359,122 @@ static int pm2vfb_cursor(struct fb_info 
 static int pm2fb_cursor(struct fb_info *info, struct fb_cursor *cursor)
 {
 	struct pm2fb_par *par = info->par;
+	u8 mode;
+
+	if (!hwcursor)
+		return -EINVAL;	/* just to force soft_cursor() call */
+
+	/* Too large of a cursor or wrong bpp :-( */
+	if (cursor->image.width > 64 ||
+	    cursor->image.height > 64 ||
+	    cursor->image.depth > 1)
+		return -EINVAL;
 
 	if (par->type == PM2_TYPE_PERMEDIA2V)
 		return pm2vfb_cursor(info, cursor);
 
-	return -ENXIO;
+	mode = 0;
+	if (cursor->enable)
+		 mode = 0x43;
+
+	pm2_RDAC_WR(par, PM2I_RD_CURSOR_CONTROL, mode);
+
+	/*
+	 * If the cursor is not be changed this means either we want the
+	 * current cursor state (if enable is set) or we want to query what
+	 * we can do with the cursor (if enable is not set)
+	 */
+	if (!cursor->set)
+		return 0;
+
+	if (cursor->set & FB_CUR_SETPOS) {
+		int x, y;
+
+		x = cursor->image.dx + 63;
+		y = cursor->image.dy + 63;
+		WAIT_FIFO(par, 4);
+		pm2_WR(par, PM2R_RD_CURSOR_X_LSB, x & 0xff);
+		pm2_WR(par, PM2R_RD_CURSOR_X_MSB, (x >> 8) & 0x7);
+		pm2_WR(par, PM2R_RD_CURSOR_Y_LSB, y & 0xff);
+		pm2_WR(par, PM2R_RD_CURSOR_Y_MSB, (y >> 8) & 0x7);
+	}
+
+	if (cursor->set & FB_CUR_SETCMAP) {
+		u32 fg_idx = cursor->image.fg_color;
+		u32 bg_idx = cursor->image.bg_color;
+
+		WAIT_FIFO(par, 7);
+		pm2_WR(par, PM2R_RD_CURSOR_COLOR_ADDRESS, 1);
+		pm2_WR(par, PM2R_RD_CURSOR_COLOR_DATA,
+			info->cmap.red[bg_idx] >> 8);
+		pm2_WR(par, PM2R_RD_CURSOR_COLOR_DATA,
+			info->cmap.green[bg_idx] >> 8);
+		pm2_WR(par, PM2R_RD_CURSOR_COLOR_DATA,
+			info->cmap.blue[bg_idx] >> 8);
+
+		pm2_WR(par, PM2R_RD_CURSOR_COLOR_DATA,
+			info->cmap.red[fg_idx] >> 8);
+		pm2_WR(par, PM2R_RD_CURSOR_COLOR_DATA,
+			info->cmap.green[fg_idx] >> 8);
+		pm2_WR(par, PM2R_RD_CURSOR_COLOR_DATA,
+			info->cmap.blue[fg_idx] >> 8);
+	}
+
+	if (cursor->set & (FB_CUR_SETSHAPE | FB_CUR_SETIMAGE)) {
+		u8 *bitmap = (u8 *)cursor->image.data;
+		u8 *mask = (u8 *)cursor->mask;
+		int i;
+
+		WAIT_FIFO(par, 1);
+		pm2_WR(par, PM2R_RD_PALETTE_WRITE_ADDRESS, 0);
+
+		for (i = 0; i < cursor->image.height; i++) {
+			int j = (cursor->image.width + 7) >> 3;
+			int k = 8 - j;
+
+			WAIT_FIFO(par, 8);
+			for (; j > 0; j--) {
+				u8 data = *bitmap ^ *mask;
+
+				if (cursor->rop == ROP_COPY)
+					data = *mask & *bitmap;
+				/* bitmap data */
+				pm2_WR(par, PM2R_RD_CURSOR_DATA, data);
+				bitmap++;
+				mask++;
+			}
+			for (; k > 0; k--)
+				pm2_WR(par, PM2R_RD_CURSOR_DATA, 0);
+		}
+		for (; i < 64; i++) {
+			int j = 8;
+			WAIT_FIFO(par, 8);
+			while (j-- > 0)
+				pm2_WR(par, PM2R_RD_CURSOR_DATA, 0);
+		}
+
+		mask = (u8 *)cursor->mask;
+		for (i = 0; i < cursor->image.height; i++) {
+			int j = (cursor->image.width + 7) >> 3;
+			int k = 8 - j;
+
+			WAIT_FIFO(par, 8);
+			for (; j > 0; j--) {
+				/* mask */
+				pm2_WR(par, PM2R_RD_CURSOR_DATA, *mask);
+				mask++;
+			}
+			for (; k > 0; k--)
+				pm2_WR(par, PM2R_RD_CURSOR_DATA, 0);
+		}
+		for (; i < 64; i++) {
+			int j = 8;
+			WAIT_FIFO(par, 8);
+			while (j-- > 0)
+				pm2_WR(par, PM2R_RD_CURSOR_DATA, 0);
+		}
+	}
+	return 0;
 }
 
 /* ------------ Hardware Independent Functions ------------ */
diff --git a/include/video/permedia2.h b/include/video/permedia2.h
index c6575b8..9ce9adb 100644
--- a/include/video/permedia2.h
+++ b/include/video/permedia2.h
@@ -58,7 +58,14 @@ #define PM2R_RD_PALETTE_WRITE_ADDRESS			
 #define PM2R_RD_PALETTE_DATA				0x4008
 #define PM2R_RD_PIXEL_MASK				0x4010
 #define PM2R_RD_PALETTE_READ_ADDRESS			0x4018
+#define PM2R_RD_CURSOR_COLOR_ADDRESS		        0x4020
+#define PM2R_RD_CURSOR_COLOR_DATA		        0x4028
 #define PM2R_RD_INDEXED_DATA				0x4050
+#define PM2R_RD_CURSOR_DATA				0x4058
+#define PM2R_RD_CURSOR_X_LSB				0x4060
+#define PM2R_RD_CURSOR_X_MSB				0x4068
+#define PM2R_RD_CURSOR_Y_LSB				0x4070
+#define PM2R_RD_CURSOR_Y_MSB				0x4078
 
 #define PM2R_START_X_DOM				0x8000
 #define PM2R_D_X_DOM					0x8008


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
