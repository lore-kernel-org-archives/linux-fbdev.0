From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 30 Jan 2015 08:02:09 +0000
Subject: Re: [PATCH v4 0/2] fbcon: user-defined cursor blink interval
Message-Id: <54CB3A81.50408@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="cQh87EEALHxcsODr6tevoFAgHDf9L27mh"
List-Id: <linux-fbdev.vger.kernel.org>
References: <alpine.DEB.2.11.1501262305150.2783@localhost.localdomain>
In-Reply-To: <alpine.DEB.2.11.1501262305150.2783@localhost.localdomain>
To: Scot Doyle <lkml14@scotdoyle.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Richard Weinberger <richard.weinberger@gmail.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

--cQh87EEALHxcsODr6tevoFAgHDf9L27mh
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 27/01/15 01:09, Scot Doyle wrote:
> Since users prefer different fbcon cursor blink intervals, allow the
> interval to be set via sysfs. The current interval of 200 milliseconds
> is retained as the default. Tested with intelfb.
>=20
> v2:  Use kstrtos16() instead of kstrtoul() and min_t() as suggested by
>      Geert Uytterhoeven
> v3:  Add error messages as suggested by Tomi Valkeinen

When I said "return an error" I did not mean "print an error message".
You should return an error code from the show and store functions when
something went wrong.

 Tomi




--cQh87EEALHxcsODr6tevoFAgHDf9L27mh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUyzqBAAoJEPo9qoy8lh71AncP/RLDxHmREmuKmtNIAfsUTwqf
i1+tvqj8KGvbh0glSetdLQlRsaVy96BV/16sWAJSriEzFReH7q4Zjfur2o4Fc50i
vdpP9iY6yYpgeRN76xQxciUzzelTyLIiV3FM37FHYssJWFi3WjvfZKLfcwoL28mt
cvpMMAsGYNEMMku8r5Ukt+qrUfdfBEaN2t/frO3cmZIOdV/w66ibqyh6HPKVbZQd
XOob2KDQ0G+AKEsk5UP0HLPuIqXtUW7q/fFyJwORSLjI0yjGUwAeSNhX5wXvNhkD
arVaIrA4NhFbo3v+u0Vk+PMEkMACBrcxZC/8N6Wbkjq80qjyihh3/tRCmXoVH9Dz
DovXx8cwRoNJrLRQrbZ64jhX6u1KbJjpA+rEeQmDof5rsuTrZ5VtbmSH4dpOI5Y2
7LCCb9fXgANSQeT/MqtsjwegUUPwJaoo4quqR1huTOcSa75KnmNxeUAexI0nw+xT
4UQ5uYpTNoA2Ix3vdpMa5Xq1rHY0ayvpXh4aWU5L2V2zN0g5v8yap8dBUH1GHp6B
IsfZL5rZwT0CpUo90+nO99NKaex3CGvJsamZV334lPqmXQYXScyAS+Omqg4RwEmH
Lg2PrlBI/V/IsqvahysMRnPYF5ChkE4e84J4IEOEGvc+Qrlakc+PQ00rT0jvmqu6
An6PsmTK7ZBUTj6ICLUr
=bfLA
-----END PGP SIGNATURE-----

--cQh87EEALHxcsODr6tevoFAgHDf9L27mh--
