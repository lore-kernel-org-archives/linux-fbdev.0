From: Pavel Machek <pavel@ucw.cz>
Date: Fri, 21 Jul 2017 11:21:34 +0000
Subject: Re: [PATCH v4 3/5] pwm-backlight: add support for PWM delays proprieties.
Message-Id: <20170721112134.GA10340@amd>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="FCuugMFkClbJLl1L"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170721104813.5389-1-enric.balletbo@collabora.com>
 <20170721104813.5389-3-enric.balletbo@collabora.com>
In-Reply-To: <20170721104813.5389-3-enric.balletbo@collabora.com>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Rob Herring <robh+dt@kernel.org>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Heiko Stuebner <heiko@sntech.de>, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, groeck@chromium.org, linux-rockchip@lists.infradead.org


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2017-07-21 12:48:11, Enric Balletbo i Serra wrote:
> Some panels (i.e. N116BGE-L41), in their power sequence specifications,
> request a delay between set the PWM signal and enable the backlight and
> between clear the PWM signal and disable the backlight. Add support for
> the new post-pwm-on-delay-ms and pwm-off-delay-ms proprieties to meet
> the timings.
>=20
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

For 3-5:

Acked-by: Pavel Machek <pavel@ucw.cz>

I guess you probably meant "properties" and I guess english could be
improved in the comments, but... this is good enough and not worth
more iterations.

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAllx474ACgkQMOfwapXb+vIlQwCfQXHVlqRrjnka9TAeEzYqRWI+
SywAn00Bl5ZFSAHZ0EVm1nUU+SDHlzpF
=0ZKG
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--
