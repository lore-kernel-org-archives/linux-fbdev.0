From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 10 May 2016 10:06:56 +0000
Subject: Re: [PATCH v2 0/3] video: fbdev: imxfb: make it work again
Message-Id: <5731B2C0.3040404@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="f6hUIDUuXJ0tdhWEiFrjm71cCsQiOXSps"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1462354998-5792-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <5731A02A.2070309@ti.com> <20160510090547.GQ30822@pengutronix.de>
In-Reply-To: <20160510090547.GQ30822@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org

--f6hUIDUuXJ0tdhWEiFrjm71cCsQiOXSps
Content-Type: multipart/mixed; boundary="nKiMirsaDRha09ERB4J1RoP2omItb45jQ"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
 kernel@pengutronix.de, linux-fbdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Message-ID: <5731B2C0.3040404@ti.com>
Subject: Re: [PATCH v2 0/3] video: fbdev: imxfb: make it work again
References: <1462354998-5792-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <5731A02A.2070309@ti.com> <20160510090547.GQ30822@pengutronix.de>
In-Reply-To: <20160510090547.GQ30822@pengutronix.de>

--nKiMirsaDRha09ERB4J1RoP2omItb45jQ
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 10/05/16 12:05, Uwe Kleine-K=C3=B6nig wrote:
> Hello Tomi,
>=20
> On Tue, May 10, 2016 at 11:47:38AM +0300, Tomi Valkeinen wrote:
>> On 04/05/16 12:43, Uwe Kleine-K=C3=B6nig wrote:
>>> this is v2 of the series which addresses the review comments I got vo=
r
>>> (implicit) v1.
>>>
>>> For patch 2 the question is still open if this is the right fix, but
>>> without this the display doesn't stay on. Patches 1 and 3 should be
>>> applicable independant of patch 2.
>>
>> I picked patches 1 and 3, they look fine.
>=20
> Thanks.
>=20
>> I still think patch 2 is just broken, it doesn't make sense to me.
>=20
> What do you think should happen during startup? Something should call
> the set_power callback to enable the device? Or should that only happen=

> when something writes to /dev/fb0?

I think the panel should be enabled at startup, as with fbdev there's no
specific enable call. So I don't have a problem with enabling the panel
at startup, but just that the regulator enables/disables don't seem to
match.

>> If the regulator is enabled in probe, then it's always on, and
>> imxfb_lcd_set_power() should be removed as it never has any effect. Bu=
t
>> that doesn't sound correct, as presumably the imxfb_lcd_set_power() ha=
s
>> worked at some point.
>=20
> I think it worked back when unused regulators were not disabled during
> boot.

Is imxfb_lcd_set_power() ever called, or just not at startup? If it is
called properly later, then perhaps you just need to kick it at startup
time to enable it. Maybe imxfb_lcd_set_power(lcd, FB_BLANK_UNBLANK);

Did you try unloading the module (both when the LCD is enabled and when
it's disabled), and seeing that the regulator gets disabled when you
unload it?

 Tomi


--nKiMirsaDRha09ERB4J1RoP2omItb45jQ--

--f6hUIDUuXJ0tdhWEiFrjm71cCsQiOXSps
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXMbLAAAoJEPo9qoy8lh71SpcP/0aDH8p0tcAhSCivvqmWDB4/
ROyF+dQunM1gSgwd4YZLRPkwNk4yrH9dNkOg6l7x3IN8lO+Gj8Az46TtWWnQGeQs
Fe0gFOlFXECKc61SSWI6pn/5RGCvk9hJdcTz/3uMheXlfyuYN1ohaBgG4XSQ74Hf
PclUzcnvuyOmYOG35dl4ac86hvzY8Gg0TrrKS00Em1/dhiGDBhj+SPboYWJcvwIA
oee3TBqmsrhaQeZSQBIvBa35186qnVZfy0wgB/H92P+qr1KmvqUgMh/iHX58s7H/
ubteLu+R8Yg/BIc9L/zAqZDo5CUwFcsBCIjnJdN/L8zrVORM8RGP2BRJg24n6o6L
4qcNn8AuiMJo6poeRyJrArJyRG/XwAL6Gn/vhkq5GPnTQH5Z/dfTdPSg8A7JiYkC
cltGPjHTbwcfa6tnFWV3h5iwPQvx1KTD0JegoFEZI9RO0gUQCHv7YCZV/jaw3nvE
TRRiuKTIok86+jVwBX1nb6+mse1K3f7NCbjWoe7UXW7/S9+/yhK/d9CXdb8DAy5M
pxt7leHDZ1Rs/lpuU2xWZ8KIQGrgPSMKzkA5jrdw0rgcxrda43bmJucLsctEUyxj
I+c0xuRtxLIbC/5ooJex971fjh/oVHUpgcjL/OaRPrD0sbGNiD0Qgluaw+xkW8AQ
BG+Hlw34Qp1cg2ZIAiAe
=eXHD
-----END PGP SIGNATURE-----

--f6hUIDUuXJ0tdhWEiFrjm71cCsQiOXSps--
