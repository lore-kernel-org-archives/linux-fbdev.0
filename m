From: Antonino Daplas <adaplas@pol.net>
Subject: Re: fb_imageblit semantic
Date: 17 Mar 2003 20:07:19 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1047902787.2599.11.camel@localhost.localdomain>
References: <130293E23DB3@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18utS0-0002qK-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 17 Mar 2003 04:10:44 -0800
In-Reply-To: <130293E23DB3@vcnet.vc.cvut.cz>
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

On Mon, 2003-03-17 at 18:40, Petr Vandrovec wrote:
> On 17 Mar 03 at 11:31, Geert Uytterhoeven wrote:
> > On 17 Mar 2003, Antonino Daplas wrote:
> > > As Geert said, it's not just trivial, but logical to split fb_imageblit
> > > into two.
> > 
> > So, are we gonna split it? This will also make hardware acceleration support
> > more clean. E.g. most sbus drivers do color expansion in hardware, and fall
> > back to cfb_imageblit() for the logo.
> > 

It's up to James, though I vote for it.  And I don't think any driver
has accelerated versions of fb_imageblit for the logo, since any
performance gained is probably minimal and it will involve too much work
for something that's going to be done only once.
  
> > > > OK, so rule is that if depth=0, input is 1bpp with palette in bgcol/fgcol,
> > > > while if depth != 0, then palette is in info->pseudo_palette ?
> > > 
> > > Yes.  You can also say that if image->depth != var->bits_per_pixel, do
> > > color expansion or reduction, whatever the case may be.
> > 
> > Hmmm... Note that image->depth can be larger than 8, while the image data is
> > still 8-bit. This is an inconsistency.

I was thinking that if image->depth=8 and var->bits_per_pixel=4, then
the driver is in danger of going out of bounds when referring to the
pseudo_palette.  But I forgot that the fb_show_logo() takes care of
avoiding that :-)  And yes, current usage of image->depth is pretty
inconsistent and basically useless.

> 
> image->depth for logo must change to 8. Or remove depth completely after
> splitting imageblit to paintchar & paintlogo, as currently depth is
> useless anyway: target format is defined by framebuffer layout, not
> by image->depth, and source format is hardwired to the code.

You're correct.  If it's going to be split, image->depth becomes
redundant.

Tony





-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
