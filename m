From: Leonard Crestez <leonard.crestez@nxp.com>
Date: Fri, 15 Jun 2018 19:43:43 +0000
Subject: [PATCH 2/3] fbdev: mxsfb: Return ENODEV on missing display node
Message-Id: <31ca6156a1b36c8ca2811d60e28c6128e988d5d4.1529091248.git.leonard.crestez@nxp.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1529091248.git.leonard.crestez@nxp.com>
In-Reply-To: <cover.1529091248.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Fabio Estevam <fabio.estevam@nxp.com>, Lucas Stach <l.stach@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>, NXP Linux Team <linux-imx@nxp.com>, Marco Franchi <marcofrk@gmail.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

When this driver encounters drm-style bindings it returns -ENOENT and
this reports a probe error. Make it return -ENODEV to signal an explicit
rejection instead.

This allows peaceful coexistence between the DRM_MXSFB and FB_MXS config
options.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/video/fbdev/mxsfb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/mxsfb.c b/drivers/video/fbdev/mxsfb.c
index 12c8bd1d24d5..9ec8882d7b3d 100644
--- a/drivers/video/fbdev/mxsfb.c
+++ b/drivers/video/fbdev/mxsfb.c
@@ -736,11 +736,11 @@ static int mxsfb_init_fbinfo_dt(struct fb_info *fb_info,
 	int ret;
 
 	display_np = of_parse_phandle(np, "display", 0);
 	if (!display_np) {
 		dev_err(dev, "failed to find display phandle\n");
-		return -ENOENT;
+		return -ENODEV;
 	}
 
 	ret = of_property_read_u32(display_np, "bus-width", &width);
 	if (ret < 0) {
 		dev_err(dev, "failed to get property bus-width\n");
-- 
2.17.1

