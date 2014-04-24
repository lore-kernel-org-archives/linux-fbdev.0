From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 24 Apr 2014 10:17:09 +0000
Subject: [PATCH 13/23] OMAPDSS: DSS & DISPC DT support for OMAP5
Message-Id: <1398334639-14172-14-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1398334639-14172-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1398334639-14172-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Add omap5 entries to dispc's and dss's of_device_id tables.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/dispc.c | 1 +
 drivers/video/fbdev/omap2/dss/dss.c   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/omap2/dss/dispc.c b/drivers/video/fbdev/omap2/dss/dispc.c
index f18397c33e8f..82a6ee9930a0 100644
--- a/drivers/video/fbdev/omap2/dss/dispc.c
+++ b/drivers/video/fbdev/omap2/dss/dispc.c
@@ -3829,6 +3829,7 @@ static const struct of_device_id dispc_of_match[] = {
 	{ .compatible = "ti,omap2-dispc", },
 	{ .compatible = "ti,omap3-dispc", },
 	{ .compatible = "ti,omap4-dispc", },
+	{ .compatible = "ti,omap5-dispc", },
 	{},
 };
 
diff --git a/drivers/video/fbdev/omap2/dss/dss.c b/drivers/video/fbdev/omap2/dss/dss.c
index d55266c0e029..ae870a569ddf 100644
--- a/drivers/video/fbdev/omap2/dss/dss.c
+++ b/drivers/video/fbdev/omap2/dss/dss.c
@@ -946,6 +946,7 @@ static const struct of_device_id dss_of_match[] = {
 	{ .compatible = "ti,omap2-dss", },
 	{ .compatible = "ti,omap3-dss", },
 	{ .compatible = "ti,omap4-dss", },
+	{ .compatible = "ti,omap5-dss", },
 	{},
 };
 
-- 
1.9.1

