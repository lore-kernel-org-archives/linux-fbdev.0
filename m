From: Nicolas Ferre <nicolas.ferre@atmel.com>
Date: Wed, 23 Oct 2013 07:57:50 +0000
Subject: Re: [PATCH 0/9] backlight: atmel-pwm-bl: fixes and clean ups
Message-Id: <5267817E.40906@atmel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1382462819-28576-1-git-send-email-jhovold@gmail.com> <001801cecf8d$f3834d90$da89e8b0$%han@samsung.com>
In-Reply-To: <001801cecf8d$f3834d90$da89e8b0$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jingoo Han <jg1.han@samsung.com>, 'Johan Hovold' <jhovold@gmail.com>
Cc: 'Andrew Morton' <akpm@linux-foundation.org>, 'Tomi Valkeinen' <tomi.valkeinen@ti.com>, 'Jean-Christophe Plagniol-Villard' <plagnioj@jcrosoft.com>, 'Richard Purdie' <rpurdie@rpsys.net>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On 23/10/2013 02:19, Jingoo Han :
> On Wednesday, October 23, 2013 2:27 AM, Johan Hovold wrote:
>>
>> These patches fix a few issues and clean up the atmel-pwm-bl driver
>> somewhat.
>>
>> Johan
>>
>> Johan Hovold (9):
>>    backlight: atmel-pwm-bl: fix reported brightness
>>    backlight: atmel-pwm-bl: fix gpio polarity in remove
>>    backlight: atmel-pwm-bl: fix module autoload
>>    backlight: atmel-pwm-bl: clean up probe error handling
>>    backlight: atmel-pwm-bl: clean up get_intensity
>>    backlight: atmel-pwm-bl: remove unused include
>>    backlight: atmel-pwm-bl: use gpio_is_valid
>>    backlight: atmel-pwm-bl: refactor gpio_on handling
>>    backlight: atmel-pwm-bl: use gpio_request_one
>
> ++cc Andrew Morton, Tomi Valkeinen, Jean-Christophe Plagniol-Villard
>
> Hi Johan Hovold,
>
> Currently, because there is no git tree for backlight,
> backlight patches have been merged to mm-tree by Andrew Morton.
> Please, add Andrew Morton to CC list.
>
> Also, there is another way.
> If Nicolas Ferre wants to merge these patches, the patches can be
> merged through ATMEL-SoC tree with my Acked-by.

Hi,

As it's a driver without interaction with AT91 code, maybe routing this 
patch series through mm-tree is the way to go.

If you find any issue in the process, please tell me. I would be happy 
to ease the process.

Bye,


>>
>>   drivers/video/backlight/atmel-pwm-bl.c | 86 ++++++++++++++++------------------
>>   1 file changed, 40 insertions(+), 46 deletions(-)
>
>


-- 
Nicolas Ferre
