From: Steve Longerbeam <slongerbeam@gmail.com>
Date: Wed, 20 Jul 2016 01:10:58 +0000
Subject: [PATCH v2 00/13] IPUv3 prep for i.MX5/6 v4l2 staging drivers, v2
Message-Id: <1468977071-29240-1-git-send-email-steve_longerbeam@mentor.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1467932621-358-1-git-send-email-steve_longerbeam@mentor.com>
In-Reply-To: <1467932621-358-1-git-send-email-steve_longerbeam@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: p.zabel@pengutronix.de, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Steve Longerbeam <steve_longerbeam@mentor.com>

These updates to IPUv3 are needed for media staging drivers
for i.MX5/6 video capture and mem2mem.

Steve Longerbeam (13):
  gpu: ipu-v3: Add Video Deinterlacer unit
  gpu: ipu-cpmem: Add ipu_cpmem_set_uv_offset()
  gpu: ipu-cpmem: Add ipu_cpmem_get_burstsize()
  gpu: ipu-v3: Add ipu_get_num()
  gpu: ipu-v3: Add IDMA channel linking support
  gpu: ipu-v3: Add ipu_set_vdi_src_mux()
  gpu: ipu-v3: Add VDI input IDMAC channels
  gpu: ipu-v3: set correct full sensor frame for PAL/NTSC
  gpu: ipu-v3: Fix CSI data format for 16-bit media bus formats
  gpu: ipu-v3: Fix IRT usage
  gpu: ipu-ic: Add complete image conversion support with tiling
  gpu: ipu-ic: allow multiple handles to ic
  gpu: ipu-v3: rename CSI client device

 drivers/gpu/ipu-v3/Makefile     |    2 +-
 drivers/gpu/ipu-v3/ipu-common.c |  161 +++-
 drivers/gpu/ipu-v3/ipu-cpmem.c  |   13 +
 drivers/gpu/ipu-v3/ipu-csi.c    |   26 +-
 drivers/gpu/ipu-v3/ipu-ic.c     | 1756 ++++++++++++++++++++++++++++++++++++++-
 drivers/gpu/ipu-v3/ipu-prv.h    |   13 +
 drivers/gpu/ipu-v3/ipu-vdi.c    |  262 ++++++
 include/video/imx-ipu-v3.h      |   94 ++-
 8 files changed, 2267 insertions(+), 60 deletions(-)
 create mode 100644 drivers/gpu/ipu-v3/ipu-vdi.c

-- 
1.9.1

