Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 921F6C4743C
	for <linux-fbdev@archiver.kernel.org>; Mon, 21 Jun 2021 13:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CA94600D4
	for <linux-fbdev@archiver.kernel.org>; Mon, 21 Jun 2021 13:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbhFUNI3 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 21 Jun 2021 09:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbhFUNI2 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 21 Jun 2021 09:08:28 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8400CC061574
        for <linux-fbdev@vger.kernel.org>; Mon, 21 Jun 2021 06:06:13 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id w13so3851944wmc.3
        for <linux-fbdev@vger.kernel.org>; Mon, 21 Jun 2021 06:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=F8qwXMvmBFqtLVWzQIYD5vryUHzEmvLf5X6idDb8i9o=;
        b=Plc6LjFUCW7ggK1p0u/KKsnEOKk/Q2Y1RKFIAC9327ThTUAv3sIP5K9ap90+w5zmfs
         ckOqfpcANzrocCxpftV4sxGzFajesEqlVzxp3eBta9XAbhGI/v8SI9/fQ7dpwsPPI7nm
         fnrrScCev88r9pt9fY7vdOGOiU48+5VDeLOrmcQ+pufFeobC8w+o+tHr9tsw9tgJ6Mjc
         6xkt2+IDWFbEvu6hpF4I7o0poX58KqMI1UUfr73srg/vKfO2LcoJY5i/YWODmdEF4yH9
         rkxGrWoR84agu/ZVv9PJZ9HSzPBGfOwng+H8SMIoJ3iMJZW7J216l8lnqUT8Jtjcq9uE
         VZsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=F8qwXMvmBFqtLVWzQIYD5vryUHzEmvLf5X6idDb8i9o=;
        b=BoF0GDCXXLo/XXTvZPzkvHHTxb9hIdYVD1shwfoJ8WvboJ7O4OmepFz3tZpu9OkDE+
         t7mi3lbN1Bqmc4tWAu3vkBmIscQPO+vrVbikXv3AwxFCS1DUdmv0FY2N2tS28FV1V8hA
         zBiQCZakJiuWqbvpVnzdO8baY5jiRwZ1AUNJyKH0r1s7wN6CwAVhQaRXZMH3T3r7J4Gz
         WKdHyCd7N5EQySi2y0+OUCWKDRtCtTm5wl8v+hWIE3AdpKbnCYJ5XSaEH8NNrMufTdeg
         iVM5AGi7YyQ8Q0fCWSZPY6GHysM1cZffIimKDeeyJbGZElq82YCD5J/ulwTexOpytoOL
         8yeg==
X-Gm-Message-State: AOAM532f4aiHBfM5/kJ9lieEf7Cu5IlgpOMNc9pPoAKvo/gkx5RBhAT0
        5j3+3aYJ4MJzthHawEXjp69B7Q==
X-Google-Smtp-Source: ABdhPJy+22bs4GQKLxRVvp2K6RtCwV53ZcHe8XOE1aLpJnnwR6TqxT3py0MEQ1lFdSpFYBa4W50O5Q==
X-Received: by 2002:a05:600c:414e:: with SMTP id h14mr19210951wmm.6.1624280772076;
        Mon, 21 Jun 2021 06:06:12 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id l15sm7275561wrt.47.2021.06.21.06.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 06:06:11 -0700 (PDT)
Date:   Mon, 21 Jun 2021 14:06:10 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org, kernel@pengutronix.de
Subject: Re: [PATCH v3 1/2] backlight: lm3630a: fix return code of
 .update_status() callback
Message-ID: <20210621130610.qttglxlstnoigcxw@maple.lan>
References: <20210621122148.116863-1-u.kleine-koenig@pengutronix.de>
 <20210621122148.116863-2-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210621122148.116863-2-u.kleine-koenig@pengutronix.de>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Mon, Jun 21, 2021 at 02:21:47PM +0200, Uwe Kleine-König wrote:
> According to <linux/backlight.h> .update_status() is supposed to
> return 0 on success and a negative error code otherwise. Adapt
> lm3630a_bank_a_update_status() and lm3630a_bank_b_update_status() to
> actually do it.
> 
> While touching that also add the error code to the failure message.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.


> ---
>  drivers/video/backlight/lm3630a_bl.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/backlight/lm3630a_bl.c
> index e88a2b0e5904..7140b0d98082 100644
> --- a/drivers/video/backlight/lm3630a_bl.c
> +++ b/drivers/video/backlight/lm3630a_bl.c
> @@ -190,7 +190,7 @@ static int lm3630a_bank_a_update_status(struct backlight_device *bl)
>  	if ((pwm_ctrl & LM3630A_PWM_BANK_A) != 0) {
>  		lm3630a_pwm_ctrl(pchip, bl->props.brightness,
>  				 bl->props.max_brightness);
> -		return bl->props.brightness;
> +		return 0;
>  	}
>  
>  	/* disable sleep */
> @@ -210,8 +210,8 @@ static int lm3630a_bank_a_update_status(struct backlight_device *bl)
>  	return 0;
>  
>  out_i2c_err:
> -	dev_err(pchip->dev, "i2c failed to access\n");
> -	return bl->props.brightness;
> +	dev_err(pchip->dev, "i2c failed to access (%pe)\n", ERR_PTR(ret));
> +	return ret;
>  }
>  
>  static int lm3630a_bank_a_get_brightness(struct backlight_device *bl)
> @@ -267,7 +267,7 @@ static int lm3630a_bank_b_update_status(struct backlight_device *bl)
>  	if ((pwm_ctrl & LM3630A_PWM_BANK_B) != 0) {
>  		lm3630a_pwm_ctrl(pchip, bl->props.brightness,
>  				 bl->props.max_brightness);
> -		return bl->props.brightness;
> +		return 0;
>  	}
>  
>  	/* disable sleep */
> @@ -287,8 +287,8 @@ static int lm3630a_bank_b_update_status(struct backlight_device *bl)
>  	return 0;
>  
>  out_i2c_err:
> -	dev_err(pchip->dev, "i2c failed to access REG_CTRL\n");
> -	return bl->props.brightness;
> +	dev_err(pchip->dev, "i2c failed to access (%pe)\n", ERR_PTR(ret));
> +	return ret;
>  }
>  
>  static int lm3630a_bank_b_get_brightness(struct backlight_device *bl)
> -- 
> 2.30.2
> 
