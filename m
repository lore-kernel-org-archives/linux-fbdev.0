From: Markus Pargmann <mpa@pengutronix.de>
Date: Tue, 05 Mar 2013 16:40:14 +0000
Subject: Re: [PATCH 2/2] video: imxfb: Add DT support
Message-Id: <20130305164014.GA11656@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1362152467-27998-1-git-send-email-mpa@pengutronix.de>
 <1362152467-27998-3-git-send-email-mpa@pengutronix.de>
 <20130304074851.GZ1906@pengutronix.de>
In-Reply-To: <20130304074851.GZ1906@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Mar 04, 2013 at 08:48:51AM +0100, Sascha Hauer wrote:
> On Fri, Mar 01, 2013 at 04:41:07PM +0100, Markus Pargmann wrote:
> > Add devicetree support for imx framebuffer driver. It uses the generic
> > display bindings and helper functions.
> > 
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > ---
> >  .../devicetree/bindings/video/fsl,imx-fb.txt       |  30 ++++
> >  drivers/video/imxfb.c                              | 176 +++++++++++++++++----
> >  2 files changed, 173 insertions(+), 33 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/video/fsl,imx-fb.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/video/fsl,imx-fb.txt b/Documentation/devicetree/bindings/video/fsl,imx-fb.txt
> > new file mode 100644
> > index 0000000..fd88d26
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/video/fsl,imx-fb.txt
> > @@ -0,0 +1,30 @@
> > +Freescale imx21 Framebuffer
> > +
> > +This framebuffer driver supports chips imx1 and imx21.
> > +
> > +Required properties:
> > +- compatible : "fsl,<chip>-fb"
> > +- reg : Should contain 1 register ranges(address and length)
> > +- interrupts : One interrupt of the fb dev
> > +
> > +Required nodes:
> > +- display: a display node is required to initialize the lcd panel
> > +	This should be in the board dts. See definition in
> > +	Documentation/devicetree/bindings/video/via,vt8500-fb.txt
> > +- default-mode: a videomode node as specified in
> > +	Documentation/devicetree/bindings/video/via,vt8500-fb.txt
> 
> Since the of_videomode helpers didn't add a binding in itself, they
> don't have a binding description in Documentation/devicetree/.
> It's forseeable that drivers will use this binding in the near
> future, so we should probably add a separate Documentation file
> for it instead of referencing some driver which already implements
> the binding.

I checked again, there is a binding description at
Documentation/devicetree/bindings/video/display-timing.txt . I replaced
the reference to the other driver. That was actually from a previous
version of this patch.

> 
> > +
> > +Optional properties:
> > +- pwmr: Address of pwmr register
> 
> This describes the imxfb internal PWM controller. Please drop this for
> now or add a proper PWM driver for it.

Okay, removed.

> 
> > +- lscr1: Address of lscr1 register
> > +- dmacr: Address of dmacr register
> 
> I think we shouldn't expose these to the devicetree. With platform_data
> this hasn't been nice, but ok. With devicetree this becomes an API, so
> we should think of something better. Can't we make up sensible values
> during runtime?

I checked the definitions of the platform-data. It seems that all
definitions use the same lscr1 value. So I simply droped that property
and introduced a default value.
For pwmr1 exist two different values, one for eukrea boards and another
for all other boards, so I added two defaults here. The different value
can be selected by setting a bool property 'dmacr-eukrea'.

Regards,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
