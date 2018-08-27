From: Bjorn Andersson <bjorn.andersson@linaro.org>
Date: Mon, 27 Aug 2018 14:54:20 +0000
Subject: Re: [PATCH V5 8/8] backlight: qcom-wled: Add auto string detection logic
Message-Id: <20180827145420.GL3048@tuxbook-pro>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1535106467-17843-1-git-send-email-kgunda@codeaurora.org>
 <1535106467-17843-9-git-send-email-kgunda@codeaurora.org>
In-Reply-To: <1535106467-17843-9-git-send-email-kgunda@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kiran Gunda <kgunda@codeaurora.org>
Cc: jingoohan1@gmail.com, lee.jones@linaro.org, b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, daniel.thompson@linaro.org, jacek.anaszewski@gmail.com, pavel@ucw.cz, robh+dt@kernel.org, mark.rutland@arm.com, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-arm-msm@vger.kernel.org

On Fri 24 Aug 03:27 PDT 2018, Kiran Gunda wrote:
> diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
[..]
>  struct wled {
> @@ -135,16 +146,22 @@ struct wled {
>  	struct regmap *regmap;
>  	struct mutex lock;	/* Lock to avoid race from thread irq handler */
>  	ktime_t last_short_event;
> +	ktime_t start_ovp_fault_time;
>  	u16 ctrl_addr;
>  	u16 sink_addr;
>  	u16 max_string_count;
> +	u16 auto_detection_ovp_count;
>  	u32 brightness;
>  	u32 max_brightness;
>  	u32 short_count;
> +	u32 auto_detect_count;
>  	bool disabled_by_short;
>  	bool has_short_detect;
> +	int ovp_irq;
> +	bool ovp_irq_disabled;

ovp_irq_disabled is now only assigned, never read. So you should be able
to drop it.

[..]
> @@ -200,7 +226,18 @@ static int wled_module_enable(struct wled *wled, int val)
>  				WLED_CTRL_REG_MOD_EN,
>  				WLED_CTRL_REG_MOD_EN_MASK,
>  				val << WLED_CTRL_REG_MOD_EN_SHIFT);
> -	return rc;
> +	if (rc < 0)
> +		return rc;
> +
> +	if (val) {
> +		schedule_delayed_work(&wled->ovp_work, HZ / 100);

wled_ovp_work() is a nop when ovp_irq = 0, so wrap the entire if/else
in a check for ovp_irq > 0 (rather than include it in the else) and drop
it from the worker.

> +	} else {
> +		if (!cancel_delayed_work_sync(&wled->ovp_work) &&
> +		    wled->ovp_irq > 0)
> +			disable_irq(wled->ovp_irq);
> +	}
> +
> +	return 0;

Also, if a user calls rmmod within 10ms of enabling module we will
schedule work of code that's no longer available in the kernel. So you
need to also cancel_delayed_work_sync() in the remove function of the
driver.


Apart from this I think this patch looks good now!

Regards,
Bjorn
