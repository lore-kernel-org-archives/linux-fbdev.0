From: Antonino Daplas <adaplas@pol.net>
Subject: Re: fb_imageblit()
Date: 11 Jan 2003 13:11:35 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1042259624.932.115.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0301101857310.18287-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from willow.compass.com.ph ([202.70.96.38])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18XE5l-0004Ri-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 10 Jan 2003 21:21:57 -0800
In-Reply-To: <Pine.LNX.4.44.0301101857310.18287-100000@phoenix.infradead.org>
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

On Sat, 2003-01-11 at 03:23, James Simmons wrote:
> 
> > I've thought of that also, packing the data according to the pixel depth.  
> 
> Actually I was think more along the image depth. The largest the penguin 
> logo gets is 224 colors. Meaning the largest image.depth is 8 bits per 
> pixel. I do agree it is messy to pack the logo data. So for say the 16 
> color logo (4 bpp) putting two pixels worth of data into each byte and 
> then seperating it out would be time consuming. The only reason I was 
> thinking this way is because of userland using the cursor means imageblit 
> is visible to userland. 

That's why we don't need to support software cursor routines, which
implies that imageblit will not be exposed to user space.  It's
impractical to do that in kernel space anyway because you need lot's of
additional code:

1.You have to constantly save and restore the screen underneath the
cursor. In the console we can cheat because we know the current
character underneath the cursor and movement of the cursor is granulated
anyway, per character instead of per pixel.

2.  Imageblit has to support more ROP's.  Otherwise, the user will be
stuck with a rectangular cursor.  In fbcon, again, we can cheat, because
we always know that any given character is just made up of 2 colors, the
background and the foreground. So it's easy to do bit operations using
the cursor image, the cursor mask, and the font bitmap of the character
underneath the cursor. In user space, expect the image beneath the
cursor to be composed of > 2 colors.
 
3. Optionally, imageblit has to support color expansion other than
mono->framebuffer format  in case the cursor image depth != framebuffer
depth.  Note, imageblit is limited by length of info->pseudo_palette, so
the app cannot pass a cursor image whose depth is equal to the
framebuffer depth (unless bpp <= 4bpp).

4. Imageblit will not be able to practically support more than 256
colors at a time and still do it efficiently. Either we change the
formatting of the data to match the native framebuffer format, which is
the most efficient but requires intimate knowledge of the hardware, or
change it into directcolor format.  Changing it to directcolor format
means we have to reconstruct each pixel from the cmap. This is just too
slow.
  
So only drivers with hardware cursor support need to expose it to
userspace.  And we keep imageblit private to fbcon.

> 
> > a. Prepare logo data so each pixel of data is in directcolor format (if
> > we will use the cmap), so depth corresponds to framebuffer depth, and
> > data is packed. 
> 
> The depth doesn't have to be the same as the framebuffer depth. The logo 
> data is in terms of color map indices. I did think in terms of packed data 
> tho.
> 

So how will the driver know how the logo data is packed if it's not
based on the framebuffer depth? Unless you have conditionals like:

if (!(8 % var->bits_per_pixel) && var-bits_per_pixel <= 8)
	pixels_per_byte = 8/var->bits_per_pixel; /* 1, 2, 4, 8 bpp*/
else
	pixels_per_byte = 1; 

Or:

	pixels_per_byte = 1 /* always */

The latter is so much simpler.  

Or if you want to pack 1-8 bpp entirely, then be willing to add code for
packing 3, 5, 6, 7 bpp.
 
> > d. Get each color component from the cmap data. 
> > 
> > e. Recreate pixel data based on var.[color].offset and
> > var.[color].length. 
> 
> Yuck no. Doing a fb_set_cmap should handle that before we call 
> xxxfb_imageblit. Then xxxfb_imageblit only has to take the data in 
> the logo data as indices of the color map. Of 
>  

Which is what the current code is already doing, building a temporary
pseudo_palette, albeit without the driver's notice. By extending the
pseudo_palette to 256 entries, we can let the driver build it on its
own.

> > f. Write the pixel data in packed form to the framebuffer. 
> 
> > Whereas, with the current approach: 
> > 
> > a. Prepare logo data such that each pixel corresponds to one byte. 
> > 
> > b. Pass the structure to cfb_imageblit. 
> > 
> > c. Read color information from pseudopalette if directcolor/truecolor. 
> > 
> > d. Write the pixel data in packed form to the framebuffer. 
> 
> I was think the same way except for the idea of more than one color 
> indices per byte for less than 8 bpp modes.
>  

Same argument as the above. Too much complexity, too little gain.

> > Secondly, indexing the cmap instead of the pseudo_palette means that
> > cfb_imageblit has to know the native framebuffer format.  
> 
> No indexing the cmap. Instead call fb_set_cmap before we call 
> xxxfb_imageblit. Personally I think we should call fb_set_cmap always.
> 

Only if the pseudo_palette is extended to > 16 entries, or some exotic
hardware requires it.  Otherwise, it's useless besides setting the color
register.

In any case, it's an easy fix.

> > I would rather have everything refer to
> > the pseudopalette, regardless of the visual format.  This will be better
> > especially for some of the corner cases, like monochrome cards with
> > bits_per_pixel = 8. 
> 
> It works pretty good for for any pack pixel type modes. Now for planar 
> cards this isn't the case. Ideally struct fb_cmap should have contained 
> a 

I don't see a problem here.  vga16fb is planar, and logo drawing works
just fine.

> 
> unsigned long pixel;
> 
> field. Like X does. It does not and changing that would break things :-(
>  

Isn't that what info->pseudo_palette is used for?

Tony



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
