From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Date: Tue, 01 Nov 2011 10:00:09 +0000
Subject: Re: [PATCH v2] GIO bus support for SGI IP22/28
Message-Id: <20111101100009.GA29087@alpha.franken.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20111020221928.0C2191DA27@solo.franken.de>
 <4EADB701.9040506@gentoo.org>
 <20111030223418.GA16346@alpha.franken.de>
 <4EAE5681.2090103@gentoo.org>
In-Reply-To: <4EAE5681.2090103@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Joshua Kinard <kumba@gentoo.org>
Cc: linux-mips@linux-mips.org, linux-fbdev@vger.kernel.org, ralf@linux-mips.org, FlorianSchandinat@gmx.de

On Mon, Oct 31, 2011 at 04:04:17AM -0400, Joshua Kinard wrote:
> A.k.a., Tulip (and possibly ThunderLAN) assume little-endian, when we're
> talking big-endian archs here.  Interesting.  Simple fix, as in defining a
> few driver structures with little- and big-endian versions (if they're doing
> something like packing bits or using bitfields)?  Or is it more complex than
> that?

iirc, the PCI bridge on the cards do 32bit swaps (address invariant) so
tulip chips need to run in big endian mode, which in turn makes descriptors
also big endian. But none of the tulip driver supports big endian descriptors.
That's fixable of course.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
