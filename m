From: Antonino Daplas <adaplas@pol.net>
Subject: Re: fb_imageblit()
Date: 08 Jan 2003 10:41:47 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1041993390.927.38.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0301072215370.17129-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from willow.compass.com.ph ([202.70.96.38])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18W6Mw-0006mH-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 07 Jan 2003 18:55:02 -0800
In-Reply-To: <Pine.LNX.4.44.0301072215370.17129-100000@phoenix.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 2003-01-08 at 06:23, James Simmons wrote: 
> > >     
> > >     If monochrome image data would be packed as well, it could be handled by
> > >     setting fb_image.fg_color = 1 and fb_image.bg_color = 0 (or vice versa for
> > >     mono10), and fb_set_logo() becomes simpler as well.
> > > 
> > >     If we retain the unpacked data for images, we need some other flag to
> > >     indicate color expansion. Perhaps setting fb_image.depth to 0?
> > > 
> > If we change the contents of the logo data, then it makes sense to pack
> > the logo data also.  However, if we stick to indices, we might as well
> > retain the "unpacked" 8-bit format.  I think setting fb_image.depth to 0
> > to mean color expansion is more appropriate. Drivers that will need
> > trivial changing would be tgafb, i810fb, rivafb, tdfxfb, atyfb, vga16fb
> > and of course cfb_imgblt.c, softcursor.c and fbcon.c.
> 
> The requirement I made of imageblit was to always use packed data. What 
> the indices approach was to to always use a struct fb_cmap. This way it 
> didn't matter if used a pseudocolor mode or a directcolor mode.
 
I've thought of that also, packing the data according to the pixel depth.  
However, this will be very inefficient since image blitting
will go like this: 

a. Prepare logo data so each pixel of data is in directcolor format (if
we will use the cmap), so depth corresponds to framebuffer depth, and
data is packed. 

b. Pass the structure to cfb_imageblit. 

c. In cfb_imageblit, unpack the logo data: 

d. Get each color component from the cmap data. 

e. Recreate pixel data based on var.[color].offset and
var.[color].length. 

f. Write the pixel data in packed form to the framebuffer. 

Whereas, with the current approach: 

a. Prepare logo data such that each pixel corresponds to one byte. 

b. Pass the structure to cfb_imageblit. 

c. Read color information from pseudopalette if directcolor/truecolor. 

d. Write the pixel data in packed form to the framebuffer. 

Aside from the inefficiency of the method (pack, unpack, pack), drawing
the logo will become inconsistent with the behavior of the rest of the
functions, since it's the only one that gets color info differently.  If
you look at color_imageblit() and slow_imageblit(), they basically use
the same code logic. 

Secondly, indexing the cmap instead of the pseudo_palette means that
cfb_imageblit has to know the native framebuffer format.  This was
argued before that the generic drawing functions need not know of the
format, one of the reasons we have info->pseudopalette.  Actually, in
order to be really consistent, I would rather have everything refer to
the pseudopalette, regardless of the visual format.  This will be better
especially for some of the corner cases, like monochrome cards with
bits_per_pixel = 8. 

Thirdly, it's much simpler for drivers to draw the logo.  Just get the
corrct pixel data from it's own palette.  No need to construct each
pixel from the cmap.  That's tedious, slow, and will contribute to code
bloat.  Which is easier?  Get each byte from the logo data, and use it as an 
index to the pseudo_palette, or unpack the data, separate each unit to 4 
color components, and construct pixel data from cmap using the 4 extracted 
indices?

I agree that it would be faster in some cases to draw a packed logo
data, but if we're going to be inconsistent, let's do it all the way. 
Make the logo data match the native framebuffer format.  This will be
very efficient, and this is the one that I actually prefer.

Tony 





-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
