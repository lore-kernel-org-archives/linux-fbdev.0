From: Donghwa Lee <dh09.lee@samsung.com>
Date: Tue, 28 Sep 2010 02:05:05 +0000
Subject: [PATCH v3 1/3] S5PV210: FB: support command mode
Message-Id: <1285639505-21980-1-git-send-email-dh09.lee@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

I had tested MIPI-DSI to use commnad mode as per H/W
and the newest FB only uses RGB mode. So some structure
was added to use command mode (CPU interface).

Signed-off-by: Donghwa Lee <dh09.lee@samsung.com>
Signed-off-by: InKi Dae <inki.dae@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/plat-samsung/include/plat/fb.h |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-samsung/include/plat/fb.h b/arch/arm/plat-samsung/include/plat/fb.h
index cb3ca3a..2190500 100644
--- a/arch/arm/plat-samsung/include/plat/fb.h
+++ b/arch/arm/plat-samsung/include/plat/fb.h
@@ -22,6 +22,18 @@
  */
 #define S3C_FB_MAX_WIN	(5)
 
+struct fb_cmdmode {
+	const char *name;	/* optional */
+	u32 refresh;		/* optional */
+	u32 xres;
+	u32 yres;
+	u32 pixclock;
+	u32 cs_setup;
+	u32 wr_setup;
+	u32 wr_act;
+	u32 wr_hold;
+};
+
 /**
  * struct s3c_fb_pd_win - per window setup data
  * @win_mode: The display parameters to initialise (not for window 0)
@@ -30,6 +42,7 @@
  */
 struct s3c_fb_pd_win {
 	struct fb_videomode	win_mode;
+	struct fb_cmdmode	cmd_mode;
 
 	unsigned short		default_bpp;
 	unsigned short		max_bpp;
-- 
1.6.0.4

