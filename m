From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Re: fb_write change in your tree
Date: Tue, 23 Mar 2004 21:10:12 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0403232108030.17102@waterleaf.sonytel.be>
References: <Pine.LNX.4.44.0403231806450.2419-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B5sE6-00056W-E2
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 23 Mar 2004 12:10:18 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1B5sE5-0003Be-L7
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 23 Mar 2004 12:10:17 -0800
In-Reply-To: <Pine.LNX.4.44.0403231806450.2419-100000@phoenix.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Tue, 23 Mar 2004, James Simmons wrote:
> > What is this change to fb_write() in your tree ? It looks very
> > wrong to me. You are removing the ability for the driver to
> > hook it's own fb_write function, which can be a problem. You
> > basically assume copy_from_user() can be used straight with
> > the framebuffer as a destination.
>
> Look again. The idea was to grab the userland data and create struct
> fb_image then use xxxfb_imageblit to draw for you. We should never
> allow fb_write and fb_read to directly access the framebuffer.
>
> Speaking of. We really need to cleanup the fb_write and crap.
> The program flow should be:
>
> fb_write -> xxxfb_imageblit -> fb_pixmap.outbuf();
>
> The outbuf and inbuf commands should replace the fb_writeX and fb_readX
> stuff. This way driver developers can still use the cfb_xxx functions for
> strange hardware. a good example is the Epson 1335 chip. You can only
> access the framebuffer 16 bits at a time. Using 32 bit transfers will drop
> have the data. Why epson did this will never be know.
>
>    The other bonus with using the imageblit method with fb_write is
> that we can treat planar modes a packed pixel modes :-)

Never thought about that one...

So if your application doesn't support the frame buffer format, it can use
write() instead of mmap() and just use packed pixels in a shadow frame buffer.

But what about read()? There's no imageget() method.

Do we want to support writev() as well? That would be useful for drawing
rectangular images.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
