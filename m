From: Egbert Eich <eich@suse.de>
Subject: Re: [Linux-fbdev-devel] Re: Who is stomping PCI config space?
Date: Mon, 7 Mar 2005 12:05:10 +0100
Message-ID: <16940.13670.840807.311073@xf14.local>
References: <9e4733910503031103552514b9@mail.gmail.com>
	<1109891245.5611.246.camel@gaston>
	<9e473391050303161559c17955@mail.gmail.com>
	<9e47339105030319037f083f7@mail.gmail.com>
	<1109918459.5610.273.camel@gaston>
	<16936.20345.249542.65736@xf14.local>
	<1109975240.5610.297.camel@gaston>
	<16937.63967.588170.359548@xf14.local>
	<1110062390.13594.71.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: benh@kernel.crashing.org wrote on Sunday,
	6 March 2005 at 09:39:50 +1100 
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

Benjamin Herrenschmidt writes:
 > 
 > Yes, you can assume the worst case at first, and later on have the
 > driver disable decoding of legacy stuff and inform your arbiter to stop
 > caring about that specific card, no ?

Right. Actually we had different mechanisms implemented and I also
had the concept of 'background' driver which would just do this
without driving any card.
Unfortunately this has never really been employed much and I would
have to look how this was designed in detail.

 > > 
 > > On a lot of cards there may be situations where VGA registers need to
 > > be accessed for specific purposes.
 > 
 > Yup, though "modern" cards usually don't. A radeon operates 100% without
 > access to any legacy resource lately (except the console restore on
 > console switch, but that's fairly isolated and I even removed it on ppc
 > as it breaks things on setups where the card was boostrapped in "no VGA"
 > mode. I personally think it should be done by the kernel). I think
 > nvidia's "remap" the VGA registes somewhere in normal MMIO space, at
 > least I think I remember seeing something like that.

How about POSTing? Doesn't the Radeon card have to be POSTed?

 > 
 > > Furthermore it must not be expected that nobody uses older cards which
 > > still require VGA registers.
 > 
 > Agreed.
 > 
 > > Is there a way to halt a process that is using VGA registers for the
 > > time the interrupt gets serviced? For example sending a signal to 
 > > this process so that it suspends norml execution waits in a signal 
 > > handler?
 > 
 > Not really. Well, something could be hacked, that is, the current CPU is
 > obviously handling the IRQ, so the process "below" has been halted, but
 > it would require some kind of IPI tricks to also halt other CPUs, quite
 > heavy handed I think.

Yes, that's what I was asking. Would there be a way to avoid too
much overhead in the kernel?
But maybe your suggestion how to handle the situation where interrupt
handling that required VGA resources could be dealt with outside the 
interrupt handler would be sufficient for all cases where this may
matter.

 > 
 > > All this would only matter for systems with more than one CPU.
 > 
 > Yes, but those are becoming quite common. Also multicore is coming ;)
 > 

I agree.

Cheers,
	Egbert.
