From: Petr Cvek <petr.cvek@tul.cz>
Date: Sat, 08 Aug 2015 17:41:42 +0000
Subject: Re: [BUG, RFC] Different bitfields in documentation and driver
Message-Id: <55C63F56.3030602@tul.cz>
List-Id: <linux-fbdev.vger.kernel.org>
References: <55C503A7.6020304@tul.cz> <87zj21k9bx.fsf@belgarion.home>
In-Reply-To: <87zj21k9bx.fsf@belgarion.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 8.8.2015 18:56, Robert Jarzmik wrote:
> Petr Cvek <petr.cvek@tul.cz> writes:
> 
>> Hello,
>> It seems that PXA2xx framebuffer has switched bitfields in nonstd definition (when using overlay).
>>
>> This:
>>
>> 	http://lxr.free-electrons.com/source/drivers/video/fbdev/pxafb.h#L80
>>
>> versus this:
>>
>> 	http://lxr.free-electrons.com/source/Documentation/fb/pxafb.txt#L128
>>
>> Should be this changed in documentation or in driver? I was able to find only
>> one use (in form of little outdated mplayer patch) and it fills both bitfields
>> with zero (so potential change in driver will not break it).
> I'd rather go for documentation. Not only the driver's way looks more pretty to
> me, but it also guarantees compatibility from the kernel side.

Oh you are right, I forgot to look into SoC datasheet and related register has YX version
(driver side). Will send patch with errata warning.

> 
>> P.S. Lack of overlay2's use is probably caused by errata "E24: LCD: Enabling
>> Overlay 2 for YUV420 hangs LCD controller.", which is not workarounded in this
>> driver. It should be mentioned in documentation and/or code, because the only
>> way to start the LCD again is a full PXA SoC reset.
> Ok, do you know if this this true for all pxa variants and steppings or is this
> for only a subset of them ?
According to this:

	http://www.marvell.com/application-processors/pxa-family/assets/pxa_27x_spec_update.pdf

errata (page 11, errata 24), bug is only for C0 revision (newer are OK, but I would guess most of devices
will have C0). There is some workaround pseudocode, but it seems it does not work with me (only
few tries to implement it, but penalty is reboot ... workaround description is a little bit confusing)

P.S. LCD controller has other errors too (notably E15 (not fixed) and E16).

Petr

> 
> Cheers.
> 

