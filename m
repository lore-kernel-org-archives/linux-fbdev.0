From: Steve Longerbeam <slongerbeam@gmail.com>
Date: Thu, 18 Aug 2016 00:50:15 +0000
Subject: [PATCH v4 0/4] IPUv3 prep for i.MX5/6 v4l2 staging drivers, v4
Message-Id: <1471481419-5917-1-git-send-email-steve_longerbeam@mentor.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: p.zabel@pengutronix.de, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, Steve Longerbeam <steve_longerbeam@mentor.com>

In this version:

- rebased against latest drm-next.
- cleaned up header includes in ipu-vdi.c.
- do away with struct ipu_ic_tile_off in ipu-ic.c, and move tile offsets
  into struct ipu_ic_tile. This paves the way for possibly allowing for
  each tile to have different dimensions in the future.


Steve Longerbeam (4):
  gpu: ipu-v3: Add Video Deinterlacer unit
  gpu: ipu-v3: Add FSU channel linking support
  gpu: ipu-ic: Add complete image conversion support with tiling
  gpu: ipu-ic: allow multiple handles to ic

 drivers/gpu/ipu-v3/Makefile     |    2 +-
 drivers/gpu/ipu-v3/ipu-common.c |  142 ++++
 drivers/gpu/ipu-v3/ipu-ic.c     | 1719 ++++++++++++++++++++++++++++++++++++++-
 drivers/gpu/ipu-v3/ipu-prv.h    |   33 +
 drivers/gpu/ipu-v3/ipu-vdi.c    |  243 ++++++
 include/video/imx-ipu-v3.h      |   93 ++-
 6 files changed, 2195 insertions(+), 37 deletions(-)
 create mode 100644 drivers/gpu/ipu-v3/ipu-vdi.c

-- 
1.9.1

