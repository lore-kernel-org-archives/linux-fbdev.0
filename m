From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 28 Jun 2017 00:28:07 +0000
Subject: [PATCH 3/3] omapfb: use of_graph_get_remote_endpoint()
Message-Id: <87injhez1k.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <87mv8tez69.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87mv8tez69.wl%kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Now, we can use of_graph_get_remote_endpoint(). Let's use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
based on 4c9c3d595f1bad021cc126d20879df4016801736
("of_graph: add of_graph_get_remote_endpoint()")

 drivers/video/fbdev/omap2/omapfb/dss/dss-of.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dss-of.c b/drivers/video/fbdev/omap2/omapfb/dss/dss-of.c
index d356a25..f1eb8b0 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/dss-of.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/dss-of.c
@@ -16,6 +16,7 @@
 #include <linux/err.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_graph.h>
 #include <linux/seq_file.h>
 
 #include <video/omapfb_dss.h>
@@ -128,7 +129,7 @@ static struct device_node *omapdss_of_get_remote_port(const struct device_node *
 {
 	struct device_node *np;
 
-	np = of_parse_phandle(node, "remote-endpoint", 0);
+	np = of_graph_get_remote_endpoint(node);
 	if (!np)
 		return NULL;
 
-- 
1.9.1

