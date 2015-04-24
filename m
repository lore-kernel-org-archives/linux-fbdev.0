From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 24 Apr 2015 13:40:35 +0000
Subject: Re: simple framebuffer slower by factor of 20, on socfpga (arm) platform
Message-Id: <553A47D3.2070107@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="klwRfHd3PBXfSr1Lid5AjRKreBdEVEFsx"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20150407121247.GA29497@amd> <CAMuHMdXWRx7bKWhQuWH05CbPTXPy5imCUcW1xUf2E8f7BtF9NQ@mail.gmail.com> <20150409110634.GA27407@amd> <552660C7.4020805@ti.com> <552663C2.70308@ti.com> <55277650.8070607@codeaurora.org> <20150424132923.GA11729@amd>
In-Reply-To: <20150424132923.GA11729@amd>
To: Pavel Machek <pavel@ucw.cz>, Archit Taneja <architt@codeaurora.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Marek Vasut <marek.vasut@gmail.com>, kernel list <linux-kernel@vger.kernel.org>, Dinh Nguyen <dinh.linux@gmail.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, Jingoo Han <jg1.han@samsung.com>, Rob Clark <robdclark@gmail.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, shc_work@mail.ru, linux@arm.linux.org.uk, hsweeten@visionengravers.com

--klwRfHd3PBXfSr1Lid5AjRKreBdEVEFsx
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 24/04/15 16:29, Pavel Machek wrote:
> Hi!
>=20
> On Fri 2015-04-10 12:35:52, Archit Taneja wrote:
>>> That said, if the fb is in RAM, and is only written by the CPU, I thi=
nk
>>> a normal memcpy() for fb_memcpy_fromfb() should be fine...
>>
>> I didn't test for performance regressions when I posted this patch.
>>
>> A look at _memcpy_fromio in arch/arm/kernel/io.c shows that readb() is=
 used
>> all the time, even when the source and destination addresses are align=
ed for
>> larger reads to be possible. Other archs seem to use readl() or readq(=
) when
>> they can. Maybe that makes memcpy_fromio slower than the implementatio=
n of
>> memcpy on arm?
>=20
> Ok, can you prepare a patch for me to try? Or should we just revert
> the original commit?

The old way worked fine, afaik, so maybe we can revert. But still, isn't
it more correct to use memcpy_fromio? It's (possibly) io memory we have
here.

 Tomi



--klwRfHd3PBXfSr1Lid5AjRKreBdEVEFsx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJVOkfTAAoJEPo9qoy8lh71eYIQAJ509Sy/MlGlLPXAlAp8Q4BV
SQYHOtLMcMbUykUHks7oXsEtK6lAv8qRLrByTWiIHShTR36GwwLVEyd6jgv1bNjJ
BxWViPbdO3BX6KTCHunxPZwQjDFgj+fcW21HpFfahUm9CkptmH+mZsWl2xDo70iD
wp2KcQGIYTcJlx2Hgy6u+ADDEbcK+v7G2USH9pwt4EPmqKMFQ/XPpIiTZ/VF9N7b
mjbPLC/D+hwS+Cu9gaGABl1q3aEErQO07itjqzohqkTbTED5g/r05iSDKvhGX1eK
JQ0sybBElJj7NMHfRDDY7PJ/yDFZj3F6e10vG+c8sf9GzzusIOYIvIk7yBlFKaxM
ZNHSTnP8S4oky0FDUUpiKlokEunDk97iqdT1h3Gy80IXsvPw9esF0xif7n/Dml8z
x2SUSSFP6rTq9PPIgypQ4FhZ556c6lGve6wQJuKIhFuOSY27F8cpRw0suRnfcShk
bUt8HkxXqFKWKSrOySi/R6AllBBi1Szt567j6azfT/I/aVgPe9bGr11ndWSqIz1q
DRzeRY1HnMNIv6vhrZwDJhaNbiWh2Jbi3qv09l86mRYy5eqWDk1ll5wxImImEcyJ
q+f7IZGAUx//AruUYVIHyt7L/Y4N6syO3s/37LiKbJj7Y+QrOwwJHlvrKqOgA0Nv
4ACqjfaUwr2pV2rzIRXt
=XViN
-----END PGP SIGNATURE-----

--klwRfHd3PBXfSr1Lid5AjRKreBdEVEFsx--
