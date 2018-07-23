From: Adam Borowski <kilobyte@angband.pl>
Date: Mon, 23 Jul 2018 10:41:51 +0000
Subject: Re: [PATCH 0/6] vt: no blinking on console, 256/24-bit color improvements
Message-Id: <20180723104151.z3lasjmdd3ubh2sc@angband.pl>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180718030152.kdq53mwpdfusvwl5@angband.pl>
 <20180721074319.GA30454@kroah.com>
 <20180721213843.wkculy5cdrrbmuij@angband.pl>
 <CAMuHMdWvZnU_p-c98sag8t1BCaBLSqZmiH88sgD2kACbvax0pA@mail.gmail.com>
In-Reply-To: <CAMuHMdWvZnU_p-c98sag8t1BCaBLSqZmiH88sgD2kACbvax0pA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-console@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Mon, Jul 23, 2018 at 10:53:29AM +0200, Geert Uytterhoeven wrote:
> On Sat, Jul 21, 2018 at 11:39 PM Adam Borowski <kilobyte@angband.pl> wrote:
> > Technically, every console can be made to blink by drawing/clearing affected
> > characters a few times per second, but that'd be quite a waste of coding
> > time and kernel size.  There's a reason browsers dropped support for <blink>
> > and text-decoration:blink.
> 
> It's very simple and fast to implement in fbcon for FB_TYPE_PLANES or
> FB_TYPE_INTERLEAVED_PLANES and FB_VISUAL_PSEUDOCOLOR ;-)

Interesting...  I'm still not going to do the effort to implement that
(which would require learning fbdev internals first), though.  But while I
dislike this feature, someone else might want it.

The main problem here is that there are only 8 or 7 bits available for
attributes, thus it's better to use them for something more useful.  And
here, fbcon already interprets this bit as bright background, thus this
patchset makes vt use it instead of non-existant blink.

There'll be more bits available once attributes get migrated into uniscr --
either 11 or 32 bits depending on chosen implementation.  But I still
wouldn't go too wild with them: the console is meant for recovery tasks as
on any properly working system you can have an X terminal configured for
pixel-to-pixel identical behaviour as anything console can do.  Thus, only
cheap improvements to attributes make sense.  This patchset is currently at
+3 net lines, this certainly counts as cheap.

On the other hand, displaying the _glyph_ better would be worth some effort.
Nicolas' uniscr that's already in Greg's tree did most of the work, what
remains is a way to load and store a font with more glyphs (needs a sparse
representation).


Meow!
-- 
// If you believe in so-called "intellectual property", please immediately
// cease using counterfeit alphabets.  Instead, contact the nearest temple
// of Amon, whose priests will provide you with scribal services for all
// your writing needs, for Reasonable And Non-Discriminatory prices.
