From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Mon, 26 May 2014 14:19:39 +0000
Subject: [PATCH v2 1/5] gpu: ipu-v3: Move i.MX IPUv3 core driver out of staging
Message-Id: <1401113983-23132-2-git-send-email-p.zabel@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1401113983-23132-1-git-send-email-p.zabel@pengutronix.de>
In-Reply-To: <1401113983-23132-1-git-send-email-p.zabel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <rmk+kernel@arm.linux.org.uk>, Dave Airlie <airlied@redhat.com>
Cc: devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, drm-devel@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, kernel@pengutronix.de

The i.MX Image Processing Unit (IPU) contains a number of image processing
blocks that sit right in the middle between DRM and V4L2. Some of the modules,
such as Display Controller, Processor, and Interface (DC, DP, DI) or CMOS
Sensor Interface (CSI) and their FIFOs could be assigned to either framework,
but others, such as the dma controller (IDMAC) and image converter (IC) can
be used by both.
The IPUv3 core driver provides an internal API to access the modules, to be
used by both DRM and V4L2 IPUv3 drivers.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
Changes since RFC:
 - Rebased onto current staging-next
 - Removed an unrelated change to ipu_pixelformat_to_colorspace
 - Avoided moving around the IPU_PIX_FMT_GBR24 #define
---
 drivers/gpu/Makefile                                          |  1 +
 drivers/gpu/ipu-v3/Kconfig                                    |  7 +++++++
 drivers/{staging/imx-drm => gpu}/ipu-v3/Makefile              |  2 +-
 drivers/{staging/imx-drm => gpu}/ipu-v3/ipu-common.c          |  2 +-
 drivers/{staging/imx-drm => gpu}/ipu-v3/ipu-dc.c              |  3 +--
 drivers/{staging/imx-drm => gpu}/ipu-v3/ipu-di.c              |  2 +-
 drivers/{staging/imx-drm => gpu}/ipu-v3/ipu-dmfc.c            |  2 +-
 drivers/{staging/imx-drm => gpu}/ipu-v3/ipu-dp.c              |  2 +-
 drivers/{staging/imx-drm => gpu}/ipu-v3/ipu-prv.h             |  2 +-
 drivers/staging/imx-drm/Kconfig                               | 11 +----------
 drivers/staging/imx-drm/Makefile                              |  1 -
 drivers/staging/imx-drm/imx-hdmi.c                            |  2 +-
 drivers/staging/imx-drm/imx-tve.c                             |  2 +-
 drivers/staging/imx-drm/ipuv3-crtc.c                          |  2 +-
 drivers/staging/imx-drm/ipuv3-plane.c                         |  2 +-
 drivers/video/Kconfig                                         |  1 +
 .../staging/imx-drm/ipu-v3 => include/video}/imx-ipu-v3.h     |  0
 17 files changed, 21 insertions(+), 23 deletions(-)
 create mode 100644 drivers/gpu/ipu-v3/Kconfig
 rename drivers/{staging/imx-drm => gpu}/ipu-v3/Makefile (59%)
 rename drivers/{staging/imx-drm => gpu}/ipu-v3/ipu-common.c (99%)
 rename drivers/{staging/imx-drm => gpu}/ipu-v3/ipu-dc.c (99%)
 rename drivers/{staging/imx-drm => gpu}/ipu-v3/ipu-di.c (99%)
 rename drivers/{staging/imx-drm => gpu}/ipu-v3/ipu-dmfc.c (99%)
 rename drivers/{staging/imx-drm => gpu}/ipu-v3/ipu-dp.c (99%)
 rename drivers/{staging/imx-drm => gpu}/ipu-v3/ipu-prv.h (99%)
 rename {drivers/staging/imx-drm/ipu-v3 => include/video}/imx-ipu-v3.h (100%)

diff --git a/drivers/gpu/Makefile b/drivers/gpu/Makefile
index d8a22c2..70da9eb 100644
--- a/drivers/gpu/Makefile
+++ b/drivers/gpu/Makefile
@@ -1,2 +1,3 @@
 obj-y			+= drm/ vga/
 obj-$(CONFIG_TEGRA_HOST1X)	+= host1x/
