From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [Linux-fbdev-devel] Re: Who is stomping PCI config space?
Date: Sun, 06 Mar 2005 09:39:50 +1100
Message-ID: <1110062390.13594.71.camel@gaston>
References: <9e4733910503031103552514b9@mail.gmail.com>
	<1109891245.5611.246.camel@gaston>
	<9e473391050303161559c17955@mail.gmail.com>
	<9e47339105030319037f083f7@mail.gmail.com>
	<1109918459.5610.273.camel@gaston>
	<16936.20345.249542.65736@xf14.local>
	<1109975240.5610.297.camel@gaston>
	<16937.63967.588170.359548@xf14.local>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <16937.63967.588170.359548@xf14.local>
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Xserver development <xorg@freedesktop.org>, Egbert Eich <eich@pdx.freedesktop.org>


> Right. And without any driver support it is difficult to know if the
> card decodes legacy resources or if this decoding is turned off.
> I can do waht Jon suggested and use the 'industry standard' VGA disable
> registers. 
> Depending on the card those registers may disable more than just VGA.
> 
>  > 
>  > There isn't a simple way to solve that that I know, except if the card
>  > can be configured to totally ignore VGA accesses, in which case it
>  > doesn't need to be disabled, but X doesn't know it...  (though if we
>  > have a central "arbibrer", the driver for the card can tell it to remove
>  > that card from the arbitration).
> 
> Right. But we don't load the driver.

Yes, you can assume the worst case at first, and later on have the
driver disable decoding of legacy stuff and inform your arbiter to stop
caring about that specific card, no ?

> On a multi-CPU system this can be a problem as one CPU may work on
> the previously enabled VGA card while the other one tries to service
> the VGA card that has sent the interrupt.

Yes. Fancy things like local disabling of irqs etc... aren't an option.
>  > 
>  > So even with a kernel based arbitrer, the irq scenario isn't possible to
>  > deal with properly, unless VGA decoding can be completely disabled on a
>  > given card, or nobody uses VGA memory accesses on any card. (Most modern
>  > drivers only use non-VGA memory/IO, or even IO are remapped to some
>  > different addresses with some cards).
> 
> On a lot of cards there may be situations where VGA registers need to
> be accessed for specific purposes.

Yup, though "modern" cards usually don't. A radeon operates 100% without
access to any legacy resource lately (except the console restore on
console switch, but that's fairly isolated and I even removed it on ppc
as it breaks things on setups where the card was boostrapped in "no VGA"
mode. I personally think it should be done by the kernel). I think
nvidia's "remap" the VGA registes somewhere in normal MMIO space, at
least I think I remember seeing something like that.

> Furthermore it must not be expected that nobody uses older cards which
> still require VGA registers.

Agreed.

> Is there a way to halt a process that is using VGA registers for the
> time the interrupt gets serviced? For example sending a signal to 
> this process so that it suspends norml execution waits in a signal 
> handler?

Not really. Well, something could be hacked, that is, the current CPU is
obviously handling the IRQ, so the process "below" has been halted, but
it would require some kind of IPI tricks to also halt other CPUs, quite
heavy handed I think.

> All this would only matter for systems with more than one CPU.

Yes, but those are becoming quite common. Also multicore is coming ;)

Ben.
