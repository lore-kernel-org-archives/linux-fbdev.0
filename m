From: Jyri Sarha <jsarha@ti.com>
Date: Thu, 06 Aug 2015 18:41:25 +0000
Subject: [PATCH 2/2] OMAPDSS: of-dss: omap_dss_find_output_by_port_node() keep port refcount
Message-Id: <1f1f0438904af54bcaadd6e1796dad06e7001172.1438885638.git.jsarha@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The only user of dss_of_port_get_parent_device() function is
omap_dss_find_output_by_port_node() and it assumes the refcount of the
port parameter is not decremented by the call.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 drivers/video/fbdev/omap2/dss/dss-of.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/omap2/dss/dss-of.c b/drivers/video/fbdev/omap2/dss/dss-of.c
index ab6ef16..43f999d 100644
--- a/drivers/video/fbdev/omap2/dss/dss-of.c
+++ b/drivers/video/fbdev/omap2/dss/dss-of.c
@@ -95,7 +95,7 @@ struct device_node *dss_of_port_get_parent_device(struct device_node *port)
 	if (!port)
 		return NULL;
 
-	np = of_get_next_parent(port);
+	np = of_get_parent(port);
 
 	for (i = 0; i < 2 && np; ++i) {
 		struct property *prop;
-- 
1.9.1

