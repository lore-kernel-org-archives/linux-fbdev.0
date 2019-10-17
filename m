From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Thu, 17 Oct 2019 13:18:02 +0000
Subject: Re: [PATCH] backlight: pwm_bl: configure pwm only once per backlight toggle
Message-Id: <20191017131802.defwuzrgq4ai4mud@holly.lan>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191017081059.31761-1-u.kleine-koenig@pengutronix.de>
 <20191017114727.fy5tg2kgi6mr2sei@holly.lan>
 <20191017121945.cmcvaffmbd7zydrm@pengutronix.de>
In-Reply-To: <20191017121945.cmcvaffmbd7zydrm@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, Adam Ford <aford173@gmail.com>, dri-devel@lists.freedesktop.org, Thierry Reding <thierry.reding@gmail.com>, kernel@pengutronix.de, Jingoo Han <jingoohan1@gmail.com>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Lee Jones <lee.jones@linaro.org>

On Thu, Oct 17, 2019 at 02:19:45PM +0200, Uwe Kleine-K=F6nig wrote:
> On Thu, Oct 17, 2019 at 12:47:27PM +0100, Daniel Thompson wrote:
> > On Thu, Oct 17, 2019 at 10:10:59AM +0200, Uwe Kleine-K=F6nig wrote:
> > > A previous change in the pwm core (namely 01ccf903edd6 ("pwm: Let
> > > pwm_get_state() return the last implemented state")) changed the
> > > semantic of pwm_get_state() and disclosed an (as it seems) common
> > > problem in lowlevel PWM drivers. By not relying on the period and duty
> > > cycle being retrievable from a disabled PWM this type of problem is
> > > worked around.
> > >=20
> > > Apart from this issue only calling the pwm_get_state/pwm_apply_state
> > > combo once is also more effective.
> >=20
> > I'm only interested in the second paragraph here.
> >=20
> > There seems to be a reasonable consensus that the i.MX27 and cros-ec
> > PWM drivers should be fixed for the benefit of other PWM clients.
> > So we make this change because it makes the pwm-bl better... not to
> > work around bugs ;-).
>=20
> That's fine, still I think it's fair to explain the motivation of
> creating this patch.

Maybe.

Whether this patch is a workaround or simply an improvement to pwm-bl
does need to be clear since it affects whether Lee steers it towards
v5.4-rcX or linux-next .


Daniel.
