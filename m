From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Re: Who is stomping PCI config space?
Date: Fri, 4 Mar 2005 12:35:20 -0500
Message-ID: <9e47339105030409352803c7e1@mail.gmail.com>
References: <9e4733910503031103552514b9@mail.gmail.com>
	 <1109891245.5611.246.camel@gaston>
	 <9e473391050303161559c17955@mail.gmail.com>
	 <9e47339105030319037f083f7@mail.gmail.com>
	 <1109918459.5610.273.camel@gaston>
	 <16936.20345.249542.65736@xf14.local>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D7Gi3-00065J-Jh
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 04 Mar 2005 09:35:31 -0800
Received: from rproxy.gmail.com ([64.233.170.203])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D7Gi2-0003Sg-4X
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 04 Mar 2005 09:35:31 -0800
Received: by rproxy.gmail.com with SMTP id z35so1150605rne
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 04 Mar 2005 09:35:29 -0800 (PST)
In-Reply-To: <16936.20345.249542.65736@xf14.local>
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
To: Egbert Eich <eich@suse.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Xserver development <xorg@freedesktop.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Egbert Eich <eich@pdx.freedesktop.org>

On Fri, 4 Mar 2005 13:02:34 +0100, Egbert Eich <eich@suse.de> wrote:
> you know well that we are not living in the same time zone, so you
> may want to give me some time to answer.

I was getting upset that when I did a VT switch my machine was hard
locking and I had to keep rebooting all of the time to debug the
problem. I had spent many hours trying to find the problem in my code
and it wasn't there. I was not expecting X to alter the state of
hardware it did not have a driver loaded for.

> It needs to have it in some central place which doesn't necessarily
> have to be the kernel.
> The point is: if Jon needs these registers in an interrupt handler
> he may have to tweak PCI config space form there anyway since another
> card may currently have VGA routed.
> 
>  >
>  > X disables any other VGA card IO/MEM in the system so that at one given
>  > point in time, only one of them will decode VGA cycles. Wether it has
>  > those cards to drive in it's config or not doesn't matter, the problem
>  > at the bus level is the same.
> 
> Right. It however should only do so if one of the cards it is driving
> itself requires VGA registers for its mode of operation.

Ok, now I see what X is doing. It is making sure there is only one
active VGA device in the system.  However, my framebuffer driver is
not using VGA mode.

I have similar code in my VGA support patch but I only shut down the
card mem/io long enough to turn off VGA support. I don't leave the
whole card turned off. I also see now that I should shut interrupts
off while doing this.

pci_read_config_word(pdev, PCI_COMMAND, &command);
pci_write_config_word(pdev, PCI_COMMAND, command | PCI_COMMAND_IO |
PCI_COMMAND_MEMORY);

vga_io_w(0x3C3, ~0x01 & vga_io_r(0x3C3));
vga_io_w(0x46e8, ~0x08 & vga_io_r(0x46e8));
vga_io_w(0x102, ~0x01 & vga_io_r(0x102));

pci_write_config_word(pdev, PCI_COMMAND, command);

If we leave the whole card turned off I can't access the interrupt
status registers to acknowledge the interrupt and shut it off.

Does this approach work for X? Where is the code that does this at VT
switch time?

On VT enter X would need to:
1) shut off interrupts
2) disable IO/MEM on all VGA cards - remember IO/mem state
3) turn the cards on one at a time and disable VGA - remember VGA enable state
4) restore IO/MEM state to all cards
5) turn interrupts back on

On VT exit:
1) shut off interrupts
2) disable IO/MEM on all VGA cards - remember IO/mem state
3) restore VGA enable state
4) restore IO/MEM state to all cards
5) turn interrupts back on

-- 
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
