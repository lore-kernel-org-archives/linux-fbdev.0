From: Jeff Garzik <jeff@garzik.org>
Date: Sat, 31 Jul 2010 22:37:27 +0000
Subject: Re: [PATCH 1/3] cyber2000fb: fix machine hang on module load
Message-Id: <4C54A5A7.9080008@garzik.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201007312255.30729.linux@rainbow-software.org> <4C5493DD.7010402@garzik.org> <20100731212509.GA3633@n2100.arm.linux.org.uk>
In-Reply-To: <20100731212509.GA3633@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Ondrej Zary <linux@rainbow-software.org>, linux-fbdev@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>

On 07/31/2010 05:25 PM, Russell King - ARM Linux wrote:
> On Sat, Jul 31, 2010 at 05:21:33PM -0400, Jeff Garzik wrote:
>> On 07/31/2010 04:55 PM, Ondrej Zary wrote:
>>> I was testing two CyberPro 2000 based PCI cards on x86 and the machine always
>>> hanged completely when the cyber2000fb module was loaded. It seems that the
>>> card hangs when some registers are accessed too quickly after writing RAMDAC
>>> control register. With this patch, both card work.
>>>
>>> Add delay after RAMDAC control register write to prevent hangs on module load.
>>>
>>> Signed-off-by: Ondrej Zary<linux@rainbow-software.org>
>>>
>>> --- linux-2.6.35-rc2-orig/drivers/video/cyber2000fb.c	2010-06-06 05:43:24.000000000 +0200
>>> +++ linux-2.6.35-rc3/drivers/video/cyber2000fb.c	2010-07-27 23:12:37.000000000 +0200
>>> @@ -436,6 +436,8 @@ static void cyber2000fb_write_ramdac_ctr
>>>    	cyber2000fb_writeb(i | 4, 0x3cf, cfb);
>>>    	cyber2000fb_writeb(val, 0x3c6, cfb);
>>>    	cyber2000fb_writeb(i, 0x3cf, cfb);
>>> +	/* prevent card lock-up observed on x86 with CyberPro 2000 */
>>> +	cyber2000fb_readb(0x3cf, cfb);
>>>    }
>>
>> IIRC, cyber2000 is basically an S3 graphics chip.
>
> No such luck.  It's a proprietary Integraphics chip, mainly used in
> ARM Netwinders some 10 years ago.  It's completely different from the
> S3 chips such as Trio64.

Ah, I stand corrected.  Maybe that was cyberfb I was remembering...

	Jeff



