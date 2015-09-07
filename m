From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 07 Sep 2015 13:18:17 +0000
Subject: Re: [PATCH 1/3] leds: Add of_led_get() and led_put()
Message-Id: <55ED8E99.9060004@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="DIBDI2wA2unPgd1sWLfRBK74c5RhNctKN"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1440502442-19531-1-git-send-email-tomi.valkeinen@ti.com>
 <1440502442-19531-2-git-send-email-tomi.valkeinen@ti.com>
 <55DC6CB9.5060301@samsung.com>
In-Reply-To: <55DC6CB9.5060301@samsung.com>
To: Jacek Anaszewski <j.anaszewski@samsung.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, linux-leds@vger.kernel.org, linux-fbdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>

--DIBDI2wA2unPgd1sWLfRBK74c5RhNctKN
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi,

On 25/08/15 16:25, Jacek Anaszewski wrote:
> Hi Tomi,
>=20
> Thanks for the patch. Generally, I'd prefer to add files
> drivers/leds/of.c and include/linux/of_leds.h and put related functions=

> there. Those functions' names should begin with "of_". Please provide

So I presume leds/of.c should be linked together with led-class.c.
Afaics, that means I need to either rename the resulting led-class.ko or
led-class.c, so that I can do it in the Makefile. Any preferences?

Alternatively I could create a led-of.ko, but that doesn't feel right.

 Tomi


--DIBDI2wA2unPgd1sWLfRBK74c5RhNctKN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJV7Y6ZAAoJEPo9qoy8lh71ffgQAI0jqrretSl1mGupzDKWvA8m
Gs4Snb+WhwZjmcC7tdcSE9OA3+Rf56WWlBce2BNDOB7HdTtgEnXfZ3KfeTeggFXD
OhFjYJ62zrfqsp2g3C6TxD3z9wsa4bcsmCYS6eLd0++QT1R8ME3xIowXOZy8+jQ1
chNXbvNP9M6XJRrBpfQIgndbypf9TKDoKPgGePCoFiM40bS1OzeRbiUg0yvOeqF1
4Ft/g9kk4jOwEcAOsj3CAH8KADNFegYmOXK8+Ph4wy359J7E8RkU45+DAx8oOkkg
mNVEmd6GkW3ac87oMKZk8l/sf0sJgP1IaBgpHvKpUTnlOQP7tVvZbaeZEVWLf8Sy
PbJuQtN4p7N/HlyTsE478t+O7m3jNsrzc+E3A31REkTgX2yhMCodkfvFYs40Ofut
iq1yETy2KSjPdsaE7qddINTgCfYYwtKGgLKuV/8rB0Yg34wOAteNLPFgQhWUy8Xm
7qAyjNchhAseHJUCbonQ+vGNUaD16xTcjAnIKcKT3Es2hEAhJ6RoFCLJDXwFx/3E
RDdvg3pkMmk/EN9Grvil643N/VDAx8OmGCUkSKovSUgOMAoy0PgDy7NrVEa6d1iM
U0n3ThcExsbZtqsDsxOT2peqeUlZIPe/ka2VpHRzhb2aCewwyh8kM+j14PaA3qnp
KaRwdeXdW9hTlaTKu+xd
=x4yv
-----END PGP SIGNATURE-----

--DIBDI2wA2unPgd1sWLfRBK74c5RhNctKN--
