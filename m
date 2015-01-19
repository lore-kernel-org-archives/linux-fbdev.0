From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 19 Jan 2015 12:58:44 +0000
Subject: Re: [PATCH] video: fbdev: Fix sparse warning messages
Message-Id: <54BCFF84.9060103@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Dk91gVML8ggNphidVVKLwKaRLmskgdtf1"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1421455200-11231-1-git-send-email-davidu@nvidia.com>
In-Reply-To: <1421455200-11231-1-git-send-email-davidu@nvidia.com>
To: linux-fbdev@vger.kernel.org

--Dk91gVML8ggNphidVVKLwKaRLmskgdtf1
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 17/01/15 02:40, David Ung wrote:
> Use NULL instead of 0 for the last entry of dmt_modes struct.
> Supresses "sparse: Using plain integer as NULL pointer" warning.
>=20
> Signed-off-by: David Ung <davidu@nvidia.com>
> ---
>  drivers/video/fbdev/core/modedb.c | 74 +++++++++++++++++++------------=
--------
>  1 file changed, 37 insertions(+), 37 deletions(-)

Thanks, queued for 3.20.

 Tomi



--Dk91gVML8ggNphidVVKLwKaRLmskgdtf1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUvP+EAAoJEPo9qoy8lh71aE0P/1McayWPl5juvWSccW4zBU44
7riKoQ+aTIud8vSY8CmmFgO1FkSSRpC8RZCDC6PFjca6UKw+bnAIrZ3UwGGDNnJI
8TPyrBRGS4DBKbP1nEEZRDCAw3oh5JsmY6+sLFFBkJsKLcXLrRM3aTQ5MrokKG2B
KXCoQ8wAxpBE/75MxvydoLFv5s+2Ml5QWXVLJZhhZCQeJBCiGEajrcV8GyB2KBe8
ALhXEIx311Kkzt02wrJjjsSSGvv5Smxhje/pWmkshTi8IGXgGLc9O7HsyRPT80jZ
SmCnWSjBp8iA/wSEEDVwq/8syZCO5sq/fBXktObsbq8f6uVBeNqkh6yq4g41TPWI
wNzodi+SKLWN2K7TjUpmdVmUyyZsdApSj6Pbb77I3nSmJQOtY4/Oi9/TV1xFscoI
t7luYbK0hqkotzbghet47yimdunor2NR5pOWk28SptwVRzWJ2K+xTR+MDVV3wx4F
QmdBndlAaYTjf46hzaLbWiZMq776Q8sA5SI1eQLtuowKon3p9tPj5Yno/8h7UVyc
9VpRRhU0N2Pnfx1WUuYgbgUiOyLKY7VjBw3O71Aw2u6wgwOdIhqQhCz57R5xPQXw
JhNUCi9avfiW8ZTzJQgb6z+GOO8OdyrOqxfwVQhBTtUzDVpiZbV8Umm4k5u+NeZz
fePPf0xQH4nq+YVujPr8
=n1Nc
-----END PGP SIGNATURE-----

--Dk91gVML8ggNphidVVKLwKaRLmskgdtf1--
