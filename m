From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Tue, 25 Feb 2014 12:09:57 +0000
Subject: Re: [PATCH 3/3] gpu: ipu-v3: Move i.MX IPUv3 core driver out of staging
Message-Id: <1393330197.4156.5.camel@pizza.hi.pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1393328624-28013-5-git-send-email-p.zabel@pengutronix.de>
In-Reply-To: <1393328624-28013-5-git-send-email-p.zabel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Am Dienstag, den 25.02.2014, 12:43 +0100 schrieb Philipp Zabel:
> The i.MX Image Processing Unit (IPU) contains a number of image processing
> blocks that sit right in the middle between DRM and V4L2. Some of the modules,
> such as Display Controller, Processor, and Interface (DC, DP, DI) or CMOS
> Sensor Interface (CSI) and their FIFOs could be assigned to either framework,
> but others, such as the dma controller (IDMAC) and image converter (IC) can
> be used by both.
> The IPUv3 core driver provides an internal API to access the modules, to be
> used by both DRM and V4L2 IPUv3 drivers.
[...]

This one is missing:

diff --git a/drivers/staging/imx-drm/imx-hdmi.c b/drivers/staging/imx-drm/imx-hdmi.c
index cb4eb76..9aeb863 100644
--- a/drivers/staging/imx-drm/imx-hdmi.c
+++ b/drivers/staging/imx-drm/imx-hdmi.c
@@ -28,7 +28,8 @@
 #include <drm/drm_edid.h>
 #include <drm/drm_encoder_slave.h>
 
-#include "ipu-v3/imx-ipu-v3.h"
+#include <video/imx-ipu-v3.h>
+
 #include "imx-hdmi.h"
 #include "imx-drm.h"
 

regards
Philipp

