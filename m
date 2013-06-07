From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 07 Jun 2013 09:53:30 +0000
Subject: Re: [PATCH 10/32] OMAPDSS: split overlay manager creation
Message-Id: <51B1AD9A.7040904@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----enig2TJMCWLSLPPJALKSVPAPM"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1369906493-27538-1-git-send-email-tomi.valkeinen@ti.com> <1369906493-27538-11-git-send-email-tomi.valkeinen@ti.com> <51B17B6C.6050801@ti.com>
In-Reply-To: <51B17B6C.6050801@ti.com>
To: Archit Taneja <archit@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org

------enig2TJMCWLSLPPJALKSVPAPM
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 07/06/13 09:19, Archit Taneja wrote:
> On Thursday 30 May 2013 03:04 PM, Tomi Valkeinen wrote:
>> Split the function that creates overlay manager structs into two: one
>> that creates just the structs, and one that creates the sysfs files fo=
r
>> the manager.
>>
>> This will help us use the overlay manager structs with omapdrm in the
>> following patches, while still leaving the sysfs files out.
>=20
> Maybe the omapdss Makefile should also reflect this change, we could
> move manager.o so that it doesn't look like a compat file any more.

It's not quite non-compat file either, as it has compat code also. So
more refactoring is needed if to make a proper compat/non-compat
division. I'll keep it unchanged for the moment, but at some point it'd
be nice to compile the compat stuff only if omapfb is enabled. Or, maybe
move the compat stuff into omapfb (but that gives a problem with omap_vou=
t).

 Tomi



------enig2TJMCWLSLPPJALKSVPAPM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJRsa2aAAoJEPo9qoy8lh71k7gP/R0+ee0YYfKum5a61z+D4S2I
us5yww1oSrxXsDMRvMpQjYgSzQP3H9BJ64/ruDpYu9chbwHpcmJfvfGPRpzMWc6Q
vDwQUrpKgjXl2YOF/Kfjy6PnRAlc5PwVZylGM0Nxs6Rse7BWr4x2PGRtHK5COoRk
n6JKJj48XHQEu0CWOl700+PYeQZy1PCihp/X0TiAUN9x+CqtwV0e7vuvXRiFCLDF
EhHaqqeTg4KBWECLGXVeM73v0VZmrPJmYUzeIt/uvFoM90vfWda9rdLqk6mfi14L
eH4WUGHLOb4FStMn4at3tkQ7WQYhfKobniMlkVd790vvFyRCvMpKqaH8zw+m1kTV
9ixhIYcHu64+1Wl5CAuY7vn5KG0d8eCcjtAXIwVHC3FAdjnpou0eQ68Hzq9TrJJj
iP8TiIvmrz7KvB9h/dbKT50GxOQ3++h+pMkuogspiPiUgGOjxM7gs7W2lgUSfD6M
Iu7vkYTNDEkYBtkAyyVhJpF1ZBXKXM0HbhlmNNkcQcriw0Byo9dELg1Jee/Dt2xa
BcaJbsHNYYjGTRP1uqQFinqQNaOfVGxahUQu5/SOu/vhD0k0ZV999FvDxfa3vh4N
TlPKjViuT9xb6a5iNxvKQ2Cz/YigYorunFnBMZcCNSkTLNWbaK49IUTA0n460Gsx
SptquLoOpkptjetpWSCD
=r5rE
-----END PGP SIGNATURE-----

------enig2TJMCWLSLPPJALKSVPAPM--
