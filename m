From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Provide control of active VGA
	device on PCI systems
Date: Sun, 20 Feb 2005 19:23:51 +1100
Message-ID: <1108887831.19402.20.camel@gaston>
References: <9e47339105021921507545d084@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D2mO2-0002Sb-FJ
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 20 Feb 2005 00:24:18 -0800
Received: from gate.crashing.org ([63.228.1.57])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1D2mO1-0000bB-R7
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 20 Feb 2005 00:24:18 -0800
In-Reply-To: <9e47339105021921507545d084@mail.gmail.com>
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
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
Cc: Jesse Barnes <jbarnes@sgi.com>, Jon Smirl <jonsmirl@gmail.com>

On Sun, 2005-02-20 at 00:50 -0500, Jon Smirl wrote:
> This patch adds a 'vga' attribute to each framebuffer device on PCI
> systems. For non-PCI hardware it does nothing.
> 
> If you have multiple VGA cards loaded, and you have framebuffer
> drivers loaded for each, you can then set 0/1 into the VGA attributes
> to move VGA console around to the different screens.
> 
> This is almost everything needed to implement reset of secondary
> cards. ROM access is already in the kernel. This code is needed to
> make sure you don't end up with multiple VGA devices enabled. All that
> is left is to construct the proper hotplug event and fix up my user
> space reset program.

HI Jon !

Looks good, but in the grand scheme of thing, it would be nice to extend
the functionality to more than just userspace reset: that is proper
arbitration of VGA access between X, vgacon, etc...

(The goal is to have X stop messing around with PCI at all, just probe
things via sysfs or whatever new model we might provide, but not
actually play with PCI resources directly nor modify bridge VGA enables,
and have it properly arbitrate with anything else wanting to use the VGA
IOs, including kernel services like vgacon).

That would require at least a kernel-side API in addition to the
userland one you are proposing, plus eventually some arbitration between
clients...

I have no time at the moment to help you there unfortunately, and I
don't yet have a clear idea of what kind of API to provide for the
actual ownership control, maybe something like the DRM lock ?

Ben.




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
