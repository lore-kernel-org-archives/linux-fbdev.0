From: James Simmons <jsimmons@www.infradead.org>
Subject: Re: Resource management.
Date: Mon, 21 Feb 2005 23:25:15 +0000 (GMT)
Message-ID: <Pine.LNX.4.56.0502212313160.18148@pentafluge.infradead.org>
References: <Pine.LNX.4.56.0502211908520.14500@pentafluge.infradead.org>
 <200502220653.01286.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D3MvZ-0002Pg-GH
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 21 Feb 2005 15:25:21 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1D3MvX-0004SX-Sp
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 21 Feb 2005 15:25:21 -0800
In-Reply-To: <200502220653.01286.adaplas@hotpop.com>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: adaplas@pol.net
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, James Simmons <jsimmons@pentafluge.infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>


> On Tuesday 22 February 2005 03:11, James Simmons wrote:
> > Hi!
> >
> >    This is my first run at the resource management code. Comments are
> > welcomed :-)
> >
> 
> Hi James,
> 
> Where is this going to?  What I see are performance penalties.  For each
> putcs and cursor, it has to call fb_find_resource() which walks the linked list
> looking for a resource using strncmp().  
> 
> What's the goal here?

	So we don't end up with a struct fb_info constantly growing with struct 
fb_pixmaps. At present we have pixmap and sprite in struct fb_info. In the 
future we will have more. I need to create a pixmap for the framebuffer 
itself. This way we can have hooks for inbuf and outbuf to deal with 
issues of devices that have hardware restriction when writing to the 
framebuffer. The classic example is the Epson135X chipsets. You can only 
write/read 16 bits at a time with the framebuffer. Also in the future I 
plan to add DMA support. One approach to this is pci_pools. This would 
require multiple fb_pixmaps. One for each area for DMA you request. Of 
course we could have a static array of struct fb_pixmaps but there is no 
guarantee that the orders will be the same for each driver.
	
Do you see any other solution to this then?
 



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
