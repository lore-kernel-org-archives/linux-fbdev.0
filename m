From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 18 Jun 2012 08:11:34 +0000
Subject: Re: [PATCH] OMAPDSS: HDMI: Discard phy_tx_enabled member
Message-Id: <1340007094.1859.3.camel@lappyti>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-/7tra/vIxPHQAvqjqbmZ"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1339797701-11540-1-git-send-email-jaswinder.singh@linaro.org>
In-Reply-To: <1339797701-11540-1-git-send-email-jaswinder.singh@linaro.org>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Jassi Brar <jaswinder.singh@linaro.org>


--=-/7tra/vIxPHQAvqjqbmZ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2012-06-16 at 03:31 +0530, jaswinder.singh@linaro.org wrote:
> From: Jassi Brar <jaswinder.singh@linaro.org>
>=20
> Explicitly maintaining HDMI phy power state using a flag is prone to
> race and un-necessary when we have a zero-cost alternative of checking
> the state before trying to set it.

Why would reading the value from the register be any less racy than
keeping it in memory? And reading from memory is probably much faster
than reading from an HDMI register, so I'm not sure what you mean with
zero-cost.

But I guess it is simpler, so in that sense the patch is ok. But please
revise the description.

 Tomi


--=-/7tra/vIxPHQAvqjqbmZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJP3uK2AAoJEPo9qoy8lh71kCkP/jigdnZrAKJhRfulGVew6O29
kylPAslxOamTwHu8aHhDO3x51YnP1rwC+orCLfogqAWLedINDtUk9b5iPT/DQgdM
pih5TpWAq0f9Y8QT3lwybK8nIS56OPRVUw5uuLFFIsFqymqqVydyajHDbams7HRs
xq8lAjtK6tRKLSYIWd7MkGcYCfp15Z/lLzHCivlaBGZwECG27dOowkqMIfvLxejq
Wj3PhHoyhoIwh7v1gO17RfjARcqrEm7kObxqsvE2R2ylvgvp8A0DmTO6bW55p93S
bjDocTevLl9e1u2e/a5JblT447b0F5DQkFfonyao1mhP3A8ob+xk4Ym0hAtc0DPd
NVkh+aRA3blBUMAnYggAhi+E+VQs4oJwmRnhhQvsWet7+2RO2uKC6ANSodxn7ukd
I54/ohYflYcKNExuunqYYfXg3RkKtoR418hiw9KMZQNY9So/IzluoADvWUo3zUiM
QRSffwL2cU/l0WWNU4j0dy3VIhpUV656NZEXlJSJ+dRzUgzSMPsbnm9DTkrV/G0f
qmSJBNp96S0SBIHyqirv3e9QT5iHPejgGHhweBN9P0aP2JPHbhFj//rTbC4K7lm6
kac+zpjHSnrjlELOhvtiLwxxPBE0pQQ57xpiYRRyVuYTHr3yvyCX2a6z29OS4ZDV
+g5zjgXXDENUrdZD5JJN
=IhrD
-----END PGP SIGNATURE-----

--=-/7tra/vIxPHQAvqjqbmZ--

