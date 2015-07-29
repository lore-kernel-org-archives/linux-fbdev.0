From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Wed, 29 Jul 2015 19:38:47 +0000
Subject: Re: [PATCH 1/2] ARM: integrator: move framebuffers to driver
Message-Id: <20150729193846.GQ7557@n2100.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1438172831-11450-1-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1438172831-11450-1-git-send-email-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Jul 29, 2015 at 02:27:11PM +0200, Linus Walleij wrote:
> Commit 11c32d7b6274cb0f554943d65bd4a126c4a86dcd
> "video: move Versatile CLCD helpers" already moved the
> CLCD mode setting helpers for Versatile and Integrator/CP
> to drivers/video/fbdev. Let's do the same for the IM-PD1
> add-on board, copy the missing displays into the database
> and simplify the code.

And thereby break the support.  The IM-PD1 CLCD can only access the memory
on the IM-PD1.  That's why the CLCD driver itself doesn't just allocate
the frame buffer using dma_alloc_writecombine().  Where the memory comes
from is platform specific.  In this case...

> -static int impd1fb_clcd_setup(struct clcd_fb *fb)
> -{
> -	unsigned long framebase = fb->dev->res.start + 0x01000000;
> -	unsigned long framesize = SZ_1M;

It's a chunk of SRAM offset by the specified value and of the specified
size above.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
