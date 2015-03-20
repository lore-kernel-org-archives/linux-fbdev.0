From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 20 Mar 2015 15:25:29 +0000
Subject: Re: [PATCH 4/8] fbdev: ssd1307fb: Use vmalloc to allocate video memory.
Message-Id: <550C3BE9.7080905@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="0emKDdt2OlJklDX3VFkdas306Cej8Cswk"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de> <1423261694-5939-5-git-send-email-niederp@physik.uni-kl.de> <20150207111821.GN2079@lukather> <20150207163541.30047a33@maestro.intranet> <20150212151121.GJ2079@lukather> <20150214152212.1643da7d@maestro.intranet> <54FED559.2030506@ti.com> <20150313223128.2a3a682e@maestro.intranet> <CAMuHMdXTinYuQTpQGc6WyVNpCOhAHPrkHKfRRQAM3Wy6Cg4wvQ@mail.gmail.com> <550C068E.1070305@ti.com> <20150320144740.GH4255@lukather>
In-Reply-To: <20150320144740.GH4255@lukather>
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, =?windows-1252?Q?Thomas_?= =?windows-1252?Q?Niederpr=FCm?= <niederp@physik.uni-kl.de>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

--0emKDdt2OlJklDX3VFkdas306Cej8Cswk
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 20/03/15 16:47, Maxime Ripard wrote:
> On Fri, Mar 20, 2015 at 01:37:50PM +0200, Tomi Valkeinen wrote:
>> On 15/03/15 00:02, Geert Uytterhoeven wrote:
>>> On Fri, Mar 13, 2015 at 10:31 PM, Thomas Niederpr=FCm
>>> <niederp@physik.uni-kl.de> wrote:
>>>> Am Tue, 10 Mar 2015 13:28:25 +0200
>>>> schrieb Tomi Valkeinen <tomi.valkeinen@ti.com>:
>>>>> Also, isn't doing __pa() for the memory returned by vmalloc plain
>>>>> wrong?
>>>>
>>>>> What was the crash about when using kmalloc? It would be good to fi=
x
>>>>> defio, as I don't see why it should not work with kmalloced memory.=

>>>>
>>>> The main challenge here is that the memory handed to userspace upon
>>>> mmap call needs to be page aligned. The memory returned by kmalloc h=
as
>>>> no such alignment, but the pointer presented to the userspace progra=
m
>>>> gets aligned to next page boundary. It's not clear to me whether the=
re
>>>> is an easy way to obtain page aligned kmalloc memory. Memory
>>>> allocated by vmalloc on the other hand is always aligned to page
>>>> boundaries. This is why I chose to go for vmalloc.
>>>
>>> __get_free_pages()?
>>
>> I'm not that experienced with mem management, so I have to ask...
>> __get_free_pages() probably works fine, but isn't vmalloc better here?=

>>
>> __get_free_pages() will give you possibly a lot more memory than you
>> need. And the memory is contiguous, so it could be difficult to alloca=
te
>> a larger memory area. The driver doesn't need contiguous memory (excep=
t
>> in the virtual sense).
>=20
> vmalloc also returns pages, so the size will be page-aligned. It
> doesn't make much of a difference here, since we will only use a
> single page in both case (the max resolution of these screens is
> 128x39, with one bit per pixel).

Ok, that's not much, then =3D).

In that case __get_free_pages sounds fine. Even if the resolution would
be slightly higher, we're only talking about a page or two extra.

Usually double-underscore in front of a func means "don't call this". I
don't know why this one has the underscores.

 Tomi



--0emKDdt2OlJklDX3VFkdas306Cej8Cswk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVDDvpAAoJEPo9qoy8lh71dq4P+gL8z4s5FWo6+e3v36qcJ/oz
VXllg9vBmXkWL26GV2JN2pLVmmLhVDeCz6x43VhZWxXe4wc91EI9dRVGoW3OVrc9
pRwohcTY69QbIrcaSBvG47aROWimV6n591dw+tTLTsfgC9XQvYqrJSX6yqXtNXLr
UzwAN3B8yHRW+wE/PTOimzAmUS9LKPFRiUjo8D2CZMjeXCjcfxgxTdrtLanbogEU
NAv5fa3xD80DHgEu937e54Vi0qGVWgGAi4D/TMG8Tmb/YjfsSx1aUI3HWSc1Bjx7
4MAgrxnDrBOxx8JOLrdEjq7tkJFnSglDIzzP1dnzJFxS/IqKbLwkyOyqHGHWX12q
TWRyDoB/5D7Dc+wY+/fFq8gKCnELqhqtN9S9e9UboTQGAy33QkoHQ/qNbPcOvP5b
iGgyyD7J3rkEsz43j6VPCoD6m7Gh+d9fcCF3jiqsXJnkesXecxTykpfEVj1V4Y+o
BqDoeAkkO6QrPBFyTjAQE7WRHiPUDP4Gbi7z+EYcJl9fcWx4nBTTYcf99b1bmBVO
vcJf5meN2RgWm9CGDuVMCZE9+/hNCc17ZEzwLJAlpIdxF385tFEh//Jv74KB5M2K
eC3rEOKQB2APsziq2ym0U9aoKA1yVM6qbx5V5b3MH+myDH74BxCWQUwdWgEbP9oA
dv3unwOAqeHS8vs/1eXL
=ez8V
-----END PGP SIGNATURE-----

--0emKDdt2OlJklDX3VFkdas306Cej8Cswk--