+obj-$(CONFIG_IMX_IPUV3_CORE)	+= ipu-v3/
diff --git a/drivers/gpu/ipu-v3/Kconfig b/drivers/gpu/ipu-v3/Kconfig
new file mode 100644
index 0000000..2f228a2
--- /dev/null
+++ b/drivers/gpu/ipu-v3/Kconfig
@@ -0,0 +1,7 @@
+config IMX_IPUV3_CORE
+	tristate "IPUv3 core support"
+	depends on SOC_IMX5 || SOC_IMX6Q || SOC_IMX6SL || ARCH_MULTIPLATFORM
+	depends on RESET_CONTROLLER
+	help
+	  Choose this if you have a i.MX5/6 system and want to use the Image
+	  Processing Unit. This option only enables IPU base support.
diff --git a/drivers/staging/imx-drm/ipu-v3/Makefile b/drivers/gpu/ipu-v3/Makefile
similarity index 59%
rename from drivers/staging/imx-drm/ipu-v3/Makefile
rename to drivers/gpu/ipu-v3/Makefile
index 28ed72e..d21cc37 100644
--- a/drivers/staging/imx-drm/ipu-v3/Makefile
+++ b/drivers/gpu/ipu-v3/Makefile
@@ -1,3 +1,3 @@
-obj-$(CONFIG_DRM_IMX_IPUV3_CORE) += imx-ipu-v3.o
+obj-$(CONFIG_IMX_IPUV3_CORE) += imx-ipu-v3.o
 
 imx-ipu-v3-objs := ipu-common.o ipu-dc.o ipu-di.o ipu-dp.o ipu-dmfc.o
diff --git a/drivers/staging/imx-drm/ipu-v3/ipu-common.c b/drivers/gpu/ipu-v3/ipu-common.c
similarity index 99%
rename from drivers/staging/imx-drm/ipu-v3/ipu-common.c
rename to drivers/gpu/ipu-v3/ipu-common.c
index a1f7b20..ad99477 100644
--- a/drivers/staging/imx-drm/ipu-v3/ipu-common.c
+++ b/drivers/gpu/ipu-v3/ipu-common.c
@@ -31,7 +31,7 @@
 
 #include <drm/drm_fourcc.h>
 
-#include "imx-ipu-v3.h"
+#include <video/imx-ipu-v3.h>
 #include "ipu-prv.h"
 
 static inline u32 ipu_cm_read(struct ipu_soc *ipu, unsigned offset)
diff --git a/drivers/staging/imx-drm/ipu-v3/ipu-dc.c b/drivers/gpu/ipu-v3/ipu-dc.c
similarity index 99%
rename from drivers/staging/imx-drm/ipu-v3/ipu-dc.c
rename to drivers/gpu/ipu-v3/ipu-dc.c
index 784a4a1..2326c75 100644
--- a/drivers/staging/imx-drm/ipu-v3/ipu-dc.c
+++ b/drivers/gpu/ipu-v3/ipu-dc.c
@@ -21,8 +21,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 
-#include "../imx-drm.h"
-#include "imx-ipu-v3.h"
+#include <video/imx-ipu-v3.h>
 #include "ipu-prv.h"
 
 #define DC_MAP_CONF_PTR(n)	(0x108 + ((n) & ~0x1) * 2)
diff --git a/drivers/staging/imx-drm/ipu-v3/ipu-di.c b/drivers/gpu/ipu-v3/ipu-di.c
similarity index 99%
rename from drivers/staging/imx-drm/ipu-v3/ipu-di.c
rename to drivers/gpu/ipu-v3/ipu-di.c
index 849b3e120..c490ba4 100644
--- a/drivers/staging/imx-drm/ipu-v3/ipu-di.c
+++ b/drivers/gpu/ipu-v3/ipu-di.c
@@ -20,7 +20,7 @@
 #include <linux/err.h>
 #include <linux/platform_device.h>
 
