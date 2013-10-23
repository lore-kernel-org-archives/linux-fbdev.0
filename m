From: Jingoo Han <jg1.han@samsung.com>
Date: Wed, 23 Oct 2013 01:19:42 +0000
Subject: Re: [PATCH 0/9] backlight: atmel-pwm-bl: fixes and clean ups
Message-Id: <001801cecf8d$f3834d90$da89e8b0$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1382462819-28576-1-git-send-email-jhovold@gmail.com>
In-Reply-To: <1382462819-28576-1-git-send-email-jhovold@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Johan Hovold' <jhovold@gmail.com>
Cc: 'Andrew Morton' <akpm@linux-foundation.org>, 'Tomi Valkeinen' <tomi.valkeinen@ti.com>, 'Jean-Christophe Plagniol-Villard' <plagnioj@jcrosoft.com>, 'Richard Purdie' <rpurdie@rpsys.net>, 'Nicolas Ferre' <nicolas.ferre@atmel.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>

On Wednesday, October 23, 2013 2:27 AM, Johan Hovold wrote:
> 
> These patches fix a few issues and clean up the atmel-pwm-bl driver
> somewhat.
> 
> Johan
> 
> Johan Hovold (9):
>   backlight: atmel-pwm-bl: fix reported brightness
>   backlight: atmel-pwm-bl: fix gpio polarity in remove
>   backlight: atmel-pwm-bl: fix module autoload
>   backlight: atmel-pwm-bl: clean up probe error handling
>   backlight: atmel-pwm-bl: clean up get_intensity
>   backlight: atmel-pwm-bl: remove unused include
>   backlight: atmel-pwm-bl: use gpio_is_valid
>   backlight: atmel-pwm-bl: refactor gpio_on handling
>   backlight: atmel-pwm-bl: use gpio_request_one

++cc Andrew Morton, Tomi Valkeinen, Jean-Christophe Plagniol-Villard

Hi Johan Hovold,

Currently, because there is no git tree for backlight,
backlight patches have been merged to mm-tree by Andrew Morton.
Please, add Andrew Morton to CC list.

Also, there is another way.
If Nicolas Ferre wants to merge these patches, the patches can be
merged through ATMEL-SoC tree with my Acked-by.

Best regards,
Jingoo Han

> 
>  drivers/video/backlight/atmel-pwm-bl.c | 86 ++++++++++++++++------------------
>  1 file changed, 40 insertions(+), 46 deletions(-)

