From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Fri, 20 Mar 2015 14:47:40 +0000
Subject: Re: [PATCH 4/8] fbdev: ssd1307fb: Use vmalloc to allocate video memory.
Message-Id: <20150320144740.GH4255@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="lHGcFxmlz1yfXmOs"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de>
 <1423261694-5939-5-git-send-email-niederp@physik.uni-kl.de>
 <20150207111821.GN2079@lukather>
 <20150207163541.30047a33@maestro.intranet>
 <20150212151121.GJ2079@lukather>
 <20150214152212.1643da7d@maestro.intranet>
 <54FED559.2030506@ti.com>
 <20150313223128.2a3a682e@maestro.intranet>
 <CAMuHMdXTinYuQTpQGc6WyVNpCOhAHPrkHKfRRQAM3Wy6Cg4wvQ@mail.gmail.com>
 <550C068E.1070305@ti.com>
In-Reply-To: <550C068E.1070305@ti.com>
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Thomas =?iso-8859-1?Q?Niederpr=FCm?= <niederp@physik.uni-kl.de>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>


--lHGcFxmlz1yfXmOs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2015 at 01:37:50PM +0200, Tomi Valkeinen wrote:
> On 15/03/15 00:02, Geert Uytterhoeven wrote:
> > On Fri, Mar 13, 2015 at 10:31 PM, Thomas Niederpr=FCm
> > <niederp@physik.uni-kl.de> wrote:
> >> Am Tue, 10 Mar 2015 13:28:25 +0200
> >> schrieb Tomi Valkeinen <tomi.valkeinen@ti.com>:
> >>> Also, isn't doing __pa() for the memory returned by vmalloc plain
> >>> wrong?
> >>
> >>> What was the crash about when using kmalloc? It would be good to fix
> >>> defio, as I don't see why it should not work with kmalloced memory.
> >>
> >> The main challenge here is that the memory handed to userspace upon
> >> mmap call needs to be page aligned. The memory returned by kmalloc has
> >> no such alignment, but the pointer presented to the userspace program
> >> gets aligned to next page boundary. It's not clear to me whether there
> >> is an easy way to obtain page aligned kmalloc memory. Memory
> >> allocated by vmalloc on the other hand is always aligned to page
> >> boundaries. This is why I chose to go for vmalloc.
> >=20
> > __get_free_pages()?
>=20
> I'm not that experienced with mem management, so I have to ask...
> __get_free_pages() probably works fine, but isn't vmalloc better here?
>=20
> __get_free_pages() will give you possibly a lot more memory than you
> need. And the memory is contiguous, so it could be difficult to allocate
> a larger memory area. The driver doesn't need contiguous memory (except
> in the virtual sense).

vmalloc also returns pages, so the size will be page-aligned. It
doesn't make much of a difference here, since we will only use a
single page in both case (the max resolution of these screens is
128x39, with one bit per pixel).

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--lHGcFxmlz1yfXmOs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVDDMLAAoJEBx+YmzsjxAgQsIP/0GnWM+PivfHdGA1akfsBZZz
vfZp/C5I1Aioo5docmp5fHgWHzNtvAabTpD8YXMjG9m4S3VxYLSvuGmCSPCRo8tz
0HRSwbzzbdvM1kSvIp7wvp74oZhBZnuI/QQ/k21vZ6NkL/KZaIzW7RO392lz7mwF
+MXqeij4+ORXizb1lgsn4+1UxjeuRYvyEoaEmAq1JxU7N7z7LWPj/cdZ//27E8fQ
0rJ1Uy1p3Mdqeal+GJph/7b25f6LdEygKP8CgyhXZTFoSmbRe9VmiVvOIzk2foT0
7i7lm5KiMz+ULP0dKAxoNiMvwZzHefPHbbidCskRbnBoPn3do2MD2Fmh8AGifkN9
NMMBXZw3GamABwBpNXNyxBvii0ncVpQAW7zZMsAWOYoL1KwCEZn1Kibyutp8w+0G
UOCIChX+38VJTLIIbru8q2JVg5xA089h76tDNrej+yprg6IW6JK3zwC3fAKxME7D
3//2Gl+bb9r/OfADMcFd8Z86eA+RfSfxbv+8X1+OTgUCiChY7ZlqRFHY5QJbSIpS
NjPraPcSi15pvXZyFQxP7g/H9I66V2LXwsi2h2NAFCH/t88U3yiBE5Gc5j99qkIW
1hMFkxbKBtFdd4+rkaWB7hqhHQsA5pWI7fm3yg8j5LCc0Z31Fhv6sL1L+n8XKHq5
Kz6MrccBfeUs0pkGeE53
=ybWr
-----END PGP SIGNATURE-----

--lHGcFxmlz1yfXmOs--
