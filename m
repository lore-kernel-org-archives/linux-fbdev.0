From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 09 Dec 2015 15:59:29 +0000
Subject: [PATCH 01/23] OMAPDSS: adopt pinctrl support
Message-Id: <1449676791-26304-2-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Dave Gerlach <d-gerlach@ti.com>

Update omapdss driver to set the state of the pins to:
- "default on resume
- "sleep" on suspend

By optionally putting the pins into sleep state in the suspend callback
we can accomplish two things.
- minimize current leakage from pins and thus save power,
- prevent the IP from driving pins output in an uncontrolled manner,
which may happen if the power domain drops the domain regulator.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/dss.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/video/fbdev/omap2/dss/dss.c b/drivers/video/fbdev/omap2/dss/dss.c
index 9200a8668b49..f95ff319e68e 100644
--- a/drivers/video/fbdev/omap2/dss/dss.c
+++ b/drivers/video/fbdev/omap2/dss/dss.c
@@ -1264,12 +1264,18 @@ static int dss_runtime_suspend(struct device *dev)
 {
 	dss_save_context();
 	dss_set_min_bus_tput(dev, 0);
+
+	pinctrl_pm_select_sleep_state(dev);
+
 	return 0;
 }
 
 static int dss_runtime_resume(struct device *dev)
 {
 	int r;
+
+	pinctrl_pm_select_default_state(dev);
+
 	/*
 	 * Set an arbitrarily high tput request to ensure OPP100.
 	 * What we should really do is to make a request to stay in OPP100,
-- 
2.5.0

