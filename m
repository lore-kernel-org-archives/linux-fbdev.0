Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A50C48BE8
	for <linux-fbdev@archiver.kernel.org>; Fri, 18 Jun 2021 10:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EF1261241
	for <linux-fbdev@archiver.kernel.org>; Fri, 18 Jun 2021 10:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbhFRKdZ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 18 Jun 2021 06:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbhFRKdY (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 18 Jun 2021 06:33:24 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1746AC061574
        for <linux-fbdev@vger.kernel.org>; Fri, 18 Jun 2021 03:31:14 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id m3so5337435wms.4
        for <linux-fbdev@vger.kernel.org>; Fri, 18 Jun 2021 03:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=cihbsgEtYnVxdrkS4r7XcqbH/OKFs8p0aoMVL84XjSk=;
        b=jn08rWVlCC2tifool8RXg8H6TcK5rnvs/9i83KpXjBn/V7wKSTRt4d4gCC15ZrPA1R
         zqTASJnHddIaKZkpsQfHkisMg98pX2HXut6r57aLiy71KLFB7WE7ULWyX2Hk3kEetIfI
         +xLNDKadSPQwD0t2uq4j+EQVYr0634cw7MdOUYBUIXF7mrGozxmqaF7o8unMspfK364j
         ibooPS2lQ+pmsvm/LdNrXzgrhPkO1t7wcigCR5lWzMmQ922nBIiCIk1zIv7kdtPAbooi
         l54z7VS1EfnnXhuMyXaXiSmD4qhFDH9v/VXrIT5xUUPw2n+Dhm6apcQwmVkS1o2LnnU/
         1FUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=cihbsgEtYnVxdrkS4r7XcqbH/OKFs8p0aoMVL84XjSk=;
        b=S5yo8yp2/RYiIC3S7A6xT/bXReeOuRn9+gSJ699TiVoou/w7+LBodXNFAi7f7GQYSz
         xRW5MaMEfd8enHB8hcfwEaMYp2ml2W7bySPDXDSNs+9wVTbSTFVcjvejpV9ObOr4h9rw
         KsFuqtfdQZ+Qmqr3cCEoraKI/Md85K5DKjdRIJVXeiUzC5ezC0atz4UgE+VlktZfyf+Y
         cHeExSLITdKlXFo1X9xkEJL6lDe1cDfgoJv0duu4606kVHQIIrL1u+6wifzV2yLBIZVb
         3DA2tG/Tk/80eIP97YXTJg5X+1+a+7JxhCCVTMmoF59l2oVEbpigzJBUQCYLq9XyaAz0
         +T3A==
X-Gm-Message-State: AOAM531UDU3bCNMSoYFE38pHKbYrZaDF1cAc/+YwN+5gYhAdPpFmydmG
        4vH7Mof8yXbV7Fcw/GnC/rK40w==
X-Google-Smtp-Source: ABdhPJzmVu5eCTgvyPXfWQXhvmtJhz9s0bWfQcET358VEtoRVshPN7UoGYzxW89DWg4X0ZJY398X7Q==
X-Received: by 2002:a1c:9a8b:: with SMTP id c133mr2457196wme.65.1624012272480;
        Fri, 18 Jun 2021 03:31:12 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id v5sm962817wml.26.2021.06.18.03.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 03:31:11 -0700 (PDT)
Date:   Fri, 18 Jun 2021 11:31:09 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH] backlight: lm3630a: convert to atomic PWM API and check
 for errors
Message-ID: <20210618103109.j7vtuif4taldtt5d@maple.lan>
References: <20210618085844.231751-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210618085844.231751-1-u.kleine-koenig@pengutronix.de>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Fri, Jun 18, 2021 at 10:58:44AM +0200, Uwe Kleine-König wrote:
> The practical upside here is that this only needs a single API call to
> program the hardware which (depending on the underlaying hardware) can
> be more effective and prevents glitches.
> 
> Up to now the return value of the pwm functions was ignored. Fix this
> and propagate the error to the caller.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

New code looks OK but these changes reveal just how crazy the return codes
from this driver's update_status() methods are since now the new (PWM) error path is
structured completely differently to the existing (I2C) error path.

update_status() should return 0 on success and a -ve errno otherwise.

Thus the new code to return -errno is correct and so is the I2C success
code path. However the PWM success path and the I2C error path are both
broken.

Are you OK to add a patch *before* this one to fix the existing code
paths before making the PWM changes?


Daniel.

> ---
>  drivers/video/backlight/lm3630a_bl.c | 33 +++++++++++++++-------------
>  1 file changed, 18 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/backlight/lm3630a_bl.c
> index e88a2b0e5904..24fa7e6938fa 100644
> --- a/drivers/video/backlight/lm3630a_bl.c
> +++ b/drivers/video/backlight/lm3630a_bl.c
> @@ -52,6 +52,7 @@ struct lm3630a_chip {
>  	struct gpio_desc *enable_gpio;
>  	struct regmap *regmap;
>  	struct pwm_device *pwmd;
> +	struct pwm_state pwmd_state;
>  };
>  
>  /* i2c access */
> @@ -167,16 +168,19 @@ static int lm3630a_intr_config(struct lm3630a_chip *pchip)
>  	return rval;
>  }
>  
> -static void lm3630a_pwm_ctrl(struct lm3630a_chip *pchip, int br, int br_max)
> +static int lm3630a_pwm_ctrl(struct lm3630a_chip *pchip, int br, int br_max)
>  {
> -	unsigned int period = pchip->pdata->pwm_period;
> -	unsigned int duty = br * period / br_max;
> +	int err;
>  
> -	pwm_config(pchip->pwmd, duty, period);
> -	if (duty)
> -		pwm_enable(pchip->pwmd);
> -	else
> -		pwm_disable(pchip->pwmd);
> +	pchip->pwmd_state.period = pchip->pdata->pwm_period;
> +
> +	err = pwm_set_relative_duty_cycle(&pchip->pwmd_state, br, br_max);
> +	if (err)
> +		return err;
> +
> +	pchip->pwmd_state.enabled = pchip->pwmd_state.duty_cycle ? true : false;
> +
> +	return pwm_apply_state(pchip->pwmd, &pchip->pwmd_state);
>  }
>  
>  /* update and get brightness */
> @@ -188,8 +192,11 @@ static int lm3630a_bank_a_update_status(struct backlight_device *bl)
>  
>  	/* pwm control */
>  	if ((pwm_ctrl & LM3630A_PWM_BANK_A) != 0) {
> -		lm3630a_pwm_ctrl(pchip, bl->props.brightness,
> -				 bl->props.max_brightness);
> +		ret = lm3630a_pwm_ctrl(pchip, bl->props.brightness,
> +				       bl->props.max_brightness);
> +		if (ret)
> +			return ret;
> +
>  		return bl->props.brightness;
>  	}
>  
> @@ -563,11 +570,7 @@ static int lm3630a_probe(struct i2c_client *client,
>  			return PTR_ERR(pchip->pwmd);
>  		}
>  
> -		/*
> -		 * FIXME: pwm_apply_args() should be removed when switching to
> -		 * the atomic PWM API.
> -		 */
> -		pwm_apply_args(pchip->pwmd);
> +		pwm_init_state(pchip->pwmd, &pchip->pwmd_state);
>  	}
>  
>  	/* interrupt enable  : irq 0 is not allowed */
> -- 
> 2.30.2
> 
