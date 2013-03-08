From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 08 Mar 2013 11:52:49 +0000
Subject: [PATCH 14/14] OMAPDSS: remove dsi videomode from dssdev
Message-Id: <1362743569-10289-15-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1362743569-10289-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1362743569-10289-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

DSI videomode is no longer needed in the omap_dss_device, so remove it.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 include/video/omapdss.h |    1 -
 1 file changed, 1 deletion(-)

diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index cbaf60f..8979086 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -631,7 +631,6 @@ struct omap_dss_device {
 
 		enum omap_dss_dsi_pixel_format dsi_pix_fmt;
 		enum omap_dss_dsi_mode dsi_mode;
-		struct omap_dss_dsi_videomode_timings dsi_vm_timings;
 	} panel;
 
 	struct {
-- 
1.7.10.4

