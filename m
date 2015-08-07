From: Jyri Sarha <jsarha@ti.com>
Date: Fri, 07 Aug 2015 11:04:29 +0000
Subject: [PATCH v2 1/2] OMAPDSS: Fix node refcount leak in omapdss_of_get_next_port()
Message-Id: <24a6d770f75b3a351a37c60af92d57bea44b6390.1438945255.git.jsarha@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Fix node refcount leak in omapdss_of_get_next_port().

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

