From: Anders Roxell <anders.roxell@linaro.org>
Date: Thu, 06 Jun 2019 09:47:12 +0000
Subject: [PATCH 3/8] drivers: (video|gpu): fix warning same module names
Message-Id: <20190606094712.23715-1-anders.roxell@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: marex@denx.de, stefan@agner.ch, airlied@linux.ie, daniel@ffwll.ch, shawnguo@kernel.org, s.hauer@pengutronix.de, b.zolnierkie@samsung.com
Cc: andrew@lunn.ch, vivien.didelot@gmail.com, f.fainelli@gmail.com, a.hajda@samsung.com, mchehab@kernel.org, p.zabel@pengutronix.de, hkallweit1@gmail.com, lee.jones@linaro.org, lgirdwood@gmail.com, broonie@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org, linux-media@vger.kernel.org, Anders Roxell <anders.roxell@linaro.org>

When building with CONFIG_DRM_MXSFB and CONFIG_FB_MXS enabled as
loadable modules, we see the following warning:

warning: same module names found:
  drivers/video/fbdev/mxsfb.ko
  drivers/gpu/drm/mxsfb/mxsfb.ko

Rework so the names matches the config fragment.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/gpu/drm/mxsfb/Makefile | 4 ++--
 drivers/video/fbdev/Makefile   | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/mxsfb/Makefile b/drivers/gpu/drm/mxsfb/Makefile
index ff6e358088fa..5d49d7548e66 100644
--- a/drivers/gpu/drm/mxsfb/Makefile
+++ b/drivers/gpu/drm/mxsfb/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
-mxsfb-y := mxsfb_drv.o mxsfb_crtc.o mxsfb_out.o
-obj-$(CONFIG_DRM_MXSFB)	+= mxsfb.o
+drm-mxsfb-y := mxsfb_drv.o mxsfb_crtc.o mxsfb_out.o
+obj-$(CONFIG_DRM_MXSFB)	+= drm-mxsfb.o
diff --git a/drivers/video/fbdev/Makefile b/drivers/video/fbdev/Makefile
index 655f2537cac1..7ee967525af2 100644
--- a/drivers/video/fbdev/Makefile
+++ b/drivers/video/fbdev/Makefile
@@ -131,7 +131,8 @@ obj-$(CONFIG_FB_VGA16)            += vga16fb.o
 obj-$(CONFIG_FB_OF)               += offb.o
 obj-$(CONFIG_FB_MX3)		  += mx3fb.o
 obj-$(CONFIG_FB_DA8XX)		  += da8xx-fb.o
-obj-$(CONFIG_FB_MXS)		  += mxsfb.o
+obj-$(CONFIG_FB_MXS)		  += fb-mxs.o
+fb-mxs-objs			  := mxsfb.o
 obj-$(CONFIG_FB_SSD1307)	  += ssd1307fb.o
 obj-$(CONFIG_FB_SIMPLE)           += simplefb.o
 
-- 
2.20.1
