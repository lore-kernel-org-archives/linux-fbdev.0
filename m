From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Resource management.
Date: Mon, 21 Feb 2005 20:01:19 -0500
Message-ID: <9e473391050221170111610521@mail.gmail.com>
References: <Pine.LNX.4.56.0502211908520.14500@pentafluge.infradead.org>
	 <200502220653.01286.adaplas@hotpop.com>
	 <Pine.LNX.4.56.0502212313160.18148@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D3OQZ-00071E-Ba
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 21 Feb 2005 17:01:27 -0800
Received: from rproxy.gmail.com ([64.233.170.192])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D3OQV-0000Xh-Sm
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 21 Feb 2005 17:01:26 -0800
Received: by rproxy.gmail.com with SMTP id z35so686298rne
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 21 Feb 2005 17:01:21 -0800 (PST)
In-Reply-To: <Pine.LNX.4.56.0502212313160.18148@pentafluge.infradead.org>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: adaplas@pol.net, James Simmons <jsimmons@pentafluge.infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>

On Mon, 21 Feb 2005 23:25:15 +0000 (GMT), James Simmons
<jsimmons@www.infradead.org> wrote:
>         So we don't end up with a struct fb_info constantly growing with struct
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

You could build this inside of the DRM framework which already
supports DMA and memory management. DRM doesn't really know anything
about 3D, it just knows how to send commands to the graphics hardware.
It's the mesa layer in user space that knows about 3D.

There is a lot of code inside DRM to stop a DRM user from using the
DMA hardware to play with kernel memory and gain root priv. fbdev will
need the same protection if it starts using DMA.

-- 
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
