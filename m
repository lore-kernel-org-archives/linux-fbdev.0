From: Leonard Crestez <leonard.crestez@nxp.com>
Date: Fri, 15 Jun 2018 19:43:42 +0000
Subject: [PATCH 1/3] drm: mxsfb: Change driver.name to mxsfb-drm
Message-Id: <47ea7572011735b68a8a70f0e11bdf00cb2fd86a.1529091248.git.leonard.crestez@nxp.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1529091248.git.leonard.crestez@nxp.com>
In-Reply-To: <cover.1529091248.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Fabio Estevam <fabio.estevam@nxp.com>, Lucas Stach <l.stach@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>, NXP Linux Team <linux-imx@nxp.com>, Marco Franchi <marcofrk@gmail.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

The FBDEV driver uses the same name and both can't be registered at the
same time. Fix this by renaming the drm driver to mxsfb-drm

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/gpu/drm/mxsfb/mxsfb_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
index ffe5137ccaf8..dd1dd58e4956 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
@@ -417,11 +417,11 @@ static int mxsfb_remove(struct platform_device *pdev)
 static struct platform_driver mxsfb_platform_driver = {
 	.probe		= mxsfb_probe,
 	.remove		= mxsfb_remove,
 	.id_table	= mxsfb_devtype,
 	.driver	= {
-		.name		= "mxsfb",
+		.name		= "mxsfb-drm",
 		.of_match_table	= mxsfb_dt_ids,
 	},
 };
 
 module_platform_driver(mxsfb_platform_driver);
-- 
2.17.1

