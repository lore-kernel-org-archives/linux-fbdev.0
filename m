From: Antonino Daplas <adaplas@pol.net>
Subject: Re: fb_imageblit()
Date: 06 Jan 2003 02:06:52 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1041790045.1037.23.camel@localhost.localdomain>
References: <Pine.GSO.4.21.0301051723310.10559-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from willow.compass.com.ph ([202.70.96.38])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18VFMl-0004bH-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 05 Jan 2003 10:19:20 -0800
In-Reply-To: <Pine.GSO.4.21.0301051723310.10559-100000@vervain.sonytel.be>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Mon, 2003-01-06 at 00:38, Geert Uytterhoeven wrote:
> 
> I have a few questions and comments related to fb_imageblit().
> 
>  1. Why is the logo data in fb_image.data stored in an `unpacked' way? I.e.
>     each byte of the logo data corresponds to one pixel of the image,
>     irrespective of the depth of the image.
> 
I asked before what would be the content of the logo data and it was
agreed that the logo data would either contain indices to the
pseudo_palette for truecolor and directcolor or the pixel itself for the
rest so it's consistent with the rest of the soft accel functions. 
Fixing the minimum unit to one byte seems a reasonable compromise
between maximum number of colors available and size of logo data.  Plus,
it would be simpler to code.

>     However, I do see one good reason: it makes life easier for planar
>     displays, since a fast c2p (chunky-to-planar) convertor doesn't have to
>     care about the image depth, the source data is always 1 byte per pixel.
> 
>  2. If fb_image.depth == 1, how can fb_imageblit() distinguish between drawing
>     a monochrome image (e.g. penguin logo) and color expanding a monochrome
>     image (e.g. drawing text)? It's not possible to handle them the same, since
>     image data for color expansion is packed, while image data for monochrome
>     image drawing is not.
I noticed this before but completely forgot about it because I have no
monochrome graphics card to test :-)

>     
>     If monochrome image data would be packed as well, it could be handled by
>     setting fb_image.fg_color = 1 and fb_image.bg_color = 0 (or vice versa for
>     mono10), and fb_set_logo() becomes simpler as well.
> 
>     If we retain the unpacked data for images, we need some other flag to
>     indicate color expansion. Perhaps setting fb_image.depth to 0?
> 
If we change the contents of the logo data, then it makes sense to pack
the logo data also.  However, if we stick to indices, we might as well
retain the "unpacked" 8-bit format.  I think setting fb_image.depth to 0
to mean color expansion is more appropriate. Drivers that will need
trivial changing would be tgafb, i810fb, rivafb, tdfxfb, atyfb, vga16fb
and of course cfb_imgblt.c, softcursor.c and fbcon.c.

I'll submit a patch if everyone agrees.  

Tony




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
