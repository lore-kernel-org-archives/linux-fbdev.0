From: =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Date: Fri, 20 May 2016 13:34:54 +0000
Subject: [PATCH 3/3] drm/imx: remove dead code
Message-Id: <1463751294-24769-4-git-send-email-LW@KARO-electronics.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1463751294-24769-1-git-send-email-LW@KARO-electronics.de>
In-Reply-To: <1463751294-24769-1-git-send-email-LW@KARO-electronics.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: David Airlie <airlied@linux.ie>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Philipp Zabel <p.zabel@pengutronix.de>, Tomi Valkeinen <tomi.valkeinen@ti.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Russell King - ARM Linux <linux@armlinux.org.uk>, Sascha Hauer <kernel@pengutronix.de>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>

The 'mode_valid' flag is never set in this driver. Remove it and the
code that depends on it.

Signed-off-by: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>
---
 drivers/gpu/drm/imx/parallel-display.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/gpu/drm/imx/parallel-display.c b/drivers/gpu/drm/imx/p=
arallel-display.c
index 440f34d..e37d0e6 100644
--- a/drivers/gpu/drm/imx/parallel-display.c
+++ b/drivers/gpu/drm/imx/parallel-display.c
@@ -39,7 +39,6 @@ struct imx_parallel_display {
 	int edid_len;
 	u32 bus_format;
 	u32 bus_flags;
-	int mode_valid;
 	struct drm_display_mode mode;
 	struct drm_panel *panel;
 };
@@ -74,17 +73,6 @@ static int imx_pd_connector_get_modes(struct drm_connect=
or *connector)
 		num_modes =3D drm_add_edid_modes(connector, imxpd->edid);
 	}
=20
-	if (imxpd->mode_valid) {
-		struct drm_display_mode *mode =3D drm_mode_create(connector->dev);
-
-		if (!mode)
-			return -EINVAL;
-		drm_mode_copy(mode, &imxpd->mode);
-		mode->type |=3D DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
-		drm_mode_probed_add(connector, mode);
-		num_modes++;
-	}
-
 	if (np) {
 		struct drm_display_mode *mode =3D drm_mode_create(connector->dev);
 		struct videomode vm;
--=20
2.1.4

