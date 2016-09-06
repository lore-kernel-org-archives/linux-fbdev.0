From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 06 Sep 2016 08:21:33 +0000
Subject: Re: [PATCH] video: mxsfb: get supply regulator optionally
Message-Id: <f8368040-bb5a-91e0-7511-df462719b949@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="d9rMwqaPJU5gkXo4pw1HjsC1Fq1KWqSli"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20160904042627.30182-1-stefan@agner.ch>
In-Reply-To: <20160904042627.30182-1-stefan@agner.ch>
To: Stefan Agner <stefan@agner.ch>, plagnioj@jcrosoft.com
Cc: robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>

--d9rMwqaPJU5gkXo4pw1HjsC1Fq1KWqSli
Content-Type: multipart/mixed; boundary="hTBspXKHnLHCQBupCUn93NEEvpGSsB9fQ";
 protected-headers="v1"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Stefan Agner <stefan@agner.ch>, plagnioj@jcrosoft.com
Cc: robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mark Brown <broonie@kernel.org>
Message-ID: <f8368040-bb5a-91e0-7511-df462719b949@ti.com>
Subject: Re: [PATCH] video: mxsfb: get supply regulator optionally
References: <20160904042627.30182-1-stefan@agner.ch>
In-Reply-To: <20160904042627.30182-1-stefan@agner.ch>

--hTBspXKHnLHCQBupCUn93NEEvpGSsB9fQ
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

On 04/09/16 07:26, Stefan Agner wrote:
> The lcd-supply is meant to be optional, there are several device-
> trees not specifying it and the code handles error values silently.
> Therefor, avoid creating a dummy regulator (and the associated
> warning) by using devm_regulator_get_optional.
>=20
> While at it, document that fact also in the device-tree bindings.

The binding change looks correct, but using
devm_regulator_get_optional() does not sound correct.

devm_regulator_get_optional() is to be used when the device in question
truly can function without the power supply. But if the supply is there,
it's just not controlled by the SW, devm_regulator_get() is to be used.

At least this is my understanding.

 Tomi


--hTBspXKHnLHCQBupCUn93NEEvpGSsB9fQ--

--d9rMwqaPJU5gkXo4pw1HjsC1Fq1KWqSli
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXznyOAAoJEPo9qoy8lh71DNQP+wQAwufULRTBiNTpC3xkdL5t
8SY9YP5mG0KEWp6O312QET6nwu5V/b9edVH9l3nQPmKHL9QO7k58f4KTfbeCbawr
tbc+o5FNKBtA1jJPEddzw4/0gGFbL1VRxCOTsK2Zb0FA5ensWLV3cU/toZ5cFtWw
FGcWTczcIXXQX9bwdd5R/eoF57dHSpngwL3FN3DBtAl5cWlIIQJBjUMQr2/nXu5a
m0brO8eGgD+03BQLr3o+YHw93//1x8e/Xa+SsKm1hv+juZhC4zMpNMUtJfonm3Xh
Xo1Q6DGj9kmDXx+xjnIJJLRQkBEKD9VPH09xioO1poreRK04tgBF+iE/U/7UW01U
nwt6d3KKmqkH862ulNe0Xd19Dcm2NM/RxZFY/PeHRwcbFA+BitnTNl92ojuvWjBd
YpFjJSE2pzB19Uky80BDnLQuLGSMI5LyZyhIpMDfhkRNQ2TJpbXJ4IcTdY30rJ7v
CG9yq+gZh2+F7OnEshtz57TJnmJmsd3FU6x6q+gk8qHZe8+R+YgBQaqYvXK3GPlT
r9AoKEgzbLkg2ZomLYlf9kjTy6ri41Kgp7JTBzVI6IiUnO4eNja6maTpYCDMPllR
LzOLl0wSQd+YAgvjClFeWDdziCtD2xI416pcTbf8TO04ETJV/Wnvclq9gUNbUlJh
CGABOzfKHM0IMIZO3ij5
=jvPP
-----END PGP SIGNATURE-----

--d9rMwqaPJU5gkXo4pw1HjsC1Fq1KWqSli--
