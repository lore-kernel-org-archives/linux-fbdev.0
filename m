From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: fb_imageblit()
Date: Sun, 5 Jan 2003 19:59:11 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0301051954061.10559-100000@vervain.sonytel.be>
References: <1041790045.1037.23.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18VG0D-0002QJ-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 05 Jan 2003 11:00:05 -0800
In-Reply-To: <1041790045.1037.23.camel@localhost.localdomain>
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
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On 6 Jan 2003, Antonino Daplas wrote:
> On Mon, 2003-01-06 at 00:38, Geert Uytterhoeven wrote:
> > I have a few questions and comments related to fb_imageblit().
> > 
> >  1. Why is the logo data in fb_image.data stored in an `unpacked' way? I.e.
> >     each byte of the logo data corresponds to one pixel of the image,
> >     irrespective of the depth of the image.
> > 
> I asked before what would be the content of the logo data and it was
> agreed that the logo data would either contain indices to the
> pseudo_palette for truecolor and directcolor or the pixel itself for the
> rest so it's consistent with the rest of the soft accel functions. 
> Fixing the minimum unit to one byte seems a reasonable compromise
> between maximum number of colors available and size of logo data.  Plus,
> it would be simpler to code.

Yes, that's reasonable.

> >     However, I do see one good reason: it makes life easier for planar
> >     displays, since a fast c2p (chunky-to-planar) convertor doesn't have to
> >     care about the image depth, the source data is always 1 byte per pixel.
> > 
> >  2. If fb_image.depth == 1, how can fb_imageblit() distinguish between drawing
> >     a monochrome image (e.g. penguin logo) and color expanding a monochrome
> >     image (e.g. drawing text)? It's not possible to handle them the same, since
> >     image data for color expansion is packed, while image data for monochrome
> >     image drawing is not.
> I noticed this before but completely forgot about it because I have no
> monochrome graphics card to test :-)

I didn't think about that as well, until I tried all possible depths (1-8) with
amifb.

> >     If monochrome image data would be packed as well, it could be handled by
> >     setting fb_image.fg_color = 1 and fb_image.bg_color = 0 (or vice versa for
> >     mono10), and fb_set_logo() becomes simpler as well.
> > 
> >     If we retain the unpacked data for images, we need some other flag to
> >     indicate color expansion. Perhaps setting fb_image.depth to 0?
> > 
> If we change the contents of the logo data, then it makes sense to pack
> the logo data also.  However, if we stick to indices, we might as well
> retain the "unpacked" 8-bit format.  I think setting fb_image.depth to 0

OK.

> to mean color expansion is more appropriate. Drivers that will need

OK.

> trivial changing would be tgafb, i810fb, rivafb, tdfxfb, atyfb, vga16fb
> and of course cfb_imgblt.c, softcursor.c and fbcon.c.
> 
> I'll submit a patch if everyone agrees.  

Thanks!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
