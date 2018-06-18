From: Daniel Vetter <daniel@ffwll.ch>
Date: Mon, 18 Jun 2018 07:43:20 +0000
Subject: Re: [PATCH 1/3] drm: mxsfb: Change driver.name to mxsfb-drm
Message-Id: <20180618074320.GS3438@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1529091248.git.leonard.crestez@nxp.com>
 <47ea7572011735b68a8a70f0e11bdf00cb2fd86a.1529091248.git.leonard.crestez@nxp.com>
 <CAOMZO5B8i0gN+rCq-yPrd112NkwJWTxYCtsLVeLhD1JLRuX6EQ@mail.gmail.com>
 <07be6d9a85b6be655fc2b084be81d8bf9715b57a.camel@nxp.com>
 <638457fd-85da-8fec-d146-517c43f71813@denx.de>
 <b3fa74c5110b45e5992920485749869ab1f7ebce.camel@nxp.com>
 <6995fa4b-47a9-887b-5e4f-4284ca6a2c79@gmail.com>
In-Reply-To: <6995fa4b-47a9-887b-5e4f-4284ca6a2c79@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Marek Vasut <marek.vasut@gmail.com>
Cc: "marex@denx.de" <marex@denx.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "marcofrk@gmail.com" <marcofrk@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Leonard Crestez <leonard.crestez@nxp.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, dl-linux-imx <linux-imx@nxp.com>

On Sat, Jun 16, 2018 at 01:32:44AM +0200, Marek Vasut wrote:
> On 06/16/2018 12:42 AM, Leonard Crestez wrote:
> > On Fri, 2018-06-15 at 23:36 +0200, Marek Vasut wrote:
> >> On 06/15/2018 10:58 PM, Leonard Crestez wrote:
> >>> On Fri, 2018-06-15 at 16:47 -0300, Fabio Estevam wrote:
> >>>> On Fri, Jun 15, 2018 at 4:43 PM, Leonard Crestez
> >>>> <leonard.crestez@nxp.com> wrote:
> > 
> >>>>> The FBDEV driver uses the same name and both can't be registered at the
> >>>>> same time. Fix this by renaming the drm driver to mxsfb-drm
> >>>>
> >>>> Stefan sent the same patch a few days ago:
> >>>
> >>> In that thread there is a proposal for removing the old fbdev/mxsfb
> >>> driver entirely.
> >>>
> >>> That would break old DTBs, isn't this generally considered bad? Also,
> >>> are we sure the removal of fbdev/mxsfb wouldn't lose any features?
> >>>
> >>> What my series does is make both drivers work with the same kernel
> >>> image and turns the choice into a board-level dtb decision. Supporting
> >>> everything at once seems desirable to me and it allows for a very
> >>> smooth upgrade path.
> >>
> >> Having two drivers in the kernel with different set of bugs is always bad.
> >>
> >>> The old driver could be removed later, after all users are converted.
> >>
> >> Both drivers were in for long enough already. And let's be realistic,
> >> how many MX23/MX28 users of old DTs with new kernels are there who
> >> cannot update the DT as well ?
> > 
> > Grepping for "display =" in arch/arm/boot/dts/imx* I see that old
> > bindings are also used by 3rd-party boards for imx6/7:
> >  * imx6sx-nitrogen6sx
> >  * imx6ul-geam
> >  * imx6ul-isiot
> >  * imx6ul-opos6uldev
> >  * imx6ul-pico-hobbit
> >  * imx6ul-tx6ul
> >  * imx7d-nitrogen7
> 
> Er, yes, a handful of boards which could be updated :)
> 
> > Converting everything might be quite a bit of work, and explicitly
> > supporting old bindings is also work.
> 
> Does adding support for old bindings justify the effort invested ? I
> doubt so, it only adds more code to maintain.
> 
> > It is very confusing that there is a whole set of displays for imx6/7
> > which are supported by upstream but only with a non-default config.
> > While it is extremely common in the embedded field to have custom
> > configs the default one in the kernel should try to "just work".
> > 
> > Couldn't this patch series be considered a bugfix? It was also
> > surprisingly small.
> 
> I think it's just a workaround which allows you to postpone the real
> fix, and I don't like that.

Yeah agreed, imo the proper fix here would be to either update the dts for
the affected boards and/or make mxsfb accept the old dt bindings for
backwards compat. Artificially extending the life of the fbdev drivers
seems silly.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
