From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 02 Jul 2010 12:33:24 +0000
Subject: Re: [PATCH 3/6] ARM: mach-shmobile: extend clock definitions on
Message-Id: <Pine.LNX.4.64.1007021402540.1237@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
References: <Pine.LNX.4.64.1006301137290.17489@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1006301137290.17489@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

On Fri, 2 Jul 2010, Magnus Damm wrote:

> On Wed, Jun 30, 2010 at 6:55 PM, Guennadi Liakhovetski
> <g.liakhovetski@gmx.de> wrote:
> > Add definitions for DV_CLKI and HDMI clocks, extend support for PLLC2 a=
nd some
> > other clocks.
> >
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
>=20
> Hi Guennadi,
>=20
> Thanks for your work on this.
>=20
> > diff --git a/arch/arm/mach-shmobile/clock-sh7372.c b/arch/arm/mach-shmo=
bile/clock-sh7372.c
> > index 26521a7..21cb629 100644
> > --- a/arch/arm/mach-shmobile/clock-sh7372.c
> > +++ b/arch/arm/mach-shmobile/clock-sh7372.c
> > @@ -50,6 +50,12 @@
> > =A0#define SMSTPCR3 =A0 =A0 =A0 0xe615013c
> > =A0#define SMSTPCR4 =A0 =A0 =A0 0xe6150140
> >
> > +/* Fixed 27 MHz video clock from DV_CLKI pin */
> > +static struct clk dv_clki_clk =3D {
> > + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "dv_clki",
> > + =A0 =A0 =A0 .rate =A0 =A0 =A0 =A0 =A0 =3D 27000000,
> > +};
>=20
> Hm, 27MHz is a board property, not a cpu property.

Well, yes, but I think somewhere something suggested, that 27MHz is what=20
you're actually supposed to provide there. Otherwise your board can always =

just call clk_set_rate(), right? Or what's the preferred way to let=20
platforms set up clocks?

> Also, you don't want to use "name" in struct clk. clkdev is used for
> lookup these days.

Right, it is not needed, thanks.

> > =A0/* PLLC2 */
> > +
> > +/* Indices are important - they are the actual src selecting values */
> > +static struct clk *pllc2_parent[] =3D {
> > + =A0 =A0 =A0 [0] =3D &extal1_div2_clk,
> > + =A0 =A0 =A0 [1] =3D &extal2_div2_clk,
> > + =A0 =A0 =A0 [2] =3D &dv_clki_div2_clk,
> > + =A0 =A0 =A0 [3] =3D NULL, =A0 =A0 /* extal2_div4 not implemented yet*/
> > +};
>=20
> Why not implemented yet?

Because it's not used yet. Should I implement it anyway?

> > + =A0 =A0 =A0 /*
> > + =A0 =A0 =A0 =A0* TODO: If the PLL is off, mult should be =3D 1, but t=
he clock must be
> > + =A0 =A0 =A0 =A0* stopped during re-parenting, a better solution to th=
is conflict
> > + =A0 =A0 =A0 =A0* should be found.
> > + =A0 =A0 =A0 =A0*/
> > + =A0 =A0 =A0 mult =3D (((__raw_readl(PLLC2CR) >> 24) & 0x3f) + 1) * 2;
>=20
> Yes, this needs to be fixed.

You mean now or in the future? If now - I don't see a reasonable fix so=20
far... Do you?

> > +enum { DIV6_HDMI, DIV6_REPARENT_NR };
> > +
> > +/* Indices are important - they are the actual src selecting values */
> > +static struct clk *hdmi_parent[] =3D {
> > + =A0 =A0 =A0 [0] =3D &pllc1_div2_clk,
> > + =A0 =A0 =A0 [1] =3D &pllc2_clk,
> > + =A0 =A0 =A0 [2] =3D &dv_clki_clk,
> > + =A0 =A0 =A0 [3] =3D NULL, =A0 =A0 /* pllc2_div4 not implemented yet */
> > +};
> > +
> > +static struct clk div6_reparent_clks[DIV6_REPARENT_NR] =3D {
> > + =A0 =A0 =A0 [DIV6_HDMI] =3D SH_CLK_DIV6_EXT(&pllc1_div2_clk, HDMICKCR=
, 0,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 hdmi_parent, ARRAY_SIZE(hdmi_parent), 6, 2),
> > +};
>=20
> This part looks nice and clean IMO. Thanks!

Thanks for the review!
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
