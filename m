From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Resource management.
Date: Tue, 22 Feb 2005 22:06:29 +0800
Message-ID: <200502222206.31364.adaplas@hotpop.com>
References: <Pine.LNX.4.56.0502211908520.14500@pentafluge.infradead.org> <200502220653.01286.adaplas@hotpop.com> <Pine.LNX.4.56.0502212313160.18148@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D3aga-0002r4-LO
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 22 Feb 2005 06:06:48 -0800
Received: from smtp-out.hotpop.com ([38.113.3.51])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D3agZ-0002rj-Mn
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 22 Feb 2005 06:06:48 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id C1A3072410
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 22 Feb 2005 14:06:39 +0000 (UTC)
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

If you intend to insist on doing this, this is my proposal:

The linked list of resources per fb_info can be kept. However, instead
of doing an fb_find_resource() per call to putcs and cursor, this can
be done only once, during initialization of fbcon or set_con2fb_map.
This resource can then be stored in an fbcon-private area. 

The advantage of this is that fbcon will only look for the resource that
it needs, ie "scratchpad" but not, for example, "overlay". Similarly, 
a user video application can totally ignore "scratchpad" but will search for
"overlay".  Secondly, the performance penalty suffered by the your initial
patch will be eliminated. We also eliminate one or two more fields in
fb_info directly accessed by fbcon.

Also, instead of storing the resource type as a string, why not use a
constant?

Tony




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
