From: Steve Longerbeam <slongerbeam@gmail.com>
Date: Sun, 31 Jul 2016 19:55:47 +0000
Subject: Re: [PATCH v3 00/12] IPUv3 prep for i.MX5/6 v4l2 staging drivers, v3
Message-Id: <575da5b9-1566-10eb-dc51-e5dd324cbfe5@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1469994147-17549-1-git-send-email-steve_longerbeam@mentor.com>
In-Reply-To: <1469994147-17549-1-git-send-email-steve_longerbeam@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: p.zabel@pengutronix.de, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

On 07/31/2016 12:42 PM, Steve Longerbeam wrote:
> In this version:
>
> - API changes to ipu-vdi.c in "gpu: ipu-v3: Add Video Deinterlacer unit".
> - "gpu: ipu-v3: Add FSU channel linking support" is new but based on
>   previous patch "gpu: ipu-v3: Add IDMA channel linking support".
>
> No other changes from previous version.

Actually one other change from previous version:

- removed the patch "gpu: ipu-v3: Add ipu_set_vdi_src_mux()".

Steve

> Steve Longerbeam (12):
>   gpu: ipu-cpmem: Add ipu_cpmem_set_uv_offset()
>   gpu: ipu-cpmem: Add ipu_cpmem_get_burstsize()
>   gpu: ipu-v3: Add ipu_get_num()
>   gpu: ipu-v3: Add VDI input IDMAC channels
>   gpu: ipu-v3: set correct full sensor frame for PAL/NTSC
>   gpu: ipu-v3: Fix CSI data format for 16-bit media bus formats
>   gpu: ipu-v3: Fix IRT usage
>   gpu: ipu-v3: rename CSI client device
>   gpu: ipu-v3: Add Video Deinterlacer unit
>   gpu: ipu-v3: Add FSU channel linking support
>   gpu: ipu-ic: Add complete image conversion support with tiling
>   gpu: ipu-ic: allow multiple handles to ic
>
>  drivers/gpu/ipu-v3/Makefile     |    2 +-
>  drivers/gpu/ipu-v3/ipu-common.c |  154 +++-
>  drivers/gpu/ipu-v3/ipu-cpmem.c  |   13 +
>  drivers/gpu/ipu-v3/ipu-csi.c    |   26 +-
>  drivers/gpu/ipu-v3/ipu-ic.c     | 1756 ++++++++++++++++++++++++++++++++++++++-
>  drivers/gpu/ipu-v3/ipu-prv.h    |   34 +
>  drivers/gpu/ipu-v3/ipu-vdi.c    |  254 ++++++
>  include/video/imx-ipu-v3.h      |   99 ++-
>  8 files changed, 2278 insertions(+), 60 deletions(-)
>  create mode 100644 drivers/gpu/ipu-v3/ipu-vdi.c
>

