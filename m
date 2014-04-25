From: Jyri Sarha <jsarha@ti.com>
Date: Fri, 25 Apr 2014 21:16:54 +0000
Subject: [PATCH RFC 16/17] ARM: omap2plus_defconfig: Enable OMAP5 HDMI support
Message-Id: <dab95ca6b8261c6eadf8dd4e01c873d1c72de572.1398453425.git.jsarha@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1398453425.git.jsarha@ti.com>
In-Reply-To: <cover.1398453425.git.jsarha-l0cyMroinI0@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, liam.r.girdwood-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, peter.ujfalusi-l0cyMroinI0@public.gmane.org, detheridge-l0cyMroinI0@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tomi.valkeinen-l0cyMroinI0@public.gmane.org, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>

This patch is here only as an example on how to enable HDMI video for
OMAP5 uEVM. Adds CONFIG_GPIO_PCA953X=y and CONFIG_OMAP5_DSS_HDMI=y.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 arch/arm/configs/omap2plus_defconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 35c42aa..363733e 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -157,6 +157,7 @@ CONFIG_PINCTRL_SINGLE=y
 CONFIG_DEBUG_GPIO=y
 CONFIG_GPIO_SYSFS=y
 CONFIG_GPIO_TWL4030=y
+CONFIG_GPIO_PCA953X=y
 CONFIG_W1=y
 CONFIG_POWER_SUPPLY=y
 CONFIG_SENSORS_LM75=m
@@ -190,6 +191,7 @@ CONFIG_FB_TILEBLITTING=y
 CONFIG_OMAP2_DSS=y
 CONFIG_OMAP2_DSS_SDI=y
 CONFIG_OMAP2_DSS_DSI=y
+CONFIG_OMAP5_DSS_HDMI=y
 CONFIG_FB_OMAP2=y
 CONFIG_DISPLAY_ENCODER_TFP410=m
 CONFIG_DISPLAY_ENCODER_TPD12S015=m
-- 
1.7.9.5

