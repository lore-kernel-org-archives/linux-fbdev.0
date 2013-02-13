From: Archit Taneja <archit@ti.com>
Date: Wed, 13 Feb 2013 14:19:14 +0000
Subject: [PATCH 11/11] OMAPDSS: Remove max_backlight_level form omap_dss_device
Message-Id: <1360764434-18788-12-git-send-email-archit@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1360764434-18788-1-git-send-email-archit@ti.com>
In-Reply-To: <1360764434-18788-1-git-send-email-archit@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

The maximum backlight level supported is a parameter which should come from
the panel's platform data. Usage of max_backlight_level in omap_dss_device has
been removed from all panel drivers. Remove it from the omap_dss_device struct.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 include/video/omapdss.h |    2 --
 1 file changed, 2 deletions(-)

diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index ec68769..f0b65a5 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -631,8 +631,6 @@ struct omap_dss_device {
 
 	int reset_gpio;
 
-	int max_backlight_level;
-
 	const char *name;
 
 	/* used to match device to driver */
-- 
1.7.9.5

