From: Jyri Sarha <jsarha@ti.com>
Date: Thu, 06 Aug 2015 18:41:24 +0000
Subject: [PATCH 1/2] OMAPDSS: dss-of: Fix node refcount leak in omapdss_of_get_next_port()
Message-Id: <2641bae47b15795f2a697e69c72ad1b7424d2178.1438885638.git.jsarha@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 drivers/video/fbdev/omap2/dss/dss-of.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/omap2/dss/dss-of.c b/drivers/video/fbdev/omap2/dss/dss-of.c
index 928ee63..ab6ef16 100644
--- a/drivers/video/fbdev/omap2/dss/dss-of.c
+++ b/drivers/video/fbdev/omap2/dss/dss-of.c
@@ -60,6 +60,7 @@ omapdss_of_get_next_port(const struct device_node *parent,
 			}
 			prev = port;
 		} while (of_node_cmp(port->name, "port") != 0);
+		of_node_put(ports);
 	}
 
 	return port;
-- 
1.9.1

