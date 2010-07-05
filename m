From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 05 Jul 2010 05:04:40 +0000
Subject: Re: [PATCH 5/6] fbdev: sh-mobile: HDMI support for SH-Mobile SoCs
Message-Id: <AANLkTinLGcpb04g-xquT9t2wStHrFgETbN2bKcm6CpSv@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

On Wed, Jun 30, 2010 at 6:55 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> Some SH-Mobile SoCs have an HDMI controller and a PHY, attached to one of=
 their
> LCDC interfaces. This patch adds a preliminary static support for such
> controllers, this means, that only the 720p mode is handled ATM. Support =
for
> more modes and a dynamic switching between them will be added by a follow=
 up
> patch.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
> =A0arch/arm/mach-shmobile/clock-sh7372.c | =A0 =A02 +-
> =A0drivers/video/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A08 +
> =A0drivers/video/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A01 +
> =A0drivers/video/sh_mobile_hdmi.c =A0 =A0 =A0 =A0| 1070 +++++++++++++++++=
++++++++++++++++
> =A0drivers/video/sh_mobile_lcdcfb.c =A0 =A0 =A0| =A0190 +++++--
> =A0include/video/sh_mobile_hdmi.h =A0 =A0 =A0 =A0| =A0 22 +
> =A0include/video/sh_mobile_lcdc.h =A0 =A0 =A0 =A0| =A0 =A01 +
> =A07 files changed, 1243 insertions(+), 51 deletions(-)
> =A0create mode 100644 drivers/video/sh_mobile_hdmi.c
> =A0create mode 100644 include/video/sh_mobile_hdmi.h
>
> diff --git a/arch/arm/mach-shmobile/clock-sh7372.c b/arch/arm/mach-shmobi=
le/clock-sh7372.c
> index 21cb629..506a8c5 100644
> --- a/arch/arm/mach-shmobile/clock-sh7372.c
> +++ b/arch/arm/mach-shmobile/clock-sh7372.c
> @@ -484,7 +484,7 @@ static struct clk_lookup lookups[] =3D {
> =A0 =A0 =A0 =A0CLKDEV_CON_ID("sub_clk", &div6_clks[DIV6_SUB]),
> =A0 =A0 =A0 =A0CLKDEV_CON_ID("spu_clk", &div6_clks[DIV6_SPU]),
> =A0 =A0 =A0 =A0CLKDEV_CON_ID("vou_clk", &div6_clks[DIV6_VOU]),
> - =A0 =A0 =A0 CLKDEV_CON_ID("hdmi_clk", &div6_reparent_clks[DIV6_HDMI]),
> + =A0 =A0 =A0 CLKDEV_DEV_ID("sh-mobile-hdmi", &div6_reparent_clks[DIV6_HD=
MI]),
> =A0 =A0 =A0 =A0CLKDEV_CON_ID("dsit_clk", &div6_clks[DIV6_DSIT]),
> =A0 =A0 =A0 =A0CLKDEV_CON_ID("dsi0p_clk", &div6_clks[DIV6_DSI0P]),
> =A0 =A0 =A0 =A0CLKDEV_CON_ID("dsi1p_clk", &div6_clks[DIV6_DSI1P]),

No. =3D)

You're changing the name of the clock specified in the data sheet. The
clock name comes from the data sheet. It's not supposed to be tied in
the the device name on this level.

The MSTP bit should be a CLKDEV_DEV_ID().

