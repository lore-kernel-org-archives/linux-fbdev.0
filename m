From: Andrzej Hajda <a.hajda@samsung.com>
Date: Wed, 25 Sep 2013 11:51:32 +0000
Subject: [PATCH 2/2] video: of: display_timing: remove broken of_display_timings_exist
Message-Id: <1380109892-13040-3-git-send-email-a.hajda@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1380109892-13040-1-git-send-email-a.hajda@samsung.com>
In-Reply-To: <1380109892-13040-1-git-send-email-a.hajda@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>
Cc: Andrzej Hajda <a.hajda@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, dri-devel@lists.freedesktop.org

of_display_timings_exist is implemented incorrectly.
It tries to find property instead of node.
The function is not used anyway so the patch removes it.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/video/of_display_timing.c | 20 --------------------
 include/video/of_display_timing.h |  1 -
 2 files changed, 21 deletions(-)

diff --git a/drivers/video/of_display_timing.c b/drivers/video/of_display_timing.c
index ba5b40f..b423bb9 100644
--- a/drivers/video/of_display_timing.c
+++ b/drivers/video/of_display_timing.c
@@ -247,23 +247,3 @@ dispfail:
 	return NULL;
 }
 EXPORT_SYMBOL_GPL(of_get_display_timings);
-
-/**
- * of_display_timings_exist - check if a display-timings node is provided
- * @np: device_node with the timing
- **/
-int of_display_timings_exist(struct device_node *np)
-{
-	struct device_node *timings_np;
-
-	if (!np)
-		return -EINVAL;
-
-	timings_np = of_parse_phandle(np, "display-timings", 0);
-	if (!timings_np)
-		return -EINVAL;
-
-	of_node_put(timings_np);
-	return 1;
-}
-EXPORT_SYMBOL_GPL(of_display_timings_exist);
diff --git a/include/video/of_display_timing.h b/include/video/of_display_timing.h
index 79e6697..16cde75 100644
--- a/include/video/of_display_timing.h
+++ b/include/video/of_display_timing.h
@@ -18,6 +18,5 @@ struct display_timings;
 int of_get_display_timing(struct device_node *np, const char *name,
 		struct display_timing *dt);
 struct display_timings *of_get_display_timings(struct device_node *np);
-int of_display_timings_exist(struct device_node *np);
 
 #endif
-- 
1.8.1.2

