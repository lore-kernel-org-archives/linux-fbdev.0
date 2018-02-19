From: Vladimir Zapolskiy <vz@mleia.com>
Date: Mon, 19 Feb 2018 21:47:36 +0000
Subject: [PATCH] video: of: display_timing: Remove of_display_timings_exist() function
Message-Id: <20180219214736.9447-1-vz@mleia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1399985901-30756-1-git-send-email-l.stach@pengutronix.de>
In-Reply-To: <1399985901-30756-1-git-send-email-l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

Since introduction of of_display_timings_exist() function in commit
cc3f414cf2e40 ("video: add of helper for display timings/videomode") it
didn't attract any users, and the function has no potential, because
of_get_display_timings() covers its functionality and does more.

Drop the unused exported function from the kernel.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 drivers/video/of_display_timing.c | 20 --------------------
 include/video/of_display_timing.h |  5 -----
 2 files changed, 25 deletions(-)

diff --git a/drivers/video/of_display_timing.c b/drivers/video/of_display_timing.c
index 8ce0a99..83b8963 100644
--- a/drivers/video/of_display_timing.c
+++ b/drivers/video/of_display_timing.c
@@ -244,23 +244,3 @@ struct display_timings *of_get_display_timings(const struct device_node *np)
 	return NULL;
 }
 EXPORT_SYMBOL_GPL(of_get_display_timings);
-
-/**
- * of_display_timings_exist - check if a display-timings node is provided
- * @np: device_node with the timing
- **/
-int of_display_timings_exist(const struct device_node *np)
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
index 956455f..bb29e59 100644
--- a/include/video/of_display_timing.h
+++ b/include/video/of_display_timing.h
@@ -19,7 +19,6 @@ struct display_timings;
 int of_get_display_timing(const struct device_node *np, const char *name,
 		struct display_timing *dt);
 struct display_timings *of_get_display_timings(const struct device_node *np);
-int of_display_timings_exist(const struct device_node *np);
 #else
 static inline int of_get_display_timing(const struct device_node *np,
 		const char *name, struct display_timing *dt)
@@ -31,10 +30,6 @@ of_get_display_timings(const struct device_node *np)
 {
 	return NULL;
 }
-static inline int of_display_timings_exist(const struct device_node *np)
-{
-	return -ENOSYS;
-}
 #endif
 
 #endif
-- 
2.10.2