> +static int __init sh_hdmi_probe(struct platform_device *pdev)
> +{
> + =A0 =A0 =A0 struct sh_mobile_hdmi_info *pdata =3D pdev->dev.platform_da=
ta;
> + =A0 =A0 =A0 struct resource *res =3D platform_get_resource(pdev, IORESO=
URCE_MEM, 0);
> + =A0 =A0 =A0 int irq =3D platform_get_irq(pdev, 0), ret;
> + =A0 =A0 =A0 struct sh_hdmi *hdmi;
> + =A0 =A0 =A0 struct clk *pllc2, *dv_clki_div2;
> + =A0 =A0 =A0 long rate, prate;
> +
> + =A0 =A0 =A0 if (!res || !pdata || irq < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> +
> + =A0 =A0 =A0 hdmi =3D kzalloc(sizeof(*hdmi), GFP_KERNEL);
> + =A0 =A0 =A0 if (!hdmi) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "Cannot allocate device=
 data\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 hdmi->pdata =3D pdata;
> +
> + =A0 =A0 =A0 hdmi->hdmi_clk =3D clk_get(&pdev->dev, "sh-mobile-hdmi");
> + =A0 =A0 =A0 if (IS_ERR(hdmi->hdmi_clk)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(hdmi->hdmi_clk);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "Unable to get clock: %=
d\n", ret);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto egetclk;
> + =A0 =A0 =A0 }
>

So clkdev already should figure out that "sh-mobile-hdmi" is needed by
the device name. The string should be used to specify interface clock
or function clock. For most drivers you do not need to pass any
string. Make sure your platform device id is setup correctly so the
platform device name matches properly with your clkdev table.

> + =A0 =A0 =A0 dv_clki_div2 =3D clk_get(NULL, "dv_clki_div2_clk");
> + =A0 =A0 =A0 if (IS_ERR(dv_clki_div2)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(dv_clki_div2);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "Unable to get clock: %=
d\n", ret);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto egetdvclki;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 pllc2 =3D clk_get(NULL, "pllc2_clk");
> + =A0 =A0 =A0 if (IS_ERR(pllc2)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(pllc2);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "Unable to get clock: %=
d\n", ret);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto egetpllc2;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 clk_disable(pllc2);

You do realize that "pllc2" is shared between a bunch of different
clocks? You most likely do not want to disable it here. Would you like
to disable all other drivers that use this clock? =3D)

Also, that "pllc2" may be a good fit for HDMI is really a cpu-specific
property, and this driver is for the HDMI block that will be present
on multiple processors. So we really don't want any cpu-specific bits
in here.

Remember to pass the device to clk_get(). No need to pass NULL here.

> + =A0 =A0 =A0 ret =3D clk_set_parent(pllc2, dv_clki_div2);
> + =A0 =A0 =A0 if (ret < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "Cannot set parent: %d\=
n", ret);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto esetdvclki;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 pr_debug("PLLC2 initial frequency %lu\n", clk_get_rate(pllc=
2));
> +
> + =A0 =A0 =A0 prate =3D clk_round_rate(pllc2, 594000000);
> + =A0 =A0 =A0 if (prate < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "Cannot get suitable ra=
te: %ld\n", prate);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D prate;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto eprate;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 ret =3D clk_set_rate(pllc2, prate);
> + =A0 =A0 =A0 if (ret < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "Cannot set rate %ld: %=
d\n", prate, ret);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto eprate;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 pr_debug("PLLC2 set frequency %lu\n", prate);

So you're setting the pllc2 rate here...

> + =A0 =A0 =A0 ret =3D clk_enable(pllc2);
> + =A0 =A0 =A0 if (ret < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "Cannot enable clock: %=
d\n", ret);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto epclkenable;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 ret =3D clk_set_parent(hdmi->hdmi_clk, pllc2);
> + =A0 =A0 =A0 if (ret < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "Cannot set parent: %d\=
n", ret);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto esetpllc2;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 rate =3D PICOS2KHZ(pdata->lcd_chan->lcd_cfg.pixclock) * 100=
0;
> +
> + =A0 =A0 =A0 rate =3D clk_round_rate(hdmi->hdmi_clk, rate);
> + =A0 =A0 =A0 if (rate < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D rate;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "Cannot get suitable ra=
te: %ld\n", rate);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto erate;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 clk_enable(hdmi->hdmi_clk);
> + =A0 =A0 =A0 clk_disable(hdmi->hdmi_clk);

(This is far from pretty)

> + =A0 =A0 =A0 ret =3D clk_set_rate(hdmi->hdmi_clk, rate);
> + =A0 =A0 =A0 if (ret < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "Cannot set rate %ld: %=
d\n", rate, ret);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto erate;
> + =A0 =A0 =A0 }

... and then you set the rate of the "hdmi_clk" here...

> + =A0 =A0 =A0 pr_debug("HDMI set frequency %lu\n", rate);
> +
> + =A0 =A0 =A0 ret =3D clk_enable(hdmi->hdmi_clk);
> + =A0 =A0 =A0 if (ret < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "Cannot enable clock: %=
d\n", ret);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto eclkenable;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 dev_info(&pdev->dev, "Enabled HDMI clock at %luHz\n", rate);

Isn't "pllc2_clk" the parent of "hdmi_clk"? Most of this needs to be
dealt with from the processor or board specific code IMO.

Perhaps this is a pretty clear case when we should use function clocks
and interface clocks?

Paul [CC:ed] may have different ideas about this but below is how I
think it should be mapped out:

The function clock should be managed by Runtime PM and MSTP. After
thinking a bit about it I believe that the correct parent of the MSTP
bit should be "hp_clk" (see "Clock Assignment to Modules" table in the
data sheet).

The interface clock should be "hdmi_clk", and the parent of this clock
should be setup by the processor specific code. It should not be part
of the HDMI driver.

I think the mapping between the driver and the clock should be handled
by the clkdev tables. So this HDMI driver should not ask for any
"hdmi_clk".

We need to work a bit more on this part I think. =3D)

Cheers,

/ magnus
