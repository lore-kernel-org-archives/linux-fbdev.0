From: <grygorii.strashko@linaro.org>
Date: Wed, 25 Feb 2015 17:03:56 +0000
Subject: [PATCH] omapdss: extend pm notifier to handle hibernation
Message-Id: <1424883836-9119-1-git-send-email-grygorii.strashko@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: nm@ti.com, sumit.semwal@linaro.org, linux-omap@vger.kernel.org, kishon@ti.com, linux-fbdev@vger.kernel.org, Grygorii Strashko <Grygorii.Strashko@linaro.org>

From: Grygorii Strashko <Grygorii.Strashko@linaro.org>

Add handling of missed events in omap_dss_pm_notif which are
needed to support hibernation (suspend to disk).

Signed-off-by: Grygorii Strashko <Grygorii.Strashko@linaro.org>
---
 drivers/video/fbdev/omap2/dss/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/video/fbdev/omap2/dss/core.c b/drivers/video/fbdev/omap2/dss/core.c
index 6b74f73..e60976a 100644
--- a/drivers/video/fbdev/omap2/dss/core.c
+++ b/drivers/video/fbdev/omap2/dss/core.c
@@ -178,11 +178,15 @@ static int omap_dss_pm_notif(struct notifier_block *b, unsigned long v, void *d)
 	DSSDBG("pm notif %lu\n", v);
 
 	switch (v) {
+	case PM_HIBERNATION_PREPARE:
 	case PM_SUSPEND_PREPARE:
+	case PM_RESTORE_PREPARE:
 		DSSDBG("suspending displays\n");
 		return dss_suspend_all_devices();
 
 	case PM_POST_SUSPEND:
+	case PM_POST_HIBERNATION:
+	case PM_POST_RESTORE:
 		DSSDBG("resuming displays\n");
 		return dss_resume_all_devices();
 
-- 
1.9.1

