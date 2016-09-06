From: Mark Brown <broonie@kernel.org>
Date: Tue, 06 Sep 2016 22:22:36 +0000
Subject: Re: [PATCH] video: mxsfb: get supply regulator optionally
Message-Id: <20160906222236.GU3950@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="+smLgjZrX8DJCqNF"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20160904042627.30182-1-stefan@agner.ch>
 <f8368040-bb5a-91e0-7511-df462719b949@ti.com>
 <4b3a7bda2202a536efaf4a693234c273@agner.ch>
In-Reply-To: <4b3a7bda2202a536efaf4a693234c273@agner.ch>
To: Stefan Agner <stefan@agner.ch>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, plagnioj@jcrosoft.com, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org


--+smLgjZrX8DJCqNF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 06, 2016 at 11:23:31AM -0700, Stefan Agner wrote:
> On 2016-09-06 01:21, Tomi Valkeinen wrote:

> > In order to ease transitions with drivers are boards start using regulators
> > provide an option to cause all regulator_get() calls to succeed, with a
> > dummy always on regulator being supplied where one has not been configured.
> > A warning is printed whenever the dummy regulator is used to aid system
> > development.

> I think we should either make the property mandatory and fix the device
> trees or we should fix the driver to support an optional regulator. The
> code already supports the reg_lcd being NULL, which is probably mostly
> pointless right now as devm_regulator_get always returns a dummy
> regulator.

I think you're agreeing with each other here (and me).

--+smLgjZrX8DJCqNF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCAAGBQJXz0GrAAoJECTWi3JdVIfQCAQH/0+z8RO1EwgJM4UR7qnEYMUr
wxcMRKOx96OQJw0DB6m0M03IQiSM/18h9q35cVLnVj8q7vt9InToagqZKKDUrLFi
sNCiLJJg4eLtvRQLFcuUYHO5CoenZAWTHml/Nq20qr72MCRNZN8C4TwK1xuoau7O
pA39yl/qZsDAQuX9djKWcusbnvUlkfRr3Lh1XvudvZ9bxR9lm+w3qin+gSwlT37i
+2Q36rCHVZ6AZ9nf2pK0/hP+/fkAxTKrBdwrIE8/AFKyhYoj5EqAApYG/FJjDFb8
y7geZGgX6gUM91JV+pkh6Vx6dtqejbWx24BD4+HsfBK4NYc+yiTEXMAsB4Pbewk=
=7R84
-----END PGP SIGNATURE-----

--+smLgjZrX8DJCqNF--
