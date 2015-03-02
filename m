From: Arun Ramamurthy <arun.ramamurthy@broadcom.com>
Date: Mon, 02 Mar 2015 19:09:55 +0000
Subject: Re: [PATCH] video: ARM CLCD: Added dt support to set tim2 register
Message-Id: <54F4B583.4000005@broadcom.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1424898082-1522-1-git-send-email-arun.ramamurthy@broadcom.com> <1425312688.3092.10.camel@arm.com>
In-Reply-To: <1425312688.3092.10.camel@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pawel Moll <pawel.moll@arm.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <Mark.Rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Dmitry Torokhov <dtor@google.com>, Anatol Pomazau <anatol@google.com>, Jonathan Richardson <jonathar@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Ray Jui <rjui@broadcom.com>, "bcm-kernel-feedback-list@broadcom.com" <bcm-kernel-feedback-list@broadcom.com>



On 15-03-02 08:11 AM, Pawel Moll wrote:
> On Wed, 2015-02-25 at 21:01 +0000, Arun Ramamurthy wrote:
>> Added code based on linaro tree:
>> http://git.linaro.org/kernel/linux-linaro-stable.git
>> with commit id:6846e7822c4cab5a84672baace3b768c2d0db142
>> at drivers/video/amba-clcd.c. This lets the driver set
>> certain tim2 register bits after reading them from
>> device tree.
>>
>> Reviewed-by: Ray Jui <rjui@broadcom.com>
>> Reviewed-by: Scott Branden <sbranden@broadcom.com>
>> Signed-off-by: Arun Ramamurthy <arun.ramamurthy@broadcom.com>
>> ---
>>   .../devicetree/bindings/video/arm,pl11x.txt        | 17 ++++++++-
>>   drivers/video/fbdev/amba-clcd.c                    | 41 ++++++++++++++++++++++
>>   2 files changed, 57 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/video/arm,pl11x.txt b/Documentation/devicetree/bindings/video/arm,pl11x.txt
>> index 3e3039a..14d6f87 100644
>> --- a/Documentation/devicetree/bindings/video/arm,pl11x.txt
>> +++ b/Documentation/devicetree/bindings/video/arm,pl11x.txt
>> @@ -35,6 +35,21 @@ Optional properties:
>>   	cell's memory interface can handle; if not present, the memory
>>   	interface is fast enough to handle all possible video modes
>>
>> +- tim2: Used to set certain bits in LCDTiming2 register.
>> +	It can be TIM2_CLKSEL or TIM2_IOE or both
>> +
>> +	TIM2_CLKSEL: This bit drives the CLCDCLKSEL signal. It is the select
>> +	signal for the external LCD clock multiplexor.
>> +
>> +	TIM2_IOE: Invert output enable:
>> +	0 = CLAC output pin is active HIGH in TFT mode
>> +	1 = CLAC output pin is active LOW in TFT mode.
>> +	This bit selects the active polarity of the output enable signal in
>> +	TFT mode. In this mode, the CLAC pin is an enable that indicates to
>> +	the LCD panel when valid display data is available. In active
>> +	display mode, data is driven onto the LCD data lines at the
>> +	programmed edge of CLCP when CLAC is in its active state.
>> +
>
> The existing bindings intentionally avoided quoting internal registers -
> they are supposed to describe how the hardware is wired up...
>
> So how about something like "arm,pl11x,tft-invert-clac"? Then the driver
> sets the bit or not, depending on the property existance?
>
Sure, I can change it to two properties called arm,pl11x,tft-invert-clac 
and arm,pl11x,tft-clksel. Would that be acceptable?

> Pawel
>
