From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: fb_imageblit semantic
Date: Mon, 17 Mar 2003 14:47:38 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0303171436170.17453-100000@vervain.sonytel.be>
References: <1047906079.2684.53.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18uuzY-0004kG-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 17 Mar 2003 05:49:29 -0800
In-Reply-To: <1047906079.2684.53.camel@localhost.localdomain>
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
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>, James Simmons <jsimmons@infradead.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On 17 Mar 2003, Antonino Daplas wrote:
> On Mon, 2003-03-17 at 20:25, Petr Vandrovec wrote:
> > On 17 Mar 03 at 13:18, Geert Uytterhoeven wrote:
> > > 
> > > That depends... How do we draw the monochrome penguin? Using image->depth is 1
> > > or 8? The latter (current method) is slower, since we need to expand the
> > > monochrome logo to 8-bit first, and (usually) compress it to 1-bit in the fbdev
> > > driver afterwards.
> > 
> > As far as I can see, it gets monochromatic logo and converts it to
> > 8bpp format ;-) (fb_set_logo, needs_logo = 1 or ~1) And then imageblit
> > converts it back to 1bpp.
> 
> Yes.  That's the sacrifice for simplicity and consistency, low color
> depths sacrifice on speed, high color depth sacrifice on color range. 
> The real beneficiary is 8-bit pseudo-pixel.

Indeed.

> Of course, there's always a choice:
> 
> 1.  allow support for non-monochrome expansion/reduction in
> cfb_imageblit(), ie input data is 4bpp and framebuffer format is 16 bpp,
> directcolor.
> 
> 2.  prepare all logo so image->depth matches framebuffer depth.  This
> will require  that fb_prepare_logo() has additional code to pack
> image->data properly

This moves code from the low-level driver to the high-level, and thus reduces
code duplication.

The disadvantage is that the conversion may be a waste of work, if the
resulting image data is not in the same format as the hardware uses (e.g. for
bitplanes).

> 3.  Just add conditionals like:
> 
> if depth == 1
> 	logo->data == logo_bw
> else if depth == 4
> 	logo->data == logo_4
> else if depth == 8
> 	logo->data == logo_8
> else
> 	prepare_logo_to_match_fb_depth

Don't forget about other depths. And the number of logo colors does not depend
on the color depth only, for visuals different from pseudocolor.

> For #2 and #3, what do we do when var->bits_per_pixel > 8?  Do we still
> use image->depth=8?

IMHO always using an image depth of 8 is fine. That's a nice trade off between
genericity and easy access of image data.

Except for monochrome, there I prefer a depth of 1, since doing 1->8 and 8->1
in a row is a bit too wasteful.

BTW, I just realized there's no need to distinguish between monochrome copy and
monochrome-to-color expansion. The monochrome logo code just has to write the
correct values to fb_image.[fb]gcolor. I.e. all zeroes or all ones (number of
bits = var.bits_per_pixel, so it works for 8-bit monochrome, too).

> Do we still use the LUT?  

Yes. An alternative is to enlarge the pseudo palette to 256 entries (if there
are enough number of colors). But since imageblit is done for the logo only,
doing the transform from LUT index to pixel value in imageblit is OK, I think.

> 4.  Go back to the 2.4 way of drawing the logo, let the upper layer do
> everything, and just directly memcopy the data to the framebuffer.

Ugh... This is much worse, since the logo drawing code has to know about all
possible frame buffer formats. In the current scheme, this is nicely hidden in
imageblit.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
