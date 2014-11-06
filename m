From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 06 Nov 2014 14:18:32 +0000
Subject: Re: [PATCH v4 0/5] simplefb: add clock handling code
Message-Id: <545B8338.8060908@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="IphvcSFB3B0gjC66LFiLCkv3nLlx4icoE"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1413996311-4287-1-git-send-email-hdegoede@redhat.com>
 <54534523.8080801@ti.com>
In-Reply-To: <54534523.8080801@ti.com>
To: linux-arm-kernel@lists.infradead.org

--IphvcSFB3B0gjC66LFiLCkv3nLlx4icoE
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 31/10/14 10:15, Tomi Valkeinen wrote:
> Hi Hans,
>=20
> On 22/10/14 19:45, Hans de Goede wrote:
>=20
>> -We will add a clocks property to the simplefb devicetree bindings, so=

>>  that u-boot setup framebuffers passed to the kernel (for early consol=
e
>>  support) can properly list the clocks used, and simplefb can claim th=
em to
>>  avoid them getting turned off, thereby breaking the early console
>=20
> Perhaps this has been discussed earlier, but I started to wonder if
> managing clocks is enough.
>=20
> What about regulators (to power the LCD), gpios (to keep the LCD
> enabled) and pinctrl (for video signals)? I guess any those could be
> reset by the kernel if no driver uses them.

Hans, ping. Have these been already discussed?

 Tomi



--IphvcSFB3B0gjC66LFiLCkv3nLlx4icoE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUW4M4AAoJEPo9qoy8lh718cQP/3ThDuUm0A1wtqSE/90n26yE
njDY6ZeNa5bw5xKjnk6LGOf2GwNzXFCdEop7P+U8FqKLvlDZWG6Md8NhwITBIYyh
Xa8mqf06P5gWoV9d3tpkUp69h6Wuwdk8Xb0+P9DNPqMTWbhk8T2TGwW1HBWclXhv
Fo1g45fFdXCx6H7h343PlhJShGmz+9t+rdP3uS/jga2beUlLpliOXk2YuX81Kro/
SNU+QawCXrN/Efv8JBREblhkTzxvXqRsZP7g5so/HhhTqmnOeNKHkIelCfvhDkmQ
jHCwqwZNvbmrKRv+GfQawVy6X/+tUesjRMgsTTN0j+k52jVFR//GIznz1/1kMpUZ
gAquwlOFogow2Dxu7O91FCEhzM6nNj5AlPu/eSguf6g2y2eAb0zxyk6p/JQKENYz
sUxBWX59uHFPY37QfSOtY3wEmJTl/5BzbxyFnRGSIinaU0JQ8KYlE0I7NncXRNqw
M6BmTjO7//dwvzqRRjuEG2GTCPMfGFrb34eqRvb+zgTJtLlFXo5nTp7BN6wUR1Fx
Sbyg/bnFNUISXJfZBdoTT8O3LMGfqZ1owO7vaHmoF7qghKBLEN17xEyIOw70JhlM
bZPIH3Paa9Xmj0uSxp44tr0R9Sm5ShoRnO3v2Wz6CQ35rcBPzNj4NKnWVUWVNQxT
owpCViiN7evgM2EeLHd3
=CC0L
-----END PGP SIGNATURE-----

--IphvcSFB3B0gjC66LFiLCkv3nLlx4icoE--
