From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 16 Nov 2012 09:06:02 +0000
Subject: Re: [PATCH 0/5] OMAPFB: use dma_alloc instead of omap's vram
Message-Id: <50A601FA.5060401@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------enig6B6E37C65F20D7F39C696190"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1352715906-16946-1-git-send-email-tomi.valkeinen@ti.com>
 <20121112225037.GU6801@atomide.com>
In-Reply-To: <20121112225037.GU6801@atomide.com>
To: linux-arm-kernel@lists.infradead.org

--------------enig6B6E37C65F20D7F39C696190
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Tony,

On 2012-11-13 00:50, Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [121112 02:27]:
>> Hi,
>>
>> This series changes omapfb to use standard dma_alloc funcs instead of =
omap
>> specific vram allocator. This let's us remove the omap vram allocator,=
 making
>> omapfb platform independent.
>>
>> However, note that using standard dma funcs causes the following downs=
ides:
>>
>> 1) dma_alloc_attrs doesn't let us allocate at certain physical address=
=2E
>> However, this should not be a problem as this feature of vram allocato=
r
>> is only used when reserving the framebuffer that was initialized by th=
e
>> bootloader, and we don't currently support "passing" a framebuffer fro=
m
>> the bootloader to the kernel anyway.
>>
>> 2) dma_alloc_attrs, as of now, always ioremaps the allocated area, and=

>> we don't need the ioremap when using VRFB. This patch uses
>> DMA_ATTR_NO_KERNEL_MAPPING for the allocation, but the flag is current=
ly
>> not operational.
>>
>> 3) OMAPFB_GET_VRAM_INFO ioctl cannot return real values anymore. I
>> changed the ioctl to return 64M for all the values, which, I hope, the=

>> applications will interpret as "there's enough vram".
>>
>> 4) "vram" kernel parameter to define how much ram to reserve for video=
 use no
>> longer works. The user needs to enable CMA and use "cma" parameter.
>=20
> Great, thanks for fixing these. Could you please queue these into
> a separate branch against v3.7-rc5 that I can also merge into
> omap-for-v3.8/cleanup-headers-prepare-multiplatform-v3?

Should we enable CMA by default in omap2plus_defconfig? And perhaps on
omap1 also?

I have to say I don't know the details of the dma allocation, but afaik
there are no drawbacks with CMA. Although it is still marked
EXPERIMENTAL in the kconfig...

 Tomi



--------------enig6B6E37C65F20D7F39C696190
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iQIcBAEBAgAGBQJQpgH6AAoJEPo9qoy8lh71mg0QAJMkXTxnH7b/iSGY0GJYQ9VR
yczH8GbCaonPuzOxHqmuoOq2NBPKjuZHcKorX1JzMozf6BpXIg0xy49sJBUskWjR
5BFWDnXuRsIXLJQLQEWrgWYP9mcxMz/aDooEp//xBb/TCHQ4CTaFjM1CcrvEBzIh
qh8L+9/XltC+qgnljEt0uvf0BGBrrMiVCfDJ65fPDFosRISvke3mGGJ+Mtwv2KJJ
D03sN7LALzEN5nD434uEKwKoZz0ZGv/5Gwzq+RmGemYnNy9D2kEpCMhyIWZ6Hrmg
jVrsGKVo/gOewbzOJGNPO8tvvA1wAPtI5kpSegUyFXQNQTVvHFLfCXvnCkXmCFEK
CcWseGFccBAlZOwtE8OA2FWZAv3vmVDRu4A5BSM/ZgqxARzLN2UZ+Y7Ja/RYeyJR
m4jwxb1YjQRIPJjoFZkvK5uUsxAEuqCk129IlxbdYKub/3RaAnMx+IiswrzooBeB
Edz5VUzw1xDrG5lxT8PFJJttvLIROyA21fuxUd3B+dp6bL/yrP/LQs/pjbTCUvSx
ClBuCv5pJgEde/0ZEW6UaGQqJRFGKfNaB2ALrTIftCCA5j+Z8D1FI/tEOzeKk/B0
Zzzr9k5aT8V2x8z2h9lWuvMPClT+r6SGn2myhsrnA/1ioqTe0nkXXvk6FCpFnkUH
Cqzkq+h1Fv6eVT//BX6T
=dyiQ
-----END PGP SIGNATURE-----

--------------enig6B6E37C65F20D7F39C696190--
