From: Inki Dae <inki.dae@samsung.com>
Date: Thu, 18 Nov 2010 11:15:56 +0000
Subject: [PATCH 2/3] S5PV210: added MIPI-DSI Driver.
Message-Id: <1290078956-29076-1-git-send-email-inki.dae@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <>
In-Reply-To: <>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Signed-off-by: Inki Dae <inki.dae@samsung.com>
Signed-off-by: Kyoungmin Park <kyoungmin.park@samsung.com>
---
 arch/arm/plat-samsung/include/plat/fb.h |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-samsung/include/plat/fb.h b/arch/arm/plat-samsung/include/plat/fb.h
index cb3ca3a..1ba0ae0 100644
--- a/arch/arm/plat-samsung/include/plat/fb.h
+++ b/arch/arm/plat-samsung/include/plat/fb.h
@@ -22,14 +22,21 @@
  */
 #define S3C_FB_MAX_WIN	(5)
 
+enum {
+	FIMD_VIDEO_MODE = 0,
+	FIMD_CPU_MODE
+};
+
 /**
  * struct s3c_fb_pd_win - per window setup data
- * @win_mode: The display parameters to initialise (not for window 0)
+ * @win_mode: The display parameters to RGB interface
+ * @cpu_mode: The display parameters to CPU interface
  * @virtual_x: The virtual X size.
  * @virtual_y: The virtual Y size.
  */
 struct s3c_fb_pd_win {
 	struct fb_videomode	win_mode;
+	struct fb_cpumode	cpu_mode;
 
 	unsigned short		default_bpp;
 	unsigned short		max_bpp;
@@ -43,6 +50,7 @@ struct s3c_fb_pd_win {
  *		the data from the display system to the connected display
  *		device.
  * @default_win: default window layer number to be used for UI layer.
+ * @interface_mode: cpu mode or rgb mode.
  * @vidcon0: The base vidcon0 values to control the panel data format.
  * @vidcon1: The base vidcon1 values to control the panel data output.
  * @win: The setup data for each hardware window, or NULL for unused.
@@ -59,6 +67,7 @@ struct s3c_fb_platdata {
 
 	struct s3c_fb_pd_win	*win[S3C_FB_MAX_WIN];
 
+	u32			interface_mode;
 	u32			 default_win;
 
 	u32			 vidcon0;
-- 
1.5.4.3

