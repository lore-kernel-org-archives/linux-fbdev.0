From: Daniel Vetter <daniel@ffwll.ch>
Date: Fri, 13 Jul 2018 07:25:36 +0000
Subject: Re: [PATCH 1/3] drm: mxsfb: Change driver.name to mxsfb-drm
Message-Id: <20180713072536.GX3008@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAOMZO5B8i0gN+rCq-yPrd112NkwJWTxYCtsLVeLhD1JLRuX6EQ@mail.gmail.com>
 <07be6d9a85b6be655fc2b084be81d8bf9715b57a.camel@nxp.com>
 <638457fd-85da-8fec-d146-517c43f71813@denx.de>
 <b3fa74c5110b45e5992920485749869ab1f7ebce.camel@nxp.com>
 <6995fa4b-47a9-887b-5e4f-4284ca6a2c79@gmail.com>
 <fd22085f646d97f66cff5b7f22785500@agner.ch>
 <6fdba55b-0be6-9e28-d87a-43d876a1fd09@denx.de>
 <617c0a7e9132b929877b8cbcf116b1ea@agner.ch>
 <7f40f34a401ced78703b1a151d9f5fe4ed8c209f.camel@nxp.com>
 <039b2914-3393-5e81-82a6-7d517c5818a9@denx.de>
In-Reply-To: <039b2914-3393-5e81-82a6-7d517c5818a9@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Marek Vasut <marex@denx.de>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "marcofrk@gmail.com" <marcofrk@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "marek.vasut@gmail.com" <marek.vasut@gmail.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Leonard Crestez <leonard.crestez@nxp.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, dl-linux-imx <linux-imx@nxp.com>

On Thu, Jul 12, 2018 at 03:14:57PM +0200, Marek Vasut wrote:
> On 07/12/2018 03:03 PM, Leonard Crestez wrote:
> > On Thu, 2018-07-12 at 11:21 +0200, Stefan Agner wrote:
> >> On 10.07.2018 11:11, Marek Vasut wrote:
> >>> On 07/10/2018 11:06 AM, Stefan Agner wrote:
> >>>> This is one of the situation where states quo is kinda the worst
> >>>> situation.
> >>>>
> >>>> Currently imx_v6_v7_defconfig and mxs_defconfig actually still uses
> >>>> CONFIG_FB_MXS.
> >>>>
> >>>> I understand that you'd rather prefer to move forward. I suggest we do
> >>>> it in steps.
> >>>>
> >>>> In 4.19:
> >>>>
> >>>> - Change DRM driver.name to mxsfb-drm so we avoid conflicts for now
> >>>
> >>> But this will break mesa if it depends on mxsfb name for ie. etnaviv
> >>> binding.
> >>
> >> Does it? grep -r -e mxsfb in libdrm and mesa master returns nothing.
> >>
> >> There is also .name in struct drm_driver, which is already set to
> >> mxsfb-drm... Is that the one exposed to user space?
> > 
> > Running etnaviv+x11 with a renamed mxsfb driver works fine on imx6sx-
> > sdb.
> > 
> > Tools like modetest already need -M mxsfb-drm, the drm_driver.name
> > seems to be what matters.
> > 
> >> - Remove CONFIG_FB_MXS from imx_v6_v7_defconfig/mxs_defconfig now, and
> >> only enable CONFIG_DRM_MXSFB=y
> > 
> > If one of the drivers is renamed then they can coexist: since the
> > bindings are distinct one driver will return a probe error and the
> > other will bind successfully. This can even be adjusted so that it
> > doesn't even print ugly scary errors.
> > 
> > This can last until somebody implements support for old bindings in the
> > drm driver and then FB_MXS can just be deleted.
> 
> So why don't we just convert the DT bindings on boards supported
> upstream and zap the old driver ? What is the problem with that?

+1 on zapping drivers :-)

> Realistically, how many MXS boards in the field use old DT and new kernel ?

Yeah I think occasionally that entire "DT is API, can't ever change it"
song is overblown. The rule with regressions isn't that you're never
allowed to break anything, but that you're only allowed to break stuff no
one will notice and report.

If there's realistically no users, go ahead and break (instead of huge and
drawn-out compat plan).

If there's a solid (and automatic enough) fallback like the drm driver,
go ahead and break.

We're doing this all the time in graphics with userspace ABI, I don't
think DT is any different. Every once in a while there's a bit of regrets
and a revert because we missed something, but overal it's much less effort
than always trying to do a perfect job with backwards compat.

Is it really a regression if no one reports it? No.

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
