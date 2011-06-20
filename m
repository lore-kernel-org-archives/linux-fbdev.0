From: Tushar Behera <tushar.behera@linaro.org>
Date: Mon, 20 Jun 2011 10:58:01 +0000
Subject: [PATCH 2/2] video: omap2: Compile omap2 support only when needed
Message-Id: <1308566761-2850-3-git-send-email-tushar.behera@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1308566761-2850-1-git-send-email-tushar.behera@linaro.org>
In-Reply-To: <1308566761-2850-1-git-send-email-tushar.behera@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Currently display support for omap2 is selected by default and
it gets built for all the configurations.

Instead of it being a built-in feature, it's compilation should
depend on the config option CONFIG_FB_OMAP2.

Cc: Paul Mundt <lethal@linux-sh.org>
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
---
 drivers/video/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index 8b83129..a19e44e 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -133,7 +133,7 @@ obj-$(CONFIG_FB_SH_MOBILE_HDMI)	  += sh_mobile_hdmi.o
 obj-$(CONFIG_FB_SH_MOBILE_MERAM)  += sh_mobile_meram.o
 obj-$(CONFIG_FB_SH_MOBILE_LCDC)	  += sh_mobile_lcdcfb.o
 obj-$(CONFIG_FB_OMAP)             += omap/
-obj-y                             += omap2/
+obj-$(CONFIG_FB_OMAP2)            += omap2/
 obj-$(CONFIG_XEN_FBDEV_FRONTEND)  += xen-fbfront.o
 obj-$(CONFIG_FB_CARMINE)          += carminefb.o
 obj-$(CONFIG_FB_MB862XX)	  += mb862xx/
-- 
1.7.4.1

