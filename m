From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Re: fb_write change in your tree
Date: Wed, 24 Mar 2004 10:28:03 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0403241026240.25288@waterleaf.sonytel.be>
References: <Pine.LNX.4.44.0403232136250.4798-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B64gJ-0007Zp-MQ
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 24 Mar 2004 01:28:15 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1B64gI-0003gC-BJ
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 24 Mar 2004 01:28:14 -0800
In-Reply-To: <Pine.LNX.4.44.0403232136250.4798-100000@phoenix.infradead.org>
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
> > >    The other bonus with using the imageblit method with fb_write is
> > > that we can treat planar modes a packed pixel modes :-)
> >
> > Never thought about that one...
> >
> > So if your application doesn't support the frame buffer format, it can use
> > write() instead of mmap() and just use packed pixels in a shadow frame buffer.
>
> Yes!!!
>
> > But what about read()? There's no imageget() method.

(sidenote: of course most applications using shadow frame buffers don't need to
 read from the real frame buffer)

> Note!!! The vga16fb and amiga driver would need to have be writing to read
> data from the framebuffer. I don't have a amiga to test it but I can do
> this for vga16fb. The only thing is I don't knowhow to do that for vga16.
> Anyone here no how?

As usual, I can take care of the Amiga driver.

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
