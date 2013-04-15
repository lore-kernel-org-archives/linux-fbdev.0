From: Eric =?UTF-8?B?QsOpbmFyZA==?= <eric@eukrea.com>
Date: Mon, 15 Apr 2013 13:13:16 +0000
Subject: Re: [PATCH v3 2/2] video: imxfb: Add DT support
Message-Id: <20130415151316.4d49e9b2@e6520eb>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1365157876-1757-1-git-send-email-mpa@pengutronix.de>
 <1365157876-1757-3-git-send-email-mpa@pengutronix.de>
 <20130408075742.GR20693@game.jcrosoft.org>
 <20130414143132.GD27394@pengutronix.de>
 <20130415124321.GB15139@game.jcrosoft.org>
In-Reply-To: <20130415124321.GB15139@game.jcrosoft.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Hi,

Le Mon, 15 Apr 2013 14:43:21 +0200,
Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com> a =C3=A9crit :

> On 16:31 Sun 14 Apr     , Markus Pargmann wrote:
> > On Mon, Apr 08, 2013 at 09:57:42AM +0200, Jean-Christophe PLAGNIOL-VILL=
ARD wrote:
> > > On 12:31 Fri 05 Apr     , Markus Pargmann wrote:
> > > > Add devicetree support for imx framebuffer driver. It uses the gene=
ric
> > > > display bindings and helper functions.
> > > >=20
> > > > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > > > Cc: Fabio Estevam <festevam@gmail.com>
> > > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > > ---
> > > >  .../devicetree/bindings/video/fsl,imx-fb.txt       |  49 ++++++
> > > >  drivers/video/imxfb.c                              | 192 +++++++++=
++++++++----
> > > >  2 files changed, 207 insertions(+), 34 deletions(-)
> > > >  create mode 100644 Documentation/devicetree/bindings/video/fsl,imx=
-fb.txt
> > > >=20
> > > > diff --git a/Documentation/devicetree/bindings/video/fsl,imx-fb.txt=
 b/Documentation/devicetree/bindings/video/fsl,imx-fb.txt
> > > > new file mode 100644
> > > > index 0000000..bde9c77
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/video/fsl,imx-fb.txt
> > > > @@ -0,0 +1,49 @@
> > > > +Freescale imx21 Framebuffer
> > > > +
> > > > +This framebuffer driver supports devices imx1, imx21, imx25, and i=
mx27.
> > > > +
> > > > +Required properties:
> > > > +- compatible : "fsl,<chip>-fb", chip should be imx1 or imx21
> > > > +- reg : Should contain 1 register ranges(address and length)
> > > > +- interrupts : One interrupt of the fb dev
> > > > +
> > > > +Required nodes:
> > > > +- display: Phandle to a display node as described in
> > > > +	Documentation/devicetree/bindings/video/display-timing.txt
> > > > +	Additional, the display node has to define properties:
> > > > +	- fsl,bpp: Bits per pixel
> > > > +	- fsl,pcr: LCDC PCR value
> > > > +
> > > > +Optional properties:
> > > > +- dmacr-eukrea: Should be set for eukrea boards.
> > > why ?
> >=20
> > Because eukrea boards have a different dmacr then all other boards using
> > imxfb. The dmacr address is hardcoded as defaults in the code. I could
> > also search for the board name in the DT, but there are no eukrea boards
> > with DT at the moment, so I thought a bool property may be better for
> > the moment.
> so no if an other board come will have an other property no
>=20
> add an optionnal option to pass the dmacr

I didn't follow the thread but dmacr is not specific to our boards :
$ grep -rn dmacr arch/arm/mach-imx/
arch/arm/mach-imx/mach-mx27_3ds.c:446:	.dmacr		=3D 0x00020010,
arch/arm/mach-imx/mach-mx21ads.c:231:	.dmacr		=3D 0x00020008,
arch/arm/mach-imx/mach-mxt_td60.c:210:	.dmacr		=3D 0x00020010,
arch/arm/mach-imx/eukrea_mbimx27-baseboard.c:192:	.dmacr		=3D 0x00040060,
arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c:165:	.dmacr		=3D 0x00040060,
arch/arm/mach-imx/mach-mx27ads.c:241:	.dmacr		=3D 0x00020010,
arch/arm/mach-imx/mach-pca100.c:351:	.dmacr		=3D 0x00020010,
arch/arm/mach-imx/pcm970-baseboard.c:185:	.dmacr		=3D 0x00020010,
arch/arm/mach-imx/mach-mx25_3ds.c:173:	.dmacr		=3D 0x00020010,

Best regards,
Eric
