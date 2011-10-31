From: Joshua Kinard <kumba@gentoo.org>
Date: Mon, 31 Oct 2011 08:04:17 +0000
Subject: Re: [PATCH v2] GIO bus support for SGI IP22/28
Message-Id: <4EAE5681.2090103@gentoo.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20111020221928.0C2191DA27@solo.franken.de> <4EADB701.9040506@gentoo.org> <20111030223418.GA16346@alpha.franken.de>
In-Reply-To: <20111030223418.GA16346@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@linux-mips.org, linux-fbdev@vger.kernel.org, ralf@linux-mips.org, FlorianSchandinat@gmx.de

On 10/30/2011 18:34, Thomas Bogendoerfer wrote:

> 
> no, but it will make live a lot easier, because address and interrupts don't
> need to be probed by the driver. Right now interrupts are on my todo, since
> there is some weirdness between guiness and fullhouse boxes...


It wouldn't be an SGI machine if it didn't implement something weird or just
plain backwards...


> it still needs something to setup the PCI bus on the card and issue
> the probing. The problem with the Tulip Phobos cards is, that they
> messed up the endianess, so that none of the Linux Tulip drivers will
> work out of the box...


A.k.a., Tulip (and possibly ThunderLAN) assume little-endian, when we're
talking big-endian archs here.  Interesting.  Simple fix, as in defining a
few driver structures with little- and big-endian versions (if they're doing
something like packing bits or using bitfields)?  Or is it more complex than
that?

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
4096R/D25D95E3 2011-03-28

"The past tempts us, the present confuses us, the future frightens us.  And
our lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
