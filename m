From: Thierry Reding <thierry.reding@gmail.com>
Date: Tue, 12 Apr 2016 11:51:55 +0000
Subject: Re: [PATCH v5 16/46] pwm: move the enabled/disabled info into pwm_state
Message-Id: <20160412115155.GN18882@ulmo.ba.sec>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="ztcJpsdPpsnnlAp8"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
 <1459368249-13241-17-git-send-email-boris.brezillon@free-electrons.com>
In-Reply-To: <1459368249-13241-17-git-send-email-boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
To: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mike Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kamil Debski <k.debski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Jacek Anaszewski <j.anaszewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jo>


--ztcJpsdPpsnnlAp8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 30, 2016 at 10:03:39PM +0200, Boris Brezillon wrote:
[...]
> @@ -145,7 +146,11 @@ static inline void pwm_get_state(const struct pwm_de=
vice *pwm,
> =20
>  static inline bool pwm_is_enabled(const struct pwm_device *pwm)
>  {
> -	return test_bit(PWMF_ENABLED, &pwm->flags);
> +	struct pwm_state pstate;

No need for the p prefix, in my opinion.

Thierry

--ztcJpsdPpsnnlAp8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXDOFbAAoJEN0jrNd/PrOhsToP/1uhEhMZpq9YKlTiLiibDzYV
zrFHNUSyfTcQw558pV4nyn6M+I2lfMYSEEsAhcxQQbZBY1adaijQfv3lnwQiBQ8C
4D6KR/Y8fT/r0/JXx4MuXPHx4D0/CSobFXiv2Oi3FGGG4ZvsGunkVxXq/Sad0EQp
xFE1wUzT0zSYZNP3eoeP35kgVo5431m0eSgNxaqbPM8qEkX8iuwz/GZncEymJeO5
1P1teQy9lo48s6DkT1M4NEIKGgWH0EU4J14DYYO3h+aQ+mkalX11ZZTlhxr5drli
tGM/QhY/TRD3Rc9CEO5d9Fxu6Xn90GsG1oEwg64tDafO/9372A6tFTzYvCMqnYqf
6ezYLCrdWu2r2IIjYaeXzUnEyBcoRkNg1qNa0Vk6TbpehsWFNIYrTAejTKCXQqwB
sPqYwe6xpNCbsTckkxJPpSnvZfFe57rOIxDxO1ZWNW6Bn1ZjDwsU0TauRxxlTr83
BwcGdrySQVgLuhw0pqu4xuQVd5bRI8SB0S9NJXfkR9KLaTI/ZsIB556GZbAsIVbh
2aLkvqvOTNqIKUFV10p+lsH8aYEOreyXRLgjtGorSdViYLy3dzmjhtHD5yUy4K7X
7mY6B5GLv6D3o1N0dfaiz5CWYZ9RDmdFwcSxq2KP9jrZT8HRSO9is2lsDjEbA6nv
1xjYbH/4MybBBst/ECXX
=af3Z
-----END PGP SIGNATURE-----

--ztcJpsdPpsnnlAp8--
