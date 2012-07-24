From: Jassi Brar <jaswinder.singh@linaro.org>
Date: Tue, 24 Jul 2012 14:15:55 +0000
Subject: [PATCH] OMAPDSS: DISPC: Use msleep instead of blocking mdelay
Message-Id: <1343138635-2802-1-git-send-email-jaswinder.singh@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com, a0393947@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Jassi Brar <jaswinder.singh@linaro.org>

We have no reason to block in the error handler workqueue, so use msleep.

Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
---
 drivers/video/omap2/dss/dispc.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index c56a51a..0e3ad44 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -3492,7 +3492,7 @@ static void dispc_error_worker(struct work_struct *work)
 					ovl->name);
 			dispc_ovl_enable(ovl->id, false);
 			dispc_mgr_go(ovl->manager->id);
-			mdelay(50);
+			msleep(50);
 		}
 	}
 
@@ -3524,7 +3524,7 @@ static void dispc_error_worker(struct work_struct *work)
 			}
 
 			dispc_mgr_go(mgr->id);
-			mdelay(50);
+			msleep(50);
 
 			if (enable)
 				dssdev->driver->enable(dssdev);
-- 
1.7.4.1

