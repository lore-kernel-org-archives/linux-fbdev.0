Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794581617;
	b=g7kkCLh5gV5JSZE0cHT4Inx4XDFASm24JgrWWzmxuYWRhXTlr/e4A71WIgq0thnnF+z+
	 ReMwJKtQmBKpluvK/Xw+fkBPTB5teWkV58UEV2F8yQXVSS6bmIkfphrs4FMXdQC13ExJD
	 757Z0t3DfqNgbswAFwcI9j81JlAT6mmSIJI2fEcDJwPdN6u6cd5FN2ZpINd9+Alh9maLj
	 ilm+BmVUL98WEe7zeUBWOFKemk7gtlrZLJC6IPko3IJAjPFVZQx0LHyll9xfR842oBjiP
	 wAF7OisF0V4I8GG75Oznheo6U34yQV4vapMcm88MQdIkH2myNmWkf5P8nvle9SDs8ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794581617;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-AI-Review-Draft;
	bh=J1fkTTthpSMnWf73EpC1C3Nkug0WjqfNB0G0R1Twl38=;
	b=CUGPpprrfP5K6amWFU3WomD9zn0N+CaGnOjPQTBGSDNvPy8KQ/Yqd1lxtRS3477fRmP4
	 UhTcmYvpX3HUO2ogGUjKqXRRepu6KUfoBUEkCoDalOJktv0vTxpyiPbQI0nMeXJNQX3Hf
	 xzYKw/XpR9gkSVT7l+3S38VTAkWwcVFmfQiS0rjf8XQQyLOlmj/ytXTQAdsAxTExMYpgc
	 GGm/z6DUabhxuLHXiBPjmX578N5t8v8qTj7V/a7Axf+gjXUmaZW7w/wu4ojBOLNV7nIWB
	 HituwPsP2BRgWEafMl3Le8CLxyHv5BBNcxyo2BQAyqDH5Ggolj+g5+od2dDM46vXtxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K63W5CrJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD13606A32D;
	Fri, 13 Nov 2026 14:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K63W5CrJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECEB61F000C4;
	Fri, 13 Nov 2026 14:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794581616;
	bh=J1fkTTthpSMnWf73EpC1C3Nkug0WjqfNB0G0R1Twl38=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=K63W5CrJIX9LO8OBbhPZdTvrgkakrsEgTDcJLhEU9e3bRIUHyQU3CmwJhSD1mdSrh
	 94spflQyvlPaPa9rMcnFj+CnbOWoNauEcSk7dI6V+GuzrghAnsIl7I+93KKpPPRfEI
	 YSFQin+bzy834BqU+S/NysJ1MpdWQBBeyaK0skhJc8MzHHuCz6fRrWYf0Yd9DCWTVE
	 JxiMFkW8qcaDknFDNEwwIga/CQ+D2RN7fnp4zYUpH9WpvvOweipJyE1wocar/HWNNs
	 kQ/zm8tvTzNBPGm6DZJ+1bVwo5ZYQ+JT08qpjtJv1FOSy69ja4cUA99WnNzhdXXVMT
	 va6JiIn6WU9OA==
Date: Fri, 13 Nov 2026 14:53:32 +0000
From: Lee Jones <lee@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Pavel Machek <pavel@kernel.org>,
	Griffin Kroah-Hartman <griffin@kroah.com>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
	linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v1] video: leds: backlight: lm3533: Support getting LED
 sources from DT
Message-ID: <179370032880.793788.4424159880220279586@kernel.org>
References: <20261101142435.130520-1-clamor95@gmail.com>
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261101142435.130520-1-clamor95@gmail.com>
X-AI-Review-Draft: <20261101142435.130520-1-clamor95@gmail.com>

Drop the 'video: ' part of the subject line.

Please review, explain or fix the Sashiko review(s).

> Add Control Bank to HVLED/LVLED muxing support based on the led-sources
> defined in the device tree.
>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>
> ---
> This was part of the original LM3533 controller DT/OF conversion patchset,
> but it appears to have been accidentally separated during the final iteration.
> Therefore, I am sending it as a follow-up.
> ---
>  drivers/leds/leds-lm3533.c          | 60 +++++++++++++++++++++++++++++
>  drivers/video/backlight/lm3533_bl.c | 45 ++++++++++++++++++++++

Why are these being bundled up?

