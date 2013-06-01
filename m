From: Jingoo Han <jg1.han@samsung.com>
Date: Sat, 01 Jun 2013 07:31:21 +0000
Subject: [PATCH] video: replace strict_strtoul() with kstrtoul()
Message-Id: <001401ce5e9a$03b485e0$0b1d91a0$@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The usage of strict_strtoul() is not preferred, because
strict_strtoul() is obsolete. Thus, kstrtoul() should be
used.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/fsl-diu-fb.c                |    4 ++--
 drivers/video/omap2/displays/panel-taal.c |    6 +++---
 drivers/video/wm8505fb.c                  |    2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
index 6c27805..6dd7225 100644
--- a/drivers/video/fsl-diu-fb.c
+++ b/drivers/video/fsl-diu-fb.c
@@ -469,7 +469,7 @@ static enum fsl_diu_monitor_port fsl_diu_name_to_port(const char *s)
 	unsigned long val;
 
 	if (s) {
-		if (!strict_strtoul(s, 10, &val) && (val <= 2))
+		if (!kstrtoul(s, 10, &val) && (val <= 2))
 			port = (enum fsl_diu_monitor_port) val;
 		else if (strncmp(s, "lvds", 4) = 0)
 			port = FSL_DIU_PORT_LVDS;
@@ -1853,7 +1853,7 @@ static int __init fsl_diu_setup(char *options)
 		if (!strncmp(opt, "monitor=", 8)) {
 			monitor_port = fsl_diu_name_to_port(opt + 8);
 		} else if (!strncmp(opt, "bpp=", 4)) {
-			if (!strict_strtoul(opt + 4, 10, &val))
+			if (!kstrtoul(opt + 4, 10, &val))
 				default_bpp = val;
 		} else
 			fb_mode = opt;
diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index c4f78bd..52541f2 100644
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@ -573,7 +573,7 @@ static ssize_t taal_store_esd_interval(struct device *dev,
 	unsigned long t;
 	int r;
 
-	r = strict_strtoul(buf, 10, &t);
+	r = kstrtoul(buf, 10, &t);
 	if (r)
 		return r;
 
@@ -611,7 +611,7 @@ static ssize_t taal_store_ulps(struct device *dev,
 	unsigned long t;
 	int r;
 
-	r = strict_strtoul(buf, 10, &t);
+	r = kstrtoul(buf, 10, &t);
 	if (r)
 		return r;
 
@@ -660,7 +660,7 @@ static ssize_t taal_store_ulps_timeout(struct device *dev,
 	unsigned long t;
 	int r;
 
-	r = strict_strtoul(buf, 10, &t);
+	r = kstrtoul(buf, 10, &t);
 	if (r)
 		return r;
 
diff --git a/drivers/video/wm8505fb.c b/drivers/video/wm8505fb.c
index 01f9ace..3072f30 100644
--- a/drivers/video/wm8505fb.c
+++ b/drivers/video/wm8505fb.c
@@ -173,7 +173,7 @@ static ssize_t contrast_store(struct device *dev,
 	struct wm8505fb_info *fbi = to_wm8505fb_info(info);
 	unsigned long tmp;
 
-	if (strict_strtoul(buf, 10, &tmp) || (tmp > 0xff))
+	if (kstrtoul(buf, 10, &tmp) || (tmp > 0xff))
 		return -EINVAL;
 	fbi->contrast = tmp;
 
-- 
1.7.10.4


