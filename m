From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 10 Dec 2015 14:25:29 +0000
Subject: [PATCH RFC 3/9] omapdss: remove CONFIG_OMAP2_DSS_VENC from omapdss.h
Message-Id: <1449757535-5674-4-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1449757535-5674-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1449757535-5674-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

We are about to make a private copy of omapdss for omapfb and for
omapdrm. The omapdss.h file will still be shared for the time being. The
copy will need to change the config symbols, and we happen to have one
use of these config symbols in omapdss.h which needs to be removed.

Luckily we can just delete the use of CONFIG_OMAP2_DSS_VENC from
omapdss, as it's used only to hide extern declarations, and there's no
harm to have those declarations even if CONFIG_OMAP2_DSS_VENC is not
set.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 include/video/omapdss.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index f001a356fd98..67f0d67001dc 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -367,14 +367,12 @@ struct omap_video_timings {
 	enum omap_dss_signal_edge sync_pclk_edge;
 };
 
-#ifdef CONFIG_OMAP2_DSS_VENC
 /* Hardcoded timings for tv modes. Venc only uses these to
  * identify the mode, and does not actually use the configs
  * itself. However, the configs should be something that
  * a normal monitor can also show */
 extern const struct omap_video_timings omap_dss_pal_timings;
 extern const struct omap_video_timings omap_dss_ntsc_timings;
-#endif
 
 struct omap_dss_cpr_coefs {
 	s16 rr, rg, rb;
-- 
2.5.0

