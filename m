From: James Simmons <jsimmons@infradead.org>
Subject: Re: fb_imageblit()
Date: Fri, 10 Jan 2003 19:23:06 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0301101857310.18287-100000@phoenix.infradead.org>
References: <1041993390.927.38.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from carisma.slowglass.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18X4kr-0006gb-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 10 Jan 2003 11:23:46 -0800
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
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>


> I've thought of that also, packing the data according to the pixel depth.  

Actually I was think more along the image depth. The largest the penguin 
logo gets is 224 colors. Meaning the largest image.depth is 8 bits per 
pixel. I do agree it is messy to pack the logo data. So for say the 16 
color logo (4 bpp) putting two pixels worth of data into each byte and 
then seperating it out would be time consuming. The only reason I was 
thinking this way is because of userland using the cursor means imageblit 
is visible to userland. 

> a. Prepare logo data so each pixel of data is in directcolor format (if
> we will use the cmap), so depth corresponds to framebuffer depth, and
> data is packed. 

The depth doesn't have to be the same as the framebuffer depth. The logo 
data is in terms of color map indices. I did think in terms of packed data 
tho.

> d. Get each color component from the cmap data. 
> 
> e. Recreate pixel data based on var.[color].offset and
> var.[color].length. 

Yuck no. Doing a fb_set_cmap should handle that before we call 
xxxfb_imageblit. Then xxxfb_imageblit only has to take the data in 
the logo data as indices of the color map. Of 
 
> f. Write the pixel data in packed form to the framebuffer. 

> Whereas, with the current approach: 
> 
> a. Prepare logo data such that each pixel corresponds to one byte. 
> 
> b. Pass the structure to cfb_imageblit. 
> 
> c. Read color information from pseudopalette if directcolor/truecolor. 
> 
> d. Write the pixel data in packed form to the framebuffer. 

I was think the same way except for the idea of more than one color 
indices per byte for less than 8 bpp modes.
 
> Secondly, indexing the cmap instead of the pseudo_palette means that
> cfb_imageblit has to know the native framebuffer format.  

No indexing the cmap. Instead call fb_set_cmap before we call 
xxxfb_imageblit. Personally I think we should call fb_set_cmap always.

> I would rather have everything refer to
> the pseudopalette, regardless of the visual format.  This will be better
> especially for some of the corner cases, like monochrome cards with
> bits_per_pixel = 8. 

It works pretty good for for any pack pixel type modes. Now for planar 
cards this isn't the case. Ideally struct fb_cmap should have contained 
a 

unsigned long pixel;

field. Like X does. It does not and changing that would break things :-(
 



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
