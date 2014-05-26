From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Mon, 26 May 2014 14:19:38 +0000
Subject: [PATCH v2 0/5] Move IPUv3 core out of staging, add CSI support
Message-Id: <1401113983-23132-1-git-send-email-p.zabel@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <rmk+kernel@arm.linux.org.uk>, Dave Airlie <airlied@redhat.com>
Cc: devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, drm-devel@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, kernel@pengutronix.de

Hi,

This is a rebased version of the earlier RFC series. It is
mostly about the first patch, which moves the IPUv3 core code
(drivers/staging/imx-drm/ipu-v3) to drivers/gpu.
host1x, which serves a similar purpose, already sits there.

I'd like to move the IPUv3 core code out of staging so that we can
start submitting V4L2 code for video capture and scaling / colorspace
conversion.
The other four patches add necessary preparations for CSI and SMFC
handling. These are used by the V4L2 CSI & capture drivers.

This series is based on the current staging-next tree, it is otherwise
nearly unchanged. I hope we can get this move in before the approaching
merge window so that we have a base for submitting the CSI V4L2 patches
in the following round.

regards
Philipp

---
Changes since RFC:
 - Rebased onto current staging-next
 - Streamlined destaging patch a bit
---
Philipp Zabel (5):
  gpu: ipu-v3: Move i.MX IPUv3 core driver out of staging
  gpu: ipu-v3: Add SMFC code
  gpu: ipu-v3: Add ipu_idmac_get_current_buffer function
  gpu: ipu-v3: Add CSI and SMFC module enable wrappers
  gpu: ipu-v3: Register the CSI modules

 drivers/gpu/Makefile                               |  1 +
 drivers/gpu/ipu-v3/Kconfig                         |  7 ++
 drivers/{staging/imx-drm => gpu}/ipu-v3/Makefile   |  4 +-
 .../{staging/imx-drm => gpu}/ipu-v3/ipu-common.c   | 82 ++++++++++++++++--
 drivers/{staging/imx-drm => gpu}/ipu-v3/ipu-dc.c   |  3 +-
 drivers/{staging/imx-drm => gpu}/ipu-v3/ipu-di.c   |  2 +-
 drivers/{staging/imx-drm => gpu}/ipu-v3/ipu-dmfc.c |  2 +-
 drivers/{staging/imx-drm => gpu}/ipu-v3/ipu-dp.c   |  2 +-
 drivers/{staging/imx-drm => gpu}/ipu-v3/ipu-prv.h  |  8 +-
 drivers/gpu/ipu-v3/ipu-smfc.c                      | 97 ++++++++++++++++++++++
 drivers/staging/imx-drm/Kconfig                    | 11 +--
 drivers/staging/imx-drm/Makefile                   |  1 -
 drivers/staging/imx-drm/imx-hdmi.c                 |  2 +-
 drivers/staging/imx-drm/imx-tve.c                  |  2 +-
 drivers/staging/imx-drm/ipuv3-crtc.c               |  2 +-
 drivers/staging/imx-drm/ipuv3-plane.c              |  2 +-
 drivers/video/Kconfig                              |  1 +
 .../imx-drm/ipu-v3 => include/video}/imx-ipu-v3.h  | 16 ++++
 18 files changed, 216 insertions(+), 29 deletions(-)
 create mode 100644 drivers/gpu/ipu-v3/Kconfig
 rename drivers/{staging/imx-drm => gpu}/ipu-v3/Makefile (51%)
 rename drivers/{staging/imx-drm => gpu}/ipu-v3/ipu-common.c (94%)
 rename drivers/{staging/imx-drm => gpu}/ipu-v3/ipu-dc.c (99%)
 rename drivers/{staging/imx-drm => gpu}/ipu-v3/ipu-di.c (99%)
 rename drivers/{staging/imx-drm => gpu}/ipu-v3/ipu-dmfc.c (99%)
 rename drivers/{staging/imx-drm => gpu}/ipu-v3/ipu-dp.c (99%)
 rename drivers/{staging/imx-drm => gpu}/ipu-v3/ipu-prv.h (96%)
 create mode 100644 drivers/gpu/ipu-v3/ipu-smfc.c
 rename {drivers/staging/imx-drm/ipu-v3 => include/video}/imx-ipu-v3.h (95%)

-- 
2.0.0.rc2

