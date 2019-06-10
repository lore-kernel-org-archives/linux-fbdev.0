From: Anders Roxell <anders.roxell@linaro.org>
Date: Mon, 10 Jun 2019 13:03:52 +0000
Subject: Re: [PATCH 5/8] drivers: media: coda: fix warning same module names
Message-Id: <CADYN=9KY5=FzrkC7MKj9QnG-eM1NVuL00w8Xv4yU2r05rhr7WQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190606094722.23816-1-anders.roxell@linaro.org> <d6b79ee0-07c6-ad81-16b0-8cf929cc214d@xs4all.nl>
In-Reply-To: <d6b79ee0-07c6-ad81-16b0-8cf929cc214d@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hans Verkuil <hverkuil@xs4all.nl>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, p.zabel@pengutronix.de, andrew@lunn.ch, vivien.didelot@gmail.com, f.fainelli@gmail.com, marex@denx.de, stefan@agner.ch, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, shawnguo@kernel.org, s.hauer@pengutronix.de, b.zolnierkie@samsung.com, a.hajda@samsung.com, hkallweit1@gmail.com, Lee Jones <lee.jones@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, David Miller <davem@davemloft.net>, Networking <netdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-fbdev@vger.kernel.org, linux-media@vger.kernel.org

On Thu, 6 Jun 2019 at 12:13, Hans Verkuil <hverkuil@xs4all.nl> wrote:
>
> On 6/6/19 11:47 AM, Anders Roxell wrote:
> > When building with CONFIG_VIDEO_CODA and CONFIG_CODA_FS enabled as
> > loadable modules, we see the following warning:
> >
> > warning: same module names found:
> >   fs/coda/coda.ko
> >   drivers/media/platform/coda/coda.ko
> >
> > Rework so media coda matches the config fragment. Leaving CODA_FS as is
> > since thats a well known module.
> >
> > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> > ---
> >  drivers/media/platform/coda/Makefile | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/media/platform/coda/Makefile b/drivers/media/platform/coda/Makefile
> > index 54e9a73a92ab..588e6bf7c190 100644
> > --- a/drivers/media/platform/coda/Makefile
> > +++ b/drivers/media/platform/coda/Makefile
> > @@ -1,6 +1,6 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> >
> > -coda-objs := coda-common.o coda-bit.o coda-gdi.o coda-h264.o coda-mpeg2.o coda-mpeg4.o coda-jpeg.o
> > +video-coda-objs := coda-common.o coda-bit.o coda-gdi.o coda-h264.o coda-mpeg2.o coda-mpeg4.o coda-jpeg.o
> >
> > -obj-$(CONFIG_VIDEO_CODA) += coda.o
> > +obj-$(CONFIG_VIDEO_CODA) += video-coda.o
>
> How about imx-coda? video-coda suggests it is part of the video subsystem,
> which it isn't.

I'll resend a v2 shortly with imx-coda instead.


Cheers,
Anders

>
> Regards,
>
>         Hans
>
> >  obj-$(CONFIG_VIDEO_IMX_VDOA) += imx-vdoa.o
> >
>
