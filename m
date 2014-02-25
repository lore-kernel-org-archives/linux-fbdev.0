From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Tue, 25 Feb 2014 11:43:40 +0000
Subject: [PATCH 0/3] Move IPUv3 core out of staging
Message-Id: <1393328624-28013-1-git-send-email-p.zabel@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi,

this series has two small cleanups for the IPUv3 core driver and then moves
it from drivers/staging/imx-drm/ipu-v3 to drivers/gpu. In this directory there
is already the host1x driver, which serves a similar purpose.

I have dropped the CSI (capture interface) patches from the RFC series. This
series applies on top of Russell's imx-drm-staging branch, which just was merged
into staging-next.

I'd like to move the core code out of staging so that we can start submitting
V4L2 code for video capture and scaling / colorspace conversion in parallel.

I'll post the third patch in both versions with and without --find-renames.

To move the remaining DRM part out of staging, I'd like to get the device tree
bindings sorted out. This is currently pending on the move of OF graph parsing
helpers and review of the imx-drm dt bindings patch series.

regards
Philipp

Philipp Zabel (3):
  imx-drm: Move IPU_PIX_FMT_GBR24 definition into imx-ipu-v3.h
  imx-drm: ipu-dc: Use usleep_range instead of msleep
  gpu: ipu-v3: Move i.MX IPUv3 core driver out of staging

 drivers/gpu/Makefile                        |    1 +
 drivers/gpu/ipu-v3/Kconfig                  |    7 +
 drivers/gpu/ipu-v3/Makefile                 |    3 +
 drivers/gpu/ipu-v3/ipu-common.c             | 1261 +++++++++++++++++++++++++++
 drivers/gpu/ipu-v3/ipu-dc.c                 |  411 +++++++++
 drivers/gpu/ipu-v3/ipu-di.c                 |  730 ++++++++++++++++
 drivers/gpu/ipu-v3/ipu-dmfc.c               |  418 +++++++++
 drivers/gpu/ipu-v3/ipu-dp.c                 |  338 +++++++
 drivers/gpu/ipu-v3/ipu-prv.h                |  206 +++++
 drivers/staging/imx-drm/Kconfig             |   11 +-
 drivers/staging/imx-drm/Makefile            |    1 -
 drivers/staging/imx-drm/imx-drm.h           |    4 -
 drivers/staging/imx-drm/imx-tve.c           |    1 +
 drivers/staging/imx-drm/ipu-v3/Makefile     |    3 -
 drivers/staging/imx-drm/ipu-v3/imx-ipu-v3.h |  324 -------
 drivers/staging/imx-drm/ipu-v3/ipu-common.c | 1261 ---------------------------
 drivers/staging/imx-drm/ipu-v3/ipu-dc.c     |  412 ---------
 drivers/staging/imx-drm/ipu-v3/ipu-di.c     |  730 ----------------
 drivers/staging/imx-drm/ipu-v3/ipu-dmfc.c   |  418 ---------
 drivers/staging/imx-drm/ipu-v3/ipu-dp.c     |  338 -------
 drivers/staging/imx-drm/ipu-v3/ipu-prv.h    |  206 -----
 drivers/staging/imx-drm/ipuv3-crtc.c        |    2 +-
 drivers/staging/imx-drm/ipuv3-plane.c       |    2 +-
 drivers/video/Kconfig                       |    1 +
 include/video/imx-ipu-v3.h                  |  326 +++++++
 25 files changed, 3706 insertions(+), 3709 deletions(-)
 create mode 100644 drivers/gpu/ipu-v3/Kconfig
 create mode 100644 drivers/gpu/ipu-v3/Makefile
 create mode 100644 drivers/gpu/ipu-v3/ipu-common.c
 create mode 100644 drivers/gpu/ipu-v3/ipu-dc.c
 create mode 100644 drivers/gpu/ipu-v3/ipu-di.c
 create mode 100644 drivers/gpu/ipu-v3/ipu-dmfc.c
 create mode 100644 drivers/gpu/ipu-v3/ipu-dp.c
 create mode 100644 drivers/gpu/ipu-v3/ipu-prv.h
 delete mode 100644 drivers/staging/imx-drm/ipu-v3/Makefile
 delete mode 100644 drivers/staging/imx-drm/ipu-v3/imx-ipu-v3.h
 delete mode 100644 drivers/staging/imx-drm/ipu-v3/ipu-common.c
 delete mode 100644 drivers/staging/imx-drm/ipu-v3/ipu-dc.c
 delete mode 100644 drivers/staging/imx-drm/ipu-v3/ipu-di.c
 delete mode 100644 drivers/staging/imx-drm/ipu-v3/ipu-dmfc.c
 delete mode 100644 drivers/staging/imx-drm/ipu-v3/ipu-dp.c
 delete mode 100644 drivers/staging/imx-drm/ipu-v3/ipu-prv.h
 create mode 100644 include/video/imx-ipu-v3.h

-- 
1.8.5.3

