From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [Linux-fbdev-devel] Re: Who is stomping PCI config space?
Date: Sun, 06 Mar 2005 09:42:19 +1100
Message-ID: <1110062539.13594.74.camel@gaston>
References: <9e4733910503031103552514b9@mail.gmail.com>
	<1109891245.5611.246.camel@gaston>
	<9e473391050303161559c17955@mail.gmail.com>
	<9e47339105030319037f083f7@mail.gmail.com>
	<1109918459.5610.273.camel@gaston>
	<16936.20345.249542.65736@xf14.local>
	<9e47339105030409352803c7e1@mail.gmail.com>
	<1109976157.5680.309.camel@gaston> <16938.847.772446.757968@xf14.local>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <16938.847.772446.757968@xf14.local>
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


> How do we deal with interrupts from VGA cards that we don't have a 
> driver for? 

We don't get any, do we ? If we get an interrupt we don't have a driver
for, the system dies usually ;) Well, unless it's an edge interrupt, in
which case we can just drop it on the floor, but PCI interrupts are
level.

> We don't service interrupts in this case either.
> Can't we unregister the interrupt handler until everything
> is set up right? Maybe a dump idea...
> Also there is a generic VGA register to control interrupts.

We have reached the end of my VGA knowledge, but I seriously doubt a VGA
card will issue interrupts if not previously programmed to do so... So
we probably don't have to bother. We only care about interrupts that we
have a use for, that is interrupts triggered by cards upon request of
their driver, for things like DMA/AGP command buffer operations, vblank,
monitor detection, ...

Ben.
