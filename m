From: Mark Brown <broonie@kernel.org>
Date: Tue, 22 Oct 2019 16:36:13 +0000
Subject: Re: [PATCH 05/46] ARM: pxa: split up mach/hardware.h
Message-Id: <20191022163613.GL5554@sirena.co.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="cy9Nn4fUvYST66Pl"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191018154052.1276506-1-arnd@arndb.de>
 <20191018154201.1276638-5-arnd@arndb.de>
In-Reply-To: <20191018154201.1276638-5-arnd@arndb.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-usb@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Dominik Brodowski <linux@dominikbrodowski.net>, linux-mtd@lists.infradead.org, Pavel Machek <pavel@ucw.cz>, Robert Jarzmik <robert.jarzmik@free.fr>, linux-clk@vger.kernel.org, linux-leds@vger.kernel.org, linux-rtc@vger.kernel.org, linux-input@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>, Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org, alsa-devel@alsa-project.org, linux-pm@vger.kernel.org, Haojian Zhuang <haojian.zhuang@gmail.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, linux-fbdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Stephen Boyd <sboyd@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, dri-devel@lists.freedesktop.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Daniel Mack <daniel@zonque.org>


--cy9Nn4fUvYST66Pl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 18, 2019 at 05:41:20PM +0200, Arnd Bergmann wrote:
> The mach/hardware.h is included in lots of places, and it provides
> three different things on pxa:

Acked-by: Mark Brown <broonie@kernel.org>

--cy9Nn4fUvYST66Pl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2vL/wACgkQJNaLcl1U
h9A46Qf/bdiNYPmWVC2CHNC1L2OLkyJ66QpIcTPyD+TqK5kJogwOBaO1gXSF9Zzl
FrZ20C2apP/oPsDhXu0l5d3giQifXBNvev/89QnOX2UBhrtJV9qE4LHll1hjeyKZ
BEGejSMZnKNLyUDKEbrGg/LeAlDx8G1odI34QfZvmSJVBKinRssnwpnH7UNZhU9s
9SvLSPJjxoWD6gDsShV0vYuFkd6XQ68qOna4lj6KknkkAE9jIpQb+fFBVqYNKNgp
Ttp0KkT/l1DAlDx4lMDfWkr/8u3807G0HTJ6xYcjeyd7e40utLqPnFLeQpMS+RGb
96bq1ZoL9nd8PdzO8lOK09fB0kB8Mg==
=tCNh
-----END PGP SIGNATURE-----

--cy9Nn4fUvYST66Pl--
