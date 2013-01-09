From: Marek Vasut <marex@denx.de>
Date: Wed, 09 Jan 2013 19:12:01 +0000
Subject: Re: [PATCHv16 0/7] of: add display helper
Message-Id: <201301092012.01985.marex@denx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1355850256-16135-1-git-send-email-s.trumtrar@pengutronix.de>
In-Reply-To: <1355850256-16135-1-git-send-email-s.trumtrar@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: devicetree-discuss@lists.ozlabs.org, Rob Herring <robherring2@gmail.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Thierry Reding <thierry.reding@avionic-design.de>, Guennady Liakhovetski <g.liakhovetski@gmx.de>, linux-media@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Stephen Warren <swarren@wwwdotorg.org>, kernel@pengutronix.de, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, David Airlie <airlied@linux.ie>, Rob Clark <robdclark@gmail.com>, Leela Krishna Amudala <leelakrishna.a@gmail.com>

Dear Steffen Trumtrar,

> Hi!
> 
> Finally, right in time before the end of the world on friday, v16 of the
> display helpers.

I tested this on 3.8-rc1 (next 20130103) with the imx drm driver. After adding 
the following piece of code (quick hack), this works just fine. Thanks!

diff --git a/drivers/staging/imx-drm/parallel-display.c b/drivers/staging/imx-
drm/parallel-display.c
index a8064fc..e45002a 100644
--- a/drivers/staging/imx-drm/parallel-display.c
+++ b/drivers/staging/imx-drm/parallel-display.c
@@ -57,6 +57,7 @@ static void imx_pd_connector_destroy(struct drm_connector 
*connector)
 static int imx_pd_connector_get_modes(struct drm_connector *connector)
 {
        struct imx_parallel_display *imxpd = con_to_imxpd(connector);
+       struct device_node *np = imxpd->dev->of_node;
        int num_modes = 0;
 
        if (imxpd->edid) {
@@ -72,6 +73,15 @@ static int imx_pd_connector_get_modes(struct drm_connector 
*connector)
                num_modes++;
        }
 
+       if (np) {
+               struct drm_display_mode *mode = drm_mode_create(connector->dev);
+               of_get_drm_display_mode(np, &imxpd->mode, 0);
+               drm_mode_copy(mode, &imxpd->mode);
+               mode->type |= DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
+               drm_mode_probed_add(connector, mode);
+               num_modes++;
+       }
+
        return num_modes;
 }

Best regards,
Marek Vasut
