From: David Miller <davem@davemloft.net>
Date: Mon, 03 Jan 2011 18:58:27 +0000
Subject: Re: Using s3virge card in Sun Blade 2000
Message-Id: <20110103.105827.112602895.davem@davemloft.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1294072336.17576.7.camel@lithium>
In-Reply-To: <1294072336.17576.7.camel@lithium>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: alex.buell@munted.org.uk
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

From: Alex Buell <alex.buell@munted.org.uk>
Date: Mon, 03 Jan 2011 16:32:16 +0000

> I'm aware the s3fb driver has big endian issues, I can help fix those
> issues so I can get the card working. Or in other words, I'd welcome
> advice on how to proceed with this. 

It's not endian issues, this driver has other problems.

It uses the VGA register accessors with a NULL regbase, which is not
going to work on sparc64.

It needs to access the VGA register space relative to the I/O space
of the PCI controller domain it is behind.

Probably if you replace the NULL values passes to vga_r*() and
vga_w*() with the I/O space resource base of the chip (should be
resource "1") it might work.
