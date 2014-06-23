From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 23 Jun 2014 11:10:21 +0000
Subject: Re: [PATCH] video: Introduce the use of the managed version of kzalloc
Message-Id: <53A80B1D.3020706@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="JWG6uHdO0NfmX0nWaJSvdptEhLxSMPAXL"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140525104035.GA3187@himangi-Dell>
In-Reply-To: <20140525104035.GA3187@himangi-Dell>
To: Himangi Saraogi <himangi774@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: julia.lawall@lip6.fr

--JWG6uHdO0NfmX0nWaJSvdptEhLxSMPAXL
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 25/05/14 13:40, Himangi Saraogi wrote:
> This patch moves data allocated using kzalloc to managed data allocated=

> using devm_kzalloc and cleans now unnecessary kfrees in probe and remov=
e
> functions. Also, linux/device.h is added to make sure the devm_*()
> routine declarations are unambiguously available. The function
> mddi_dummy_remove is removed as it is no longer required after
> removing the kfree. The variable ret is also done away with.

Thanks, queued for 3.17.

 Tomi



--JWG6uHdO0NfmX0nWaJSvdptEhLxSMPAXL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTqAsdAAoJEPo9qoy8lh71HoIP/jjfRRoIC5UYY0X4snZy3s7m
mXo+JkjCLqu9st0gVfeXGXdoDqHh7t1/d5NQYo/Zvnv5niVHucvEVsrpsxzCXW7L
8/fdA2EfCqwfOXyT7BgQtc2bZ5kBeRDwLnE0stpo0Mc5SB2enq1ozdO9d1RzgEOX
m47WvOEL5se7NkjJgXxB7SmB5pfBBJoBiNA2dgCclLvgcrclda2A8cMrolVUlXs3
xEzAf7r2cBx8kqBHy4l5pNrP56+hi9JQtKWyXAQeyjhb6UjnlcVzAmSd91E+k6G/
LLqJp4DgU3QKX6ldXFx8OSWv7FCFQ4bt2iDbHqWxLTQVbqMz2PJbW4RBS7KoRkXC
j/BpBCo84lxtOJs1tvp4aHJ7AZFHZdixRXwp7j9tPCEYLQokSod+MslpCJ7l/5Ds
PUy4aoWbkpPZiWrOkoaCRnx2CsTiNJLA7r3uetAW5epw4Vo61vYAq1djOMyFRYJN
baGaJNBoySwsf0PnNCsxyaeJTQB2WJHKwax/9s8pMGx4+JTmPNmkYUEBiIkpFdIL
3oRVAhPEBgfMKhbtysEXLsBbr4fsR+Il5f7s3zfIEtgc45W6GSOSjG0B7DV1JbEK
91zkTrFZMaBHyUg21iSV6csJA58OtspRIVdeWqgPwLTBP9V5HHcrD36XZ4hYRwqX
YyG1/Q0DrMNLOi+UyF9l
=N0uc
-----END PGP SIGNATURE-----

--JWG6uHdO0NfmX0nWaJSvdptEhLxSMPAXL--
