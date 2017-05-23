From: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 23 May 2017 07:21:43 +0000
Subject: Re: [PATCH 3/3] mfd: twl: move header file out of I2C realm
Message-Id: <20170523072143.njhh7mkbm2tt277l@ninjato>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="7yzzt65nmxassi3y"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170521220212.1404-1-wsa@the-dreams.de>
 <20170521220212.1404-4-wsa@the-dreams.de>
 <20170523071636.hiws54msfxpg6qkb@dell>
In-Reply-To: <20170523071636.hiws54msfxpg6qkb@dell>
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Daniel Thompson <daniel.thompson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.>


--7yzzt65nmxassi3y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> For my own reference:
>   Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
>=20
> I guess this will be going through the MFD tree?

I'd prefer that, yes. Thanks!


--7yzzt65nmxassi3y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlkj4wMACgkQFA3kzBSg
KbboAA/7BYWjzye3Zd9b4l7Uvdy3BTUglIU4h8PBWztw8snSPIIMd5ShjYZotX7x
qXKUqi92du010bqAANjftdAl2ej4Dl1OdMm2NuaBlfGIV3bf1s+f+mx6iubHg+gC
h3KYEBU3fUMc+dypGCd6xsM84DCtOLPcYmu/uaKKmvZLfyNvvsDaTFUOyUp15nup
y8I9DNOmbirzmQj7sFF+38//j3SWfMO4EWGDBDUuQgT/CNf6DyclYITi1TVuh5Z6
X4mJqOpMCE+GzPZvDe60b7oMDAJrVyrsyj3SjkgUNMegQwGW0ZFGdmyJf3I43FLx
RUKeN4o48TPW4LS1rX9hzDIOvTlL6ZUc814/9q84zHly0RP5y4uzyJ8bOuZA2BJa
O0Yu4Y+QL3OC1qGzktwbsBUHPVLUZZH7oRMY2haS+o+4rzOhiZbH9tZE4v2ALyfX
8oGKWd2RYn76zG0Su6C5QCA/4ck1t2Wr4CwastYmdKuhyBEAF85uTvwmBoaXJxbp
bea5aO2y2xBdvgTvSd0XkbMiJpqMFb9gFfoA7SMkIPVmgPHcX9ZqI7QT5nXi5ugy
ZUfn/VYQUh8TyXZiRrOwJ595KjykkGIyxq2xgGFZR5eJ60N9t7ZEDqv6FBfhoj5V
elD1t7D2bkdQm0hfSxal45Zedg/OquhGI+ktNbjMKWLBN70owfs=
=bddv
-----END PGP SIGNATURE-----

--7yzzt65nmxassi3y--
