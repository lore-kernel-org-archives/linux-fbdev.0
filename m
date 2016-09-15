From: Steve Longerbeam <slongerbeam@gmail.com>
Date: Thu, 15 Sep 2016 18:04:10 +0000
Subject: [PATCH v5 0/2] IPUv3 prep for i.MX5/6 v4l2 staging drivers, v5
Message-Id: <1473962652-16820-1-git-send-email-steve_longerbeam@mentor.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: p.zabel@pengutronix.de, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, Steve Longerbeam <steve_longerbeam@mentor.com>, dri-devel@lists.freedesktop.org

This now contains only the queued image conversion support, along
with a split-out patch that adds macro ipu_rot_mode_is_irt().

Steve Longerbeam (2):
  gpu: ipu-v3: Add ipu_rot_mode_is_irt()
  gpu: ipu-v3: Add queued image conversion support

 drivers/gpu/ipu-v3/Makefile            |    3 +-
 drivers/gpu/ipu-v3/ipu-common.c        |    9 +
 drivers/gpu/ipu-v3/ipu-ic.c            |    2 +-
 drivers/gpu/ipu-v3/ipu-image-convert.c | 1721 ++++++++++++++++++++++++++++++++
 drivers/gpu/ipu-v3/ipu-prv.h           |    5 +
 include/video/imx-image-convert.h      |  207 ++++
 include/video/imx-ipu-v3.h             |   22 +-
 7 files changed, 1960 insertions(+), 9 deletions(-)
 create mode 100644 drivers/gpu/ipu-v3/ipu-image-convert.c
 create mode 100644 include/video/imx-image-convert.h

-- 
2.7.4

