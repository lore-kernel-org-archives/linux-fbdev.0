From: Jeff Garzik <jeff@garzik.org>
Date: Sat, 31 Jul 2010 21:21:33 +0000
Subject: Re: [PATCH 1/3] cyber2000fb: fix machine hang on module load
Message-Id: <4C5493DD.7010402@garzik.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201007312255.30729.linux@rainbow-software.org>
In-Reply-To: <201007312255.30729.linux@rainbow-software.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ondrej Zary <linux@rainbow-software.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-fbdev@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>

On 07/31/2010 04:55 PM, Ondrej Zary wrote:
> I was testing two CyberPro 2000 based PCI cards on x86 and the machine always
> hanged completely when the cyber2000fb module was loaded. It seems that the
> card hangs when some registers are accessed too quickly after writing RAMDAC
> control register. With this patch, both card work.
>
> Add delay after RAMDAC control register write to prevent hangs on module load.
>
> Signed-off-by: Ondrej Zary<linux@rainbow-software.org>
>
> --- linux-2.6.35-rc2-orig/drivers/video/cyber2000fb.c	2010-06-06 05:43:24.000000000 +0200
> +++ linux-2.6.35-rc3/drivers/video/cyber2000fb.c	2010-07-27 23:12:37.000000000 +0200
> @@ -436,6 +436,8 @@ static void cyber2000fb_write_ramdac_ctr
>   	cyber2000fb_writeb(i | 4, 0x3cf, cfb);
>   	cyber2000fb_writeb(val, 0x3c6, cfb);
>   	cyber2000fb_writeb(i, 0x3cf, cfb);
> +	/* prevent card lock-up observed on x86 with CyberPro 2000 */
> +	cyber2000fb_readb(0x3cf, cfb);
>   }

IIRC, cyber2000 is basically an S3 graphics chip.  When working on s3fb, 
over a decade ago, ISTR needing a lot of MMIO register flushes -- dummy 
register reads -- to flush out just-written register writes.


