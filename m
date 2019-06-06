From: Anders Roxell <anders.roxell@linaro.org>
Date: Thu, 06 Jun 2019 09:47:22 +0000
Subject: [PATCH 5/8] drivers: media: coda: fix warning same module names
Message-Id: <20190606094722.23816-1-anders.roxell@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mchehab@kernel.org, p.zabel@pengutronix.de
Cc: andrew@lunn.ch, vivien.didelot@gmail.com, f.fainelli@gmail.com, marex@denx.de, stefan@agner.ch, airlied@linux.ie, daniel@ffwll.ch, shawnguo@kernel.org, s.hauer@pengutronix.de, b.zolnierkie@samsung.com, a.hajda@samsung.com, hkallweit1@gmail.com, lee.jones@linaro.org, lgirdwood@gmail.com, broonie@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org, linux-media@vger.kernel.org, Anders Roxell <anders.roxell@linaro.org>

When building with CONFIG_VIDEO_CODA and CONFIG_CODA_FS enabled as
loadable modules, we see the following warning:

warning: same module names found:
  fs/coda/coda.ko
  drivers/media/platform/coda/coda.ko

Rework so media coda matches the config fragment. Leaving CODA_FS as is
since thats a well known module.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/media/platform/coda/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/coda/Makefile b/drivers/media/platform/coda/Makefile
index 54e9a73a92ab..588e6bf7c190 100644
--- a/drivers/media/platform/coda/Makefile
+++ b/drivers/media/platform/coda/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
-coda-objs := coda-common.o coda-bit.o coda-gdi.o coda-h264.o coda-mpeg2.o coda-mpeg4.o coda-jpeg.o
+video-coda-objs := coda-common.o coda-bit.o coda-gdi.o coda-h264.o coda-mpeg2.o coda-mpeg4.o coda-jpeg.o
 
-obj-$(CONFIG_VIDEO_CODA) += coda.o
+obj-$(CONFIG_VIDEO_CODA) += video-coda.o
 obj-$(CONFIG_VIDEO_IMX_VDOA) += imx-vdoa.o
-- 
2.20.1
