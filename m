From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 07 Sep 2016 07:20:25 +0000
Subject: Re: [PATCH] video: mxsfb: get supply regulator optionally
Message-Id: <1812b2bf-bd66-3553-4c2d-3d2b08603ca0@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="xQIPXWJ6PRBxDwwnt5mavbHwwDjMrDd0I"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20160904042627.30182-1-stefan@agner.ch>
 <f8368040-bb5a-91e0-7511-df462719b949@ti.com>
 <4b3a7bda2202a536efaf4a693234c273@agner.ch>
In-Reply-To: <4b3a7bda2202a536efaf4a693234c273-XLVq0VzYD2Y@public.gmane.org>
To: Stefan Agner <stefan-XLVq0VzYD2Y@public.gmane.org>
Cc: plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

--xQIPXWJ6PRBxDwwnt5mavbHwwDjMrDd0I
Content-Type: multipart/mixed; boundary="NBIrhjX6Iatt1ub97pREB7oT0P1sLVPIU";
 protected-headers="v1"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Stefan Agner <stefan@agner.ch>
Cc: plagnioj@jcrosoft.com, robh+dt@kernel.org, mark.rutland@arm.com,
 devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Message-ID: <1812b2bf-bd66-3553-4c2d-3d2b08603ca0@ti.com>
Subject: Re: [PATCH] video: mxsfb: get supply regulator optionally
References: <20160904042627.30182-1-stefan@agner.ch>
 <f8368040-bb5a-91e0-7511-df462719b949@ti.com>
 <4b3a7bda2202a536efaf4a693234c273@agner.ch>
In-Reply-To: <4b3a7bda2202a536efaf4a693234c273@agner.ch>

--NBIrhjX6Iatt1ub97pREB7oT0P1sLVPIU
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/09/16 21:23, Stefan Agner wrote:
> On 2016-09-06 01:21, Tomi Valkeinen wrote:
>> Hi,
>>
>> On 04/09/16 07:26, Stefan Agner wrote:
>>> The lcd-supply is meant to be optional, there are several device-
>>> trees not specifying it and the code handles error values silently.
>>> Therefor, avoid creating a dummy regulator (and the associated
>>> warning) by using devm_regulator_get_optional.
>>>
>>> While at it, document that fact also in the device-tree bindings.
>>
>> The binding change looks correct, but using
>> devm_regulator_get_optional() does not sound correct.
>>
>> devm_regulator_get_optional() is to be used when the device in questio=
n
>> truly can function without the power supply. But if the supply is ther=
e,
>> it's just not controlled by the SW, devm_regulator_get() is to be used=
=2E
>=20
> The framebuffer device can even function without a display, no problem
> there.. Probably not really useful...

Yes. Of course, the question then becomes, why is the fb driver even
dealing with the LCD's regulator. But yes, I know the answer: because
that's how it has been done =3D).

> devm_regulator_get creates a dummy regulator and a warning. Afaik, the
> dummy regulator was meant to be as an aid during development, but not a=
s
> a permanent solution. This is what the initial commit of the dummy
> regulator says:

Yep, the fixed regulator is afaik the correct solution to represent
non-controllable regulators.

>> In order to ease transitions with drivers are boards start using regul=
ators
>> provide an option to cause all regulator_get() calls to succeed, with =
a
>> dummy always on regulator being supplied where one has not been config=
ured.
>> A warning is printed whenever the dummy regulator is used to aid syste=
m
>> development.
>=20
> I think we should either make the property mandatory and fix the device=

> trees or we should fix the driver to support an optional regulator. The=

> code already supports the reg_lcd being NULL, which is probably mostly
> pointless right now as devm_regulator_get always returns a dummy
> regulator.

To really clean this up, the LCD driver should be separated from the fb
driver. But that's pointless work on a framework that should be
deprecated (is there a DRM driver for this in the works? =3D).

I'm fine with the _optional version, that's the easiest cleanup here.
And, I guess, it could be even argued that it's correct in some cases,
as the fb output could go outside the board, to some externally powered
display.

I'm fine with doing more cleanups too, if it eases the maintenance
burden in the future. But I don't see what the cleanups for the device
trees would really give us here.

Mark, what do you say?

 Tomi


--NBIrhjX6Iatt1ub97pREB7oT0P1sLVPIU--

--xQIPXWJ6PRBxDwwnt5mavbHwwDjMrDd0I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXz7+5AAoJEPo9qoy8lh71qREP/1HCx1Z4ElLXgT8tlaqIqKIX
6P6ErzxyLSpoZmb5AEaEQA8ylNO3eO2w/MklDWz4MUnfy4NRwIer8yh50wSqEx1D
aLz7imsoBGC5JraCJsNsW9JTeKF6DVzjwZ1wL6EvqyfvEXPxfDnMWv43Yg1O9vD2
/qRmpAI8jVhY7K8AFDi9hdgw47eFtH/VPHUHFHzyB54I8V5xHxQINCSnyigi0naT
Xyl/sB0WLit/8h8vEhP7Mkj2HihwtrMc6N25Vh8zLRGSV+n+6LFduZT02NrGHZ2S
0qMjm0unjN4e46gaq1DaP7a50GAWLQEWmE+aZG+5vSz+aGM1x+6uvGJSDSBh1C0u
3FFa2EeSuwpKLdYTSYzrvZFb3roXSMMsL6oU9z3I4phbQM/N35rse1ghgm8JE8UV
1nFn2QaRzIqBAIoAUWE4FUL+9JAXo4q4C9oIgexw1cMzu1NJ5rLIiajqTyvE+VV1
25dsbeXkO87s+FpRailNzQPxHEe6xAt+Klcla5Z4qsQUI4jdRMMuTwsgEI4UT0US
M9dpwi8x2j6VMS/R06vp+louwRL32bKo/22aoKnW2dmckfmZuOUbPTQvkluk7E4h
A6E8qiJJLKcg0siu0J16cs0huMIAUUV2sg7GMjgoWBO+CvoCGQYPhJTW7GyIrtov
fbSruiyaEiMqWkHdqtmw
=ilaK
-----END PGP SIGNATURE-----

--xQIPXWJ6PRBxDwwnt5mavbHwwDjMrDd0I--
