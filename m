From: Pavel Machek <pavel@ucw.cz>
Date: Wed, 24 Apr 2019 14:20:38 +0000
Subject: Re: [PATCH v6 2/3] dt-bindings: backlight: add lm3630a bindings
Message-Id: <20190424142037.GA20237@amd>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="yrj/dFKFPuw6o+aM"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190424092505.6578-1-masneyb@onstation.org>
 <20190424092505.6578-3-masneyb@onstation.org>
In-Reply-To: <20190424092505.6578-3-masneyb@onstation.org>
To: Brian Masney <masneyb@onstation.org>
Cc: lee.jones@linaro.org, daniel.thompson@linaro.org, jingoohan1@gmail.com, robh+dt@kernel.org, jacek.anaszewski@gmail.com, mark.rutland@arm.com, b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, dmurphy@ti.com, jonathan@marek.ca, Rob Herring <robh@kernel.org>


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.=
yaml
> @@ -0,0 +1,129 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds/backlight/lm3630a-backlight.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#

I'm not a great fan on links to external websites. But this is comment
for Rob.

> +title: TI LM3630A High-Efficiency Dual-String White LED
> +
> +maintainers:
> +  - Lee Jones <lee.jones@linaro.org>
> +  - Daniel Thompson <daniel.thompson@linaro.org>
> +  - Jingoo Han <jingoohan1@gmail.com>

Not a great fan of duplicating MAINTAINERS information here. But this
is a comment for Rob, again.

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlzAcLUACgkQMOfwapXb+vLuOwCgncoOwxSVP55VHXnFcEgdj8fS
K/4AnijZY3OLIR7PsuPCSefpsYc7zdNf
=F424
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
