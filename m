From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 24 Nov 2015 11:28:09 +0000
Subject: Re: [PATCH] video: constify geode ops structures
Message-Id: <565449C9.10206@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="enVrx1qFpvJ1Isc08Iv4b2ioIFAED6pAU"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1447018493-20631-1-git-send-email-Julia.Lawall@lip6.fr>
In-Reply-To: <1447018493-20631-1-git-send-email-Julia.Lawall@lip6.fr>
To: Julia Lawall <Julia.Lawall@lip6.fr>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: kernel-janitors@vger.kernel.org, linux-geode@lists.infradead.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

--enVrx1qFpvJ1Isc08Iv4b2ioIFAED6pAU
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 08/11/15 23:34, Julia Lawall wrote:
> These geode ops structures are never modified, so declare them as const=
=2E
>=20
> Done with the help of Coccinelle.
>=20
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
>=20
> ---
>  drivers/video/fbdev/geode/display_gx1.c  |    2 +-
>  drivers/video/fbdev/geode/display_gx1.h  |    2 +-
>  drivers/video/fbdev/geode/geodefb.h      |    4 ++--
>  drivers/video/fbdev/geode/video_cs5530.c |    2 +-
>  drivers/video/fbdev/geode/video_cs5530.h |    2 +-
>  5 files changed, 6 insertions(+), 6 deletions(-)

Thanks, queued for 4.5.

 Tomi


--enVrx1qFpvJ1Isc08Iv4b2ioIFAED6pAU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWVEnJAAoJEPo9qoy8lh71mlYQAKaCCYWg3W+w71nV8K7Ivt3Y
NjfP07ApN31g8gqXpAVhTWP990BD5JTx1KtN4oJnFuiKU7OZwC3XaACYs3kF67w8
7uhdk+npN6AQ2wC0nEq+iOeZrqKLu44YB6Vk7l10zbT1Or3GmtbcrZnwLCA/bqaK
fPV6MBSPdtJMVhatZJyRv1aodmb8vEq86PLC97zXsSyP5qLD4Kcc6hlhBfRSgEEo
FdUL5muRA/C7ZkY3tTY7vEMBSDvG+eY+nS50VRttOo09QsBDhNNUbmd9g3yszPnX
1eezWz33vIvjp8zZ44TOaIfgPTpnZKzPiti0pUxYtQIYOppxPPl5148KcPBbyMT5
mfLAAN6eWAfMyrA9QwrK0bVnWThH+VlguE1LJ+Db00Xrv3zxMST1tH/k/kuZgh9C
li1TCCQfH5g8KHhVfAaNmj+rlz665uxedSztX2I1pasX1vfHpMo6nR+8KamkGN3X
kdBAzVdDFjuqbVxrDvxsNoqK5/hjZEwm38OWuAOATFqC0Sb9EnFJDyhSutUBGRyh
AlkiD2bzTPPGJkweLvsbpybdEWJjjPy3Ii2VpNlPl4TLpULJKubcOnMkwvFRjSJy
PEhYDFvzdwEoGJpQMor5YKZOKNNTTQXhAkjG0/HGh9cjCSV44vyZRce1PcfYFsIV
dGLq+TdKMPRqSVTk7/m3
=APHw
-----END PGP SIGNATURE-----

--enVrx1qFpvJ1Isc08Iv4b2ioIFAED6pAU--
