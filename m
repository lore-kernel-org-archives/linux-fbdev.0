From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 24 Apr 2014 07:57:59 +0000
Subject: Re: [PATCH v2 1/3] video: clps711x: Add new Cirrus Logic CLPS711X framebuffer driver
Message-Id: <5358C407.60103@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="G08JkeF2Ig9QqQlIdIEh3Nvua6DtTjXEj"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1397285583-15187-1-git-send-email-shc_work@mail.ru>
In-Reply-To: <1397285583-15187-1-git-send-email-shc_work@mail.ru>
To: linux-fbdev@vger.kernel.org

--G08JkeF2Ig9QqQlIdIEh3Nvua6DtTjXEj
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

On 12/04/14 09:53, Alexander Shiyan wrote:
> This adds support for the framebuffer available in the Cirrus
> Logic CLPS711X CPUs.
> FB features:
> - 1-2-4 bits per pixel.
> - Programmable panel size to a maximum of 1024x256 at 4 bps.
> - Relocatible Frame Buffer (SRAM or SDRAM).
> - Programmable refresh rates.
> - 16 gray scale values.
> This new driver supports usage with devicetree and as a general
> change it removes last user of <mach/hardware.h> for CLPS711X targets,
> so this subarch will fully prepared to switch to multiplatform.
> The driver have been tested with custom board equipped Cirrus Logic
> EP7312 in DT and non-DT mode.

My original comment about this is still unanswered: why a totally new
driver? The proper way would be to gradually change the old driver with
a patch series. Then it's possible to review the patches and see what is
actually changed.

 Tomi



--G08JkeF2Ig9QqQlIdIEh3Nvua6DtTjXEj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTWMQKAAoJEPo9qoy8lh71yQ4P/3hyP9DUA64TSYYAEWyiRQLt
S/lMED+/ap3Xpgd6Ol4vBHfSMuKoCptppnGPc0gpEbWm0tMeu3m7joQcB75uJZ1/
VVEKYLwgm046UzXT5G9gf7X9McdJMFNTVbrUNwyBvy7Zp4WdFg2iV71+umqGnOKq
qr479I4vtl/TfVDBdv3rgqAeFrBSMEexCK/bdIKLrVIEJhvyuhwJ5IttP80LyWe5
ToYh7Tt10zUPOKbVtUkjrrMhKW3eywmSTI0+xUFPygMD8mNZ8Y2iJV2H9crH/bCj
IzZCv+wIgcSR8TMVpl7C3mpSMTiKeplUVFGZvNQofxY+iZlFnwQ0IN2AHas9qTYv
lcHVU86q6YHYPEAN+kqNSxMjQqowmu5E+wgLAlFi8mXfdzKwereUSz7Bq90QR6O2
7nSU5bFt540Z2zM1BbChPgFYvL2pCpc8uizOlJHG8ztj+G8VdrG5jA3WgzL1kOZh
GoqCdrDtUJ/g/vJESCEjprtpBspESkEYJNTfXz6xfIyrdHBnFBrvKw8yLOOmFTgi
9ezXAYcVmzPBw2kjoCXSHSHSQS9I0HXKQafRyQ93Rzrnt74xjxjbL20W3sNjsMvC
wcJVp4CB2FUVx/hdpiiiV1UGl5zzkd/byYKOQWdPdDRsjesNsH/qxIb+U+N1/QpQ
44EMCYb1lusLWd0Gk88L
=SPFM
-----END PGP SIGNATURE-----

--G08JkeF2Ig9QqQlIdIEh3Nvua6DtTjXEj--
