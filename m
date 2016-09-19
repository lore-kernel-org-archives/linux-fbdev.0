From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Mon, 19 Sep 2016 07:35:24 +0000
Subject: Re: [PATCH v7 0/3] IPUv3 prep for i.MX5/6 v4l2 staging drivers, v7
Message-Id: <1474270524.3117.29.camel@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1474140838-1082-1-git-send-email-steve_longerbeam@mentor.com>
In-Reply-To: <1474140838-1082-1-git-send-email-steve_longerbeam@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Steve Longerbeam <slongerbeam@gmail.com>
Cc: tomi.valkeinen@ti.com, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, Steve Longerbeam <steve_longerbeam@mentor.com>

Hi Steve,

Am Samstag, den 17.09.2016, 12:33 -0700 schrieb Steve Longerbeam:
> Changes from v6:
> 
> - renamed include/video/imx-image-convert.h to imx-ipu-image-convert.h.
> - changed MIN_W, MIN_H to absolute minimum allowed assuming conversions
>   to/from planar pixel formats and with rotations (16x8).
> - removed setting defaults if given 0 widths/heights in
>   ipu_image_convert_adjust().
> 
> Steve Longerbeam (3):
>   gpu: ipu-v3: Add FSU channel linking support
>   gpu: ipu-v3: Add ipu_rot_mode_is_irt()
>   gpu: ipu-v3: Add queued image conversion support
> 
>  drivers/gpu/ipu-v3/Makefile            |    3 +-
>  drivers/gpu/ipu-v3/ipu-common.c        |  140 +++
>  drivers/gpu/ipu-v3/ipu-ic.c            |    2 +-
>  drivers/gpu/ipu-v3/ipu-image-convert.c | 1709 ++++++++++++++++++++++++++++++++
>  drivers/gpu/ipu-v3/ipu-prv.h           |   32 +
>  include/video/imx-ipu-image-convert.h  |  207 ++++
>  include/video/imx-ipu-v3.h             |   35 +-
>  7 files changed, 2119 insertions(+), 9 deletions(-)
>  create mode 100644 drivers/gpu/ipu-v3/ipu-image-convert.c
>  create mode 100644 include/video/imx-ipu-image-convert.h

thanks, I have updated to v7 and sent a pull request:

https://lists.freedesktop.org/archives/dri-devel/2016-September/118572.html

regards
Philipp

