From: Archit Taneja <archit@ti.com>
Date: Wed, 13 Feb 2013 14:19:08 +0000
Subject: [PATCH 05/11] OMAPDSS: remove set_backlight/get_backlight function ptrs
Message-Id: <1360764434-18788-6-git-send-email-archit@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1360764434-18788-1-git-send-email-archit@ti.com>
In-Reply-To: <1360764434-18788-1-git-send-email-archit@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

From: Tomi Valkeinen <tomi.valkeinen@ti.com>

Now that no board nor panel is using set_backlight and get_backlight
functions, we can remove them from omapdss.h.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Archit Taneja <archit@ti.com>
---
 include/video/omapdss.h |    2 --
 1 file changed, 2 deletions(-)

diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index caefa09..d5dcd50 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -659,8 +659,6 @@ struct omap_dss_device {
 	/* platform specific  */
 	int (*platform_enable)(struct omap_dss_device *dssdev);
 	void (*platform_disable)(struct omap_dss_device *dssdev);
-	int (*set_backlight)(struct omap_dss_device *dssdev, int level);
-	int (*get_backlight)(struct omap_dss_device *dssdev);
 };
 
 struct omap_dss_hdmi_data
-- 
1.7.9.5

