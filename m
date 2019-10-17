From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=  <u.kleine-koenig@pengutronix.de>
Date: Thu, 17 Oct 2019 18:28:38 +0000
Subject: Re: [PATCH] backlight: pwm_bl: configure pwm only once per backlight toggle
Message-Id: <20191017182838.e3mx3vmwqcvb3aco@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191017081059.31761-1-u.kleine-koenig@pengutronix.de>
 <20191017114727.fy5tg2kgi6mr2sei@holly.lan>
 <20191017121945.cmcvaffmbd7zydrm@pengutronix.de>
 <20191017131802.defwuzrgq4ai4mud@holly.lan>
In-Reply-To: <20191017131802.defwuzrgq4ai4mud@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>, dri-devel@lists.freedesktop.org, Thierry Reding <thierry.reding@gmail.com>, kernel@pengutronix.de, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Lee Jones <lee.jones@linaro.org>, Adam Ford <aford173@gmail.com>

On Thu, Oct 17, 2019 at 02:18:02PM +0100, Daniel Thompson wrote:
> On Thu, Oct 17, 2019 at 02:19:45PM +0200, Uwe Kleine-K=F6nig wrote:
> > On Thu, Oct 17, 2019 at 12:47:27PM +0100, Daniel Thompson wrote:
> > > On Thu, Oct 17, 2019 at 10:10:59AM +0200, Uwe Kleine-K=F6nig wrote:
> > > > A previous change in the pwm core (namely 01ccf903edd6 ("pwm: Let
> > > > pwm_get_state() return the last implemented state")) changed the
> > > > semantic of pwm_get_state() and disclosed an (as it seems) common
> > > > problem in lowlevel PWM drivers. By not relying on the period and d=
uty
> > > > cycle being retrievable from a disabled PWM this type of problem is
> > > > worked around.
> > > >=20
> > > > Apart from this issue only calling the pwm_get_state/pwm_apply_state
> > > > combo once is also more effective.
> > >=20
> > > I'm only interested in the second paragraph here.
> > >=20
> > > There seems to be a reasonable consensus that the i.MX27 and cros-ec
> > > PWM drivers should be fixed for the benefit of other PWM clients.
> > > So we make this change because it makes the pwm-bl better... not to
> > > work around bugs ;-).
> >=20
> > That's fine, still I think it's fair to explain the motivation of
> > creating this patch.
>=20
> Maybe.
>=20
> Whether this patch is a workaround or simply an improvement to pwm-bl
> does need to be clear since it affects whether Lee steers it towards
> v5.4-rcX or linux-next .

Given that there will be a a fix in the pwm subsystem I'd say linux-next
sounds right.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
