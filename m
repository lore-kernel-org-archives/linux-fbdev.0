From: Egbert Eich <eich@suse.de>
Subject: Re: [Linux-fbdev-devel] Re: Who is stomping PCI config space?
Date: Sat, 5 Mar 2005 20:06:55 +0100
Message-ID: <16938.847.772446.757968@xf14.local>
References: <9e4733910503031103552514b9@mail.gmail.com>
	<1109891245.5611.246.camel@gaston>
	<9e473391050303161559c17955@mail.gmail.com>
	<9e47339105030319037f083f7@mail.gmail.com>
	<1109918459.5610.273.camel@gaston>
	<16936.20345.249542.65736@xf14.local>
	<9e47339105030409352803c7e1@mail.gmail.com>
	<1109976157.5680.309.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: benh@kernel.crashing.org wrote on Saturday,
	5 March 2005 at 09:42:36 +1100 
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
 > > 
 > > If we leave the whole card turned off I can't access the interrupt
 > > status registers to acknowledge the interrupt and shut it off.
 > 
 > Also, some cards won't let you switch VGA access decoding off.

This is what I suspect. I had some success with the generic VGA disable
code but our mileage may vary.

 > 
 > > Does this approach work for X? Where is the code that does this at VT
 > > switch time?
 > > 
 > > On VT enter X would need to:
 > > 1) shut off interrupts
 > 
 > Not possible (system interrupts). Unless it does it on the card itself,
 > which is a per-driver thing.

How do we deal with interrupts from VGA cards that we don't have a 
driver for? We don't service interrupts in this case either.
Can't we unregister the interrupt handler until everything
is set up right? Maybe a dump idea...
Also there is a generic VGA register to control interrupts.


Egbert.
