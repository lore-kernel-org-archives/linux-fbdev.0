From: Boris BREZILLON <boris.brezillon@free-electrons.com>
Date: Fri, 09 May 2014 13:53:12 +0000
Subject: [PATCH] video: of: display_timing: fix default native-mode setting
Message-Id: <1399643592-17125-1-git-send-email-boris.brezillon@free-electrons.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Boris BREZILLON <boris.brezillon@free-electrons.com>

Set native mode to the first child node of the display-timings node and not
the first child node of the display-timings parent node.

Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
---
 drivers/video/of_display_timing.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/of_display_timing.c b/drivers/video/of_display_timing.c
index ba5b40f..19dd752 100644
--- a/drivers/video/of_display_timing.c
+++ b/drivers/video/of_display_timing.c
@@ -164,7 +164,7 @@ struct display_timings *of_get_display_timings(struct device_node *np)
 	entry = of_parse_phandle(timings_np, "native-mode", 0);
 	/* assume first child as native mode if none provided */
 	if (!entry)
-		entry = of_get_next_child(np, NULL);
+		entry = of_get_next_child(timings_np, NULL);
 	/* if there is no child, it is useless to go on */
 	if (!entry) {
 		pr_err("%s: no timing specifications given\n",
-- 
1.8.3.2

