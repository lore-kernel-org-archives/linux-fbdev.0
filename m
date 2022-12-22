Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5876AC4332F
	for <linux-fbdev@archiver.kernel.org>; Thu, 22 Dec 2022 16:40:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbiLVQkC (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 22 Dec 2022 11:40:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiLVQkA (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 22 Dec 2022 11:40:00 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1428631DFD
        for <linux-fbdev@vger.kernel.org>; Thu, 22 Dec 2022 08:39:59 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id o5so2234393wrm.1
        for <linux-fbdev@vger.kernel.org>; Thu, 22 Dec 2022 08:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=luABOnCrlVSdR9io8JSfc8eAe/zDLsHgsTWLT2NYCGs=;
        b=V+C376yvgmxQlnX1BlFhBDbJ8j4Sz48pRHQ7M1E3a7NsWkhera/DCE7kFEbPECjspW
         4JhQpbtcDSUwG1cbxSEzGcw4wjjIkI397fm6cwDEKuQL062zKdpgTRpxbMfTiMOROlEy
         ehdasNIPFPQhE/FpO88qvU4xqd/4EbIdVuRnOivxhx/7gdXCIqqMOVl8LrDRRRpstERH
         xzX+HUCDvGqiXIHty3Ula3dqnKM8/NjXW2Q8s7kHxrGBIah7i9YsxI3RM6Bc/zbhPbom
         Ft6mZkdlyIdAwLjieUdA/teQHO8KubqSE05L//Bl6q4dsO0ixur5K9RDdwQak2l57S2T
         L61w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=luABOnCrlVSdR9io8JSfc8eAe/zDLsHgsTWLT2NYCGs=;
        b=ptO/nR92BQLgqOVT3mXe+BqX6IEaKKy1+VG/wKisrtPORCourlCQZEogaVYtlyxXBH
         gm8A7fZYgxMGX0ipNA+1XdRSmEc9nNnA2G4WY5SAGNoiGvs/P9WDB6nJxaldAqbxzJH8
         ALXyc9t+MrirO2FYRYfHPHTkRcaoLVpTtlvKQ4brJVfx+aicnjYBoOzzuVqlaPDtFhKn
         wkcjHczjY+iNS/ithVoriKjuGRomG3lSWZlD2e5XfYf81HgXenCma4Bm2qJBCV6/Cla+
         myM+OqsSvXGFJjoB3Z7+abUducZYrRSw7YXpTT/dV7C2NvQsMCH99rYrVgfU3wZx6zNT
         sAAg==
X-Gm-Message-State: AFqh2kpPVZ479/beFh6Pknv1fLhxX2QR7dg8znfGgu1vXgnurxTJp7NP
        jOxx8+qucgc+i4FWK3TafgqjpA==
X-Google-Smtp-Source: AMrXdXsboUgPbZD28ip7UN92WxcTwW+13dg1F+V6XUKM/L2mYaNDoqDiUlLDmZb8DgmYykHjM3c4Ug==
X-Received: by 2002:adf:e586:0:b0:241:c603:900 with SMTP id l6-20020adfe586000000b00241c6030900mr7443600wrm.16.1671727197552;
        Thu, 22 Dec 2022 08:39:57 -0800 (PST)
Received: from aspen.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id v3-20020a5d4a43000000b0026fc5694a60sm957747wrs.26.2022.12.22.08.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 08:39:56 -0800 (PST)
Date:   Thu, 22 Dec 2022 16:39:54 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Jianhua Lu <lujianhua000@gmail.com>
Cc:     Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Helge Deller <deller@gmx.de>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v3 1/2] backlight: ktz8866: Add support for Kinetic
 KTZ8866 backlight
Message-ID: <Y6SIWoVFX/OlNO0n@aspen.lan>
References: <20221222125441.1547-1-lujianhua000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221222125441.1547-1-lujianhua000@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Thu, Dec 22, 2022 at 08:54:40PM +0800, Jianhua Lu wrote:
> Add support for Kinetic KTZ8866 backlight, which is used in
> Xiaomi tablet, Mi Pad 5 series. This driver lightly based on
> downstream implementation [1].
> [1] https://github.com/MiCode/Xiaomi_Kernel_OpenSource/blob/elish-r-oss/drivers/video/backlight/ktz8866.c
>
> Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
> ---
> Changes in v2:
>   - Add missing staitc modifier to ktz8866_write function.
>
> Changes in v3:
>   - Add 2022 to Copyright line.
>   - Sort headers
>   - Remove meaningless comment
>   - Use definitions instead of hardcoding.
>   - Add missing maintainer info
>
>  MAINTAINERS                       |   6 +
>  drivers/video/backlight/Kconfig   |   8 ++
>  drivers/video/backlight/Makefile  |   1 +
>  drivers/video/backlight/ktz8866.c | 180 ++++++++++++++++++++++++++++++
>  drivers/video/backlight/ktz8866.h |  31 +++++
>  5 files changed, 226 insertions(+)
>  create mode 100644 drivers/video/backlight/ktz8866.c
>  create mode 100644 drivers/video/backlight/ktz8866.h
>
> diff --git a/drivers/video/backlight/ktz8866.c b/drivers/video/backlight/ktz8866.c
> new file mode 100644
> index 000000000000..ea641bdfc4d2
> --- /dev/null
> +++ b/drivers/video/backlight/ktz8866.c
> @@ -0,0 +1,180 @@
> +
> +#define BL_EN_BIT BIT(6)
> +#define BL_CURRENT_SINKS 0x1F
> +#define BL_OVP_LIMIT 0x33
> +#define LED_CURRENT_RAMPING_TIME 0xBD
> +#define LED_DIMMING_TIME 0x11
> +#define LCD_BIAS_EN 0x9F
> +#define LED_CURRENT 0xF9
> +
> +#define low_3_bit(x) ((x)&0x7)
> +#define high_8_bit(x) ((x >> 3) & 0xFF)

These don't seem to be particularly useful. They are used exactly once
so I think it is better just to implement the shifts directly
in ktz8866_backlight_update_status().

> +struct ktz8866 {
> +	struct i2c_client *client;
> +	struct regmap *regmap;
> +	bool state;
> +};
> +
> +enum {
> +	LED_OFF,
> +	LED_ON,
> +};

Let's remove this emum. It is better to rename state to
led_on in order to make the code read well:

  if (ktz->led_on) ...
  ktz->led_on = true;
  ktz->led_on = false;

> +static void ktz8866_init(struct ktz8866 *ktz)
> +{
> +	/* Enable 1~5 current sinks */
> +	ktz8866_write(ktz, BL_EN, BL_CURRENT_SINKS);
> +	/* Backlight OVP 26.4V */
> +	ktz8866_write(ktz, BL_CFG1, BL_OVP_LIMIT);
> +	/* LED current ramping time 128ms */
> +	ktz8866_write(ktz, BL_CFG2, LED_CURRENT_RAMPING_TIME);
> +	/* LED on/off ramping time 1ms */
> +	ktz8866_write(ktz, BL_DIMMING, LED_DIMMING_TIME);
> +	/* Enable OUTP and OUTN via pin ENP and ENN */
> +	ktz8866_write(ktz, LCD_BIAS_CFG1, LCD_BIAS_EN);
> +	/* Backlight Full-scale LED Current 30.0mA */
> +	ktz8866_write(ktz, FULL_SCALE_CURRENT, LED_CURRENT);
> +}

Are these settings specific to the mipad 5 m/board? Many of these look
like they should be described in the devicetree rather than hardcoded
in the driver.


> +static int ktz8866_probe(struct i2c_client *client,
> +			 const struct i2c_device_id *id)
> +{
> +	struct backlight_device *backlight_dev;
> +	struct backlight_properties props;
> +	struct ktz8866 *ktz;
> +
> +	ktz = devm_kzalloc(&client->dev, sizeof(*ktz), GFP_KERNEL);
> +	if (!ktz)
> +		return -ENOMEM;
> +
> +	ktz->client = client;
> +	ktz->regmap = devm_regmap_init_i2c(client, &ktz8866_regmap_config);
> +
> +	if (IS_ERR(ktz->regmap)) {
> +		dev_err(&client->dev, "failed to init regmap\n");
> +		return PTR_ERR(ktz->regmap);
> +	}
> +
> +	memset(&props, 0, sizeof(props));
> +	props.type = BACKLIGHT_RAW;
> +	props.max_brightness = MAX_BRIGHTNESS;
> +	props.brightness = clamp_t(unsigned int, DEFAULT_BRIGHTNESS, 0,
> +				   props.max_brightness);

Please set the scale property correctly. "Unknown" is never correct for
new drivers.


> +	backlight_dev = devm_backlight_device_register(
> +		&client->dev, "ktz8866-backlight", &client->dev, ktz,
> +		&ktz8866_backlight_ops, &props);
> +
> +	if (IS_ERR(backlight_dev)) {
> +		dev_err(&client->dev, "failed to register backlight device\n");
> +		return PTR_ERR(backlight_dev);
> +	}
> +
> +	ktz8866_init(ktz);
> +
> +	i2c_set_clientdata(client, backlight_dev);
> +	backlight_update_status(backlight_dev);
> +
> +	return 0;
> +}
> diff --git a/drivers/video/backlight/ktz8866.h b/drivers/video/backlight/ktz8866.h
> new file mode 100644
> index 000000000000..b0ed8cbee608
> --- /dev/null
> +++ b/drivers/video/backlight/ktz8866.h
> @@ -0,0 +1,31 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Register definitions for Kinetic KTZ8866 backlight
> + *
> + * Copyright (C) 2022 Jianhua Lu <lujianhua000@gmail.com>
> + */
> +
> +#ifndef KTZ8866_H
> +#define KTZ8866_H
> +
> +#define DEVICE_ID 0x01
> +#define BL_CFG1 0x02
> +#define BL_CFG2 0x03
> +#define BL_BRT_LSB 0x04
> +#define BL_BRT_MSB 0x05
> +#define BL_EN 0x08
> +#define LCD_BIAS_CFG1 0x09
> +#define LCD_BIAS_CFG2 0x0A
> +#define LCD_BIAS_CFG3 0x0B
> +#define LCD_BOOST_CFG 0x0C
> +#define OUTP_CFG 0x0D
> +#define OUTN_CFG 0x0E
> +#define FLAG 0x0F
> +#define BL_OPTION1 0x10
> +#define BL_OPTION2 0x11
> +#define PWM2DIG_LSBs 0x12
> +#define PWM2DIG_MSBs 0x13
> +#define BL_DIMMING 0x14
> +#define FULL_SCALE_CURRENT 0x15
> +
> +#endif /* KTZ8866_H */

This header file is not required. Please remove and move any definitions
the driver needs into the C file.


Daniel.
