From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [Linux-fbdev-devel] Re: Who is stomping PCI config space?
Date: Sat, 05 Mar 2005 09:27:19 +1100
Message-ID: <1109975240.5610.297.camel@gaston>
References: <9e4733910503031103552514b9@mail.gmail.com>
	<1109891245.5611.246.camel@gaston>
	<9e473391050303161559c17955@mail.gmail.com>
	<9e47339105030319037f083f7@mail.gmail.com>
	<1109918459.5610.273.camel@gaston>
	<16936.20345.249542.65736@xf14.local>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <16936.20345.249542.65736@xf14.local>
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
To: Egbert Eich <eich@suse.de>
Cc: Xserver development <xorg@freedesktop.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Egbert Eich <eich@pdx.freedesktop.org>


> It needs to have it in some central place which doesn't necessarily
> have to be the kernel. 

I think it has to be the kernel so we can include kernel services, like
kernel fbdev's or vgacon in the loop.

> The point is: if Jon needs these registers in an interrupt handler
> he may have to tweak PCI config space form there anyway since another 
> card may currently have VGA routed.

The problem is that a card that has VGA support _and_ MMIO registers.
Even if nobody uses VGA on it, if a different VGA card on the same bus
is active, X will disable IO decoding on the first one (to disable VGA
too).

There isn't a simple way to solve that that I know, except if the card
can be configured to totally ignore VGA accesses, in which case it
doesn't need to be disabled, but X doesn't know it...  (though if we
have a central "arbibrer", the driver for the card can tell it to remove
that card from the arbitration).

In the normal case tho, I don't really see how to deal with that other
than, indeed, switching the enables at interrupt time, when the IRQ gets
in, which will obviously conflict with a concurrent server working on
the "other" card at the same time....

So even with a kernel based arbitrer, the irq scenario isn't possible to
deal with properly, unless VGA decoding can be completely disabled on a
given card, or nobody uses VGA memory accesses on any card. (Most modern
drivers only use non-VGA memory/IO, or even IO are remapped to some
different addresses with some cards).

As soon as two cards are in the system on the same bus segment, with one
of the them needing legacy VGA accesses to the low PCI memory/IO ports,
and the other one potentially decoding that space, there is simply no
solution that I can see with interrupts. 
>  > 
>  > X disables any other VGA card IO/MEM in the system so that at one given
>  > point in time, only one of them will decode VGA cycles. Wether it has
>  > those cards to drive in it's config or not doesn't matter, the problem
>  > at the bus level is the same.
> 
> Right. It however should only do so if one of the cards it is driving 
> itself requires VGA registers for its mode of operation.

Ben.
