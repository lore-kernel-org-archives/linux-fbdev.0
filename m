From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Resource management.
Date: Tue, 22 Feb 2005 21:25:54 +0800
Message-ID: <200502222125.58858.adaplas@hotpop.com>
References: <Pine.LNX.4.56.0502211908520.14500@pentafluge.infradead.org> <200502220653.01286.adaplas@hotpop.com> <Pine.LNX.4.56.0502212313160.18148@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D3a3N-0000C1-BR
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 22 Feb 2005 05:26:17 -0800
Received: from smtp-out.hotpop.com ([38.113.3.51])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D3a3M-0006gq-LO
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 22 Feb 2005 05:26:17 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 1FBAC725DE
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 22 Feb 2005 13:26:09 +0000 (UTC)
In-Reply-To: <Pine.LNX.4.56.0502212313160.18148@pentafluge.infradead.org>
Content-Disposition: inline
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: James Simmons <jsimmons@www.infradead.org>, adaplas@pol.net
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, James Simmons <jsimmons@pentafluge.infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>

On Tuesday 22 February 2005 07:25, James Simmons wrote:
> > On Tuesday 22 February 2005 03:11, James Simmons wrote:
> > > Hi!
> > >
> > >    This is my first run at the resource management code. Comments are
> > > welcomed :-)
> >
> > Hi James,
> >
> > Where is this going to?  What I see are performance penalties.  For each
> > putcs and cursor, it has to call fb_find_resource() which walks the
> > linked list looking for a resource using strncmp().
> >
> > What's the goal here?
>
> 	So we don't end up with a struct fb_info constantly growing with struct
> fb_pixmaps. At present we have pixmap and sprite in struct fb_info. In the
> future we will have more. I need to create a pixmap for the framebuffer
> itself. This way we can have hooks for inbuf and outbuf to deal with
> issues of devices that have hardware restriction when writing to the
> framebuffer. The classic example is the Epson135X chipsets. You can only
> write/read 16 bits at a time with the framebuffer. Also in the future I
> plan to add DMA support. One approach to this is pci_pools. This would
> require multiple fb_pixmaps. One for each area for DMA you request. Of
> course we could have a static array of struct fb_pixmaps but there is no
> guarantee that the orders will be the same for each driver.
>
> Do you see any other solution to this then?

The structure fb_pixmap was designed originally as a kind of scratchpad, ie,
this is where each character map is consolidated into a single image before
writing to the framebuffer.  Of course, this structure is not restricted to
that role only, but it can be used in different ways, as long as its
function as a scratchpad is kept in mind.  The only thing we need to know is
where this scratchpad is located, is it in system RAM or some kind of IO
memory, and we already have support for that. In short, it was never meant
as an accessor to different areas of the graphics aperture. which is the
reason I'm not too keen on info->sprite.

In the example you cited, the epson problem can be easily solved by
creating an epson-specific fb_read/write.

However, if you are trying to add features to fbdev, like video overlay,
textures and the like, then that is a different problem altogether and
requires a new interface/architecture. Extending the function of structure
fb_pixmap will just complicate things even more by blurring its role as
a simple scratchpad area.

Tony




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
