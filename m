From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Re: [PATCH]: image.depth fix to accomodate
 monochrome cards
Date: Sat, 11 Jan 2003 14:24:05 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0301111422040.18570-100000@vervain.sonytel.be>
References: <1042254692.932.31.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18XLda-0001nk-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 11 Jan 2003 05:25:23 -0800
In-Reply-To: <1042254692.932.31.camel@localhost.localdomain>
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

On 11 Jan 2003, Antonino Daplas wrote:
> On Sat, 2003-01-11 at 03:43, Geert Uytterhoeven wrote:
> > On Fri, 10 Jan 2003, James Simmons wrote:
> > >    I'm just not to crazy about the depth equal zero thing. I just pitcure 
> > > developers having a hard time with it.
> > 
> > Monochrome color expansion just works differently: it expands the zeroes and
> > ones in a bitmap based on fg_color and bg_color, while image drawing draws an
> > image containing colormap indices to the frame buffer.
> > 
> > Do you have a better suggestion?
> > 
> 
> If James is a bit skeptical about this, how about doing it this way:
> 
> If image.fg_color and image.bg_color == 0, then each byte of image.data
> is an index to the pseudo_palette, or the actual pixel, whatever the
> case may be.  Otherwise, image.data is a monochrome bitmap that should
> be expanded using fg_color and bg_color.
> 
> No other changes will be needed except that mono cards have to test for
> fg_color and bg_color, and we need to memset the fb_image structure to 0
> in fb_set_logo(). Non-mono cards will continue testing for image.depth.
> 
> Do you think this will work?  The only problem I can think of is a color
> expansion request where both bg and fg is 0.

And that can happen, try <ESC>[31m<ESC>[41m to set both to red.

> Or to totally eliminate the above possibility, add an extra field in
> struct fb_image to denote color expansion vs logo drawing.  Again, only
> mono cards will need to do this test.

Ugh, why invent a new field if we can use an existing field? depth == 0 is
invalid for image blitting anyway.

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
