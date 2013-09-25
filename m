From: Andrzej Hajda <a.hajda@samsung.com>
Date: Wed, 25 Sep 2013 11:51:31 +0000
Subject: [PATCH 1/2] video: of: display_timing: correct display-timings node finding
Message-Id: <1380109892-13040-2-git-send-email-a.hajda@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1380109892-13040-1-git-send-email-a.hajda@samsung.com>
In-Reply-To: <1380109892-13040-1-git-send-email-a.hajda@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>
Cc: Andrzej Hajda <a.hajda@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, dri-devel@lists.freedesktop.org

of_get_display_timing(s) use of_find_node_by_name
to get child node, this is incorrect, of_get_child_by_name
should be used instead. The patch fixes it.
Small typo is also corrected.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/video/of_display_timing.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/of_display_timing.c b/drivers/video/of_display_timing.c
index 171821d..ba5b40f 100644
--- a/drivers/video/of_display_timing.c
+++ b/drivers/video/of_display_timing.c
@@ -120,7 +120,7 @@ int of_get_display_timing(struct device_node *np, const char *name,
 		return -EINVAL;
 	}
 
-	timing_np = of_find_node_by_name(np, name);
+	timing_np = of_get_child_by_name(np, name);
 	if (!timing_np) {
 		pr_err("%s: could not find node '%s'\n",
 			of_node_full_name(np), name);
@@ -143,11 +143,11 @@ struct display_timings *of_get_display_timings(struct device_node *np)
 	struct display_timings *disp;
 
 	if (!np) {
-		pr_err("%s: no devicenode given\n", of_node_full_name(np));
+		pr_err("%s: no device node given\n", of_node_full_name(np));
 		return NULL;
 	}
 
-	timings_np = of_find_node_by_name(np, "display-timings");
+	timings_np = of_get_child_by_name(np, "display-timings");
 	if (!timings_np) {
 		pr_err("%s: could not find display-timings node\n",
 			of_node_full_name(np));
-- 
1.8.1.2

