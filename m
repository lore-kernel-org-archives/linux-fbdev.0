From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 23 Jul 2018 11:07:27 +0000
Subject: Re: [PATCH 0/6] vt: no blinking on console, 256/24-bit color improvements
Message-Id: <CAMuHMdVPx40SL2kqv+nRUDoX0GL4uKoZd7gYmab94T2RyrpkMw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180718030152.kdq53mwpdfusvwl5@angband.pl> <20180721074319.GA30454@kroah.com>
 <20180721213843.wkculy5cdrrbmuij@angband.pl> <CAMuHMdWvZnU_p-c98sag8t1BCaBLSqZmiH88sgD2kACbvax0pA@mail.gmail.com>
 <20180723104151.z3lasjmdd3ubh2sc@angband.pl>
In-Reply-To: <20180723104151.z3lasjmdd3ubh2sc@angband.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adam Borowski <kilobyte@angband.pl>
Cc: Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-console@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Adam,

On Mon, Jul 23, 2018 at 12:42 PM Adam Borowski <kilobyte@angband.pl> wrote:
> On Mon, Jul 23, 2018 at 10:53:29AM +0200, Geert Uytterhoeven wrote:
> > On Sat, Jul 21, 2018 at 11:39 PM Adam Borowski <kilobyte@angband.pl> wrote:
> > > Technically, every console can be made to blink by drawing/clearing affected
> > > characters a few times per second, but that'd be quite a waste of coding
> > > time and kernel size.  There's a reason browsers dropped support for <blink>
> > > and text-decoration:blink.
> >
> > It's very simple and fast to implement in fbcon for FB_TYPE_PLANES or
> > FB_TYPE_INTERLEAVED_PLANES and FB_VISUAL_PSEUDOCOLOR ;-)
>
> Interesting...  I'm still not going to do the effort to implement that
> (which would require learning fbdev internals first), though.  But while I
> dislike this feature, someone else might want it.
>
> The main problem here is that there are only 8 or 7 bits available for
> attributes, thus it's better to use them for something more useful.  And
> here, fbcon already interprets this bit as bright background, thus this
> patchset makes vt use it instead of non-existant blink.

Even better that they are mutually exclusive ;-)  So it can work fine with
only 4 bitplanes.

That means bitplane 3 means either bright background (palette[8..15] are
the extra-bright versions of palette[0..7]) or blinking (palette[8..15]
alternate between palette[0..7] and all zeroes).

> There'll be more bits available once attributes get migrated into uniscr --
> either 11 or 32 bits depending on chosen implementation.  But I still
> wouldn't go too wild with them: the console is meant for recovery tasks as
> on any properly working system you can have an X terminal configured for
> pixel-to-pixel identical behaviour as anything console can do.  Thus, only
> cheap improvements to attributes make sense.  This patchset is currently at
> +3 net lines, this certainly counts as cheap.

Assumed all those systems are sufficiently powerful to still run X
(said the guy who once ran X with mem=2M on his Amiga, just to prove it could
 work ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
