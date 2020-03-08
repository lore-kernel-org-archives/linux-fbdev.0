From: Bjorn Andersson <bjorn.andersson@linaro.org>
Date: Sun, 08 Mar 2020 21:47:48 +0000
Subject: Re: [PATCH V1 2/2] backlight: qcom-wled: Add support for WLED5 peripheral in PM8150L
Message-Id: <20200308214748.GL1094083@builder>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1583153739-19170-1-git-send-email-kgunda@codeaurora.org>
 <1583153739-19170-3-git-send-email-kgunda@codeaurora.org>
In-Reply-To: <1583153739-19170-3-git-send-email-kgunda@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kiran Gunda <kgunda@codeaurora.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, daniel.thompson@linaro.org, b.zolnierkie@samsung.com, jingoohan1@gmail.com, Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, robh+dt@kernel.org, jacek.anaszewski@gmail.com, pavel@ucw.cz, linux-arm-msm@vger.kernel.org, lee.jones@linaro.org, linux-leds@vger.kernel.org, Dan Murphy <dmurphy@ti.com>

On Mon 02 Mar 04:55 PST 2020, Kiran Gunda wrote:
> diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
[..]
> @@ -147,14 +187,39 @@ struct wled {
>  	u32 max_brightness;
>  	u32 short_count;
>  	u32 auto_detect_count;
> +	u32 version;
>  	bool disabled_by_short;
>  	bool has_short_detect;
> +	bool cabc_disabled;
>  	int short_irq;
>  	int ovp_irq;
>  
>  	struct wled_config cfg;
>  	struct delayed_work ovp_work;
>  	int (*wled_set_brightness)(struct wled *wled, u16 brightness);
> +	int (*cabc_config)(struct wled *wled, bool enable);
> +	int (*wled_sync_toggle)(struct wled *wled);

Please split this patch in one that adds these and breaks out the wled3
support, and then a second patch that adds wled5.

> +};
> +
[..]
> +static int wled5_set_brightness(struct wled *wled, u16 brightness)
> +{
> +	int rc, offset;
> +	u16 low_limit = wled->max_brightness * 1 / 1000;
> +	u8 v[2], brightness_msb_mask;
> +
> +	/* WLED5's lower limit is 0.1% */
> +	if (brightness > 0 && brightness < low_limit)
> +		brightness = low_limit;
> +
> +	brightness_msb_mask = 0xf;
> +	if (wled->max_brightness = WLED5_SINK_REG_BRIGHT_MAX_15B)
> +		brightness_msb_mask = 0x7f;

Why not just brightness &= wled->max_brightness? But given that it seems
like the framework ensures that brightness <= max_brightness, why not
skip this altogether?

> +
> +	v[0] = brightness & 0xff;
> +	v[1] = (brightness >> 8) & brightness_msb_mask;
> +
> +	offset = wled5_brightness_reg[wled->cfg.mod_sel];
> +	rc = regmap_bulk_write(wled->regmap, wled->sink_addr + offset,
> +			v, 2);
> +	return rc;
> +}
> +
>  static int wled4_set_brightness(struct wled *wled, u16 brightness)
>  {
>  	int rc, i;
> @@ -237,7 +325,28 @@ static int wled_module_enable(struct wled *wled, int val)
>  	return 0;
>  }
>  
> -static int wled_sync_toggle(struct wled *wled)
> +static int wled5_sync_toggle(struct wled *wled)
> +{
> +	int rc;
> +	u8 val;
> +
> +	val = (wled->cfg.mod_sel = MOD_A) ? WLED5_SINK_REG_SYNC_MOD_A_BIT :
> +					     WLED5_SINK_REG_SYNC_MOD_B_BIT;
> +	rc = regmap_update_bits(wled->regmap,
> +				wled->sink_addr + WLED5_SINK_REG_MOD_SYNC_BIT,
> +				WLED5_SINK_REG_SYNC_MASK, val);
> +	if (rc < 0)
> +		return rc;
> +
> +	val = 0;

Just plug 0 in the function call.

> +	rc = regmap_update_bits(wled->regmap,
> +				wled->sink_addr + WLED5_SINK_REG_MOD_SYNC_BIT,
> +				WLED5_SINK_REG_SYNC_MASK, val);
> +
> +	return rc;

And return regmap_update_bits(...);

> +}
> +

Regards,
Bjorn
