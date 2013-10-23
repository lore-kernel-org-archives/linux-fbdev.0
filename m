From: Jingoo Han <jg1.han@samsung.com>
Date: Wed, 23 Oct 2013 01:54:01 +0000
Subject: Re: [PATCH 9/9] backlight: atmel-pwm-bl: use gpio_request_one
Message-Id: <002101cecf92$bef81fb0$3ce85f10$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1382462819-28576-1-git-send-email-jhovold@gmail.com>
 <1382462819-28576-10-git-send-email-jhovold@gmail.com>
In-Reply-To: <1382462819-28576-10-git-send-email-jhovold@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Johan Hovold' <jhovold@gmail.com>
Cc: 'Richard Purdie' <rpurdie@rpsys.net>, 'Nicolas Ferre' <nicolas.ferre@atmel.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>

On Wednesday, October 23, 2013 2:27 AM, Johan Hovold wrote:
> 
> Use devm_gpio_request_one rather than requesting and setting direction
> in two calls.
> 
> Signed-off-by: Johan Hovold <jhovold@gmail.com>

Acked-by: Jingoo Han <jg1.han@samsung.com>

Best regards,
Jingoo Han

> ---
>  drivers/video/backlight/atmel-pwm-bl.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)

