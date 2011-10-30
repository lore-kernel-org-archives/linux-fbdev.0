From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Date: Sun, 30 Oct 2011 22:34:18 +0000
Subject: Re: [PATCH v2] GIO bus support for SGI IP22/28
Message-Id: <20111030223418.GA16346@alpha.franken.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20111020221928.0C2191DA27@solo.franken.de>
 <4EADB701.9040506@gentoo.org>
In-Reply-To: <4EADB701.9040506@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Joshua Kinard <kumba@gentoo.org>
Cc: linux-mips@linux-mips.org, linux-fbdev@vger.kernel.org, ralf@linux-mips.org, FlorianSchandinat@gmx.de

On Sun, Oct 30, 2011 at 04:43:45PM -0400, Joshua Kinard wrote:
> Does this handle any glue logic for add-on NIC cards found for Indy and I2?

no, but it will make live a lot easier, because address and interrupts don't
need to be probed by the driver. Right now interrupts are on my todo, since
there is some weirdness between guiness and fullhouse boxes...

>  I have a G130 Phobus and a rare ThunderLAN card in my Indy.  The Phobus has
> an Altera GIO/PCI glue chip.  Not sure about the ThunderLAN.  Both have
> normal driver support in the kernel (Phobus is just a Tulip chip).

it still needs something to setup the PCI bus on the card and issue
the probing. The problem with the Tulip Phobos cards is, that they
messed up the endianess, so that none of the Linux Tulip drivers will
work out of the box...

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
