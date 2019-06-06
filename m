From: Mark Brown <broonie@kernel.org>
Date: Thu, 06 Jun 2019 10:59:54 +0000
Subject: Re: [PATCH 8/8] drivers: regulator: 88pm800: fix warning same module names
Message-Id: <20190606105954.GZ2456@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="JbpSbCMiCLmwdpgc"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190606094736.23970-1-anders.roxell@linaro.org>
In-Reply-To: <20190606094736.23970-1-anders.roxell@linaro.org>
To: Anders Roxell <anders.roxell@linaro.org>
Cc: andrew@lunn.ch, linux-fbdev@vger.kernel.org, airlied@linux.ie, linux-kernel@vger.kernel.org, lee.jones@linaro.org, marex@denx.de, f.fainelli@gmail.com, vivien.didelot@gmail.com, linux-media@vger.kernel.org, b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, mchehab@kernel.org, linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, lgirdwood@gmail.com, shawnguo@kernel.org, davem@davemloft.net, hkallweit1@gmail.com


--JbpSbCMiCLmwdpgc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 06, 2019 at 11:47:36AM +0200, Anders Roxell wrote:

>  obj-$(CONFIG_REGULATOR_88PG86X) += 88pg86x.o
> -obj-$(CONFIG_REGULATOR_88PM800) += 88pm800.o
> +obj-$(CONFIG_REGULATOR_88PM800) += 88pm800-regulator.o
> +88pm800-regulator-objs		:= 88pm800.o

Don't do this, no need for this driver to look different to all the
others in the Makefile - just rename the whole file.

--JbpSbCMiCLmwdpgc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlz48ioACgkQJNaLcl1U
h9CG4wf+KwJtkqXwPsGULtOJI6nSm5LEkmrz72NfdgOqj1WW7rLXjWvVzFh/6QR4
Yx2iXClMJ3RT5wsgfK/nlN0mPPVrA7hVeHFDLig5RdvadGQZd0UdN6BgUYcZpZat
5jUkB6rgNxVOe+6kO4onKQn4RWHwkF3Sy7xlN0adWD2b2qqoZPMy3Sc62S+JtAb7
KcHORRkbS49Q1xEtsikUD7SZY3cgJOqjQ6ZQcd9dr1iEXZr8wQ3A8wAnBtqm+OEQ
ptNlJi9FmLI9Ihk1Ps82hCwgTT8hWRdQU0JxFV5ybOtLv5y24PoXCvdo2NNtRcdr
ysZl+LpymLjvpEgM2ByRehnnqcnyuQ==
=2HyU
-----END PGP SIGNATURE-----

--JbpSbCMiCLmwdpgc--
