From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 16 Feb 2016 12:53:30 +0000
Subject: Re: [patch] video: fbdev: metronomefb: two harmless off by one bugs
Message-Id: <56C31BCA.2020606@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="PcdhGRTfgmFqTPB1eXbrHsFMTBttBa4Xm"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20160130144432.GF3462@mwanda>
In-Reply-To: <20160130144432.GF3462@mwanda>
To: Dan Carpenter <dan.carpenter@oracle.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

--PcdhGRTfgmFqTPB1eXbrHsFMTBttBa4Xm
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 30/01/16 16:44, Dan Carpenter wrote:
> par->metromem_cmd->args[] is an array of 31 elements of size u16.  Here=

> we have initialized the first "i" elements and want to set the rest to
> zero.
>=20
> The issue here is that ARRAY_SIZE(par->metromem_cmd->args) is 31 and no=
t
> 32 as in the original code.  It means that we set ->csum to zero, but
> that is harmless because we immediately set it to the correct value on
> the next line.
>=20
> Still, the buffer overflow upsets static checkers so let's correct the
> math.

Thanks, queued for 4.6.

 Tomi


--PcdhGRTfgmFqTPB1eXbrHsFMTBttBa4Xm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWwxvKAAoJEPo9qoy8lh71lOAP/0AuEcz5V27euHhiqhd+wZ2O
hjOboSKvTWImlmQfGXFPtYrTaCfSDkn5iVfONJxe9O25u2KXw0aOSCx1xMt0kiqB
GV6IWaGH4eGcavf1h/RPqhwUiXk+DIrGiY735th9FB0zVSXqwaOG543x3d5EnMc/
qd+CykpZ/Pt7INAEH4ak5Mb7IEfHeT5+us5bditbr5vscRvdLy9UdrV1DPMsIuE/
jv3rp05+EeTs4msDUw1af4686EbS7nyyVHwfMN2mwSaG2JDFB4EE+AsxSuepKwZn
QfKgdduNajLOdWU7NhUkcbas8K0CugHEsXu/Q11ZqiC1DbNsjbADoS0cCw228719
nFm4wWuk+xKqfj5B9MgEb6aAf+l1SIJE+aDX0JA9Dv94iMT8QKELp+VJdb6h/HqI
7Psk2lYRVGJSQgbSSHaSNIyZBudC9+V5sW+sjS5JPyeaB9Sl8z5xfNWsBF7WHQgK
G+poURIEeJkbPGiwQepw53R5CLmabCfBfpENCxXRj5/Y66gnUY1YORJjgBM4aWYF
JgxeWwDq6ceyhO71GCLduOIGf4bzO3HQ4A2QAEFAie9F1wqVfHlh4tG+QuxdxTgD
EcyqKJawX5JjioGnyzobIJa/8kkwExxsuhTqW5cWyYj4i1T07sOCLC2uvqgb5quS
SNMk3vKHxr3zl/AXUPnO
=i3DT
-----END PGP SIGNATURE-----

--PcdhGRTfgmFqTPB1eXbrHsFMTBttBa4Xm--
