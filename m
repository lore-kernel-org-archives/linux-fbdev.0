From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 15 Apr 2014 09:46:29 +0000
Subject: Re: [PATCH RESEND] video: bf54x-lq043fb: fix build error
Message-Id: <534CFFF5.70801@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="jq0wtTc0SQ3mpriR7WsHnvXV2tA2RePiN"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1397546239-6650-1-git-send-email-realmz6@kernel.org>
In-Reply-To: <1397546239-6650-1-git-send-email-realmz6@kernel.org>
To: Steven Miao <realmz6@kernel.org>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, adi-buildroot-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, Steven Miao <realmz6@gmail.com>

--jq0wtTc0SQ3mpriR7WsHnvXV2tA2RePiN
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 15/04/14 10:17, Steven Miao wrote:
> From: Steven Miao <realmz6@gmail.com>
>=20
> include <linux/gpio.h>, drop <asm/gpio.h>
>=20

Thanks, queued for 3.15 fixes.

Btw, usually it's good to say in the description what kind of build
error happens (i.e. copy paste the error).

 Tomi



--jq0wtTc0SQ3mpriR7WsHnvXV2tA2RePiN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTTP/1AAoJEPo9qoy8lh710pIP/1fU3dKO2a81CprHfEDq0y4t
jy0heifu2dKmNZorLKU4SCm/WOOU1GLP1yfdwxbgPSiYLSNK4E+wzyD/f3hkZbkb
A3c9tpAQ6FwuhzD+0+qDSCToBqTy/uu0g0NBmtOxFxn3GQPzehFtAJ6sQJ0mme3S
pIsLFf13nOhy/pyHeE0oq8N8JHEGCXWMQT90z3yvCUve9TUTngiixSfav/eXCso/
yWSK+/Yan59FnNtLJMk1Wc0WNrO1hrE3Wr7XkqemqUmpt0i2310QIGB/48jqHAcG
PUsHg9fdB4zHwYcZ4v+xzO9Zad8z17KQigFKpDQ/61WtgclVQ+NjrdPSNW/FjAid
sLce3oODbs/kqi8ZS+hOLz6ycVV+viFk9EBE3miRsTYi8ok3znG2hlYDsJ38i9Bu
LeXwlGdcYWHK1YWSLIOFTysvQ7TUa+orLXgXoB5nsdPxBXFSbjnJtJXqjF6a33ep
qpd/5SHqCm4Wo5LPfRwqDioi8xNtavv3MONQd6U7myQlISjeY++Ic59iWPKd2S4c
Lt59fnFrU1ZRVKH5hfYQVKDc7u0+tnM+XOANmYmiVi0Zb0G2r+zZghgu+1NH83ca
4GCz8vpFu4to7zIpwVVvNMTKBukCUWtDB9Kg11dqoc+eeAWhOh5NGsfPzSl2DGx4
PUSpLlbTdQujcWyMwzER
=0gqq
-----END PGP SIGNATURE-----

--jq0wtTc0SQ3mpriR7WsHnvXV2tA2RePiN--
