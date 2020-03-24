From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Tue, 24 Mar 2020 17:05:32 +0000
Subject: [PATCH v1 5/5] video: ssd1307fb: Remove redundant forward declaration
Message-Id: <20200324170532.44384-5-andriy.shevchenko@linux.intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

There is no need to have forward declaration of struct ssd1307fb_par.
Drop it for good.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/video/fbdev/ssd1307fb.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index 6e543396002a..509cab2c8b6c 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -48,8 +48,6 @@
 static u_int refreshrate = REFRESHRATE;
 module_param(refreshrate, uint, 0);
 
-struct ssd1307fb_par;
-
 struct ssd1307fb_deviceinfo {
 	u32 default_vcomh;
 	u32 default_dclk_div;
-- 
2.25.1
