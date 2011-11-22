From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 22 Nov 2011 09:21:15 +0000
Subject: [PATCH 16/65] OMAPDSS: remove unneeded dss_ovl_wait_for_go()
Message-Id: <1321953724-6350-17-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

There's an unnecessary wrapper function, dss_ovl_wait_for_go(), which
does nothing else than call dss_mgr_wait_for_go_ovl(). The
dss_ovl_wait_for_go() function can be removed.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/overlay.c |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/drivers/video/omap2/dss/overlay.c b/drivers/video/omap2/dss/overlay.c
index d15b826..0ab14fa 100644
--- a/drivers/video/omap2/dss/overlay.c
+++ b/drivers/video/omap2/dss/overlay.c
@@ -548,11 +548,6 @@ static void dss_ovl_get_overlay_info(struct omap_overlay *ovl,
 	*info = ovl->info;
 }
 
-static int dss_ovl_wait_for_go(struct omap_overlay *ovl)
-{
-	return dss_mgr_wait_for_go_ovl(ovl);
-}
-
 static int omap_dss_set_manager(struct omap_overlay *ovl,
 		struct omap_overlay_manager *mgr)
 {
@@ -689,7 +684,7 @@ void dss_init_overlays(struct platform_device *pdev)
 		ovl->unset_manager = &omap_dss_unset_manager;
 		ovl->set_overlay_info = &dss_ovl_set_overlay_info;
 		ovl->get_overlay_info = &dss_ovl_get_overlay_info;
-		ovl->wait_for_go = &dss_ovl_wait_for_go;
+		ovl->wait_for_go = &dss_mgr_wait_for_go_ovl;
 
 		ovl->caps = dss_feat_get_overlay_caps(ovl->id);
 		ovl->supported_modes -- 
1.7.4.1

