From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH] Provide control of active VGA device on PCI systems
Date: Thu, 24 Feb 2005 01:14:13 -0500
Message-ID: <9e4733910502232214ecb3a5c@mail.gmail.com>
References: <9e47339105021921507545d084@mail.gmail.com>
	 <Pine.LNX.4.56.0502220401580.21388@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D4CGR-0000oR-MC
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 23 Feb 2005 22:14:19 -0800
Received: from rproxy.gmail.com ([64.233.170.192])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D4CGQ-00022l-3e
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 23 Feb 2005 22:14:19 -0800
Received: by rproxy.gmail.com with SMTP id z35so646187rne
        for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 23 Feb 2005 22:14:14 -0800 (PST)
In-Reply-To: <Pine.LNX.4.56.0502220401580.21388@pentafluge.infradead.org>
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
To: linux-fbdev-devel@lists.sourceforge.net, James Simmons <jsimmons@infradead.org>
Cc: Jesse Barnes <jbarnes@sgi.com>

On Tue, 22 Feb 2005 04:07:23 +0000 (GMT), James Simmons
<jsimmons@www.infradead.org> wrote:
> This is not a bad patch but could you please merge that code into
> vgastate.c and uses the vga io functions in include/video/vga.h
> This way drivers can choose to link to the vga functions themselves.
> The bonus is there is code in vgastate.c to save the state and restore
> the vga text state with a fbdev device. You can for example with the
> NVIDIA fbdev driver load it and do a open on /dev/fbX and it will go to
> the graphics state. On the last close of /dev/fbX it will go back to the
> vga text state it was in before the first open. With your code it would
> make it even more functional.

There are only three drivers linking in vgastate. This code has to run
for all cards with PCI class VGA. It is used by the code that supports
the VBIOS reset in user space. If I move it into vgastate.c I need to
bring vgastate.o into the core fb module.

The problem this code addresses:
boot video card is a VGA device
reseting secondary card will also enable it's VGA device
now we have two active VGA devices - this is bad since most archs only allow one

It fixes it like this:
boot video card is VGA
reset program uses sysfs to disable all VGA devices in system, write
vga=4 to any vga attrib
after secondary card is reset it will have active VGA
now reset program disables secondary VGA and restores the original
one, write vga=3 to any vga attrib

It has a neat side effect of letting you move the console around to
different VGA devices but that is not it's primary purpose. This code
needs to go into the core fb module. It has to deal with all VGA
devices in the system whether they have fb loaded or not.

I am going to remove the fb_hotplug function and IORESOURCE_NO_RESET
and use a different scheme for triggering the user space reset
program.

-- 
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
