From: Lucas Stach <l.stach@pengutronix.de>
Date: Tue, 13 May 2014 12:58:21 +0000
Subject: [PATCH] video: of: display_timing: remove two unsafe error messages
Message-Id: <1399985901-30756-1-git-send-email-l.stach@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The error message would try to dereference the pointer that
just has been tested to be NULL. As those messages don't
really add any value without the info that the np could
provide, just remove them.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/video/of_display_timing.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/video/of_display_timing.c b/drivers/video/of_display_timing.c
index ba5b40f581f6..3dc93cfacd47 100644
--- a/drivers/video/of_display_timing.c
+++ b/drivers/video/of_display_timing.c
@@ -115,10 +115,8 @@ int of_get_display_timing(struct device_node *np, const char *name,
 {
 	struct device_node *timing_np;
 
-	if (!np) {
-		pr_err("%s: no devicenode given\n", of_node_full_name(np));
+	if (!np)
 		return -EINVAL;
-	}
 
 	timing_np = of_get_child_by_name(np, name);
 	if (!timing_np) {
@@ -142,10 +140,8 @@ struct display_timings *of_get_display_timings(struct device_node *np)
 	struct device_node *native_mode;
 	struct display_timings *disp;
 
-	if (!np) {
-		pr_err("%s: no device node given\n", of_node_full_name(np));
+	if (!np)
 		return NULL;
-	}
 
 	timings_np = of_get_child_by_name(np, "display-timings");
 	if (!timings_np) {
-- 
2.0.0.rc0

