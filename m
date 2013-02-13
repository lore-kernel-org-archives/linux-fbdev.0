From: Archit Taneja <archit@ti.com>
Date: Wed, 13 Feb 2013 14:34:23 +0000
Subject: [PATCH 31/33] OMAPDSS: remove platform_enable/disable callbacks from omap_dss_device
Message-Id: <1360765345-19312-32-git-send-email-archit@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1360765345-19312-1-git-send-email-archit@ti.com>
In-Reply-To: <1360765345-19312-1-git-send-email-archit@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

None of the omapdss panel drivers call platform_enable/disable callbacks, and
none of the omap board files define these callbacks for any omap_dss_device.
Hence these callbacks can be removed form the omap_dss_device struct.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 include/video/omapdss.h |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index f0b65a5..e1ebb48 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -650,10 +650,6 @@ struct omap_dss_device {
 	enum omap_dss_display_state state;
 
 	enum omap_dss_audio_state audio_state;
-
-	/* platform specific  */
-	int (*platform_enable)(struct omap_dss_device *dssdev);
-	void (*platform_disable)(struct omap_dss_device *dssdev);
 };
 
 struct omap_dss_hdmi_data
-- 
1.7.9.5

