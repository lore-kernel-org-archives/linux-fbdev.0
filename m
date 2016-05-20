From: =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Date: Fri, 20 May 2016 13:34:52 +0000
Subject: [PATCH 1/3] drm/imx: imx-ldb: honor 'native-mode' property when selecting video mode from DT
Message-Id: <1463751294-24769-2-git-send-email-LW@KARO-electronics.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1463751294-24769-1-git-send-email-LW@KARO-electronics.de>
In-Reply-To: <1463751294-24769-1-git-send-email-LW@KARO-electronics.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: David Airlie <airlied@linux.ie>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Philipp Zabel <p.zabel@pengutronix.de>, Tomi Valkeinen <tomi.valkeinen@ti.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Russell King - ARM Linux <linux@armlinux.org.uk>, Sascha Hauer <kernel@pengutronix.de>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>

This patch allows to select a specific video mode from a list of modes
defined in DT by setting the 'native-mode' property appropriately.

This change does not affect the behaviour of existing platforms, since
they either:
   - have just one display-timings subnode
   - have the native-mode property pointing to the first entry
   - let the bootloader select the appropriate timing

Signed-off-by: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>
---
 drivers/gpu/drm/imx/imx-ldb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/imx/imx-ldb.c b/drivers/gpu/drm/imx/imx-ldb.c
index a58eee5..b2dc4df 100644
--- a/drivers/gpu/drm/imx/imx-ldb.c
+++ b/drivers/gpu/drm/imx/imx-ldb.c
@@ -25,6 +25,7 @@
 #include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>
 #include <linux/of_device.h>
 #include <linux/of_graph.h>
+#include <video/of_display_timing.h>
 #include <video/of_videomode.h>
 #include <linux/regmap.h>
 #include <linux/videodev2.h>
@@ -600,7 +601,8 @@ static int imx_ldb_bind(struct device *dev, struct devi=
ce *master, void *data)
 			channel->edid =3D kmemdup(edidp, channel->edid_len,
 						GFP_KERNEL);
 		} else if (!channel->panel) {
-			ret =3D of_get_drm_display_mode(child, &channel->mode, 0);
+			ret =3D of_get_drm_display_mode(child, &channel->mode,
+						OF_USE_NATIVE_MODE);
 			if (!ret)
 				channel->mode_valid =3D 1;
 		}
--=20
2.1.4

