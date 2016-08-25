From: Tim Harvey <tharvey@gateworks.com>
Date: Thu, 25 Aug 2016 14:17:35 +0000
Subject: Re: [PATCH v4 0/4] IPUv3 prep for i.MX5/6 v4l2 staging drivers, v4
Message-Id: <CAJ+vNU1LfgbvihqgN0LWr1JxpKtW7jW3Xu0DycD0ePqC1K=8EA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1471481419-5917-1-git-send-email-steve_longerbeam@mentor.com>
In-Reply-To: <1471481419-5917-1-git-send-email-steve_longerbeam@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, linux-fbdev@vger.kernel.org, Steve Longerbeam <steve_longerbeam@mentor.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, DRI mailing list <dri-devel@lists.freedesktop.org>, Steve Longerbeam <slongerbeam@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Fabio Estevam <fabio.estevam@nxp.com>

On Wed, Aug 17, 2016 at 5:50 PM, Steve Longerbeam <slongerbeam@gmail.com> wrote:
> In this version:
>
> - rebased against latest drm-next.
> - cleaned up header includes in ipu-vdi.c.
> - do away with struct ipu_ic_tile_off in ipu-ic.c, and move tile offsets
>   into struct ipu_ic_tile. This paves the way for possibly allowing for
>   each tile to have different dimensions in the future.
>
>
> Steve Longerbeam (4):
>   gpu: ipu-v3: Add Video Deinterlacer unit
>   gpu: ipu-v3: Add FSU channel linking support
>   gpu: ipu-ic: Add complete image conversion support with tiling
>   gpu: ipu-ic: allow multiple handles to ic
>
>  drivers/gpu/ipu-v3/Makefile     |    2 +-
>  drivers/gpu/ipu-v3/ipu-common.c |  142 ++++
>  drivers/gpu/ipu-v3/ipu-ic.c     | 1719 ++++++++++++++++++++++++++++++++++++++-
>  drivers/gpu/ipu-v3/ipu-prv.h    |   33 +
>  drivers/gpu/ipu-v3/ipu-vdi.c    |  243 ++++++
>  include/video/imx-ipu-v3.h      |   93 ++-
>  6 files changed, 2195 insertions(+), 37 deletions(-)
>  create mode 100644 drivers/gpu/ipu-v3/ipu-vdi.c
>

Philipp,

Have you had a chance to review this last series of Steve's submitted
last week? We are down to 4 patches in gpu/ipu-v3 needed in order to
get his IMX5/6 capture driver into staging and the sooner we do that
the sooner we can get more testing and additional support/features for
it.

Regards,

Tim
