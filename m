From: Egbert Eich <eich@suse.de>
Subject: Re: [Linux-fbdev-devel] Re: Who is stomping PCI config space?
Date: Sat, 5 Mar 2005 19:26:39 +0100
Message-ID: <16937.63967.588170.359548@xf14.local>
References: <9e4733910503031103552514b9@mail.gmail.com>
	<1109891245.5611.246.camel@gaston>
	<9e473391050303161559c17955@mail.gmail.com>
	<9e47339105030319037f083f7@mail.gmail.com>
	<1109918459.5610.273.camel@gaston>
	<16936.20345.249542.65736@xf14.local>
	<1109975240.5610.297.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: benh@kernel.crashing.org wrote on Saturday,
	5 March 2005 at 09:27:19 +1100 
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Egbert Eich <eich@suse.de>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Xserver development <xorg@freedesktop.org>, Egbert Eich <eich@pdx.freedesktop.org>


Ben,

Benjamin Herrenschmidt writes:
 > > The point is: if Jon needs these registers in an interrupt handler
 > > he may have to tweak PCI config space form there anyway since another 
 > > card may currently have VGA routed.
 > 
 > The problem is that a card that has VGA support _and_ MMIO registers.
 > Even if nobody uses VGA on it, if a different VGA card on the same bus
 > is active, X will disable IO decoding on the first one (to disable VGA
 > too).

Right. And without any driver support it is difficult to know if the
card decodes legacy resources or if this decoding is turned off.
I can do waht Jon suggested and use the 'industry standard' VGA disable
registers. 
Depending on the card those registers may disable more than just VGA.

 > 
 > There isn't a simple way to solve that that I know, except if the card
 > can be configured to totally ignore VGA accesses, in which case it
 > doesn't need to be disabled, but X doesn't know it...  (though if we
 > have a central "arbibrer", the driver for the card can tell it to remove
 > that card from the arbitration).

Right. But we don't load the driver.

 > 
 > In the normal case tho, I don't really see how to deal with that other
 > than, indeed, switching the enables at interrupt time, when the IRQ gets
 > in, which will obviously conflict with a concurrent server working on
 > the "other" card at the same time....

On a multi-CPU system this can be a problem as one CPU may work on
the previously enabled VGA card while the other one tries to service
the VGA card that has sent the interrupt.

 > 
 > So even with a kernel based arbitrer, the irq scenario isn't possible to
 > deal with properly, unless VGA decoding can be completely disabled on a
 > given card, or nobody uses VGA memory accesses on any card. (Most modern
 > drivers only use non-VGA memory/IO, or even IO are remapped to some
 > different addresses with some cards).

On a lot of cards there may be situations where VGA registers need to
be accessed for specific purposes.
Furthermore it must not be expected that nobody uses older cards which
still require VGA registers.

Is there a way to halt a process that is using VGA registers for the
time the interrupt gets serviced? For example sending a signal to 
this process so that it suspends norml execution waits in a signal 
handler?
All this would only matter for systems with more than one CPU.

Cheers,
	Egbert.
