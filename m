From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 06 Sep 2019 15:13:00 +0000
Subject: [PATCH] fbdev/sa1100fb: Remove even more dead code
Message-Id: <20190906151307.1127187-1-arnd@arndb.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Daniel Vetter <daniel.vetter@intel.com>, Sam Ravnborg <sam@ravnborg.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Viresh Kumar <viresh.kumar@linaro.org>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

This function lost its only call site as part of
earlier dead code removal, so remove it as well:

drivers/video/fbdev/sa1100fb.c:975:21: error: unused function 'sa1100fb_min_dma_period' [-Werror,-Wunused-function]

Fixes: 390e5de11284 ("fbdev/sa1100fb: Remove dead code")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/video/fbdev/sa1100fb.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/video/fbdev/sa1100fb.c b/drivers/video/fbdev/sa1100fb.c
index ae2bcfee338a..81ad3aa1ca06 100644
--- a/drivers/video/fbdev/sa1100fb.c
+++ b/drivers/video/fbdev/sa1100fb.c
@@ -967,19 +967,6 @@ static void sa1100fb_task(struct work_struct *w)
 }
 
 #ifdef CONFIG_CPU_FREQ
-/*
- * Calculate the minimum DMA period over all displays that we own.
- * This, together with the SDRAM bandwidth defines the slowest CPU
- * frequency that can be selected.
- */
-static unsigned int sa1100fb_min_dma_period(struct sa1100fb_info *fbi)
-{
-	/*
-	 * FIXME: we need to verify _all_ consoles.
-	 */
-	return sa1100fb_display_dma_period(&fbi->fb.var);
-}
-
 /*
  * CPU clock speed change handler.  We need to adjust the LCD timing
  * parameters when the CPU clock is adjusted by the power management
-- 
2.20.0
