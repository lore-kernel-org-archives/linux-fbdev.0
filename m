From: Arun Ramamurthy <arun.ramamurthy@broadcom.com>
Date: Wed, 04 Mar 2015 00:35:26 +0000
Subject: Re: [PATCH] video: ARM CLCD: Added support for FBIO_WAITFORVSYNC
Message-Id: <54F6534E.50304@broadcom.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1424898082-1522-1-git-send-email-arun.ramamurthy@broadcom.com>	 <1424898082-1522-3-git-send-email-arun.ramamurthy@broadcom.com>	 <1425312029.3092.1.camel@arm.com> <54F4B576.5030702@broadcom.com> <1425376886.3092.25.camel@arm.com>
In-Reply-To: <1425376886.3092.25.camel@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pawel Moll <pawel.moll@arm.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <Mark.Rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Dmitry Torokhov <dtor@google.com>, Anatol Pomazau <anatol@google.com>, Jonathan Richardson <jonathar@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Ray Jui <rjui@broadcom.com>, "bcm-kernel-feedback-list@broadcom.com" <bcm-kernel-feedback-list@broadcom.com>



On 15-03-03 02:01 AM, Pawel Moll wrote:
> On Mon, 2015-03-02 at 19:09 +0000, Arun Ramamurthy wrote:
>> On 15-03-02 08:00 AM, Pawel Moll wrote:
>>> On Wed, 2015-02-25 at 21:01 +0000, Arun Ramamurthy wrote:
>>>> Added ioctl and interrupt handler functions to support FBIO_WAITFORVSYNC
>>>> Also corrected documentation to make interrupts and interrupt-names
>>>> optional as they are not required properties.
>>>
>>> You may not be aware of this fact, but its the "documentation" what
>>> defines what properties are required...
>>>
>> Pawel, I was not aware of that. Since the driver code did not require
>> the interrupts or interrupt-names bindings to load properly, I moved it
>> out of the required properties. I can remove that change.
>
> Cool. Drivers don't have to use all available properties :-) The
> interrupt names are required because CLCD can be wired up with a single,
> combined interrupt or with 4 separate interrupt lines (see "A.4. On-chip
> signals", in the TRM) and the binding has to provide ways of describing
> this. Yes, one could say "1 number = combined, 4 numbers = split", but
> I personally prefer to be explicit than implicit.
>
> Just request the interrupt by name and you'll be fine.
>
Ok got it, will make the necessary changes
>> Any other comments on this change? Thanks
>
> I have no experience with the vsync ioctl, so can't really comment on
> it. One minor thing I did spot is your use of curly brackets in one of
> the switch cases:
>
> On Wed, 2015-02-25 at 21:01 +0000, Arun Ramamurthy wrote:
> @@ -466,6 +468,73 @@ static int clcdfb_pan_display(struct fb_var_screeninfo *var,
>>   	return 0;
>>   }
>>
>> +static int clcdfb_ioctl(struct fb_info *info,
>> +			unsigned int cmd, unsigned long args)
>> +{
>> +	struct clcd_fb *fb = to_clcd(info);
>> +	int retval = 0;
>> +	u32 val, ienb_val;
>> +
>> +	switch (cmd) {
>> +	case FBIO_WAITFORVSYNC:{
>
> In the line above...
>
>> +		if (fb->lcd_irq <= 0) {
>> +			retval = -EINVAL;
>> +			break;
>> +		}
>> +		/* disable Vcomp interrupts */
>> +		ienb_val = readl(fb->regs + fb->off_ienb);
>> +		ienb_val &= ~CLCD_PL111_IENB_VCOMP;
>> +		writel(ienb_val, fb->regs + fb->off_ienb);
>> +
>> +		/* clear Vcomp interrupt */
>> +		writel(CLCD_PL111_IENB_VCOMP, fb->regs + CLCD_PL111_ICR);
>> +
>> +		/* Generate Interrupt at the start of Vsync */
>> +		reinit_completion(&fb->wait);
>> +		val = readl(fb->regs +  fb->off_cntl);
>> +		val &= ~(CNTL_LCDVCOMP(3));
>> +		writel(val, fb->regs + fb->off_cntl);
>> +
>> +		/* enable Vcomp interrupt */
>> +		ienb_val = readl(fb->regs + fb->off_ienb);
>> +		ienb_val |= CLCD_PL111_IENB_VCOMP;
>> +		writel(ienb_val, fb->regs + fb->off_ienb);
>> +		if (!wait_for_completion_interruptible_timeout
>> +			(&fb->wait, HZ/10))
>> +			retval = -ETIMEDOUT;
>> +		break;
>> +	}
>
> ... and here.
>
> Not sure it's needed?
>
No its not needed, I can remove it.
> Pawel
>
>
