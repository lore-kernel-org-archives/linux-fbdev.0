From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Tue, 27 Jul 2010 16:25:11 +0000
Subject: Re: [PATCH] [resend] cyber2000fb: fix machine hang on module load
Message-Id: <20100727162510.GB17099@n2100.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201007271529.22520.linux@rainbow-software.org>
In-Reply-To: <201007271529.22520.linux@rainbow-software.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ondrej Zary <linux@rainbow-software.org>
Cc: linux-fbdev@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>

On Tue, Jul 27, 2010 at 03:29:20PM +0200, Ondrej Zary wrote:
> Hello,
> I was testing two CyberPro 2000 based PCI cards on x86 and the machine always
> hanged completely when the cyber2000fb module was loaded. It seems that the
> card hangs when some registers are accessed too quickly after writing RAMDAC
> control register. With this patch, both card work.
> 
> Add delay after RAMDAC control register write to prevent hangs on module load.

This one on the other hand I think is rather too heavy.

What might be better is to re-code the last register write to use
the x86 outb_p() stuff to slow it down, rather than using udelay().
Could you try something along those lines please?
