From: Egbert Eich <eich@suse.de>
Subject: Re: [Linux-fbdev-devel] Re: Who is stomping PCI config space?
Date: Mon, 7 Mar 2005 12:19:02 +0100
Message-ID: <16940.14502.277774.189552@xf14.local>
References: <9e4733910503031103552514b9@mail.gmail.com>
	<1109891245.5611.246.camel@gaston>
	<9e473391050303161559c17955@mail.gmail.com>
	<9e47339105030319037f083f7@mail.gmail.com>
	<1109918459.5610.273.camel@gaston>
	<16936.20345.249542.65736@xf14.local>
	<9e47339105030409352803c7e1@mail.gmail.com>
	<1109976157.5680.309.camel@gaston>
	<16938.847.772446.757968@xf14.local>
	<1110062539.13594.74.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: benh@kernel.crashing.org wrote on Sunday,
	6 March 2005 at 09:42:19 +1100 
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
 > > How do we deal with interrupts from VGA cards that we don't have a 
 > > driver for? 
 > 
 > We don't get any, do we ? If we get an interrupt we don't have a driver
 > for, the system dies usually ;) Well, unless it's an edge interrupt, in
 > which case we can just drop it on the floor, but PCI interrupts are
 > level.

Usually VGA chips are capable of sending interrupts. At least the VGA
specs had a bit where interrupts can be enabled/disabled.
I'm surprised that this has not been an issue yet as I'm not sure if
the BIOS POST always leaves them disabled. For PCI chips they probalbly
do.

 > 
 > > We don't service interrupts in this case either.
 > > Can't we unregister the interrupt handler until everything
 > > is set up right? Maybe a dump idea...
 > > Also there is a generic VGA register to control interrupts.
 > 
 > We have reached the end of my VGA knowledge, but I seriously doubt a VGA
 > card will issue interrupts if not previously programmed to do so... So
 > we probably don't have to bother. We only care about interrupts that we

Possibly.

 > have a use for, that is interrupts triggered by cards upon request of
 > their driver, for things like DMA/AGP command buffer operations, vblank,
 > monitor detection, ...

The classic use for interrupts has been vblank. We have never used it
and I've heard reports from some people who have played around with this
that on some VGA chips it did what it was supposed to on others it didn't.

Cheers,
	Egbert.
