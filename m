From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=  <u.kleine-koenig@pengutronix.de>
Date: Tue, 19 May 2015 07:59:08 +0000
Subject: Re: [PATCH] backlight: pwm_bl: Simplify usage of devm_gpiod_get_optional
Message-Id: <20150519075908.GA23505@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1431785290.6638.1.camel@ingics.com>
In-Reply-To: <1431785290.6638.1.camel@ingics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Axel Lin <axel.lin@ingics.com>
Cc: linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <acourbot@nvidia.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>

Hello,

On Sat, May 16, 2015 at 10:08:10PM +0800, Axel Lin wrote:
> Since 39b2bbe3d715 (gpio: add flags argument to gpiod_get*() functions),
> the gpiod_get* functions take an additional parameter that allows to
> specify direction and initial value for output.
> Simplify the usage of devm_gpiod_get_optional accordingly.
>=20
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
as I just sent the same patch:

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

@Axel: Do you have some more patches of this type in the queue? I
currently have several fixes on top of 4.1-rc4. Some of them are still
in a single wip patch, some other are already sent out.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
