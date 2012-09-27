From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 27 Sep 2012 10:42:27 +0000
Subject: [PATCH] video: s3c-fb: use FIMD_V8_VIDTCON0 for EXYNOS5 FIMD
Message-Id: <001601cd9c9c$c95b2f80$5c118e80$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This patch uses FIMD_V8_VIDTCON0 as the address definition
of VIDTCON0 register, because the address offset of VIDTCONx
registers is changed from 0x0 to 0x20000 for EXYNOS5 FIMD.
So, FIMD_V8_VIDTCON0 should be used.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/s3c-fb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
index 52b744f..8e1555d 100644
--- a/drivers/video/s3c-fb.c
+++ b/drivers/video/s3c-fb.c
@@ -1910,7 +1910,7 @@ static struct s3c_fb_driverdata s3c_fb_data_exynos4 = {
 static struct s3c_fb_driverdata s3c_fb_data_exynos5 = {
 	.variant = {
 		.nr_windows	= 5,
-		.vidtcon	= VIDTCON0,
+		.vidtcon	= FIMD_V8_VIDTCON0,
 		.wincon		= WINCON(0),
 		.winmap		= WINxMAP(0),
 		.keycon		= WKEYCON,
-- 
1.7.1


