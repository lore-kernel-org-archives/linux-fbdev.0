From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 20 Aug 2015 07:51:26 +0000
Subject: Re: [PATCH] fbdev: radeon: Remove 'struct timeval' usage
Message-Id: <55D586FE.6070303@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="B5W7iueHufgRfxqFs8hSA8ESu9KTcLFsL"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20150525040716.GA4448@tinar>
In-Reply-To: <20150525040716.GA4448@tinar>
To: Tina Ruchandani <ruchandani.tina@gmail.com>, Arnd Bergmann <arnd@arndb.de>
Cc: y2038@lists.linaro.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

--B5W7iueHufgRfxqFs8hSA8ESu9KTcLFsL
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Tina,

On 25/05/15 07:07, Tina Ruchandani wrote:
> 'struct timeval' uses a 32-bit representation for the
> seconds field which will overflow in the year 2038 and beyond.
> This patch replaces the usage of 'struct timeval' with
> ktime_t which uses a 64-bit time representation and does not
> suffer from the y2038 problem. This patch is part of a larger
> effort to remove all instances of 'struct timeval', 'struct
> timespec', time_t and other 32-bit timekeeping variables
> from the kernel.
> The patch also replaces the use of real time (do_gettimeofday)
> with monotonic time (ktime_get).
>=20
> Signed-off-by: Tina Ruchandani <ruchandani.tina@gmail.com>

I had dropped this from 4.2 as there were issues reported, but forgot to
write a mail about it...

Can you send a updated patch with the issues fixed?

 Tomi


--B5W7iueHufgRfxqFs8hSA8ESu9KTcLFsL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJV1Yb+AAoJEPo9qoy8lh71ZUIP/RZPNykkK1lBNB2322uHYDLw
TNRdOd7GbVt0gDpLYh5k4vwishcLESDVKAc4SF3VXZyoDmHcuOc5l9sc9VyXMeRp
gep6NiP81+GOVuGeGm504AFpGaLS4nTLiV+XIk30prkFWrAX3kAFjPTut10qrh2k
SUj5PiliLMsZeRb7ypV+tCTNI/4yHtzMKf/OfM/eMMqrx+Wf/dR4aofaVMR5Eh1p
y1sdNBZElRfZk1xVj/zSC0FHvzBRQvGXIHj5+E4IFrOomFBfgc9DjgZv7P7/IiDF
h8Yvbs2OdWWdJk4QxOokQJYCmzg8xyFsBMbH63Qy9LI8cJn3HgY8eNsTamjDxtCo
KVE2FrD48o5rJhtqS6ckq4ziPml5WN1wBFOoRBsoEOe9qOil8kgP2Orgvpl8+15R
/ntsgEVxMY96HqkMx16jWAEuT4tjZ2g6mK76E5hgl6xRXu7gSNWH1XcLa1571X8C
XFbQ6RlWP70zfD24ttqjOljznUeimvMX+Zju3xMMGAdyx6o4FMyfDBXhuLe3PiRS
OLNcKetx/Wm5Z+MBMIobOTCOg82NFvidUWf96gp/2RbDXpwr11ffGjvwI5H1yoKx
ksXNpoacX5ic7Xt47M6G1TwQt26Lnb3WmAWx0Yk5x29TKXNMVqiKfo4V4elVNghZ
p0vovhOor9EqFzZF4TY1
=+qRf
-----END PGP SIGNATURE-----

--B5W7iueHufgRfxqFs8hSA8ESu9KTcLFsL--
