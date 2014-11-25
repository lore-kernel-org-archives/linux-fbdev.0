From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 25 Nov 2014 13:02:07 +0000
Subject: Re: [PATCH v3 2/2] dt-bindings: simplefb-sunxi: Add sunxi simplefb extensions
Message-Id: <54747DCF.9010502@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="PAKNBTKCbBFfRP6lAUVRwuD1U00Tt7h6G"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1416309051-26784-1-git-send-email-hdegoede@redhat.com>
 <1416309051-26784-3-git-send-email-hdegoede@redhat.com>
 <547476DA.2030004@ti.com> <54747B72.1050406@redhat.com>
In-Reply-To: <54747B72.1050406@redhat.com>
To: linux-arm-kernel@lists.infradead.org

--PAKNBTKCbBFfRP6lAUVRwuD1U00Tt7h6G
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 25/11/14 14:52, Hans de Goede wrote:

>>> +Required properties:
>>> +- compatible: "allwinner,simple-framebuffer"
>>> +- allwinner,pipeline, one of:
>>
>> Sorry my ignorance, but what's sunxi and what's allwinner? Both names
>> are mixed here.
>=20
> sunxi is the sun#i SoCs from Allwinner, Allwinner is the manufacturer
> and the
> SoC "code" names used everywhere in the kernel for their SoCs are sun4i=
,
> sun5i,
> sun6i, etc. Most people refer to these SoCs as sunxi. This is also what=
 the
> linux-sunxi mailinglist in the Cc is about.
>=20
> The official devicetree vendor prefix for Allwinner is allwinner, hence=
 the
> allwinner in the compatible name, see e.g. also
>=20
> Documentation/devicetree/bindings/input/sun4i-lradc-keys.txt
>=20
> Which also uses sunxi / sun4i everywhere except in the compatible vendo=
r
> prefix.

Alright, thanks for explanation.

Shouldn't the compatible then be "allwinner,sunxi-simple-framebuffer",
to differentiate from some other SoC Allwinner has or might create in
the future? That is, presuming you're confident enough that a single
compatible string covers all the current and forthcoming sunxi SoCs.

Perhaps simplefb is a bit special case, but I usually feel better if the
compatible string is defined in a more specific manner. In this case I'd
have:

allwinner,sun4i-simple-framebuffer
allwinner,sun5i-simple-framebuffer
allwinner,sun6i-simple-framebuffer

so that if sun7i has totally different display controller, there would
be no conflict.

 Tomi



--PAKNBTKCbBFfRP6lAUVRwuD1U00Tt7h6G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUdH3PAAoJEPo9qoy8lh71XyoP/2wBudt5qp3HAU0gFiphDgeV
6GKPr2wQXu0EHhWfxc5XoxHi60B61olciohOwkBJog8XxqYAN1HmqmiaLFala4M4
e1QL038BMD2w45b5OzmYyoPEVmWpahkLONrZTVrVbJ+1IPCYYD75yHrsAUhxdDUt
IkUGdcxPgIJApaYUXmkvL44uOyUbey6VUITbVVDh2Xz77/ytfrUuPwktuV/AG6jR
PEZ0n63kKX1/HjnmeWMeFYKGsghy/STNoELnU3cOPN5yMOv3SMGhS73sjsw2k3FW
ieZXsUF0HJVfcSsF1Tp1GtQNnMLNvNFQIJWQaVbn4JI6AyJMSAC1lV7v6iv5nHs5
Q9unV3j3bXVmMEyA7sOXEBoUbJKlyyOGuHx58jFxbqueeQGu5K0qszuWGDKeAFg2
JorGf2GaR52OCyVJ3jqplNsyCJ7RDL+Ba71g++q0ERHGreTt1N0G+hYwHa+H2egP
oyoJ7kYq3MIKLFoqJd3YaV+IVaxX7FM4QnibvsDLQ06qw5MYuXH2tQ6IWCP/JLKF
jxOir5xL+9UfV3TGzHro50hcDKtEBsLzU8RY0yly/C3NqpHeuSwuVXMmU0MTAu2Z
s08Z8LV0Uqgudo2rxj2cT1ywaCKUDYdJlhaBWW5uEDNWuos9uXhvAJlu6dW0czBE
KRwErJm8yf+za+8ubhsu
=tUnY
-----END PGP SIGNATURE-----

--PAKNBTKCbBFfRP6lAUVRwuD1U00Tt7h6G--
