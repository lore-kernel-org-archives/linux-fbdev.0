From: Leonard Crestez <leonard.crestez@nxp.com>
Date: Fri, 15 Jun 2018 19:43:44 +0000
Subject: [PATCH 3/3] ARM: imx_v6_v7_defconfig: Enable DRM_MXSFB
Message-Id: <e7e902fd04097a4a5c15440a63d0acc87e28e37f.1529091248.git.leonard.crestez@nxp.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1529091248.git.leonard.crestez@nxp.com>
In-Reply-To: <cover.1529091248.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Fabio Estevam <fabio.estevam@nxp.com>, Lucas Stach <l.stach@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>, NXP Linux Team <linux-imx@nxp.com>, Marco Franchi <marcofrk@gmail.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

Multiple boards have drm-style bindings on imx lcdif nodes, enable the
driver so that they work by default.

Also enable DRM_PANEL_SEIKO_43WVF1G, it is one of the supported display
attachments for imx development boards.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index f70507ab91ee..dd0f64da2243 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -256,18 +256,20 @@ CONFIG_VIDEO_ADV7180=m
 CONFIG_VIDEO_OV5640=m
 CONFIG_IMX_IPUV3_CORE=y
 CONFIG_DRM=y
 CONFIG_DRM_PANEL_LVDS=y
 CONFIG_DRM_PANEL_SIMPLE=y
+CONFIG_DRM_PANEL_SEIKO_43WVF1G=y
 CONFIG_DRM_DW_HDMI_AHB_AUDIO=m
 CONFIG_DRM_DW_HDMI_CEC=y
 CONFIG_DRM_IMX=y
 CONFIG_DRM_IMX_PARALLEL_DISPLAY=y
 CONFIG_DRM_IMX_TVE=y
 CONFIG_DRM_IMX_LDB=y
 CONFIG_DRM_IMX_HDMI=y
 CONFIG_DRM_ETNAVIV=y
+CONFIG_DRM_MXSFB=y
 CONFIG_FB_MXS=y
 CONFIG_LCD_CLASS_DEVICE=y
 CONFIG_LCD_L4F00242T03=y
 CONFIG_LCD_PLATFORM=y
 CONFIG_BACKLIGHT_PWM=y
-- 
2.17.1

