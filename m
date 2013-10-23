From: Jingoo Han <jg1.han@samsung.com>
Date: Wed, 23 Oct 2013 01:52:32 +0000
Subject: Re: [PATCH 7/9] backlight: atmel-pwm-bl: use gpio_is_valid
Message-Id: <001f01cecf92$89d62250$9d8266f0$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1382462819-28576-1-git-send-email-jhovold@gmail.com>
 <1382462819-28576-8-git-send-email-jhovold@gmail.com>
In-Reply-To: <1382462819-28576-8-git-send-email-jhovold@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Johan Hovold' <jhovold@gmail.com>
Cc: 'Richard Purdie' <rpurdie@rpsys.net>, 'Nicolas Ferre' <nicolas.ferre@atmel.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>

On Wednesday, October 23, 2013 2:27 AM, Johan Hovold wrote:
> 
> Use gpio_is_valid rather than open coding the more restrictive != -1
> test.
> 
> Signed-off-by: Johan Hovold <jhovold@gmail.com>

Acked-by: Jingoo Han <jg1.han@samsung.com>

Best regards,
Jingoo Han

> ---
>  drivers/video/backlight/atmel-pwm-bl.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

