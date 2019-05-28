From: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Tue, 28 May 2019 09:02:36 +0000
Subject: [PATCH 05/33] fbdev/sa1100fb: Remove dead code
Message-Id: <20190528090304.9388-6-daniel.vetter@ffwll.ch>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190528090304.9388-1-daniel.vetter@ffwll.ch>
In-Reply-To: <20190528090304.9388-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, linux-fbdev@vger.kernel.org, DRI Development <dri-devel@lists.freedesktop.org>, Daniel Vetter <daniel.vetter@intel.com>, Sam Ravnborg <sam@ravnborg.org>

Motivated because it contains a struct display, which is a fbcon
internal data structure that I want to rename. It seems to have been
formerly used in drivers, but that's very long time ago.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/video/fbdev/sa1100fb.c | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/drivers/video/fbdev/sa1100fb.c b/drivers/video/fbdev/sa1100fb.c
index 15ae50063296..f7f8dee044b1 100644
--- a/drivers/video/fbdev/sa1100fb.c
+++ b/drivers/video/fbdev/sa1100fb.c
@@ -974,35 +974,10 @@ static void sa1100fb_task(struct work_struct *w)
  */
 static unsigned int sa1100fb_min_dma_period(struct sa1100fb_info *fbi)
 {
-#if 0
-	unsigned int min_period = (unsigned int)-1;
-	int i;
-
-	for (i = 0; i < MAX_NR_CONSOLES; i++) {
-		struct display *disp = &fb_display[i];
-		unsigned int period;
-
-		/*
-		 * Do we own this display?
-		 */
-		if (disp->fb_info != &fbi->fb)
-			continue;
-
-		/*
-		 * Ok, calculate its DMA period
-		 */
-		period = sa1100fb_display_dma_period(&disp->var);
-		if (period < min_period)
-			min_period = period;
-	}
-
-	return min_period;
-#else
 	/*
 	 * FIXME: we need to verify _all_ consoles.
 	 */
 	return sa1100fb_display_dma_period(&fbi->fb.var);
-#endif
 }
 
 /*
-- 
2.20.1
