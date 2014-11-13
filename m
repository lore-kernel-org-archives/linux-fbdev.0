From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 13 Nov 2014 14:34:46 +0000
Subject: Re: [PATCH v3 4/4] fbcon: Change fbcon_init from module_init to fs_initcall
Message-Id: <5464C186.8030806@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="eaOsSM1fxpwAxw8RKnsl14ixoBmkU9ijK"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1415885645-24613-1-git-send-email-hdegoede@redhat.com>
 <1415885645-24613-4-git-send-email-hdegoede@redhat.com>
In-Reply-To: <1415885645-24613-4-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org

--eaOsSM1fxpwAxw8RKnsl14ixoBmkU9ijK
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 13/11/14 15:34, Hans de Goede wrote:
> Various fb drivers register themselves before module_init so as to have=
 a
> console as early as possible, this is of little use if fbcon does not i=
nitialze
> early too.
>=20
> Fbcon cannot initialize earlier then fs_initcall, because then the crea=
tion
> of /sys/class/graphics/fbcon will fail.

Not related to this series, but makes me wonder how difficult it would
be to get fbcon and simplefb initialize at even earlier stage. Well,
something for the future.

 Tomi



--eaOsSM1fxpwAxw8RKnsl14ixoBmkU9ijK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUZMGGAAoJEPo9qoy8lh71tAIP+wUFtSBRSOM5YNA4PRnI1Nxg
nL5R6xfYb5oLQANWMoYRFL+mzkFPZtQeeG34d5vbWCmQuG+6jNI1riMNeXSB+8xm
KkVbeEkb57boXRrcxAaENBzgoR3xXAhr7vlkmtPFnPAtY6KLHF4STlX51uUhU6nC
ABcpZ3AJci9dKvKYwTQXf5IMBH43B4rH1TrzP+b8If0sjNFTYoZ0i28Iz2YKenZL
DbRjM7SxO0qGaZQ/jtf7Q1w0bmr42vCM8U2zk9CKtnYAtcAqNmLk2K0rmqzVqA2w
EIgLfy/jnF4KrQODwTXAqwEdS39V0Qmpo0UR6H31Iv5eYgGiEUpQJpRW0Tz/YZBV
LmuvyMVV18AKt3HYLb2qAxBe7EmyL2tXdxL0v7PkU/d7qOmUidaOoofTjAuJzrOT
dUzfllvQnDINP2IGzWk6P9UuwD4od//zXIx6z0TAW8joTi+pvBqU5xohSeGRBgOh
LN4cGRBemiQj4F+w9MLwnKgUg7YCdiInecLi2nIDLLqcdiFa7C9wrIAfbjTTbMl6
qOfF3QxWUzOxPIBIisyTKKATjJNdqZqbr6jpz21ljVcsJjBlMwMu4IRQSsanvIOb
YL8xHvso/LGZ0wYWEyzwMFeb2YlDHSp/8+SM1Eo4F5nzBQwvuJJcOkbkozgGulqP
oR+Cyq/m5u+nTgeQ3yLW
=V7ZC
-----END PGP SIGNATURE-----

--eaOsSM1fxpwAxw8RKnsl14ixoBmkU9ijK--
