From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Framebuffer and non-PCI devices
Date: Sun, 20 Feb 2005 07:38:29 +0800
Message-ID: <200502200738.37022.adaplas@hotpop.com>
References: <9e47339105021910257461d4cc@mail.gmail.com> <Pine.LNX.4.62.0502191937500.3355@numbat.sonytel.be> <9e473391050219135923cc6455@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D2eBc-0004mq-Se
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 19 Feb 2005 15:38:56 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D2eBb-0003L8-DM
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 19 Feb 2005 15:38:56 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 18791E788E7
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 19 Feb 2005 23:38:41 +0000 (UTC)
In-Reply-To: <9e473391050219135923cc6455@mail.gmail.com>
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
To: linux-fbdev-devel@lists.sourceforge.net, Jon Smirl <jonsmirl@gmail.com>

On Sunday 20 February 2005 05:59, Jon Smirl wrote:
> I started editing all of the drivers to make assigning fb_info->device
> explicit.  Does this look like it is useful? I was surprised some
> architectures don't make use of 'struct device'. If this is
> interesting there are about ten more drivers that I need to patch.  I
> did find several drivers which have device struct's that are not
> assigning them to fb_info->device.

No, don't do this.  Either convert the driver to use framebuffer_alloc()/
framebuffer_release(), or let the driver explicitly set info->device.

Tony




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
