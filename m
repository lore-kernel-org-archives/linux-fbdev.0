From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 26 Apr 2016 16:45:56 +0000
Subject: Re: [PATCH] omapfb: Fix regulator API abuse in dss.c and hdmi4.c
Message-Id: <571F9B44.6080500@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="6cFssFnM8LPQQl9UujBoKl5qjTPlnqtOQ"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1459355376-28507-1-git-send-email-broonie@kernel.org>
In-Reply-To: <1459355376-28507-1-git-send-email-broonie@kernel.org>
To: linux-fbdev@vger.kernel.org

--6cFssFnM8LPQQl9UujBoKl5qjTPlnqtOQ
Content-Type: multipart/mixed; boundary="SnwdwO3tRMfFpFejFLFdGsCSCujUAvWns"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Tony Lindgren <tony@atomide.com>
Cc: Mark Brown <broonie@kernel.org>,
 Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
 Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org,
 linux-fbdev@vger.kernel.org
Message-ID: <571F9B44.6080500@ti.com>
Subject: Re: [PATCH] omapfb: Fix regulator API abuse in dss.c and hdmi4.c
References: <1459355376-28507-1-git-send-email-broonie@kernel.org>
 <56FCC3F3.7060907@ti.com> <20160331164953.GD2350@sirena.org.uk>
 <56FD5A2C.7090608@ti.com> <20160426162229.GW5995@atomide.com>
 <571F9944.9090900@ti.com> <20160426164241.GY5995@atomide.com>
In-Reply-To: <20160426164241.GY5995@atomide.com>

--SnwdwO3tRMfFpFejFLFdGsCSCujUAvWns
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 26/04/16 19:42, Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [160426 09:38]:
>> On 26/04/16 19:22, Tony Lindgren wrote:
>>> * Tomi Valkeinen <tomi.valkeinen@ti.com> [160331 10:31]:
>>>> Tero, Tony, with a quick look, for example omap5-board-common.dtsi
>>>> defines ldo4_reg having range from 1.5 to 1.8. That should be change=
d to
>>>> 1.8 only, right? ldo1_reg has a range too, I'm not familiar with tha=
t
>>>> LDO's use, but it's for camera so my guess is that it should be 1.8 =
too.
>>>>
>>>> I can have a more thorough look tomorrow, and do a test run on omap5=

>>>> uevm (with Mark's patch).
>>>
>>> Any news on this fix?
>>
>> I sent the DT changes to you some time ago:
>>
>> http://www.spinics.net/lists/linux-omap/msg127893.html
>> http://www.spinics.net/lists/linux-omap/msg127894.html
>=20
> OK thanks yeah I have those tagged as fixes.
>=20
>> We can get rid of the dss code after those are in.
>=20
> OK so I'll apply the fixes and forget about this thread :)

Fixes for v4.6? If so, I can push the regulator cleanup to omapfb and
omapdrm for 4.7, which would be nice.

 Tomi


--SnwdwO3tRMfFpFejFLFdGsCSCujUAvWns--

--6cFssFnM8LPQQl9UujBoKl5qjTPlnqtOQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXH5tEAAoJEPo9qoy8lh71fJoP/1TIDsnzMKYWV4shH3EdeVVr
N0JOI8kJV41QisoOJliS+LZCjtZQUSxv6C/lhw2RO+3DYIaV4NWEcNvTtn7jV4QK
+mJQy/yiKWv8Qq4WNYPpI4cMYhy9rLkSz7aAjbbcvq+Z8cZC8MUOypkeX3IJ0e/y
j1xzl0aGEvWg39BANnZDc5elHS4d4gYBLuj5ecZGamrLs0s3wlyuc9QThNAxYCZe
wxeoFw4um1y5ng938GaF6XMe0tJPU92t/PoORisJwhWeuXlpl2M+IMXvtAmx+RWD
hhoCZZ2NupN0FTH0dIe1JockbUiK79NgWVPn1cZxw5j18rq9DhYnvXhYJvy6QqHh
bLILRYEo+YrJJnp7d+KSSwwQbc9HUZJqVz41XD0RsFowsG4stIIhtYK9ZKTUbqdB
wHWJvZLPn181QOFQNUGEAXmfOL3nPpCCcKy8PswRqEBWiWq7A4gI3u7AHdWnZq1e
pNA2QXVxxPDvCODkV43gpEaLuyNzYQo2zZa4ytzakW4iwIH+18qP7EcBMNuI7wEg
GvVEUwPXRybPkTSK37g0VggMwlfnPCVeCnKdlsRBRBOIfD/0ZvmQtrVqk+sjMSPs
pnVXHEbWXTbP7wNeVXG7kpJGzfOQvJ2QAlEx5Jh3XIYOnI4qIKkaSNJg47odd6AR
eqVVeb8dLHu36IzxNDqW
=Juwb
-----END PGP SIGNATURE-----

--6cFssFnM8LPQQl9UujBoKl5qjTPlnqtOQ--
