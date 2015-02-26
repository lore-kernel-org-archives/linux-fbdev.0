From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 26 Feb 2015 12:49:09 +0000
Subject: [PATCH 15/15] OMAPDSS: disable VT switch
Message-Id: <1424954949-12801-15-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1424954949-12801-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1424954949-12801-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, NeilBrown <neil@brown.name>

We don't need VT switch when suspending/resuming, so disable it. This
speeds up suspend/resume.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: NeilBrown <neil@brown.name>
---
 drivers/video/fbdev/omap2/dss/dss.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/video/fbdev/omap2/dss/dss.c b/drivers/video/fbdev/omap2/dss/dss.c
index a6d10d4279f3..7f978b6a34e8 100644
--- a/drivers/video/fbdev/omap2/dss/dss.c
+++ b/drivers/video/fbdev/omap2/dss/dss.c
@@ -38,6 +38,7 @@
 #include <linux/regmap.h>
 #include <linux/of.h>
 #include <linux/regulator/consumer.h>
+#include <linux/suspend.h>
 
 #include <video/omapdss.h>
 
@@ -1138,6 +1139,8 @@ static int __init omap_dsshw_probe(struct platform_device *pdev)
 
 	dss_debugfs_create_file("dss", dss_dump_regs);
 
+	pm_set_vt_switch(0);
+
 	return 0;
 
 err_pll_init:
-- 
2.3.0

