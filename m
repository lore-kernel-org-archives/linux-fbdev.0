From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Re: [PATCH]: image.depth fix to accomodate
 monochrome cards
Date: Wed, 8 Jan 2003 10:52:21 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0301081045090.21171-100000@vervain.sonytel.be>
References: <1041991742.927.12.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18WCvk-0003fN-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 08 Jan 2003 01:55:24 -0800
In-Reply-To: <1041991742.927.12.camel@localhost.localdomain>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Antonino Daplas <adaplas@pol.net>
Cc: James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On 8 Jan 2003, Antonino Daplas wrote:
> On Wed, 2003-01-08 at 05:06, Geert Uytterhoeven wrote: 
> > On 8 Jan 2003, Antonino Daplas wrote:
> > > 2.  diff submitted by Geert: cleaner logo data preparation for
> > > monochrome cards and correct initialization of palette_cmap.transp.
> > 
> > I'll have to do some more fixes there, since the monochrome logo is used not
> > only on monochrome displays, but on all other displays with bits_per_pixel < 4
> > Since the pixel data in fb_image are colormap indices, they have to reflect the
> > correct `black' and `white' colors on such displays.
> > 
> > E.g. on amifb (which supports all bits_per_pixel from 1 through 8) the logo
> > showed up in black-and-blue with bits_per_pixel == 3, cfr. the first two
> > entries of {red,green,blue}8[] in fbcmap.c.
> > 
> 
> Hmm, I see.  I think only linux_logo_bw will be the only one affected,
> since linux_logo_16 happens to match the console palette and in
> linux_logo, we either reset the palette and/or the cmap.

Indeed.

> Would expanding each bit to the full bit depth work?  Ie for bpp=8 using
> monochrome data, white is 0 and black is 0xff.

For bpp=8 that won't work, since we have 16 console colors only :-)

But for bpp=[1-3] that's OK, cfr. fbcmap.c.

BTW, perhaps it makes sense to just pass the appropriate `black' and `white'
pixel values to the logo conversion routine? Preferably through a 2-element
array, so we can index it with the logo data bit value instead of using
tests/branches. Then we'd have:

  - mono01: black = (1<<bits_per_pixel)-1, white = 0
  - mono10: black = 0, white = (1<<bits_per_pixel)-1
  - pseudocolor depth 1: black = 0, white = 1
  - pseudocolor depth 2: black = 0, white = 3
  - pseudocolor depth 3: black = 0, white (actually light grey) = 7

And thanks to the `(1<<depth)-1' instead of `1' for the mono* cases, monochrome
with bits_per_pixel = e.g. 8 will work as well.

What do you think?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
