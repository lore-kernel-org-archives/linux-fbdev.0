From: Karim Eshapa <karim.eshapa@gmail.com>
Date: Mon, 15 May 2017 19:14:26 +0000
Subject: [PATCH] video: fbdev: omap2: omapfb: displays: panel-dsi-cm: Use time comparison kernel macro.
Message-Id: <1494875666-4109-1-git-send-email-karim.eshapa@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com
Cc: b.zolnierkie@samsung.com, peter.ujfalusi@ti.com, tj@kernel.org, mingo@kernel.org, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Karim Eshapa <karim.eshapa@gmail.com>

Use time_before_eq() kernel macro for
time comparison more safe.

Signed-off-by: Karim Eshapa <karim.eshapa@gmail.com>
---
 drivers/video/fbdev/omap2/omapfb/displays/panel-dsi-cm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/displays/panel-dsi-cm.c b/drivers/video/fbdev/omap2/omapfb/displays/panel-dsi-cm.c
index fd2b372d..7f20bc2 100644
--- a/drivers/video/fbdev/omap2/omapfb/displays/panel-dsi-cm.c
+++ b/drivers/video/fbdev/omap2/omapfb/displays/panel-dsi-cm.c
@@ -100,7 +100,7 @@ static void hw_guard_wait(struct panel_drv_data *ddata)
 {
 	unsigned long wait = ddata->hw_guard_end - jiffies;
 
-	if ((long)wait > 0 && wait <= ddata->hw_guard_wait) {
+	if ((long)wait > 0 && time_before_eq(wait, ddata->hw_guard_wait)) {
 		set_current_state(TASK_UNINTERRUPTIBLE);
 		schedule_timeout(wait);
 	}
-- 
2.7.4

