From: James Simmons <jsimmons@www.infradead.org>
Subject: Re: Framebuffer and non-PCI devices
Date: Tue, 22 Feb 2005 04:01:31 +0000 (GMT)
Message-ID: <Pine.LNX.4.56.0502220401120.21388@pentafluge.infradead.org>
References: <9e47339105021910257461d4cc@mail.gmail.com>
 <Pine.LNX.4.62.0502191937500.3355@numbat.sonytel.be>
 <9e473391050219135923cc6455@mail.gmail.com> <200502200738.37022.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D3REu-0002MU-1s
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 21 Feb 2005 20:01:36 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1D3REs-0004xG-81
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 21 Feb 2005 20:01:35 -0800
In-Reply-To: <200502200738.37022.adaplas@hotpop.com>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Jon Smirl <jonsmirl@gmail.com>


> On Sunday 20 February 2005 05:59, Jon Smirl wrote:
> > I started editing all of the drivers to make assigning fb_info->device
> > explicit.  Does this look like it is useful? I was surprised some
> > architectures don't make use of 'struct device'. If this is
> > interesting there are about ten more drivers that I need to patch.  I
> > did find several drivers which have device struct's that are not
> > assigning them to fb_info->device.
> 
> No, don't do this.  Either convert the driver to use framebuffer_alloc()/
> framebuffer_release(), or let the driver explicitly set info->device.

Ug. Most fbdev drivers are not PCI devices.



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
