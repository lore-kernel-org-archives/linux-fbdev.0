From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 20 Mar 2015 11:37:50 +0000
Subject: Re: [PATCH 4/8] fbdev: ssd1307fb: Use vmalloc to allocate video memory.
Message-Id: <550C068E.1070305@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="iLVp7TA7wp2N9kU5Cso3OsNUF9q1C6r3N"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de>	<1423261694-5939-5-git-send-email-niederp@physik.uni-kl.de>	<20150207111821.GN2079@lukather>	<20150207163541.30047a33@maestro.intranet>	<20150212151121.GJ2079@lukather>	<20150214152212.1643da7d@maestro.intranet>	<54FED559.2030506@ti.com>	<20150313223128.2a3a682e@maestro.intranet> <CAMuHMdXTinYuQTpQGc6WyVNpCOhAHPrkHKfRRQAM3Wy6Cg4wvQ@mail.gmail.com>
In-Reply-To: <CAMuHMdXTinYuQTpQGc6WyVNpCOhAHPrkHKfRRQAM3Wy6Cg4wvQ@mail.gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>, =?UTF-8?B?VGhvbWFzIE5pZWRl?= =?UTF-8?B?cnByw7xt?= <niederp@physik.uni-kl.de>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

--iLVp7TA7wp2N9kU5Cso3OsNUF9q1C6r3N
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 15/03/15 00:02, Geert Uytterhoeven wrote:
> On Fri, Mar 13, 2015 at 10:31 PM, Thomas Niederpr=C3=BCm
> <niederp@physik.uni-kl.de> wrote:
>> Am Tue, 10 Mar 2015 13:28:25 +0200
>> schrieb Tomi Valkeinen <tomi.valkeinen@ti.com>:
>>> Also, isn't doing __pa() for the memory returned by vmalloc plain
>>> wrong?
>>
>>> What was the crash about when using kmalloc? It would be good to fix
>>> defio, as I don't see why it should not work with kmalloced memory.
>>
>> The main challenge here is that the memory handed to userspace upon
>> mmap call needs to be page aligned. The memory returned by kmalloc has=

>> no such alignment, but the pointer presented to the userspace program
>> gets aligned to next page boundary. It's not clear to me whether there=

>> is an easy way to obtain page aligned kmalloc memory. Memory
>> allocated by vmalloc on the other hand is always aligned to page
>> boundaries. This is why I chose to go for vmalloc.
>=20
> __get_free_pages()?

I'm not that experienced with mem management, so I have to ask...
__get_free_pages() probably works fine, but isn't vmalloc better here?

__get_free_pages() will give you possibly a lot more memory than you
need. And the memory is contiguous, so it could be difficult to allocate
a larger memory area. The driver doesn't need contiguous memory (except
in the virtual sense).

 Tomi



--iLVp7TA7wp2N9kU5Cso3OsNUF9q1C6r3N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVDAaOAAoJEPo9qoy8lh71L70P/15gbDWd9nqhGyGXILqnArxh
J0mmJY1ayJNXm6VDGkd9/BxrKSEwWvQQrqwRTrJopJhZj1qJhCf/ozkCpaE30NLD
INwU7T4gUuOnjUUEDNgRdY6HcPeVk2g0cYKiPBr3A7YKv8sIDAQvRsNEC9De8ur+
PdhjQbippl2GXdQsdrLUJIeDqxj7JzYM0bKjNxGiY5QncHizF1hCSaMerAdU7iNV
4pFOUzEesstB9OXKoMFacEM+nnne7xYkN4gjE8pTM4C4zTVNyuXsm/7A5KGbnqY0
gZVpfSuwpt/XM2JLeef3KN+zSXJp42zWhUbwb0wvyUbil7B2gr2TdpFbOCeynamk
p0+qoZben0+h1r20QmV4ma2vsO403Dvf3naW04713ousnBufwqGcREFjyduimnOl
84ih8RfDXOSZTMHkz6Aqv+oEFBl54UiiDYCC3btkVYHxeJq4JzKqkFxS5fWYq8f3
cWlV9zebhJS/8Rb9Ak6H/bGHi0stG48lVcsgF4lTRmNPs897YPP94FOLD56R3xNH
gP+iMY6Ry0r8uD1HwI5zWAaV6rNavf6HIKsyJD8wtikfNMdntNtii4SMAbDmtzDw
K6amHT60Eskzt1Aa278YV0yP7Cy0wzm0NpZeEW4QOSNu4HnP5J+JVkeWsEcawNkT
w96ZE0Qed3F7kC/8UFfm
=LCgm
-----END PGP SIGNATURE-----

--iLVp7TA7wp2N9kU5Cso3OsNUF9q1C6r3N--
