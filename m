From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [Linux-fbdev-devel] Re: Who is stomping PCI config space?
Date: Sat, 05 Mar 2005 09:42:36 +1100
Message-ID: <1109976157.5680.309.camel@gaston>
References: <9e4733910503031103552514b9@mail.gmail.com>
	<1109891245.5611.246.camel@gaston>
	<9e473391050303161559c17955@mail.gmail.com>
	<9e47339105030319037f083f7@mail.gmail.com>
	<1109918459.5610.273.camel@gaston>
	<16936.20345.249542.65736@xf14.local>
	<9e47339105030409352803c7e1@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <9e47339105030409352803c7e1@mail.gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/listinfo/xorg>,
	<mailto:xorg-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/xorg>
List-Post: <mailto:xorg@lists.freedesktop.org>
List-Help: <mailto:xorg-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/xorg>,
	<mailto:xorg-request@lists.freedesktop.org?subject=subscribe>
Sender: xorg-bounces@lists.freedesktop.org
Errors-To: xorg-bounces@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Egbert Eich <eich@suse.de>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Xserver development <xorg@freedesktop.org>, Egbert Eich <eich@pdx.freedesktop.org>


> Ok, now I see what X is doing. It is making sure there is only one
> active VGA device in the system.  However, my framebuffer driver is
> not using VGA mode.
> 
> I have similar code in my VGA support patch but I only shut down the
> card mem/io long enough to turn off VGA support. I don't leave the
> whole card turned off. I also see now that I should shut interrupts
> off while doing this.

Shut interrupts off never works. It only affects one CPU, you can still
take the interrupt on the other CPU. Unless you switch interrupt
emission on the card itself, or use some kind of spinlock to put IRQs
"on hold" while you are doing the shutdown...
 
> pci_read_config_word(pdev, PCI_COMMAND, &command);
> pci_write_config_word(pdev, PCI_COMMAND, command | PCI_COMMAND_IO |
> PCI_COMMAND_MEMORY);
> 
> vga_io_w(0x3C3, ~0x01 & vga_io_r(0x3C3));
> vga_io_w(0x46e8, ~0x08 & vga_io_r(0x46e8));
> vga_io_w(0x102, ~0x01 & vga_io_r(0x102));
> 
> pci_write_config_word(pdev, PCI_COMMAND, command);
> 
> If we leave the whole card turned off I can't access the interrupt
> status registers to acknowledge the interrupt and shut it off.

Also, some cards won't let you switch VGA access decoding off.

> Does this approach work for X? Where is the code that does this at VT
> switch time?
> 
> On VT enter X would need to:
> 1) shut off interrupts

Not possible (system interrupts). Unless it does it on the card itself,
which is a per-driver thing.

> 2) disable IO/MEM on all VGA cards - remember IO/mem state
> 3) turn the cards on one at a time and disable VGA - remember VGA enable state
> 4) restore IO/MEM state to all cards
> 5) turn interrupts back on
> 
> On VT exit:
> 1) shut off interrupts
> 2) disable IO/MEM on all VGA cards - remember IO/mem state
> 3) restore VGA enable state
> 4) restore IO/MEM state to all cards
> 5) turn interrupts back on

Ben.
