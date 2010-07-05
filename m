From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Mon, 05 Jul 2010 15:38:44 +0000
Subject: Re: [PATCH 6/6] ARM: mach-shmobile: add HDMI support to the ap4evb
Message-Id: <Pine.LNX.4.64.1007051714290.2152@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
References: <Pine.LNX.4.64.1006301152570.17489@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1006301152570.17489@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

On Mon, 5 Jul 2010, Magnus Damm wrote:

> On Wed, Jun 30, 2010 at 6:55 PM, Guennadi Liakhovetski
> <g.liakhovetski@gmx.de> wrote:
> > Support HDMI in 720p mode.
> >
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > ---
> > =A0arch/arm/mach-shmobile/board-ap4evb.c | =A0128 +++++++++++++++++++++=
+++++++++++-
> > =A01 files changed, 127 insertions(+), 1 deletions(-)
>=20
> Hi Guennadi,
>=20
> Thanks for your work on this!
>=20
> > --- a/arch/arm/mach-shmobile/board-ap4evb.c
> > +++ b/arch/arm/mach-shmobile/board-ap4evb.c
> > @@ -645,8 +732,36 @@ static void __init gpio_no_direction(u32 addr)
> > =A0#define GPIO_PORT9CR =A0 0xE6051009
> > =A0#define GPIO_PORT10CR =A00xE605100A
> >
> > +static int __init hdmi_init_pm_clock(void)
> > +{
> > + =A0 =A0 =A0 struct clk *hdmi_pm =3D clk_get(NULL, "sh-hdmi.0"),
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *lcdc1_pm =3D clk_get(&lcdc1_device.dev, =
"sh_mobile_lcdc_fb.1");
> > + =A0 =A0 =A0 int ret;
> > +
> > + =A0 =A0 =A0 if (!IS_ERR(hdmi_pm)) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D clk_enable(hdmi_pm);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret < 0)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("Cannot enable clo=
ck: %d\n", ret);
> > + =A0 =A0 =A0 } else {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("Cannot get HDMI PM: %ld\n", PTR_E=
RR(hdmi_pm));
> > + =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 if (!IS_ERR(lcdc1_pm)) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D clk_enable(lcdc1_pm);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret < 0)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("Cannot enable clo=
ck: %d\n", ret);
> > + =A0 =A0 =A0 } else {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("Cannot get LCDC1 PM: %ld\n", PTR_=
ERR(lcdc1_pm));
> > + =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 return 0;
> > +}
>=20
> This part I'm not so happy with.
>=20
> Question 1:
>=20
> Why do you need to statically enable the LCDC clock here? I guess it
> works around the fact that Runtime PM is missing at this point? The
> LCDC driver should manage its own clocks. With this in place the
> clocks will never be disabled and your Runtime PM changes to the LCDC
> driver will never actually stop the clocks.

Not yet on ARM, no. The change to the lcdcfb runtime-pm, that actually=20
does anything at all with HDMI on ap4evb is the addition of ->display_on=20
and ->display_off calls.

> Question 2:
>=20
> And why do we need to enable the HDMI clock here? Same reason as
> above? I imagine that the HDMI driver already does Runtime PM?

Exactly, just like with MIPI (see ap4evb_init_display_clk()).

> Also, you should not need to pass any strings to clk_get(). clkdev
> should be able to figure out the binding from the device name.

Ok

Thanks
Guennadi
---
Guennadi Liakhovetski
