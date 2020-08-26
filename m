From: "Timo A. Aranjo" <timo.aranjo@aol.com>
Date: Wed, 26 Aug 2020 01:21:01 +0000
Subject: [PATCH] Staging: sm750fb: Fix basic coding style issues
Message-Id: <20200826012101.12162-1-timo.aranjo@aol.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The word "enought" was changed to read as "enough".
In addition to this, there was a missing new-line after varaible
declarations within a function.

Signed-off-by: Timo A. Aranjo <timo.aranjo@aol.com>
---
 drivers/staging/sm750fb/sm750.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 84fb585a5739..029f0d09e966 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -411,6 +411,7 @@ static int __maybe_unused lynxfb_suspend(struct device *dev)
 {
 	struct fb_info *info;
 	struct sm750_dev *sm750_dev;
+
 	sm750_dev = dev_get_drvdata(dev);
 
 	console_lock();
@@ -500,7 +501,7 @@ static int lynxfb_ops_check_var(struct fb_var_screeninfo *var,
 	var->height = var->width = -1;
 	var->accel_flags = 0;/* FB_ACCELF_TEXT; */
 
-	/* check if current fb's video memory big enought to hold the onscreen*/
+	/* check if current fb's video memory big enough to hold the onscreen*/
 	request = var->xres_virtual * (var->bits_per_pixel >> 3);
 	/* defaulty crtc->channel go with par->index */
 
-- 
2.25.1
