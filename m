From: Steve Longerbeam <slongerbeam@gmail.com>
Date: Thu, 15 Sep 2016 18:30:48 +0000
Subject: [PATCH v6 0/3] IPUv3 prep for i.MX5/6 v4l2 staging drivers, v6
Message-Id: <1473964251-20662-1-git-send-email-steve_longerbeam@mentor.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: p.zabel@pengutronix.de, tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, Steve Longerbeam <steve_longerbeam@mentor.com>, dri-devel@lists.freedesktop.org

Fixed a missed compile error from v5. Also, although "gpu: ipu-v3: Add
FSU channel linking support" has already been accepted, need to inlcude
it again here only to allow ipu-image-convert.c to compile.

Steve Longerbeam (3):
  gpu: ipu-v3: Add FSU channel linking support
  gpu: ipu-v3: Add ipu_rot_mode_is_irt()
  gpu: ipu-v3: Add queued image conversion support

 drivers/gpu/ipu-v3/Makefile            |    3 +-
 drivers/gpu/ipu-v3/ipu-common.c        |  140 +++
 drivers/gpu/ipu-v3/ipu-ic.c            |    2 +-
 drivers/gpu/ipu-v3/ipu-image-convert.c | 1718 ++++++++++++++++++++++++++++++++
 drivers/gpu/ipu-v3/ipu-prv.h           |   32 +
 include/video/imx-image-convert.h      |  207 ++++
 include/video/imx-ipu-v3.h             |   35 +-
 7 files changed, 2128 insertions(+), 9 deletions(-)
 create mode 100644 drivers/gpu/ipu-v3/ipu-image-convert.c
 create mode 100644 include/video/imx-image-convert.h

-- 
2.7.4

