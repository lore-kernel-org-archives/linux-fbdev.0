From: James Simmons <jsimmons@infradead.org>
Subject: Re: fb_imageblit()
Date: Tue, 7 Jan 2003 22:23:55 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0301072215370.17129-100000@phoenix.infradead.org>
References: <1041790045.1037.23.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from carisma.slowglass.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18W29A-0001Tn-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 07 Jan 2003 14:24:33 -0800
In-Reply-To: <1041790045.1037.23.camel@localhost.localdomain>
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


> > I have a few questions and comments related to fb_imageblit().
> > 
> >  1. Why is the logo data in fb_image.data stored in an `unpacked' way? I.e.
> >     each byte of the logo data corresponds to one pixel of the image,
> >     irrespective of the depth of the image.
> > 
> I asked before what would be the content of the logo data and it was
> agreed that the logo data would either contain indices to the
> pseudo_palette for truecolor and directcolor or the pixel itself for the
> rest so it's consistent with the rest of the soft accel functions. 
> Fixing the minimum unit to one byte seems a reasonable compromise
> between maximum number of colors available and size of logo data.  Plus,
> it would be simpler to code.

I didn't realize that the data for the logo was unpacked. The imageblit 
blit function that I have written always assumes its packed data. This 
explains why sometimes I get weird effects. I don't mind if the logo image 
is restricked to 256 colors. Have a 65K color image would add alot fo 
bloat to the kernel image.

> >  2. If fb_image.depth == 1, how can fb_imageblit() distinguish between drawing
> >     a monochrome image (e.g. penguin logo) and color expanding a monochrome
> >     image (e.g. drawing text)? It's not possible to handle them the same, since
> >     image data for color expansion is packed, while image data for monochrome
> >     image drawing is not.
> I noticed this before but completely forgot about it because I have no
> monochrome graphics card to test :-)

> >     
> >     If monochrome image data would be packed as well, it could be handled by
> >     setting fb_image.fg_color = 1 and fb_image.bg_color = 0 (or vice versa for
> >     mono10), and fb_set_logo() becomes simpler as well.
> > 
> >     If we retain the unpacked data for images, we need some other flag to
> >     indicate color expansion. Perhaps setting fb_image.depth to 0?
> > 
> If we change the contents of the logo data, then it makes sense to pack
> the logo data also.  However, if we stick to indices, we might as well
> retain the "unpacked" 8-bit format.  I think setting fb_image.depth to 0
> to mean color expansion is more appropriate. Drivers that will need
> trivial changing would be tgafb, i810fb, rivafb, tdfxfb, atyfb, vga16fb
> and of course cfb_imgblt.c, softcursor.c and fbcon.c.

The requirement I made of imageblit was to always use packed data. What 
the indices approach was to to always use a struct fb_cmap. This way it 
didn't matter if used a pseudocolor mode or a directcolor mode.



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
