From: Antonino Daplas <adaplas@pol.net>
Subject: Re: fb_imageblit semantic
Date: 17 Mar 2003 21:02:12 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1047906079.2684.53.camel@localhost.localdomain>
References: <1304562C67A8@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18uuJ8-0001Ja-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 17 Mar 2003 05:05:38 -0800
In-Reply-To: <1304562C67A8@vcnet.vc.cvut.cz>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, James Simmons <jsimmons@infradead.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Mon, 2003-03-17 at 20:25, Petr Vandrovec wrote:
> On 17 Mar 03 at 13:18, Geert Uytterhoeven wrote:
> > 
> > That depends... How do we draw the monochrome penguin? Using image->depth is 1
> > or 8? The latter (current method) is slower, since we need to expand the
> > monochrome logo to 8-bit first, and (usually) compress it to 1-bit in the fbdev
> > driver afterwards.
> 
> As far as I can see, it gets monochromatic logo and converts it to
> 8bpp format ;-) (fb_set_logo, needs_logo = 1 or ~1) And then imageblit
> converts it back to 1bpp.
>  

Yes.  That's the sacrifice for simplicity and consistency, low color
depths sacrifice on speed, high color depth sacrifice on color range. 
The real beneficiary is 8-bit pseudo-pixel.

Of course, there's always a choice:

1.  allow support for non-monochrome expansion/reduction in
cfb_imageblit(), ie input data is 4bpp and framebuffer format is 16 bpp,
directcolor.

2.  prepare all logo so image->depth matches framebuffer depth.  This
will require  that fb_prepare_logo() has additional code to pack
image->data properly

3.  Just add conditionals like:

if depth == 1
	logo->data == logo_bw
else if depth == 4
	logo->data == logo_4
else if depth == 8
	logo->data == logo_8
else
	prepare_logo_to_match_fb_depth

For #2 and #3, what do we do when var->bits_per_pixel > 8?  Do we still
use image->depth=8? Do we still use the LUT?  

4.  Go back to the 2.4 way of drawing the logo, let the upper layer do
everything, and just directly memcopy the data to the framebuffer.

> > And perhaps we may want to draw 32-bit ARGB images later?
> > 
> > So I see the following possible valid values for image->depth:
> >   - 8 (logo with up to 256 colors and LUT)
> >   - optional 1 (monochrome logo, if we don't want to expand?)
> >   - optional 32 (ARGB image, dithering left to the driver?)
> 
> I still do not understand 'if we don't want to expand'. This forces too
> much knowledge on upper layer, as far as I can tell.

I agree.

Tony




-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
