From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Sat, 31 Jul 2010 22:51:20 +0000
Subject: Re: [PATCH 1/3] cyber2000fb: fix machine hang on module load
Message-Id: <20100731225120.GC3633@n2100.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201007312255.30729.linux@rainbow-software.org> <4C5493DD.7010402@garzik.org> <20100731212509.GA3633@n2100.arm.linux.org.uk> <4C54A5A7.9080008@garzik.org>
In-Reply-To: <4C54A5A7.9080008@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jeff Garzik <jeff@garzik.org>
Cc: Ondrej Zary <linux@rainbow-software.org>, linux-fbdev@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>

On Sat, Jul 31, 2010 at 06:37:27PM -0400, Jeff Garzik wrote:
> On 07/31/2010 05:25 PM, Russell King - ARM Linux wrote:
>> No such luck.  It's a proprietary Integraphics chip, mainly used in
>> ARM Netwinders some 10 years ago.  It's completely different from the
>> S3 chips such as Trio64.
>
> Ah, I stand corrected.  Maybe that was cyberfb I was remembering...

I think so - the old cyberfb.h contained this:
-/* s3 commands */
-#define S3_BITBLT       0xc011
-#define S3_TWOPOINTLINE 0x2811
-#define S3_FILLEDRECT   0x40b1

so yes, it was similar to the S3 driver.
