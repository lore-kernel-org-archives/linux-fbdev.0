From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Sat, 26 Oct 2013 00:18:54 +0000
Subject: Re: [PATCHv3][ 3/5] video: mx3fb: Add device tree suport.
Message-Id: <20131026001854.GE17135@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1382532229-32755-1-git-send-email-denis@eukrea.com>
 <1382532229-32755-3-git-send-email-denis@eukrea.com>
 <20131025195040.0CCC3C404DA@trevor.secretlab.ca>
In-Reply-To: <20131025195040.0CCC3C404DA@trevor.secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Fri, Oct 25, 2013 at 08:50:40PM +0100, Grant Likely wrote:
> On Wed, 23 Oct 2013 14:43:47 +0200, Denis Carikli <denis@eukrea.com> wrot=
e:
> > Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> > Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > Cc: linux-fbdev@vger.kernel.org
> > Cc: Rob Herring <rob.herring@calxeda.com>
> > Cc: Pawel Moll <pawel.moll@arm.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Stephen Warren <swarren@wwwdotorg.org>
> > Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> > Cc: devicetree@vger.kernel.org
> > Cc: Sascha Hauer <kernel@pengutronix.de>
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: Eric B=E9nard <eric@eukrea.com>
> > Signed-off-by: Denis Carikli <denis@eukrea.com>
> > ---
> > ChangeLog v2->v3:
> > - The device tree bindings were reworked in order to make it look more =
like the
> >   IPUv3 bindings.
> > - The interface_pix_fmt property now looks like the IPUv3 one.
> > ---
> >  .../devicetree/bindings/video/fsl,mx3-fb.txt       |   35 ++++++
> >  drivers/video/Kconfig                              |    2 +
> >  drivers/video/mx3fb.c                              |  125 ++++++++++++=
+++++---
> >  3 files changed, 147 insertions(+), 15 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/video/fsl,mx3-fb.=
txt
> >=20
> > diff --git a/Documentation/devicetree/bindings/video/fsl,mx3-fb.txt b/D=
ocumentation/devicetree/bindings/video/fsl,mx3-fb.txt
> > new file mode 100644
> > index 0000000..0b31374
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/video/fsl,mx3-fb.txt
> > @@ -0,0 +1,35 @@
> > +Freescale MX3 fb
> > +=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Required properties:
> > +- compatible: Should be "fsl,mx3fb". compatible chips include the imx3=
1 and the
> > +  imx35.
> > +- reg: should be register base and length as documented in the datashe=
et.
> > +- clocks: Handle to the ipu_gate clock.
> > +
> > +Example:
> > +
> > +lcdc: mx3fb@53fc00b4 {
> > +	compatible =3D "fsl,mx3-fb";
> > +	reg =3D <0x53fc00b4 0x0b>;
> > +	clocks =3D <&clks 55>;
> > +};
>=20
> This (and some of the other bindings) are trivial, and they are all
> associated with a single SoC. I think it would be better to collect all
> the mx3 bindings into a single file rather than distributing them all
> over the bindings tree.
>=20
> I started thinking about this after some of the DT conversations in
> Edinburgh this week. Unless there is a high likelyhood of components
> being used separately, I think it is far more useful to collect all the
> bindings for an SoC into a single file. It will certainly reduce a lot
> of the boilerplate that we've been collecting in bindings documentation
> files.
>=20
> A long time ago I took that approach for the mpc5200 documentation[1].
> Take a look at that organization and let me know what you think.

I don't think this is a good idea. When a new SoC comes out we don't
know which components will be reused on the next SoC. This will cause a
lot of bikeshedding when it actually is reused and then has to be moved.

Also I would find it quite inconsistent if I had to lookup some devices
in a SoC file and most bindings in subsystem specific files. So when
searching for a binding I would first have to know if the hardware is
unique to the SoC or not.

Sascha

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
