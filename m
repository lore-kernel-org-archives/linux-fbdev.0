From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Fri, 09 Jun 2017 12:07:13 +0000
Subject: [PATCH v1] omapfb: Use sysfs_match_string() helper
Message-Id: <20170609120713.21861-1-andriy.shevchenko@linux.intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Use sysfs_match_string() helper instead of open coded variant.

Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/video/fbdev/omap2/omapfb/dss/manager-sysfs.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/dss/manager-sysfs.c b/drivers/video/fbdev/omap2/omapfb/dss/manager-sysfs.c
index 9e2a67fdf4d2..44b96af4ef4e 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/manager-sysfs.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/manager-sysfs.c
@@ -182,22 +182,16 @@ static ssize_t manager_trans_key_type_show(struct omap_overlay_manager *mgr,
 static ssize_t manager_trans_key_type_store(struct omap_overlay_manager *mgr,
 					    const char *buf, size_t size)
 {
-	enum omap_dss_trans_key_type key_type;
 	struct omap_overlay_manager_info info;
 	int r;
 
-	for (key_type = OMAP_DSS_COLOR_KEY_GFX_DST;
-			key_type < ARRAY_SIZE(trans_key_type_str); key_type++) {
-		if (sysfs_streq(buf, trans_key_type_str[key_type]))
-			break;
-	}
-
-	if (key_type = ARRAY_SIZE(trans_key_type_str))
-		return -EINVAL;
+	r = sysfs_match_string(trans_key_type_str, buf);
+	if (r < 0)
+		return r;
 
 	mgr->get_manager_info(mgr, &info);
 
-	info.trans_key_type = key_type;
+	info.trans_key_type = r;
 
 	r = mgr->set_manager_info(mgr, &info);
 	if (r)
-- 
2.11.0

