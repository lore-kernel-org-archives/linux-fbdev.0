From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Framebuffer and non-PCI devices
Date: Sat, 19 Feb 2005 20:17:23 -0500
Message-ID: <9e473391050219171725353404@mail.gmail.com>
References: <9e47339105021910257461d4cc@mail.gmail.com>
	 <Pine.LNX.4.62.0502191937500.3355@numbat.sonytel.be>
	 <9e473391050219135923cc6455@mail.gmail.com>
	 <200502200738.37022.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D2fix-00013g-8J
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 19 Feb 2005 17:17:27 -0800
Received: from rproxy.gmail.com ([64.233.170.206])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D2fiv-0002UV-Ss
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 19 Feb 2005 17:17:27 -0800
Received: by rproxy.gmail.com with SMTP id z35so188718rne
        for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 19 Feb 2005 17:17:24 -0800 (PST)
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
Content-Type: text/plain; charset="us-ascii"
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net

On Sun, 20 Feb 2005 07:38:29 +0800, Antonino A. Daplas
<adaplas@hotpop.com> wrote:
> No, don't do this.  Either convert the driver to use framebuffer_alloc()/
> framebuffer_release(), or let the driver explicitly set info->device.

I'll take a new tactic then. I'm trying to figure out how to wire my
VGA routing code into framebuffer. Only PCI devices need the routing
so I'm trying to come up with a way to identify them and not the other
devices. I have another idea now that is simpler, I'll code some of it
up and post it.

-- 
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
