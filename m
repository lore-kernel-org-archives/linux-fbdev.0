From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=  <u.kleine-koenig@pengutronix.de>
Date: Tue, 24 Mar 2020 12:57:35 +0000
Subject: Re: [PATCH v11 10/12] backlight: pwm_bl: Use 64-bit division function
Message-Id: <20200324125735.2mjuvbxt5bpon2ft@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1584667964.git.gurus@codeaurora.org>
 <17fc1dcf8b9b392d1e37dc7e3e67409e3c502840.1584667964.git.gurus@codeaurora.org>
 <20200320133123.GD5477@dell> <20200324110710.GL5477@dell>
In-Reply-To: <20200324110710.GL5477@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Lee Jones <lee.jones@linaro.org>, Thierry Reding <thierry.reding@gmail.com>
Cc: Guru Das Srinagesh <gurus@codeaurora.org>, Daniel Thompson <daniel.thompson@linaro.org>, linux-pwm@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Subbaraman Narayanamurthy <subbaram@codeaurora.org>

Hello Lee,

On Tue, Mar 24, 2020 at 11:07:10AM +0000, Lee Jones wrote:
> On Fri, 20 Mar 2020, Lee Jones wrote:
>=20
> > On Thu, 19 Mar 2020, Guru Das Srinagesh wrote:
> >=20
> > > Since the PWM framework is switching struct pwm_state.period's dataty=
pe
> > > to u64, prepare for this transition by using div_u64 to handle a 64-b=
it
> > > dividend instead of a straight division operation.
> > >=20
> > > Cc: Lee Jones <lee.jones@linaro.org>
> > > Cc: Daniel Thompson <daniel.thompson@linaro.org>
> > > Cc: Jingoo Han <jingoohan1@gmail.com>
> > > Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > > Cc: linux-pwm@vger.kernel.org
> > > Cc: dri-devel@lists.freedesktop.org
> > > Cc: linux-fbdev@vger.kernel.org
> > >=20
> > > Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
> > > Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> > > ---
> > >  drivers/video/backlight/pwm_bl.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> >=20
> > Can this patch be taken on its own?
>=20
> Hellooooo ...

Conceptually it can. As the last patch depends on this one (and the
others) some coordination might be beneficial. But that's up to Thierry
to decide how (and if) he want this series to be applied.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
