From: Antonino Daplas <adaplas@pol.net>
Subject: Re: fb_imageblit semantic
Date: 17 Mar 2003 07:00:32 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1047855544.1220.79.camel@localhost.localdomain>
References: <12BAC7B62B6D@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18uhAd-0001lV-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 16 Mar 2003 15:03:59 -0800
In-Reply-To: <12BAC7B62B6D@vcnet.vc.cvut.cz>
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

On Fri, 2003-03-14 at 18:52, Petr Vandrovec wrote:
> On 14 Mar 03 at 11:40, Geert Uytterhoeven wrote:
> > On Fri, 14 Mar 2003, Petr Vandrovec wrote:
> > > On 14 Mar 03 at 10:22, Geert Uytterhoeven wrote:
> > > > On Thu, 13 Mar 2003, Petr Vandrovec wrote:
> > > > > Why do you pass image.depth == 16 (or 24 or 32) to fb_imageblit
> > > > > when logo image is in reality always 8bpp, as quick look at 
> > > > > cfb_imageblit revealed?
> > > > 
> > > > Should indeed be 8.
> > > > 
> > > > > Should I just assume that image.depth == 1 means that data are
> > > > > 1bpp with fgcol/bgcol valid, and all other depths mean 8bpp
> > > > > input?
> > > > 
> > > > This was changed from 1 to 0 in James' latest tree.
> > > 
> > > WTF? Color depth 0 means that whole picture is single-color, and
> > > imageblit degenerates to rectfill in such case. Please, either
> > > use 'depth' as source image color depth, or do not name it depth.
> > 
> > It's 0 (expand [bf]gcol) to differentiate from 1 (copy monochrome).
> > 
> > Splitting imageblit into separate routines for both operations would be
> > trivial, though.
> 
> There is no such thing as copy monochrome if target is not monochrome,
> you have to put palette somewhere. If you'll look at cfb_imageblit,
> you'll find that there is already defined way to do that: code uses
> artifically created 256 entry pseudopalette... If target is monochrome,
> it just copies data. If target is not monochrome, it has somehow expand
> data to fit to screen format. Nothing differs between font painting
> and copying 1bpp bitmap to Xbpp display. 
> 

It's mainly code consistency and simplicity.

1.  character painting - monochrome input with color in fg_color and
bg_color

2.  logo drawing -  array of 8-bit color indices which may or may not
point to info->pseudo_palette

Unfortunately, monochrome framebuffers will be affected (how does it
interpret if request is character painting or logo drawing). One
solution is to make an exception for monochrome so we always pass it
packed mono data whether character or logo drawing.  The second, to
avoid the former's inconsistency but has a more confusing semantics, is
make image->depth=0 to mean monochrome expansion.


As Geert said, it's not just trivial, but logical to split fb_imageblit
into two.

> OK, so rule is that if depth=0, input is 1bpp with palette in bgcol/fgcol,
> while if depth != 0, then palette is in info->pseudo_palette ?

Yes.  You can also say that if image->depth != var->bits_per_pixel, do
color expansion or reduction, whatever the case may be.

Tony




-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