-#include "imx-ipu-v3.h"
+#include <video/imx-ipu-v3.h>
 #include "ipu-prv.h"
 
 struct ipu_di {
diff --git a/drivers/staging/imx-drm/ipu-v3/ipu-dmfc.c b/drivers/gpu/ipu-v3/ipu-dmfc.c
similarity index 99%
rename from drivers/staging/imx-drm/ipu-v3/ipu-dmfc.c
rename to drivers/gpu/ipu-v3/ipu-dmfc.c
index 59f182b..042c395 100644
--- a/drivers/staging/imx-drm/ipu-v3/ipu-dmfc.c
+++ b/drivers/gpu/ipu-v3/ipu-dmfc.c
@@ -17,7 +17,7 @@
 #include <linux/errno.h>
 #include <linux/io.h>
 
-#include "imx-ipu-v3.h"
+#include <video/imx-ipu-v3.h>
 #include "ipu-prv.h"
 
 #define DMFC_RD_CHAN		0x0000
diff --git a/drivers/staging/imx-drm/ipu-v3/ipu-dp.c b/drivers/gpu/ipu-v3/ipu-dp.c
similarity index 99%
rename from drivers/staging/imx-drm/ipu-v3/ipu-dp.c
rename to drivers/gpu/ipu-v3/ipu-dp.c
index d90f82a..98686ed 100644
--- a/drivers/staging/imx-drm/ipu-v3/ipu-dp.c
+++ b/drivers/gpu/ipu-v3/ipu-dp.c
@@ -19,7 +19,7 @@
 #include <linux/io.h>
 #include <linux/err.h>
 
-#include "imx-ipu-v3.h"
+#include <video/imx-ipu-v3.h>
 #include "ipu-prv.h"
 
 #define DP_SYNC 0
diff --git a/drivers/staging/imx-drm/ipu-v3/ipu-prv.h b/drivers/gpu/ipu-v3/ipu-prv.h
similarity index 99%
rename from drivers/staging/imx-drm/ipu-v3/ipu-prv.h
rename to drivers/gpu/ipu-v3/ipu-prv.h
index bfc1b33..72e1158 100644
--- a/drivers/staging/imx-drm/ipu-v3/ipu-prv.h
+++ b/drivers/gpu/ipu-v3/ipu-prv.h
@@ -22,7 +22,7 @@ struct ipu_soc;
 #include <linux/clk.h>
 #include <linux/platform_device.h>
 
-#include "imx-ipu-v3.h"
+#include <video/imx-ipu-v3.h>
 
 #define IPUV3_CHANNEL_CSI0			 0
 #define IPUV3_CHANNEL_CSI1			 1
diff --git a/drivers/staging/imx-drm/Kconfig b/drivers/staging/imx-drm/Kconfig
index c6e8ba7..82fb758 100644
--- a/drivers/staging/imx-drm/Kconfig
+++ b/drivers/staging/imx-drm/Kconfig
@@ -39,19 +39,10 @@ config DRM_IMX_LDB
 	  Choose this to enable the internal LVDS Display Bridge (LDB)
 	  found on i.MX53 and i.MX6 processors.
 
-config DRM_IMX_IPUV3_CORE
-	tristate "IPUv3 core support"
-	depends on DRM_IMX
-	depends on RESET_CONTROLLER
-	help
-	  Choose this if you have a i.MX5/6 system and want
-	  to use the IPU. This option only enables IPU base
-	  support.
-
 config DRM_IMX_IPUV3
 	tristate "DRM Support for i.MX IPUv3"
 	depends on DRM_IMX
-	depends on DRM_IMX_IPUV3_CORE
+	depends on IMX_IPUV3_CORE
 	help
 	  Choose this if you have a i.MX5 or i.MX6 processor.
 
diff --git a/drivers/staging/imx-drm/Makefile b/drivers/staging/imx-drm/Makefile
index 129e3a3..582c438 100644
--- a/drivers/staging/imx-drm/Makefile
+++ b/drivers/staging/imx-drm/Makefile
@@ -6,7 +6,6 @@ obj-$(CONFIG_DRM_IMX) += imxdrm.o
 obj-$(CONFIG_DRM_IMX_PARALLEL_DISPLAY) += parallel-display.o
 obj-$(CONFIG_DRM_IMX_TVE) += imx-tve.o
 obj-$(CONFIG_DRM_IMX_LDB) += imx-ldb.o
-obj-$(CONFIG_DRM_IMX_IPUV3_CORE) += ipu-v3/
 
 imx-ipuv3-crtc-objs  := ipuv3-crtc.o ipuv3-plane.o
 obj-$(CONFIG_DRM_IMX_IPUV3)	+= imx-ipuv3-crtc.o
diff --git a/drivers/staging/imx-drm/imx-hdmi.c b/drivers/staging/imx-drm/imx-hdmi.c
index 1b44048..e7f3de5 100644
--- a/drivers/staging/imx-drm/imx-hdmi.c
+++ b/drivers/staging/imx-drm/imx-hdmi.c
@@ -27,8 +27,8 @@
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_encoder_slave.h>
+#include <video/imx-ipu-v3.h>
 
-#include "ipu-v3/imx-ipu-v3.h"
 #include "imx-hdmi.h"
 #include "imx-drm.h"
 
diff --git a/drivers/staging/imx-drm/imx-tve.c b/drivers/staging/imx-drm/imx-tve.c
index a23f4f7..b12fb17 100644
--- a/drivers/staging/imx-drm/imx-tve.c
+++ b/drivers/staging/imx-drm/imx-tve.c
@@ -30,8 +30,8 @@
 #include <drm/drmP.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_crtc_helper.h>
+#include <video/imx-ipu-v3.h>
 
-#include "ipu-v3/imx-ipu-v3.h"
 #include "imx-drm.h"
 
 #define TVE_COM_CONF_REG	0x00
diff --git a/drivers/staging/imx-drm/ipuv3-crtc.c b/drivers/staging/imx-drm/ipuv3-crtc.c
index 47bec5e..720868b 100644
--- a/drivers/staging/imx-drm/ipuv3-crtc.c
+++ b/drivers/staging/imx-drm/ipuv3-crtc.c
@@ -30,7 +30,7 @@
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_fb_cma_helper.h>
 
-#include "ipu-v3/imx-ipu-v3.h"
+#include <video/imx-ipu-v3.h>
 #include "imx-drm.h"
 #include "ipuv3-plane.h"
 
diff --git a/drivers/staging/imx-drm/ipuv3-plane.c b/drivers/staging/imx-drm/ipuv3-plane.c
index 5697e59..6f393a1 100644
--- a/drivers/staging/imx-drm/ipuv3-plane.c
+++ b/drivers/staging/imx-drm/ipuv3-plane.c
@@ -17,7 +17,7 @@
 #include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_gem_cma_helper.h>
 
-#include "ipu-v3/imx-ipu-v3.h"
+#include "video/imx-ipu-v3.h"
 #include "ipuv3-plane.h"
 
 #define to_ipu_plane(x)	container_of(x, struct ipu_plane, base)
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index c7b4f0f..8bf495f 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -20,6 +20,7 @@ source "drivers/char/agp/Kconfig"
 source "drivers/gpu/vga/Kconfig"
 
 source "drivers/gpu/host1x/Kconfig"
+source "drivers/gpu/ipu-v3/Kconfig"
 
 menu "Direct Rendering Manager"
 source "drivers/gpu/drm/Kconfig"
diff --git a/drivers/staging/imx-drm/ipu-v3/imx-ipu-v3.h b/include/video/imx-ipu-v3.h
similarity index 100%
rename from drivers/staging/imx-drm/ipu-v3/imx-ipu-v3.h
rename to include/video/imx-ipu-v3.h
-- 
2.0.0.rc2

