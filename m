From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: fb_imageblit()
Date: Wed, 8 Jan 2003 16:15:31 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0301081613510.21171-100000@vervain.sonytel.be>
References: <1041993390.927.38.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18WHy5-0003KJ-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 08 Jan 2003 07:18:09 -0800
In-Reply-To: <1041993390.927.38.camel@localhost.localdomain>
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
Cc: James Simmons <jsimmons@infradead.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On 8 Jan 2003, Antonino Daplas wrote:

> On Wed, 2003-01-08 at 06:23, James Simmons wrote: 
> > > >     
> > > >     If monochrome image data would be packed as well, it could be handled by
> > > >     setting fb_image.fg_color = 1 and fb_image.bg_color = 0 (or vice versa for
> > > >     mono10), and fb_set_logo() becomes simpler as well.
> > > > 
> > > >     If we retain the unpacked data for images, we need some other flag to
> > > >     indicate color expansion. Perhaps setting fb_image.depth to 0?
> > > > 
> > > If we change the contents of the logo data, then it makes sense to pack
> > > the logo data also.  However, if we stick to indices, we might as well
> > > retain the "unpacked" 8-bit format.  I think setting fb_image.depth to 0
> > > to mean color expansion is more appropriate. Drivers that will need
> > > trivial changing would be tgafb, i810fb, rivafb, tdfxfb, atyfb, vga16fb
> > > and of course cfb_imgblt.c, softcursor.c and fbcon.c.
> > 
> > The requirement I made of imageblit was to always use packed data. What 
> > the indices approach was to to always use a struct fb_cmap. This way it 
> > didn't matter if used a pseudocolor mode or a directcolor mode.
>  
> I've thought of that also, packing the data according to the pixel depth.  
> However, this will be very inefficient since image blitting
> will go like this: 
> 
> a. Prepare logo data so each pixel of data is in directcolor format (if
> we will use the cmap), so depth corresponds to framebuffer depth, and
> data is packed. 
> 
> b. Pass the structure to cfb_imageblit. 
> 
> c. In cfb_imageblit, unpack the logo data: 
> 
> d. Get each color component from the cmap data. 
> 
> e. Recreate pixel data based on var.[color].offset and
> var.[color].length. 
> 
> f. Write the pixel data in packed form to the framebuffer. 
> 
> Whereas, with the current approach: 
> 
> a. Prepare logo data such that each pixel corresponds to one byte. 
> 
> b. Pass the structure to cfb_imageblit. 
> 
> c. Read color information from pseudopalette if directcolor/truecolor. 

Hoever, pseudopalette has entries for the first 16 colors only!
Hence you are limited to the 16 color for directcolor/truecolor modes.

> d. Write the pixel data in packed form to the framebuffer. 

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
