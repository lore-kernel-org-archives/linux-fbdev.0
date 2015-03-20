From: Thomas =?UTF-8?B?TmllZGVycHLDvG0=?= <niederp@physik.uni-kl.de>
Date: Fri, 20 Mar 2015 20:36:59 +0000
Subject: Re: [PATCH 4/8] fbdev: ssd1307fb: Use vmalloc to allocate video memory.
Message-Id: <20150320213659.11e7f79d@maestro.intranet>
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
	<20150320144740.GH4255@lukather>
	<550C3BE9.7080905@ti.com>
In-Reply-To: <550C3BE9.7080905@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Am Fri, 20 Mar 2015 17:25:29 +0200
schrieb Tomi Valkeinen <tomi.valkeinen@ti.com>:

> On 20/03/15 16:47, Maxime Ripard wrote:
> > On Fri, Mar 20, 2015 at 01:37:50PM +0200, Tomi Valkeinen wrote:
> >> On 15/03/15 00:02, Geert Uytterhoeven wrote:
> >>> On Fri, Mar 13, 2015 at 10:31 PM, Thomas Niederpr=C3=BCm
> >>> <niederp@physik.uni-kl.de> wrote:
> >>>> Am Tue, 10 Mar 2015 13:28:25 +0200
> >>>> schrieb Tomi Valkeinen <tomi.valkeinen@ti.com>:
> >>>>> Also, isn't doing __pa() for the memory returned by vmalloc
> >>>>> plain wrong?
> >>>>
> >>>>> What was the crash about when using kmalloc? It would be good
> >>>>> to fix defio, as I don't see why it should not work with
> >>>>> kmalloced memory.
> >>>>
> >>>> The main challenge here is that the memory handed to userspace
> >>>> upon mmap call needs to be page aligned. The memory returned by
> >>>> kmalloc has no such alignment, but the pointer presented to the
> >>>> userspace program gets aligned to next page boundary. It's not
> >>>> clear to me whether there is an easy way to obtain page aligned
> >>>> kmalloc memory. Memory allocated by vmalloc on the other hand is
> >>>> always aligned to page boundaries. This is why I chose to go for
> >>>> vmalloc.
> >>>
> >>> __get_free_pages()?
> >>
> >> I'm not that experienced with mem management, so I have to ask...
> >> __get_free_pages() probably works fine, but isn't vmalloc better
> >> here?
> >>
> >> __get_free_pages() will give you possibly a lot more memory than
> >> you need. And the memory is contiguous, so it could be difficult
> >> to allocate a larger memory area. The driver doesn't need
> >> contiguous memory (except in the virtual sense).
> >=20
> > vmalloc also returns pages, so the size will be page-aligned. It
> > doesn't make much of a difference here, since we will only use a
> > single page in both case (the max resolution of these screens is
> > 128x39, with one bit per pixel).
>=20
> Ok, that's not much, then =3D).
>=20
> In that case __get_free_pages sounds fine. Even if the resolution
> would be slightly higher, we're only talking about a page or two
> extra.
>=20
> Usually double-underscore in front of a func means "don't call this".
> I don't know why this one has the underscores.

This irritated me as well. But since it turned out that there is even a
section on "get_free_page and Friends" in LDD3 that talks about
__get_free_pages() without any word of caution, I assumed it's ok to
call this functions.

Thomas