What is the dependency?  If none, please separate.

>  2 files changed, 105 insertions(+)
>
> diff --git a/drivers/leds/leds-lm3533.c b/drivers/leds/leds-lm3533.c
> index 7259097bd6a71..a1aeff70a90fc 100644
> --- a/drivers/leds/leds-lm3533.c
> +++ b/drivers/leds/leds-lm3533.c
> @@ -26,6 +26,11 @@
>  #define LM3533_ALS_CHANNEL_LV_MIN	1
>  #define LM3533_ALS_CHANNEL_LV_MAX	2
>
> +#define LM3533_REG_OUTPUT_CONF1			0x10
> +#define   OUTPUT_CONF1_SHIFT			2
> +#define   OUTPUT_LVLED_MASK			0x3
> +#define LM3533_REG_OUTPUT_CONF2			0x11
> +#define   OUTPUT_CONF2_SHIFT			6
>  #define LM3533_REG_CTRLBANK_BCONF_BASE		0x1b
>  #define LM3533_REG_PATTERN_ENABLE		0x28
>  #define LM3533_REG_PATTERN_LOW_TIME_BASE	0x71
> @@ -54,6 +59,9 @@ struct lm3533_led {
>  	u32 max_current;
>  	u32 pwm;
>
> +	int num_leds;
> +	u32 leds[LM3533_LVCTRLBANK_MAX];
> +
>  	bool have_als;
>  };
>
> @@ -622,8 +630,36 @@ static const struct attribute_group *lm3533_led_attribute_groups[] = {
>
>  static int lm3533_led_setup(struct lm3533_led *led)
>  {
> +	u32 output_cfg_shift = 0;
> +	u32 output_cfg_val = 0;
> +	u32 output_cfg_mask = 0;
>  	int ret;
>
> +	if (led->num_leds) {
> +		for (int i = 0; i < led->num_leds; i++) {
> +			if (led->leds[i] >= LM3533_LVCTRLBANK_MAX)
> +				continue;
> +
> +			output_cfg_shift = led->leds[i] * 2;
> +			output_cfg_val |= led->id << output_cfg_shift;
> +			output_cfg_mask |= OUTPUT_LVLED_MASK << output_cfg_shift;
> +		}
> +
> +		/* LVLED1, LVLED2 and LVLED3 */
> +		ret = regmap_update_bits(led->regmap, LM3533_REG_OUTPUT_CONF1,
> +					 output_cfg_mask << OUTPUT_CONF1_SHIFT,
> +					 output_cfg_val << OUTPUT_CONF1_SHIFT);
> +		if (ret)
> +			return ret;
> +
> +		/* LVLED4 and LVLED5 */
> +		ret = regmap_update_bits(led->regmap, LM3533_REG_OUTPUT_CONF2,
> +					 output_cfg_mask >> OUTPUT_CONF2_SHIFT,
> +					 output_cfg_val >> OUTPUT_CONF2_SHIFT);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	ret = lm3533_ctrlbank_set_max_current(&led->cb, led->max_current);
>  	if (ret)
>  		return ret;
> @@ -698,6 +734,30 @@ static int lm3533_led_probe(struct platform_device *pdev)
>
>  	device_property_read_u32(&pdev->dev, "ti,pwm-config-mask", &led->pwm);
>
> +	/*
> +	 * If led-sources property is not set then either this Control Bank uses
> +	 * its default LVLED or is not linked to any LVLED at all.
> +	 */
> +	led->num_leds = device_property_count_u32(&pdev->dev, "led-sources");
> +	if (led->num_leds > LM3533_LVCTRLBANK_MAX) {
> +		dev_err(&pdev->dev, "num of LED sources exceeds max %d: %d\n",

"Number "

> +			LM3533_LVCTRLBANK_MAX, led->num_leds);
> +		ret = -EINVAL;
> +		goto err_deregister;
> +	}

Could we move the 'led-sources' parsing above led_classdev_register(),
or convert the driver to devm_led_classdev_register() and use 'return
dev_err_probe()' here?

> +	if (led->num_leds < 0)
> +		led->num_leds = 0;
> +
> +	if (led->num_leds > 0) {
> +		ret = device_property_read_u32_array(&pdev->dev, "led-sources",
> +						     led->leds, led->num_leds);
> +		if (ret) {
> +			dev_err(&pdev->dev, "failed to get led-sources\n");
> +			goto err_deregister;
> +		}

dev_err_probe()

> +	}
> +
>  	ret = lm3533_led_setup(led);
>  	if (ret)
>  		goto err_deregister;
> diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/backlight/lm3533_bl.c
> index adcd6ac7cf229..e8164c8528577 100644
> --- a/drivers/video/backlight/lm3533_bl.c
> +++ b/drivers/video/backlight/lm3533_bl.c
> @@ -7,6 +7,7 @@
>   * Author: Johan Hovold <jhovold@gmail.com>
>   */
>
> +#include <linux/bits.h>
>  #include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/platform_device.h>
> @@ -21,6 +22,7 @@
>  #define LM3533_HVCTRLBANK_COUNT		2
>  #define LM3533_BL_MAX_BRIGHTNESS	255
>
> +#define LM3533_REG_OUTPUT_CONF1		0x10
>  #define LM3533_REG_CTRLBANK_AB_BCONF	0x1a
>  #define   CTRLBANK_AB_BCONF_ALS(n)	BIT(2 * (n))
>  #define   CTRLBANK_AB_BCONF_MODE(n)	BIT(2 * (n) + 1)
> @@ -35,6 +37,9 @@ struct lm3533_bl {
>  	u32 max_current;
>  	u32 pwm;
>
> +	int num_leds;
> +	u32 led_strings[LM3533_HVCTRLBANK_COUNT];
> +
>  	bool have_als;
>  	bool linear;
>  };
> @@ -236,6 +241,8 @@ static const struct attribute_group *lm3533_bl_attribute_groups[] = {
>  static int lm3533_bl_setup(struct lm3533_bl *bl)
>  {
>  	int ctrlbank = lm3533_bl_get_ctrlbank_id(bl);
> +	u32 output_cfg_val = 0;
> +	u32 output_cfg_mask = 0;
>  	int ret;
>
>  	ret = regmap_assign_bits(bl->regmap, LM3533_REG_CTRLBANK_AB_BCONF,
> @@ -243,6 +250,21 @@ static int lm3533_bl_setup(struct lm3533_bl *bl)
>  	if (ret)
>  		return ret;
>
> +	if (bl->num_leds) {
> +		for (int i = 0; i < bl->num_leds; i++) {
> +			if (bl->led_strings[i] >= LM3533_HVCTRLBANK_COUNT)
> +				continue;
> +
> +			output_cfg_val |= ctrlbank << bl->led_strings[i];
> +			output_cfg_mask |= BIT(bl->led_strings[i]);
> +		}

This for loop doesn't need to be in the if statement.

> +		ret = regmap_update_bits(bl->regmap, LM3533_REG_OUTPUT_CONF1,
> +					 output_cfg_mask, output_cfg_val);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	ret = lm3533_ctrlbank_set_max_current(&bl->cb, bl->max_current);
>  	if (ret)
>  		return ret;
> @@ -320,6 +342,29 @@ static int lm3533_bl_probe(struct platform_device *pdev)
>
>  	device_property_read_u32(&pdev->dev, "ti,pwm-config-mask", &bl->pwm);
>
> +	/*
> +	 * If led-sources property is not set then either this Control Bank uses
> +	 * its default HVLED or is not linked to any HVLED at all.
> +	 */
> +	bl->num_leds = device_property_count_u32(&pdev->dev, "led-sources");
> +	if (bl->num_leds > LM3533_HVCTRLBANK_COUNT) {
> +		dev_err(&pdev->dev, "num of LED sources %d exceeds max %d\n",
> +			bl->num_leds, LM3533_HVCTRLBANK_COUNT);
> +		return -EINVAL;
> +	}

dev_err_probe()

> +
> +	if (bl->num_leds < 0)
> +		bl->num_leds = 0;
> +
> +	if (bl->num_leds > 0) {
> +		ret = device_property_read_u32_array(&pdev->dev, "led-sources",
> +						     bl->led_strings,
> +						     bl->num_leds);
> +		if (ret)
> +			return dev_err_probe(&pdev->dev, ret,
> +					     "failed to get led-sources\n");
> +	}
> +
>  	ret = lm3533_bl_setup(bl);
>  	if (ret)
>  		return ret;
> -- 
> 2.53.0
>

-- 
Lee Jones
