From: Boris Brezillon <boris.brezillon@free-electrons.com>
Date: Thu, 02 Jul 2015 07:46:50 +0000
Subject: Re: [RFC PATCH 12/15] pwm: rockchip: add initial state retrieval
Message-Id: <20150702094650.2f934b22@bbrezillon>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
 <1435738921-25027-13-git-send-email-boris.brezillon@free-electrons.com>
 <3258341.kaLi8uDfLr@diego>
In-Reply-To: <3258341.kaLi8uDfLr@diego>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Wed, 01 Jul 2015 23:44:46 +0200
Heiko St=C3=BCbner <heiko@sntech.de> wrote:

> Hi Boris,
>=20
> Am Mittwoch, 1. Juli 2015, 10:21:58 schrieb Boris Brezillon:
> > Implement the ->init_state() function to expose initial state.
> >=20
> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > ---
>=20
> [...]
>=20
> > @@ -98,6 +110,36 @@ static void rockchip_pwm_set_enable_v2(struct pwm_c=
hip
> > *chip, writel_relaxed(val, pc->base + pc->data->regs.ctrl);
> >  }
> >=20
> > +static void rockchip_pwm_init_state(struct pwm_chip *chip,
> > +				    struct pwm_device *pwm)
> > +{
> > +	struct rockchip_pwm_chip *pc =3D to_rockchip_pwm_chip(chip);
> > +	unsigned long clk_rate;
> > +	u64 tmp;
> > +	int ret;
> > +
> > +	ret =3D clk_enable(pc->clk);
> > +	if (ret)
> > +		return;
> > +
> > +	clk_rate =3D clk_get_rate(pc->clk);
> > +
> > +	tmp =3D readl(pc->base + pc->data->regs.period);
> > +	tmp *=3D pc->data->prescaler * NSEC_PER_SEC;
> > +	tmp =3D do_div(tmp, clk_rate);
>=20
> I guess you want to have the division result here and not the remainder, =
so
> -       tmp =3D do_div(tmp, clk_rate);
> +       do_div(tmp, clk_rate);
>=20

Oh crap. I make the same mistake over and over again.

[...]
> >  static const struct rockchip_pwm_data pwm_data_v2 =3D {
> > @@ -207,6 +252,7 @@ static const struct rockchip_pwm_data pwm_data_v2 =
=3D {
> >  	.prescaler =3D 1,
> >  	.ops =3D &rockchip_pwm_ops_v2,
> >  	.set_enable =3D rockchip_pwm_set_enable_v2,
> > +	.init =3D rockchip_pwm_init_v2,
>=20
> you're referencing the v2 init here, but only add it in the next patch?
> [pwm: rockchip: add support for atomic update]

Yep, this function should be added in this patch.

Thanks,

Boris


--=20
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
