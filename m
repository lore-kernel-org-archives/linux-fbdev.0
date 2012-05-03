From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Thu, 03 May 2012 09:58:15 +0000
Subject: Re: [PATCH] i2c: Split I2C_M_NOSTART support out of I2C_FUNC_PROTOCOL_MANGLING
Message-Id: <20120503095814.GA3955@opensource.wolfsonmicro.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="ReaqsoxgOBHFXBhH"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1335443839-22872-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <20120503095211.GC9574@pengutronix.de>
In-Reply-To: <20120503095211.GC9574-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Florian Tobias Schandinat <FlorianSchandinat-Mmb7MZpHnFY@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 03, 2012 at 11:52:11AM +0200, Wolfram Sang wrote:

> Also, I'd think the FUNC_NOSTART bit should be 0x08 and SMBUS_PEC 0x4000. This
> will be more intuitive, probably?

What is the value in renumbering everything?  It just seems like it
makes the diff less clear and has no practical value.

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPolavAAoJEBus8iNuMP3dDrsP/2d1LiHwW4PPvTmVHzAGQ+4F
u2r7OtI4vz5LaUdQjeJhPAPnjg35nbEJNlX18c9iK/aBxEC3/qeLlz+ZTtRIsODG
PPUBxy3mPC7+saEhG7OuF5K96VVzpDpWXfrJrBTS8aU+vJyrgun7r9m9hcPtb59K
dadTh8V85zX/6znmBo0s7kFGmopgxUCpTnCygMVbLCTJeV2fW7WkFSciSH/J27YK
BAj96+TtVtI9DKBcI+oS5HO1St0WqulztUvvGxXY0zSvOrfwSbsaZ8FATD4UQ8fg
3avH2jHUHGXxRry+R+He2/p5PPHcCt9pFMUcctEWqIu9taQQLqVuIz2yTrFmNZ+i
yyyTxi1MFB6nLn7savUJ3Fr6KC1JjhnR2Kng9YFkDO6jO8L4bkONVjnA+5XHBdLp
8cWRCrMEKxDXcY8zNvrEWTrbsqrwTb7Vn3tWIGysz85211jDG3N9ejPfmnoXLzHh
Z2gNBUnyB6u+yJYks1zYyo/eWLif3Nl9OZBl+PUUTwf+4gAj/u7L8ApDxEcsjNd0
WfhcokgkdzXw1IlgioJo1B+ZSG851t/hIzrbE2djWk2XUw30DXRxG5CQldWk7V0a
RSqhfYCGL+vgDoCbJVjLnqM5DkPb7OP8mZ3mrbPjblLxoXCOYtPVmcaychfrxcEI
m4BsWucWubbYwG4JyDRK
=hsMG
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
