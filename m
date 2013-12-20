From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Fri, 20 Dec 2013 17:52:41 +0000
Subject: [RFC PATCH 0/5] Move IPUv3 core out of staging, add CSI support
Message-Id: <1387561966-31758-1-git-send-email-p.zabel@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi,

this is mostly about the first patch, which moves the IPUv3 core code
(drivers/staging/imx-drm/ipu-v3) to drivers/gpu. host1x, which
serves a similar purpose, already sits there.
The other four patches add the necessary code for CSI and SMFC handling,
which is used by the V4L2 CSI capture driver.

Currently this is based on Russell's patch
    [PATCH 62/64] imx-drm: pass an IPU ID to crtc and core

I am aware that there are now quite a few other patches in the pipeline
that touch drivers/staging/imx-drm/ipu-v3/*, so I am happy to rebase this
(or them) as needed. I'd like to move the core code out of staging so that
we can start submitting V4L2 code for video capture and scaling / colorspace
conversion in parallel.

Philipp Zabel (5):
  gpu: ipu-v3: Move i.MX IPUv3 core driver out of staging
  gpu: ipu-v3: Add SMFC code
  gpu: ipu-v3: Add ipu_idmac_get_current_buffer function
  gpu: ipu-v3: Add CSI and SMFC module enable wrappers
  gpu: ipu-v3: Register the CSI modules

 drivers/gpu/Makefile                               |  1 +
 drivers/gpu/ipu-v3/Kconfig                         |  7 ++
 drivers/{staging/imx-drm => gpu}/ipu-v3/Makefile   |  4 +-
 .../{staging/imx-drm => gpu}/ipu-v3/ipu-common.c   | 81 ++++++++++++++++--
 drivers/{staging/imx-drm => gpu}/ipu-v3/ipu-dc.c   |  3 +-
 drivers/{staging/imx-drm => gpu}/ipu-v3/ipu-di.c   |  2 +-
 drivers/{staging/imx-drm => gpu}/ipu-v3/ipu-dmfc.c |  2 +-
 drivers/{staging/imx-drm => gpu}/ipu-v3/ipu-dp.c   |  2 +-
 drivers/{staging/imx-drm => gpu}/ipu-v3/ipu-prv.h  |  8 +-
 drivers/gpu/ipu-v3/ipu-smfc.c                      | 97 ++++++++++++++++++++++
 drivers/staging/imx-drm/Kconfig                    | 11 +--
 drivers/staging/imx-drm/Makefile                   |  1 -
 drivers/staging/imx-drm/imx-drm.h                  |  4 -
 drivers/staging/imx-drm/imx-tve.c                  |  1 +
 drivers/staging/imx-drm/ipuv3-crtc.c               |  2 +-
 drivers/staging/imx-drm/ipuv3-plane.c              |  2 +-
 drivers/video/Kconfig                              |  1 +
 .../imx-drm/ipu-v3 => include/video}/imx-ipu-v3.h  | 18 ++++
 18 files changed, 217 insertions(+), 30 deletions(-)
 create mode 100644 drivers/gpu/ipu-v3/Kconfig
 rename drivers/{staging/imx-drm => gpu}/ipu-v3/Makefile (51%)
 rename drivers/{staging/imx-drm => gpu}/ipu-v3/ipu-common.c (94%)
 rename drivers/{staging/imx-drm => gpu}/ipu-v3/ipu-dc.c (99%)
 rename drivers/{staging/imx-drm => gpu}/ipu-v3/ipu-di.c (99%)
 rename drivers/{staging/imx-drm => gpu}/ipu-v3/ipu-dmfc.c (99%)
 rename drivers/{staging/imx-drm => gpu}/ipu-v3/ipu-dp.c (99%)
 rename drivers/{staging/imx-drm => gpu}/ipu-v3/ipu-prv.h (96%)
 create mode 100644 drivers/gpu/ipu-v3/ipu-smfc.c
 rename {drivers/staging/imx-drm/ipu-v3 => include/video}/imx-ipu-v3.h (94%)

regards
Philipp
