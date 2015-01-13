From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 13 Jan 2015 11:35:40 +0000
Subject: Re: [PATCH v2] video: vt8500lcdfb: remove unneeded continue
Message-Id: <54B5030C.2050504@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="SJ2gVVdCvXC72FwcKNG9bv3x6cMmiaf6U"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1420608948-4550-1-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1420608948-4550-1-git-send-email-sudipm.mukherjee@gmail.com>
To: linux-arm-kernel@lists.infradead.org

--SJ2gVVdCvXC72FwcKNG9bv3x6cMmiaf6U
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 07/01/15 07:35, Sudip Mukherjee wrote:
> continue is not needed at the end of a for loop, also removed the
> braces which were no longer required.
>=20

Thanks, queued for 3.20.

 Tomi




--SJ2gVVdCvXC72FwcKNG9bv3x6cMmiaf6U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUtQMMAAoJEPo9qoy8lh71d3kP/1Xv3+6U7kr1ujMWdVnRfjk9
FVpgY1qtdUO2wmGzefGELuqGWPzuJCcOenXHCiFpLEM3kyCPK8lm1O82ekGbqCd1
3X0DsB+X6rnSf1S9TLshciREsG/rtEhoVBZPBxvTY9U2VgEXQohGcX63BqgIW5x3
Rd21q5So/CiSWXtk7cBYiqByBnTSwklSQu6FXw0FIGb1QaLoNLoYxBarVPS5IgeV
QGCFoN9fwU3BiP9q4Zxm4ygsvgzi9CdbVAVMGpQ0mC4aN5c8DykmYTIAlqOdJgn7
dAat9bOK/CQwR3CsdjxHwxsADWVKEZC2eahXkAew6BOdGSUaKdPs6KKAk5L4a19Z
+GWBkByGprHQftFibSuYHu1icqh+oWTTGPuiYiRull3uSu1gCcMeYd9H/Arh9sAP
TSHpUtgTEJcy0OblfHlePJyHeszJuIvY5WegrieLfe7aWCJtNXpf/XUfujChlUz4
in5HQOIh9Wyo1IZy+smss0CBffA+QxkV0nPv0dVEyrArAjUo2jNoBDLO4ThHHJ1/
+NLbr5sLyTmueWx4XDkJ2JkYb5EC5ZXL5Byy7NXgch+e5I7dHVzn64zdsTL41W+C
l9O3NX2wgjC3BexuE/HE7vJ3iIX0LNHiIHkekyiwIOMzAyupGqytOMnetYq/nl9t
qxX2Kw4AqRQaeIoC+SBc
=mNjK
-----END PGP SIGNATURE-----

--SJ2gVVdCvXC72FwcKNG9bv3x6cMmiaf6U--
