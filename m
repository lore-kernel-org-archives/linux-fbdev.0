From: Alex Buell <alex.buell@munted.org.uk>
Date: Mon, 03 Jan 2011 19:39:01 +0000
Subject: Re: Using s3virge card in Sun Blade 2000
Message-Id: <1294083541.17576.11.camel@lithium>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1294072336.17576.7.camel@lithium>
	 <20110103.105827.112602895.davem@davemloft.net>
In-Reply-To: <20110103.105827.112602895.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 2011-01-03 at 10:58 -0800, David Miller wrote:
> From: Alex Buell <alex.buell@munted.org.uk>
> Date: Mon, 03 Jan 2011 16:32:16 +0000
> 
> > I'm aware the s3fb driver has big endian issues, I can help fix those
> > issues so I can get the card working. Or in other words, I'd welcome
> > advice on how to proceed with this. 
> 
> It's not endian issues, this driver has other problems.
> 
> It uses the VGA register accessors with a NULL regbase, which is not
> going to work on sparc64.
> 
> It needs to access the VGA register space relative to the I/O space
> of the PCI controller domain it is behind.
> 
> Probably if you replace the NULL values passes to vga_r*() and
> vga_w*() with the I/O space resource base of the chip (should be
> resource "1") it might work.

I've had a look at linux/include/video/vga.h, and yes I see what you
mean now.

Secondly, is Linux fully capable of handling different graphic cards
simultaneously? For example, plug in a pair of monitors and have
consoles on both with disparate graphic cards i.e. XVR-500 and S3ViRGE
etc? 
-- 
Tactical Nuclear Kittens
