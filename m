From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 26 Feb 2015 12:49:02 +0000
Subject: [PATCH 08/15] OMAPDSS: DISPC: change sync_pclk_edge default value
Message-Id: <1424954949-12801-8-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1424954949-12801-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1424954949-12801-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

The common 'struct videomode' does not have a flag to select when the
sync signals should be driven.

The default behavior of DISPC HW is to drive the sync signal on the
opposite pixel clock edge from data signal, which is also what the
videomode_to_omap_video_timings() uses.

However, it looks like what panels usually expect is that the data and
sync signals are driven on the same edge, so let's change
videomode_to_omap_video_timings() to set the sync_pclk_edge accordingly.

Note that this only affect panels drivers that use
videomode_to_omap_video_timings(), probably when getting the video
timings directly from DT data. The drivers can still configure the
sync_pclk_edge independently if they so wish.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/display.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/display.c b/drivers/video/fbdev/omap2/dss/display.c
index a6fd2d35ad60..ef5b9027985d 100644
--- a/drivers/video/fbdev/omap2/dss/display.c
+++ b/drivers/video/fbdev/omap2/dss/display.c
@@ -295,9 +295,7 @@ void videomode_to_omap_video_timings(const struct videomode *vm,
 		OMAPDSS_DRIVE_SIG_RISING_EDGE :
 		OMAPDSS_DRIVE_SIG_FALLING_EDGE;
 
-	ovt->sync_pclk_edge = vm->flags & DISPLAY_FLAGS_PIXDATA_POSEDGE ?
-		OMAPDSS_DRIVE_SIG_FALLING_EDGE :
-		OMAPDSS_DRIVE_SIG_RISING_EDGE;
+	ovt->sync_pclk_edge = ovt->data_pclk_edge;
 }
 EXPORT_SYMBOL(videomode_to_omap_video_timings);
 
-- 
2.3.0

