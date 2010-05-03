From: Jani Nikula <ext-jani.1.nikula@nokia.com>
Date: Mon, 03 May 2010 06:18:23 +0000
Subject: [PATCH v2 03/21] OMAP: DSS2: Taal: Add locks to protect taal data access
Message-Id: <db2b972d4fa08c2f5b3cd06392ef62415890a188.1272621452.git.ext-jani.1.nikula@nokia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1272621452.git.ext-jani.1.nikula@nokia.com>
 <1ef57e99d69aaf89b8e61074aa8ce2e5f6632d28.1272621452.git.ext-jani.1.nikula@nokia.com>
 <c95257e8042f471c55a38133020d1d63e22161f3.1272621452.git.ext-jani.1.nikula@nokia.com>
In-Reply-To: <c95257e8042f471c55a38133020d1d63e22161f3.1272621452.git.ext-jani.1.nikula@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi.Valkeinen@nokia.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, ext-jani.1.nikula@nokia.com

From: Jani Nikula <ext-jani.1.nikula@nokia.com>

Avoid potential race conditions in sysfs access to taal data.

Signed-off-by: Jani Nikula <ext-jani.1.nikula@nokia.com>
---
 drivers/video/omap2/displays/panel-taal.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index 5f5afba..f542607 100644
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@ -364,6 +364,8 @@ static ssize_t taal_num_errors_show(struct device *dev,
 	u8 errors;
 	int r;
 
+	mutex_lock(&td->lock);
+
 	if (td->enabled) {
 		dsi_bus_lock();
 		r = taal_dcs_read_1(DCS_READ_NUM_ERRORS, &errors);
@@ -372,6 +374,8 @@ static ssize_t taal_num_errors_show(struct device *dev,
 		r = -ENODEV;
 	}
 
+	mutex_unlock(&td->lock);
+
 	if (r)
 		return r;
 
@@ -386,6 +390,8 @@ static ssize_t taal_hw_revision_show(struct device *dev,
 	u8 id1, id2, id3;
 	int r;
 
+	mutex_lock(&td->lock);
+
 	if (td->enabled) {
 		dsi_bus_lock();
 		r = taal_get_id(&id1, &id2, &id3);
@@ -394,6 +400,8 @@ static ssize_t taal_hw_revision_show(struct device *dev,
 		r = -ENODEV;
 	}
 
+	mutex_unlock(&td->lock);
+
 	if (r)
 		return r;
 
@@ -443,6 +451,8 @@ static ssize_t store_cabc_mode(struct device *dev,
 	if (i = ARRAY_SIZE(cabc_modes))
 		return -EINVAL;
 
+	mutex_lock(&td->lock);
+
 	if (td->enabled) {
 		dsi_bus_lock();
 		if (!td->cabc_broken)
@@ -452,6 +462,8 @@ static ssize_t store_cabc_mode(struct device *dev,
 
 	td->cabc_mode = i;
 
+	mutex_unlock(&td->lock);
+
 	return count;
 }
 
-- 
1.6.5.2

