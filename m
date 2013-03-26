From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 26 Mar 2013 13:33:50 +0000
Subject: [PATCH 20/26] OMAPDSS: Taal platform_data changes
Message-Id: <1364304836-18134-21-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1364304836-18134-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1364304836-18134-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

The forthcoming omap_dss_device to platform_device conversion requires a
few new fields to the Taal platform data. Add the platform data fields
here so that we can make the board file changes independently of the
panel driver changes.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 include/video/omap-panel-nokia-dsi.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/include/video/omap-panel-nokia-dsi.h b/include/video/omap-panel-nokia-dsi.h
index 04219a2..8892da7 100644
--- a/include/video/omap-panel-nokia-dsi.h
+++ b/include/video/omap-panel-nokia-dsi.h
@@ -15,6 +15,7 @@ struct omap_dss_device;
  */
 struct nokia_dsi_panel_data {
 	const char *name;
+	const char *source;
 
 	int reset_gpio;
 
-- 
1.7.10.4

