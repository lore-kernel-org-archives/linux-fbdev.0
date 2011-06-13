From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 13 Jun 2011 13:37:10 +0000
Subject: Re: [PATCH] fb.h: ARM uses __raw_{read/write}
Message-Id: <201106131537.10698.arnd@arndb.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201106101731.08578.hartleys@visionengravers.com>
	<20110613040003.GA29731@linux-sh.org>
	<20110613100819.GA26914@1n450.cable.virginmedia.net>
In-Reply-To: <20110613100819.GA26914@1n450.cable.virginmedia.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Monday 13 June 2011 12:08:19 Catalin Marinas wrote:
> The change proposed by Hartley wouldn't make much difference from the
> current volatile accesses (__raw_* accessors are implemented as volatile
> on ARM).

I guess it would mainly make a difference if we get a platform where
the PCI bus window is not in the same address space as the regular
physical memory and the accessors actually need to do a computation
on the address. AFAICT, ARM does not currently have any such platform
and I would hope that it says that way.

> I think the memcpy_(from|to)io could be optimised on ARM to only add a
> barrier before or after he copying loop.

Agreed, good idea.

	Arnd
