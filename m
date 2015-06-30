From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 30 Jun 2015 12:03:35 +0000
Subject: [PATCH] OMAPDSS: fix probing if rfbi device is enabled
Message-Id: <1435665815-27911-1-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

After the commit 736e60ddc215b85e73bbf7da26e1cde84cc9500f ("OMAPDSS:
componentize omapdss") the dss core device will wait until all the
subdevices have been successfully probed. However, we don't have a
working driver for RFBI, so if RFBI device exists, omapdss will never
get probed.

All the .dtsi files set RFBI as disabled, except am4372.dtsi. This
causes omapdss probe to not finish on AM4 devices.

This patch makes omapdss driver skip adding rfbi device as a
subcomponent, solving the issue.

This should be reverted when we have a working RFBI driver.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Reported-by: Felipe Balbi <balbi@ti.com>
---
 drivers/video/fbdev/omap2/dss/dss.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/video/fbdev/omap2/dss/dss.c b/drivers/video/fbdev/omap2/dss/dss.c
index 612b093831d5..9200a8668b49 100644
--- a/drivers/video/fbdev/omap2/dss/dss.c
+++ b/drivers/video/fbdev/omap2/dss/dss.c
@@ -1225,6 +1225,15 @@ static int dss_add_child_component(struct device *dev, void *data)
 {
 	struct component_match **match = data;
 
+	/*
+	 * HACK
+	 * We don't have a working driver for rfbi, so skip it here always.
+	 * Otherwise dss will never get probed successfully, as it will wait
+	 * for rfbi to get probed.
+	 */
+	if (strstr(dev_name(dev), "rfbi"))
+		return 0;
+
 	component_match_add(dev->parent, match, dss_component_compare, dev);
 
 	return 0;
-- 
2.1.4

