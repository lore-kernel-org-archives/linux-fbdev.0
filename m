From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 08 Sep 2015 07:10:07 +0000
Subject: Re: [PATCH 1/3] leds: Add of_led_get() and led_put()
Message-Id: <55EE89CF.8060308@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="9kkmblLVDuCFwlEE7vT2j5PpWBbXTJfQ0"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1440502442-19531-1-git-send-email-tomi.valkeinen@ti.com>
 <1440502442-19531-2-git-send-email-tomi.valkeinen@ti.com>
 <55DC6CB9.5060301@samsung.com> <55ED848F.2060906@ti.com>
 <55ED9B01.5030003@samsung.com>
In-Reply-To: <55ED9B01.5030003@samsung.com>
To: Jacek Anaszewski <j.anaszewski@samsung.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, linux-leds@vger.kernel.org, linux-fbdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>

--9kkmblLVDuCFwlEE7vT2j5PpWBbXTJfQ0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable


On 07/09/15 17:11, Jacek Anaszewski wrote:

>>> Thanks for the patch. Generally, I'd prefer to add files
>>> drivers/leds/of.c and include/linux/of_leds.h and put related functio=
ns
>>> there. Those functions' names should begin with "of_". Please provide=

>>
>> Ok, I'll do that. I do need to export something from led-class in that=

>> case, so that the of.c gets hold of 'leds_class' pointer, either
>> directly or indirectly.
>=20
> What exactly do you need to export?

The "static struct class *leds_class" from led-class.c, in one way or
another. of_led_get() needs to go through the led devices from the class.=


For now I just removed the "static" from it, so that I can use it from of=
=2Ec.

>>> also no-op versions of the functions to address configurations when
>>> CONFIG_OF isn't enabled. I have also few comments below.
>>
>> Yep. No-ops for the purpose of making the kernel image smaller?
>=20
> No, for the case when support for LED subsystem is disabled in the
> kernel config. I'd rather backlight driver depended on LED subsystem
> than selected it.

Sorry, I didn't get that one. How does the backlight driver's
depend/select affect this?

>>> Please move it to include/linux/leds.h, make static inline and provid=
e
>>> also no-op version for the case when CONFIG_LEDS_CLASS isn't enabled.=

>>
>> Ok. Why do you want it as static inline in the leds.h?
>=20
> This function contains only one instruction, why should we waste
> a function call for it?

I like to keep code in .c files and leave .h files for declarations, and
only in special cases have inline code in .h files.

What do you mean with "waste"?

In this case there's no need to get more performance by inlining (which
anyway may not help and needs to be studied separately for every case),
with inlining the resulting kernel image is larger, and inlining forces
the users of led_put to include module.h to compile.

 Tomi


--9kkmblLVDuCFwlEE7vT2j5PpWBbXTJfQ0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJV7onVAAoJEPo9qoy8lh71KT8P/RNjJdDLAwZFSQAJaKO+k7R2
pfhcY3x1iNHiIwgi9oJlbjFzgEO87XR1KewuBOjMjBEbFDP3yvpYCE/BVkidwJiJ
UOA+uPtpMkOFoRRc/LjSvUE3A7JGbWPoNYtllH++UaDVV1oee6sh4Ja2YVD7muaq
V3orR1u3khS1ETmSlvmUuzO195P5ARJumOC4jcaH+IY4h2fJJbkhAWNmuueQa2zU
sp8sKIKLg7nWAYtL/iDXM9TZL1QJ4BQBr/Scwov8O4j1CUj6NohszZGtfabvEJ2o
xlsKG9r6Eks4TRuOepmTm2xW/qRYo6DP/ggdVECoS81y13Vo1ckpPNdpqW5tjsVV
+9mtZ5/sNaD18nTgEfFSaS06anbVG/68nWAGCPMEK5/m5niV3FEWbV2q2NJtysmN
NbjILqEo++zYhkMUvHsa6bjV8/M8GQsh3bMq2k/nL11/ed6Q7MKlzMxIqx6/jhbZ
LnDhNLFY4TMhudFju+GOHabtSGSiQ0Dt7bMsBHVCsf3Kz8cyhbHJ1zeFUwcGsrab
y1M93yTs5ld9333Q38jbbV46H0jbxaHPqwdJUECYxEW2F8LixJ9uhywhjFNF6IHF
O2KjcbDjvf/dLB/Chf50CflafbbZMRZU8UrBtKQtaAzHT+TKrK737B+btTzMje/r
kcbmmpIOo16mZj8rGlQp
=BNro
-----END PGP SIGNATURE-----

--9kkmblLVDuCFwlEE7vT2j5PpWBbXTJfQ0--
