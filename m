From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 30 Apr 2014 10:58:28 +0000
Subject: Re: [patch] video: mmpfb: cleanup some static checker warnings in probe()
Message-Id: <5360D754.6080101@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="XqwCbOSbQWEhSwABKnp63112DOsNQ7QTV"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140414080929.GB13372@mwanda>
In-Reply-To: <20140414080929.GB13372@mwanda>
To: linux-fbdev@vger.kernel.org

--XqwCbOSbQWEhSwABKnp63112DOsNQ7QTV
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 14/04/14 11:09, Dan Carpenter wrote:
> Sparse complains about using zero instead of NULL for pointers.
> Probably, if we enabled the warning, then GCC would complain about the
> unused initializers.  I've just removed them.
>=20
> Smatch complains that we first check if "fbi" is NULL and then
> dereference it in the error handling.  It turns out that "fbi" can't be=

> NULL so I've removed the check.
>=20
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Thanks, queued for 3.16.

 Tomi



--XqwCbOSbQWEhSwABKnp63112DOsNQ7QTV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTYNdUAAoJEPo9qoy8lh71CdAP/3dai80/5iJzVx+q53tgwff+
60OTxGVdEPXuxCKxn0QK8eA2h7oB/kO4RfQcA2suGJ/KBZzcKS5my/5DewN0Z6Tl
Zk1R+ZgZCY0hP9WNzRSHAWp3S9tO8xfjJ2r7hFj1GLf7jqsBP1HZcHqgHwEM+8LL
QwEEteKJ+j+atEAVoca8TEvpRfbyyJjo4hX0PrURMFvWZ5kDUIxIBvDWII2G+m5i
SzY62RWQWJ1vw5xDN2xDOVmSJSmy3PMAMoVk8yqvv5gBEgvUH9jrRCQYePEW5awC
q7UU/YarNTAr1A74lKoELW1EkzoRUh+fLNSHflcD+G3Cz4IVgAe2ebhmFK0oRF03
TZ8j/se+GEBdR0sWWEra/4h7AAJnMkaRNQWwAl0+XfH6tPhg4kWoPC4mgttJpuVI
7J+2l2X/U5WE75TXNjtzSTg7VvO8bhvnjnIlgSThmBU8D8odhmpJ1igN9VKnD2Oj
P/yW+T9DpPVwQgoG36Ir3BCbrJ5hTP5uUl3zAk40+GdgSa+9pIxgg5GO6P23Qy2Z
pTEEZs5eNACRhaIke+pdRzyORrNxqKshwRH2m+yk0jxz5viQjESQLnK+M8ayVeEg
/44f+CQjWw/r2UYt7+k9d6oPHlGmG9DieItUxZfcwaP9aopfq0dS+j6pC7TYfQsn
1YdeiFetz/27bDWts+4Q
=QAki
-----END PGP SIGNATURE-----

--XqwCbOSbQWEhSwABKnp63112DOsNQ7QTV--
