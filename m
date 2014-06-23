From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 23 Jun 2014 11:50:08 +0000
Subject: Re: [PATCH 3/10] video: use safer test on the result of find_first_zero_bit
Message-Id: <53A81470.5030606@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="AS9LdoLUjc046qPhunBEpHguJ5vrk7gNj"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1401872880-23685-1-git-send-email-Julia.Lawall@lip6.fr> <1401872880-23685-4-git-send-email-Julia.Lawall@lip6.fr>
In-Reply-To: <1401872880-23685-4-git-send-email-Julia.Lawall@lip6.fr>
To: Julia Lawall <Julia.Lawall@lip6.fr>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: kernel-janitors@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

--AS9LdoLUjc046qPhunBEpHguJ5vrk7gNj
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 04/06/14 12:07, Julia Lawall wrote:
> From: Julia Lawall <Julia.Lawall@lip6.fr>
>=20
> Find_first_zero_bit considers BITS_PER_LONG bits at a time, and thus ma=
y
> return a larger number than the maximum position argument if that posit=
ion
> is not a multiple of BITS_PER_LONG.

Thanks, queued for 3.17.

 Tomi



--AS9LdoLUjc046qPhunBEpHguJ5vrk7gNj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTqBRwAAoJEPo9qoy8lh718xwP/R6CO6ppHG/R7S1XjZ4GaqHc
7mnzgn4M88x/DiCZ5Zsk9QuMn1iPY87cdNuXizIlphrnSW0fxGBTKiuzvB8BZMdu
y+ZVS7HaqT1u3dviAMnES1mJtBJMEnNFYUVAwzszDZyn9uoFAB1jZt3hdXqo585T
tg3qsrh3DH9MNT5fMlheyx9D2vFVW5T3tPmBtlafKTIgVVeZHaBbPbmZeLq/xQi0
zoRzWZVkTuHn3803HJHpMD+gncjgkkFH+jGGNL+P/fwHfxZS8zyTJ3QhI4s245XW
FqmKYQHsUCkZrr8249NMff4+TUiFURjS93OeS0WzuECV1IWdYL8JTmTxAqI1XilV
R8rc9M2B5QW11MYy35xzzrOwWJLiwtwh7HRl8ZFof/7VKM6AX3syh8Xhe1HwyXgo
1AIzkiadXs8ArPLM21Vsudvp3KdmX6FRlZmx9jAabP3+aBydK4/Oqd7HzQfR3cdg
y1IpDneCTycHgwbnv3fojqTVt9U+h8yKDNjrfPQxxnUrmxD5Q7air9sSy0vS9iC5
0lNeiCtKTT+Pb0ed5YRqrdekTAcv5B80F6HrXuZoDHZ5gyo2sdczqass2nJtBBQc
ZfgceVPwJJNZzxsmSzM16xWLDZnkXTdcQqALZQIr8LiNeA4iziMgGq7COOcuT2er
kqGf9fpjSZ0BLlW8VJbS
=o5gy
-----END PGP SIGNATURE-----

--AS9LdoLUjc046qPhunBEpHguJ5vrk7gNj--
