From: James Simmons <jsimmons@infradead.org>
Subject: Re: Re: fb_write change in your tree
Date: Tue, 23 Mar 2004 21:40:59 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0403232136250.4798-100000@phoenix.infradead.org>
References: <Pine.GSO.4.58.0403232108030.17102@waterleaf.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B5tdx-0000hR-1c
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 23 Mar 2004 13:41:05 -0800
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1B5tdv-0003XO-6h
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 23 Mar 2004 13:41:03 -0800
In-Reply-To: <Pine.GSO.4.58.0403232108030.17102@waterleaf.sonytel.be>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> > Look again. The idea was to grab the userland data and create struct
> > fb_image then use xxxfb_imageblit to draw for you. We should never
> > allow fb_write and fb_read to directly access the framebuffer.
> >
> > Speaking of. We really need to cleanup the fb_write and crap.
> > The program flow should be:
> >
> > fb_write -> xxxfb_imageblit -> fb_pixmap.outbuf();
> >
> > The outbuf and inbuf commands should replace the fb_writeX and fb_readX
> > stuff. This way driver developers can still use the cfb_xxx functions for
> > strange hardware. a good example is the Epson 1335 chip. You can only
> > access the framebuffer 16 bits at a time. Using 32 bit transfers will drop
> > have the data. Why epson did this will never be know.
> >
> >    The other bonus with using the imageblit method with fb_write is
> > that we can treat planar modes a packed pixel modes :-)
> 
> Never thought about that one...
> 
> So if your application doesn't support the frame buffer format, it can use
> write() instead of mmap() and just use packed pixels in a shadow frame buffer.

Yes!!!

> But what about read()? There's no imageget() method.

I have been thinking about that one. The best solution avoiding break the 
current api is to allow a struct fb_image into xxxfb_imageblit that lacks 
a data pointer. If it doesn't have a data pointer we then allocate memory
and transfer data from the framebuffer into the data buffer we have and 
then sent back to the user. 

> Do we want to support writev() as well? That would be useful for drawing
> rectangular images.

If we go with using imageblit for thsi we could. 

Note!!! The vga16fb and amiga driver would need to have be writing to read 
data from the framebuffer. I don't have a amiga to test it but I can do 
this for vga16fb. The only thing is I don't knowhow to do that for vga16. 
Anyone here no how?




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
