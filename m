From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 09 Dec 2015 15:59:51 +0000
Subject: [PATCH 23/23] OMAPDSS: remove extra out == NULL checks
Message-Id: <1449676791-26304-24-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

All the output drivers check for 'out' being NULL, but it can never be
NULL. Remove the check.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/dpi.c   | 2 +-
 drivers/video/fbdev/omap2/dss/dsi.c   | 2 +-
 drivers/video/fbdev/omap2/dss/hdmi4.c | 2 +-
 drivers/video/fbdev/omap2/dss/hdmi5.c | 2 +-
 drivers/video/fbdev/omap2/dss/rfbi.c  | 2 +-
 drivers/video/fbdev/omap2/dss/sdi.c   | 2 +-
 drivers/video/fbdev/omap2/dss/venc.c  | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/dpi.c b/drivers/video/fbdev/omap2/dss/dpi.c
index fb45b6432968..7953e6a52346 100644
--- a/drivers/video/fbdev/omap2/dss/dpi.c
+++ b/drivers/video/fbdev/omap2/dss/dpi.c
@@ -395,7 +395,7 @@ static int dpi_display_enable(struct omap_dss_device *dssdev)
 		goto err_no_reg;
 	}
 
-	if (out = NULL || out->manager = NULL) {
+	if (out->manager = NULL) {
 		DSSERR("failed to enable display: no output/manager\n");
 		r = -ENODEV;
 		goto err_no_out_mgr;
diff --git a/drivers/video/fbdev/omap2/dss/dsi.c b/drivers/video/fbdev/omap2/dss/dsi.c
index b3606def5b7b..59065e18444d 100644
--- a/drivers/video/fbdev/omap2/dss/dsi.c
+++ b/drivers/video/fbdev/omap2/dss/dsi.c
@@ -3833,7 +3833,7 @@ static int dsi_enable_video_output(struct omap_dss_device *dssdev, int channel)
 	u16 word_count;
 	int r;
 
-	if (out = NULL || out->manager = NULL) {
+	if (out->manager = NULL) {
 		DSSERR("failed to enable display: no output/manager\n");
 		return -ENODEV;
 	}
diff --git a/drivers/video/fbdev/omap2/dss/hdmi4.c b/drivers/video/fbdev/omap2/dss/hdmi4.c
index 94c8d5549b4c..7103c659a534 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi4.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi4.c
@@ -343,7 +343,7 @@ static int hdmi_display_enable(struct omap_dss_device *dssdev)
 
 	mutex_lock(&hdmi.lock);
 
-	if (out = NULL || out->manager = NULL) {
+	if (out->manager = NULL) {
 		DSSERR("failed to enable display: no output/manager\n");
 		r = -ENODEV;
 		goto err0;
diff --git a/drivers/video/fbdev/omap2/dss/hdmi5.c b/drivers/video/fbdev/omap2/dss/hdmi5.c
index b59ba7902be1..a955a2c4c061 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi5.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi5.c
@@ -373,7 +373,7 @@ static int hdmi_display_enable(struct omap_dss_device *dssdev)
 
 	mutex_lock(&hdmi.lock);
 
-	if (out = NULL || out->manager = NULL) {
+	if (out->manager = NULL) {
 		DSSERR("failed to enable display: no output/manager\n");
 		r = -ENODEV;
 		goto err0;
diff --git a/drivers/video/fbdev/omap2/dss/rfbi.c b/drivers/video/fbdev/omap2/dss/rfbi.c
index 1525a494d057..aea6a1d0fb20 100644
--- a/drivers/video/fbdev/omap2/dss/rfbi.c
+++ b/drivers/video/fbdev/omap2/dss/rfbi.c
@@ -880,7 +880,7 @@ static int rfbi_display_enable(struct omap_dss_device *dssdev)
 	struct omap_dss_device *out = &rfbi.output;
 	int r;
 
-	if (out = NULL || out->manager = NULL) {
+	if (out->manager = NULL) {
 		DSSERR("failed to enable display: no output/manager\n");
 		return -ENODEV;
 	}
diff --git a/drivers/video/fbdev/omap2/dss/sdi.c b/drivers/video/fbdev/omap2/dss/sdi.c
index 5843580a1deb..d747cc6b59e1 100644
--- a/drivers/video/fbdev/omap2/dss/sdi.c
+++ b/drivers/video/fbdev/omap2/dss/sdi.c
@@ -136,7 +136,7 @@ static int sdi_display_enable(struct omap_dss_device *dssdev)
 	unsigned long pck;
 	int r;
 
-	if (out = NULL || out->manager = NULL) {
+	if (out->manager = NULL) {
 		DSSERR("failed to enable display: no output/manager\n");
 		return -ENODEV;
 	}
diff --git a/drivers/video/fbdev/omap2/dss/venc.c b/drivers/video/fbdev/omap2/dss/venc.c
index 99ca268c1cdd..c9260a451ca6 100644
--- a/drivers/video/fbdev/omap2/dss/venc.c
+++ b/drivers/video/fbdev/omap2/dss/venc.c
@@ -503,7 +503,7 @@ static int venc_display_enable(struct omap_dss_device *dssdev)
 
 	mutex_lock(&venc.venc_lock);
 
-	if (out = NULL || out->manager = NULL) {
+	if (out->manager = NULL) {
 		DSSERR("Failed to enable display: no output/manager\n");
 		r = -ENODEV;
 		goto err0;
-- 
2.5.0

