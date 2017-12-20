From: Felix Brack <fb@ltec.ch>
Date: Wed, 20 Dec 2017 17:08:01 +0000
Subject: Re: [PATCH] Add support for ORISE OTM3225A LCD SoC
Message-Id: <ec45a950-b503-779d-2944-0620fc1fc3bc@ltec.ch>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1509714581-4065-1-git-send-email-fb@ltec.ch>
 <cde8376c-8217-6cfd-0a0a-b90b75892bea@ltec.ch>
 <20171220165736.e247aggbkl4qir23@oak.lan>
In-Reply-To: <20171220165736.e247aggbkl4qir23@oak.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: linux-fbdev@vger.kernel.org, lee.jones@linaro.org, jingoohan1@gmail.com, b.zolnierkie@samsung.com, linux-kernel@vger.kernel.org

Hi Daniel,

On 20.12.2017 17:57, Daniel Thompson wrote:
> On Wed, Dec 20, 2017 at 05:35:24PM +0100, Felix Brack wrote:
>> Just a gentle echo request ;-)
>> Is there something completely wrong with this patch or am I just too
>> impatient?
>>
>> regards Felix
>>
>> On 03.11.2017 14:09, Felix Brack wrote:
>>> This patch adds a LCD driver supporting the OTM3225A LCD SoC
>>> from ORISE Technology. This device can drive TFT LC panels having a
>>> resolution of 240x320 pixels. After initializing the OTM3225A using
>>> it's SPI interface it switches to use 16-bib RGB as external
>>> display interface.
> 
> Was this a backlight driver? I've just noticed all the backlight
> maintainers on Cc: but the subject doesn't make this obvious and even
> with you quoting the patch header I still can't be entirely sure!
>
Yes it is a backlight driver. Sorry for not quoting the entire message.

> As a result I think its very likely the patch simply got overlooked
> because it didn't look much like a backlight driver when filtering
> e-mail. Patches that can't be easily categorized from the subject
> line will often get overlooked.
> 
> So, asssuming this was a backlight driver, could you resend the patch
> with an updated description and a subject line commenting:
> [PATCH] backlight: otm3225a:
>
Okay, I will.

> 
> Daniel.
> 

regards Felix
