From: Jingoo Han <jg1.han@samsung.com>
Date: Wed, 23 Oct 2013 01:47:58 +0000
Subject: Re: [PATCH 2/9] backlight: atmel-pwm-bl: fix gpio polarity in remove
Message-Id: <001a01cecf91$e67fb620$b37f2260$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1382462819-28576-1-git-send-email-jhovold@gmail.com>
 <1382462819-28576-3-git-send-email-jhovold@gmail.com>
In-Reply-To: <1382462819-28576-3-git-send-email-jhovold@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Johan Hovold' <jhovold@gmail.com>
Cc: 'Richard Purdie' <rpurdie@rpsys.net>, 'Nicolas Ferre' <nicolas.ferre@atmel.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>

On Wednesday, October 23, 2013 2:27 AM, Johan Hovold wrote:
> 
> Make sure to honour gpio polarity also at remove so that the backlight
> is actually disabled on boards with active-low enable pin.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Johan Hovold <jhovold@gmail.com>

Acked-by: Jingoo Han <jg1.han@samsung.com>

Best regards,
Jingoo Han

> ---
>  drivers/video/backlight/atmel-pwm-bl.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)


