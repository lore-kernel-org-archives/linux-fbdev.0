From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 16 May 2013 13:00:01 +0000
Subject: [PATCH 1/2] videomode: don't allocate mem in of_get_display_timing()
Message-Id: <1368709202-1056-1-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Steffen Trumtrar <s.trumtrar@pengutronix.de>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Move the allocation of display_timing memory from of_get_display_timing() to
of_get_display_timings(). This allows us to use of_get_display_timing()
in a way that doesn't require dynamic memory allocation.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/video/of_display_timing.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/video/of_display_timing.c b/drivers/video/of_display_timing.c
index 56009bc..0e81023 100644
--- a/drivers/video/of_display_timing.c
+++ b/drivers/video/of_display_timing.c
@@ -56,18 +56,13 @@ static int parse_timing_property(struct device_node *np, const char *name,
  * of_get_display_timing - parse display_timing entry from device_node
  * @np: device_node with the properties
  **/
-static struct display_timing *of_get_display_timing(struct device_node *np)
+static int of_get_display_timing(struct device_node *np,
+		struct display_timing *dt)
 {
-	struct display_timing *dt;
 	u32 val = 0;
 	int ret = 0;
 
-	dt = kzalloc(sizeof(*dt), GFP_KERNEL);
-	if (!dt) {
-		pr_err("%s: could not allocate display_timing struct\n",
-			of_node_full_name(np));
-		return NULL;
-	}
+	memset(dt, 0, sizeof(*dt));
 
 	ret |= parse_timing_property(np, "hback-porch", &dt->hback_porch);
 	ret |= parse_timing_property(np, "hfront-porch", &dt->hfront_porch);
@@ -101,11 +96,10 @@ static struct display_timing *of_get_display_timing(struct device_node *np)
 	if (ret) {
 		pr_err("%s: error reading timing properties\n",
 			of_node_full_name(np));
-		kfree(dt);
-		return NULL;
+		return -EINVAL;
 	}
 
-	return dt;
+	return 0;
 }
 
 /**
@@ -174,9 +168,17 @@ struct display_timings *of_get_display_timings(struct device_node *np)
 
 	for_each_child_of_node(timings_np, entry) {
 		struct display_timing *dt;
+		int r;
 
-		dt = of_get_display_timing(entry);
+		dt = kzalloc(sizeof(*dt), GFP_KERNEL);
 		if (!dt) {
+			pr_err("%s: could not allocate display_timing struct\n",
+					of_node_full_name(np));
+			goto timingfail;
+		}
+
+		r = of_get_display_timing(entry, dt);
+		if (r) {
 			/*
 			 * to not encourage wrong devicetrees, fail in case of
 			 * an error
-- 
1.8.1.2

