From: Egbert Eich <eich@suse.de>
Subject: Re: [Linux-fbdev-devel] Re: Who is stomping PCI config space?
Date: Sat, 5 Mar 2005 18:33:59 +0100
Message-ID: <16937.60807.259663.415412@xf14.local>
References: <9e4733910503031103552514b9@mail.gmail.com>
	<1109891245.5611.246.camel@gaston>
	<9e473391050303161559c17955@mail.gmail.com>
	<9e47339105030319037f083f7@mail.gmail.com>
	<1109918459.5610.273.camel@gaston>
	<16936.20345.249542.65736@xf14.local>
	<9e47339105030409352803c7e1@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: jonsmirl@gmail.com wrote on Friday,
	4 March 2005 at 12:35:20 -0500 
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
Cc: Egbert Eich <eich@suse.de>, Xserver development <xorg@freedesktop.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Egbert Eich <eich@pdx.freedesktop.org>

Jon Smirl writes:
 > On Fri, 4 Mar 2005 13:02:34 +0100, Egbert Eich <eich@suse.de> wrote:
 > > you know well that we are not living in the same time zone, so you
 > > may want to give me some time to answer.
 > 
 > I was getting upset that when I did a VT switch my machine was hard
 > locking and I had to keep rebooting all of the time to debug the
 > problem. I had spent many hours trying to find the problem in my code
 > and it wasn't there. I was not expecting X to alter the state of
 > hardware it did not have a driver loaded for.
 > 

I understand that this upsets you. But from my explanations you
should see that there are reasons for this behavior.


 > > It needs to have it in some central place which doesn't necessarily
 > > have to be the kernel.
 > > The point is: if Jon needs these registers in an interrupt handler
 > > he may have to tweak PCI config space form there anyway since another
 > > card may currently have VGA routed.
 > > 
 > >  >
 > >  > X disables any other VGA card IO/MEM in the system so that at one given
 > >  > point in time, only one of them will decode VGA cycles. Wether it has
 > >  > those cards to drive in it's config or not doesn't matter, the problem
 > >  > at the bus level is the same.
 > > 
 > > Right. It however should only do so if one of the cards it is driving
 > > itself requires VGA registers for its mode of operation.
 > 
 > Ok, now I see what X is doing. It is making sure there is only one
 > active VGA device in the system.  However, my framebuffer driver is
 > not using VGA mode.

Right, but X may be using a VGA register for something - maybe for
setting fb start (panning) or setting the HW cursor or whatever
else. 
If your hardware decodes VGA it would also decode these register
accesses. Without knowing details about your card it would be hard
for X to know if it does or not.

 > 
 > I have similar code in my VGA support patch but I only shut down the
 > card mem/io long enough to turn off VGA support. I don't leave the
 > whole card turned off. I also see now that I should shut interrupts
 > off while doing this.

To shut off VGA you'd need a driver. But as you said the driver isn't
loaded. 
When I designed the interface in X I was thinking about 'background
drivers' which would be able to set this up. Unfortunately this
issue had never been persued any further at the time and has been
forgotten since then.
I don't recall how much of this I actually implemented.

 > 
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

Right.
 > 
 > Does this approach work for X? Where is the code that does this at VT
 > switch time?

We use this approach in the int10 code to get around the problem that
some BIOSes stomp over other VGA cards during POSTing - I discovered
this with Tseng BIOSes which should not be in use much today any more. 
Therefore I cannot say if these remedies work on all cards, though.
What we can say I think is that these calls don't hurt as we have used
them for years without issues.

 > 
 > On VT enter X would need to:
 > 1) shut off interrupts
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

Right. Let me see how I can integrate this into my 
resource management in X. It shouldn't be too hard
to do and would be a remedy until we find a better
solution. 
I would need help from the kernel people to do the
interrupts. Also I may make this job configurable 
as I'm not sure if these VGA disable registers
are universally used.

Currently X has a heuristic that looks for enabled
VGA to identify the primary (ie. POSTed) video card.

With more than one graphics card enabled we will
mess up this heuristic. I need to look into this.

Egbert.
