From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 13 Jan 2015 11:19:17 +0000
Subject: Re: [patch] fbdev: off by one test (harmless)
Message-Id: <54B4FF35.8050703@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nDhUMrfxW7g1o1J9WrdKI5rqLeuFgJDxt"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20141226172657.GA14762@mwanda>
In-Reply-To: <20141226172657.GA14762@mwanda>
To: linux-fbdev@vger.kernel.org

--nDhUMrfxW7g1o1J9WrdKI5rqLeuFgJDxt
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 29/12/14 23:51, David Ung wrote:
>=20
>>> test is really a no-op.  But it's still off by one and upsets the
>>> static checkers so we may as well correct it.
>>
>> 'idx' should be 0~63, because cea_modes array is defined as
>> 'cea_modes[64]'.
>=20
> According to CEA/EIA-861E, there are 64 defined modes, but idx is valid=
 for 1-64, 0 is reserved hence the check for=20
>=20
>         If (!idx || idx > 63) {
>=20
> Think idx check really should be !idx || idx > 64 if following CEA/EIA-=
861E

In that case there's something funny with the code. The code indexes
'cea_modes' using 'idx', and I _think_ cea_modes is already offset
properly, i.e. there's no entry at 0. But its length is 64, which is not
right, as there's the empty item in the beginning.

So maybe the correct fix is to increase the length of cea_modes to 65,
and change the idx check as you mention above?

 Tomi



--nDhUMrfxW7g1o1J9WrdKI5rqLeuFgJDxt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUtP81AAoJEPo9qoy8lh71QkYQAKTxwE2bhtXKzZgXxeFuNNFk
EjB04GV3ULmqkiooq855mpHiAeUgcAMewfvF8PNdtaSYF1Lww+vopUZFhHiWKitr
vW31Plqk183kRJOTqiP6nkgrdWV7VwWjFZDU8xdTrHT0SlFE52SJoaF8lgYRs9v+
oV7dtcP30Wstyh+rbi6ucdXGCGvp6RNMysT9JK7T6+6F/hjrFSCmuO9IKLu9/YOQ
UzBb7g307ydW8RRq9ORAsIceJrW1ND1CNL5YCDThFBRnbNwmPqhRf31RGxVQlW6l
05pPYRDkNxY1r7/UmbcqBE65BDHaVQUuQyhMVELM7ykaN49fmn/DAi/E8kR7hoRf
TRoDQSKGw/2zmbOEFNwIK51maUh5hHkoef7LFWBOQ361qFacPpeq39J/XaCYn9Vr
tdiSW2c0FjRaknHLfHtBgQ7bBQT7O8MI32D6HVpS9Oo2uVGB1dWOcz7U35VGQhHh
4D1kmhHHnwvqajpB+NE3DZsZmf83yUc2rS+MOp0v6XsSdY/trF7u7hHp4PIkoROZ
p42WnCxGJ3T0EuHd4MsE6hkaFqALfCR4tzL7a7NA6CF2b9vFTOa++HinS6NV7Pi6
H8l4fjEKcrcP/wrRq5L2Qb2CBpddqIoLaQJy/BzMCB2Fx9axGHQ/CZ2sJxQVL4hz
sYfSf8KWaHU+FXa458A1
=NOqy
-----END PGP SIGNATURE-----

--nDhUMrfxW7g1o1J9WrdKI5rqLeuFgJDxt--
