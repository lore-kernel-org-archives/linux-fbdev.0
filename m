From: Pawel Osciak <p.osciak@samsung.com>
Date: Fri, 09 Jul 2010 08:49:58 +0000
Subject: [PATCH 10/19] s3c-fb: Separate S5PC100 and S5PV210 framebuffer driver
Message-Id: <1278665407-18002-11-git-send-email-p.osciak@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1278665407-18002-1-git-send-email-p.osciak@samsung.com>
In-Reply-To: <1278665407-18002-1-git-send-email-p.osciak@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

S5PC100 and S5PV210 framebuffer devices differ slightly in terms of
available registers and their driver data structures have to be separate.
Those differences include dissimilar ways to control shadow register
updates.

Signed-off-by: Pawel Osciak <p.osciak@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/video/s3c-fb.c |   37 ++++++++++++++++++++++++++++++++++---
 1 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
index 77f5765..5f931b4 100644
--- a/drivers/video/s3c-fb.c
+++ b/drivers/video/s3c-fb.c
@@ -1251,7 +1251,35 @@ static struct s3c_fb_driverdata s3c_fb_data_64xx __devinitdata = {
 	.win[4]	= &s3c_fb_data_64xx_wins[4],
 };
 
-static struct s3c_fb_driverdata s3c_fb_data_s5p __devinitdata = {
+static struct s3c_fb_driverdata s3c_fb_data_s5pc100 __devinitdata = {
+	.variant = {
+		.nr_windows	= 5,
+		.vidtcon	= VIDTCON0,
+		.wincon		= WINCON(0),
+		.winmap		= WINxMAP(0),
+		.keycon		= WKEYCON,
+		.osd		= VIDOSD_BASE,
+		.osd_stride	= 16,
+		.buf_start	= VIDW_BUF_START(0),
+		.buf_size	= VIDW_BUF_SIZE(0),
+		.buf_end	= VIDW_BUF_END(0),
+
+		.palette = {
+			[0] = 0x2400,
+			[1] = 0x2800,
+			[2] = 0x2c00,
+			[3] = 0x3000,
+			[4] = 0x3400,
+		},
+	},
+	.win[0]	= &s3c_fb_data_64xx_wins[0],
+	.win[1]	= &s3c_fb_data_64xx_wins[1],
+	.win[2]	= &s3c_fb_data_64xx_wins[2],
+	.win[3]	= &s3c_fb_data_64xx_wins[3],
+	.win[4]	= &s3c_fb_data_64xx_wins[4],
+};
+
+static struct s3c_fb_driverdata s3c_fb_data_s5pv210 __devinitdata = {
 	.variant = {
 		.nr_windows	= 5,
 		.vidtcon	= VIDTCON0,
@@ -1319,8 +1347,11 @@ static struct platform_device_id s3c_fb_driver_ids[] = {
 		.name		= "s3c-fb",
 		.driver_data	= (unsigned long)&s3c_fb_data_64xx,
 	}, {
-		.name		= "s5p-fb",
-		.driver_data	= (unsigned long)&s3c_fb_data_s5p,
+		.name		= "s5pc100-fb",
+		.driver_data	= (unsigned long)&s3c_fb_data_s5pc100,
+	}, {
+		.name		= "s5pv210-fb",
+		.driver_data	= (unsigned long)&s3c_fb_data_s5pv210,
 	}, {
 		.name		= "s3c2443-fb",
 		.driver_data	= (unsigned long)&s3c_fb_data_s3c2443,
-- 
1.7.1.569.g6f426

