From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Re: HP300 support checked in
Date: Wed, 14 Jul 2004 11:05:21 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0407141104220.17289@waterleaf.sonytel.be>
References: <1089576608.2555.35.camel@kars.perseus.home>
 <200407141532.45514.adaplas@hotpop.com> <Pine.GSO.4.58.0407140957470.17289@waterleaf.sonytel.be>
 <200407141638.45154.adaplas@hotpop.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bkfhf-0005U7-4h
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 14 Jul 2004 02:05:27 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1Bkfhe-0005F1-FY
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 14 Jul 2004 02:05:26 -0700
In-Reply-To: <200407141638.45154.adaplas@hotpop.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Antonino Daplas <adaplas@pol.net>
Cc: Kars de Jong <jongk@linux-m68k.org>, Linux/m68k kernel mailing list <linux-m68k@lists.linux-m68k.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 14 Jul 2004, Antonino A. Daplas wrote:
> On Wednesday 14 July 2004 16:00, Geert Uytterhoeven wrote:
> > On Wed, 14 Jul 2004, Antonino A. Daplas wrote:
> > > Or we can use the fields in var->green, var->red, var->blue, ie,  to
> > > describe a 4-color 8-bit chunky framebuffer:
> > >
> > > var->red.length = 2;
> > > var->red.offset = 0;
> > > var->green = var->blue = var->red.
> > > var->bits_per_pixel = 8;
> >
> > This breaks something different, since for pseudocolor visuals, the
> > *.lengths indicate the sizes of the CLUT entries (e.g. 8 bit per component
> > for modern 24-bit color, 6 bit for VGA-style 18-bit color).
>
> I don't know.  For pseudocolor, color depth == CLUT size.  So if we check if all
> lengths are equal and if all offsets are equal to zero, then color depth = CLUT size.
> Otherwise, color depth = red.length + green.length + blue.length. Transparency
> can be ignored for now.

Forget what I said. I was a bit confused, mixing code from many years ago in my
head...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
