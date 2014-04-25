From: Jyri Sarha <jsarha@ti.com>
Date: Fri, 25 Apr 2014 21:16:55 +0000
Subject: [PATCH RFC 17/17] ARM: omap2plus_defconfig: Enable OMAP4+ HDMI audio support
Message-Id: <24cfb47c270007f7a479c911a28e3ffb0d036727.1398453425.git.jsarha@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1398453425.git.jsarha@ti.com>
In-Reply-To: <cover.1398453425.git.jsarha-l0cyMroinI0@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, liam.r.girdwood-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, peter.ujfalusi-l0cyMroinI0@public.gmane.org, detheridge-l0cyMroinI0@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tomi.valkeinen-l0cyMroinI0@public.gmane.org, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>

This patch is here only as an example on how to enable HDMI audio for
OMAP4+ HW. Adds CONFIG_SND_SIMPLE_CARD=m and CONFIG_SND_SOC_HDMI_CODEC=m.
Also builds SND_OMAP_SOC in kernel to support in kernel built OMAPDSS
with integrated HDMI DAI driver.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 arch/arm/configs/omap2plus_defconfig |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 363733e..8b512c7 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -204,20 +204,22 @@ CONFIG_LCD_PLATFORM=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
 CONFIG_LOGO=y
-CONFIG_SOUND=m
-CONFIG_SND=m
+CONFIG_SOUND=y
+CONFIG_SND=y
 CONFIG_SND_MIXER_OSS=m
 CONFIG_SND_PCM_OSS=m
 CONFIG_SND_VERBOSE_PRINTK=y
 CONFIG_SND_DEBUG=y
 CONFIG_SND_USB_AUDIO=m
-CONFIG_SND_SOC=m
-CONFIG_SND_OMAP_SOC=m
+CONFIG_SND_SOC=y
+CONFIG_SND_OMAP_SOC=y
 CONFIG_SND_AM33XX_SOC_EVM=m
 CONFIG_SND_DAVINCI_SOC=m
 CONFIG_SND_OMAP_SOC_OMAP_TWL4030=m
 CONFIG_SND_OMAP_SOC_OMAP_ABE_TWL6040=m
 CONFIG_SND_OMAP_SOC_OMAP3_PANDORA=m
+CONFIG_SND_SIMPLE_CARD=m
+CONFIG_SND_SOC_HDMI_CODEC=m
 CONFIG_USB=y
 CONFIG_USB_DEBUG=y
 CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
-- 
1.7.9.5

