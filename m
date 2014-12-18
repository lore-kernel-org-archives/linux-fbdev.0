From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 18 Dec 2014 14:05:01 +0000
Subject: Re: Weird/Unneeded call to msleep in exynos_mipi_dsi_wr_data in exynos_mipi_dsi_common.c
Message-Id: <5492DF0D.3080607@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="VJdv1a0WcfBdG5ccDTovVrxNXvv0tl9jm"
List-Id: <linux-fbdev.vger.kernel.org>
References: <54920A54.2060608@gmail.com> <5492ABE7.1060900@samsung.com>	
 <5492D80E.3010906@gmail.com> <1418909978.2236.0.camel@pengutronix.de>
 <5492DB1A.2020704@gmail.com>
In-Reply-To: <5492DB1A.2020704@gmail.com>
To: linux-arm-kernel@lists.infradead.org

--VJdv1a0WcfBdG5ccDTovVrxNXvv0tl9jm
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 18/12/14 15:48, nick wrote:
> Lucas,
> That's fair do you known of anyone who does have the hardware so we can=
 test my patch. If you do then we can get this fixed rather
> easily.
> Cheers Nick=20
>=20
> On 2014-12-18 08:39 AM, Lucas Stach wrote:
>> Am Donnerstag, den 18.12.2014, 08:35 -0500 schrieb nick:
>>> Krzysztof,
>>> If we look at the code for this function, it already is handling the =
data correctly. In addition  the locks=20
>>> seem to be better protection then msleep. Further more is no reason f=
or this delay as we are neither resetting=20
>>> the hardware or waiting for the hardware here so why is it needed? I =
don't have Exynos based hardware lying
>>> around through to test it.
>>
>> If you can't test it, don't touch it. It's that simple.

There seems to be multiple msleep(20)s in exynos_mipi_dsi_common.c, a
few with /* FIXME */ and a few without any comments. Looks like bad (but
relatively harmless) code to me, but as Lucas said, if you can't test
it, don't touch it.

 Tomi



--VJdv1a0WcfBdG5ccDTovVrxNXvv0tl9jm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUkt8NAAoJEPo9qoy8lh71p8MP/1fXGGsVE1n0j+uRmqziiHyw
FD/g3tEGQ/tdtg+rWbEbpX20rAcLbo3ieFV17rFHrjrcOMvRMPaEjHnIqpM5MCBM
8cs33yx7Ljc+0ge6v567Q4xWIzBlsP3k5W/ebRivRn9NoMLc3A8p4ssh6KAW9GNK
l7Jg1WL4igSgXA4cMAauuUu5jDGCtAywcrG/RHR2tNP1hnkixdfiAHzSodb6xHjI
TXYPHZhCNc8hJevLV9Ux0vv9J18eBj2X15ghB7KWsR6ujYf4gjIn/UNAGxgANoVH
eslWIbZeJB8oA9bOGT9zdG2vF8Hsu/a2IHtNYalxygt5tXPvuTzewmMBxBlQSQ0b
CC80SJH76TePtH/9csf417rusivI96D5kion24JZjGXwvsgkx1rKeThQEEa/tIxe
t0oC1OtnxlpCDpxAHoZoZ6FNAoMZe/+5wWThDrdwsmrHGuTR/epYhKoIS4KxeZkS
9x3k78Iwlu0hxOqb5Q7jeM3/3Ody/RJg/JN17QLJxMWgTk7JIGZpXEst/r3lG3xB
jCmyqjXBP7SWEyEz6MUNM7jxi4oPjVSmgKPZSFdx2H65fjNB6zyCsaMri/IuzUfd
FhXD3VbXyAn4It5WIZjcvdS/MsrkwSmEBKVonTXkqYONGpwEYmMq7bs9gUvMeWSn
LRY0RtZ0ktPOK8UvumK+
=lGJn
-----END PGP SIGNATURE-----

--VJdv1a0WcfBdG5ccDTovVrxNXvv0tl9jm--
