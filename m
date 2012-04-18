From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Wed, 18 Apr 2012 16:21:25 +0000
Subject: Re: [PATCH] backlight: Add LMS501KF03 LCD panel driver
Message-Id: <4F8EEA05.1050403@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1334558406-22576-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1334558406-22576-1-git-send-email-sachin.kamat@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 04/16/2012 06:40 AM, Sachin Kamat wrote:
> LMS501KF03 is a 480x800 LCD module with brightness control.
> The driver uses 3-wired SPI inteface.
> 
> Signed-off-by: Ilho Lee <Ilho215.lee@samsung.com>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---

> diff --git a/drivers/video/backlight/lms501kf03.c b/drivers/video/backlight/lms501kf03.c
> new file mode 100644
> index 0000000..3dc85d4
> --- /dev/null
> +++ b/drivers/video/backlight/lms501kf03.c
> +static int lms501kf03_ldi_enable(struct lms501kf03 *lcd)
> +{
> +	int ret, i;
> +	const unsigned short *init_seq[] = {
> +		SEQ_DISPLAY_ON,
> +	};

Is this array expected to grow at some point?
Otherwise I'd suggest to get rid of it and simplify the code below.

> +
> +	for (i = 0; i < ARRAY_SIZE(init_seq); i++) {
> +		ret = lms501kf03_panel_send_sequence(lcd, init_seq[i]);
> +		if (ret)
> +			break;
> +	}
> +
> +	return ret;
> +}
> +
> +static int lms501kf03_ldi_disable(struct lms501kf03 *lcd)
> +{
> +	int ret, i;
> +
> +	const unsigned short *init_seq[] = {
> +		SEQ_DISPLAY_OFF,
> +	};

dito

> +
> +	for (i = 0; i < ARRAY_SIZE(init_seq); i++) {
> +		ret = lms501kf03_panel_send_sequence(lcd, init_seq[i]);
> +		if (ret)
> +			break;
> +	}
> +
> +	return ret;
> +}


Best regards,

Florian Tobias Schandinat
