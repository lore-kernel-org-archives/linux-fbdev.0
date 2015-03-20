From: Thomas =?UTF-8?B?TmllZGVycHLDvG0=?= <niederp@physik.uni-kl.de>
Date: Fri, 20 Mar 2015 20:27:48 +0000
Subject: Re: [PATCH 4/8] fbdev: ssd1307fb: Use vmalloc to allocate video memory.
Message-Id: <20150320212748.4bc2b42a@maestro.intranet>
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
	<CAMuHMdXA87LOYxTwf5G3EZ58dPQJfdgv=3esSJQ_MQqCQciKKw@mail.gmail.com>
In-Reply-To: <CAMuHMdXA87LOYxTwf5G3EZ58dPQJfdgv=3esSJQ_MQqCQciKKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Am Fri, 20 Mar 2015 16:24:29 +0100
schrieb Geert Uytterhoeven <geert@linux-m68k.org>:

> On Fri, Mar 20, 2015 at 3:47 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > On Fri, Mar 20, 2015 at 01:37:50PM +0200, Tomi Valkeinen wrote:
> >> On 15/03/15 00:02, Geert Uytterhoeven wrote:
> >> > On Fri, Mar 13, 2015 at 10:31 PM, Thomas Niederpr=C3=BCm
> >> > <niederp@physik.uni-kl.de> wrote:
> >> >> Am Tue, 10 Mar 2015 13:28:25 +0200
> >> >> schrieb Tomi Valkeinen <tomi.valkeinen@ti.com>:
> >> >>> Also, isn't doing __pa() for the memory returned by vmalloc
> >> >>> plain wrong?
> >> >>
> >> >>> What was the crash about when using kmalloc? It would be good
> >> >>> to fix defio, as I don't see why it should not work with
> >> >>> kmalloced memory.
> >> >>
> >> >> The main challenge here is that the memory handed to userspace
> >> >> upon mmap call needs to be page aligned. The memory returned by
> >> >> kmalloc has no such alignment, but the pointer presented to the
> >> >> userspace program gets aligned to next page boundary. It's not
> >> >> clear to me whether there is an easy way to obtain page aligned
> >> >> kmalloc memory. Memory allocated by vmalloc on the other hand
> >> >> is always aligned to page boundaries. This is why I chose to go
> >> >> for vmalloc.
> >> >
> >> > __get_free_pages()?
> >>
> >> I'm not that experienced with mem management, so I have to ask...
> >> __get_free_pages() probably works fine, but isn't vmalloc better
> >> here?
> >>
> >> __get_free_pages() will give you possibly a lot more memory than
> >> you need. And the memory is contiguous, so it could be difficult
> >> to allocate a larger memory area. The driver doesn't need
> >> contiguous memory (except in the virtual sense).
> >
> > vmalloc also returns pages, so the size will be page-aligned. It
> > doesn't make much of a difference here, since we will only use a
> > single page in both case (the max resolution of these screens is
> > 128x39, with one bit per pixel).
>=20
> In that case I recommend get_zeroed_page(), to avoid the vmalloc()
> overhead of setting up a mapping.

I looked into get_zeroed_page() too but I thought __get_free_pages()
might be more future proof since get_zeroed_page() will not reserve
enough memory if more than one page is needed. This might occur if a new
controller pops up that has more pixels than bits in a page or the
driver is used on a system with a small page size. Also
get_zeroed_page() is also just calling __get_free_pages() with the
order parameter set to 0. Therefore I think a call like

__get_free_pages(GFP_KERNEL | __GFP_ZERO, get_order(size))=20

does the same as get_zeroed_page() if only one page is needed but has
the ability to reserve more pages if needed.

Thomas

