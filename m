From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] sysfs support for fbdev
Date: Wed, 02 Mar 2005 10:49:00 +1100
Message-ID: <1109720940.5611.57.camel@gaston>
References: <9e47339105030102003ee47879@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D6H9D-0007Zs-4N
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 01 Mar 2005 15:51:27 -0800
Received: from gate.crashing.org ([63.228.1.57])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1D6H8x-00079d-7m
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 01 Mar 2005 15:51:26 -0800
Received: from gaston (localhost [127.0.0.1])
	by gate.crashing.org (8.12.8/8.12.8) with ESMTP id j21NnjgJ018668
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 1 Mar 2005 17:49:46 -0600
In-Reply-To: <9e47339105030102003ee47879@mail.gmail.com>
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

On Tue, 2005-03-01 at 05:00 -0500, Jon Smirl wrote:
> Not finished yet but here's an update.
> 
> Merges Antonio's fbcon support
> Creates monitor device inside of fbdev
> Creates two fbdev devices for radeonfb
> 
> The changes in class.c are temporary GregKH promises a real fix soon.
> Patch is 1000+ lines so I made it an attachment.
> 
> Making the monitor device inside of the fbdev allows hotplug to work
> for monitors. Now all I need to do is hook up the radeon interrupt.
> When finished, unplug the monitor, get interrupt, build monitor
> device, get hotplug event, helper builds modelist, set modelist to
> fbdev, this causes sysfs attribute change event, hal then dbus hears
> this, X rebuilds the display. Still a few weeks of work to go.
> 
> If anyone wants to help implement some of the other attributes, send
> me a patch and I will incorporate it.

I can already get some of the radeonfb bits in for 2.6.12, that will
make things easier. I'll let you know.

Ben.




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
