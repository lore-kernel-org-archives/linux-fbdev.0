Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56AADC48BC2
	for <linux-fbdev@archiver.kernel.org>; Mon, 21 Jun 2021 10:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FDFC611C1
	for <linux-fbdev@archiver.kernel.org>; Mon, 21 Jun 2021 10:23:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbhFUK0K (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 21 Jun 2021 06:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbhFUK0J (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 21 Jun 2021 06:26:09 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5AFC061574
        for <linux-fbdev@vger.kernel.org>; Mon, 21 Jun 2021 03:23:55 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id a11so19010326wrt.13
        for <linux-fbdev@vger.kernel.org>; Mon, 21 Jun 2021 03:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=oiKVdmJOnVuPvDX95e842EXPabwHvh6iizPWqy5O4cs=;
        b=uWF9SfuZfnwNkSZw5Cp0c3l2zOmGbMqlhxp2YX0gLtPVFoa+/o89ayPaAl8wAI2UPj
         8FPFc59d7ZeeE5RcxZV0KQpfyASOO/DOxr3T7fRVdiL8xfGTMsr5lcgELYZ+aKR4vaxI
         d/GkuP+6C/kqb3uRqTw563MqnDryNEtm2d5gqUWHDPhRlZ+ySRTeqlE1nKHYiSQlDJeu
         lwg/olZTjDFm4wiYKu74YdwEDvqFjOiGFGaD9StboJ8cYG1FjiqMjlxLE8zZ0jdBcukq
         ojZ5HLdxjMizPNgNNGh3N9yQvZvPZk8wHkUwBnlQAH9r4FZHLgI9sGyU9Y4+24uuMnBZ
         R1Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=oiKVdmJOnVuPvDX95e842EXPabwHvh6iizPWqy5O4cs=;
        b=gDV3lR42jeaD/fvWhR1bLJLFL/P7IafP88kybueAP2MepzF342lKAh/1yQysts8LCu
         yeT1DhnwIs8/xTA3YZ0zcEKF8IakBPg4FZjnOMrlM6bs/3RlvUfrElUEkM/W9pUuIzOh
         MSVqIx4hSrSQ7hG5JFdHHlyh47UMwaE7FfzCiG03N00/9PbfvTgSXc+WpOyBFAL9xiMY
         IkUGbjBIvohaOST55PK1vrB2KBsCBWJgSHlOFiduwynSKVI08vn/cVwZHZQ9W5R+cp27
         L5aP/znRmtHAvbnP433znnuQP+GOAmFGpbRC/AsinFCPLvge43SkdrFuzanGw+DhACK+
         hCKA==
X-Gm-Message-State: AOAM5331kxyleVnGXbuUmJW5EtBFyzLvEB301c0AW0qC1I3MfqvWH8OB
        Y1LfwX5s5mvCfYbHIoRi1WPTNA==
X-Google-Smtp-Source: ABdhPJyE5bHZgsVdfdJv6AqwKtG5oeiVjg5mqAlQ2MLSnSagaYHt7MonCyQJqu3Ku62Q6Z4QkYETgw==
X-Received: by 2002:a5d:488a:: with SMTP id g10mr17079859wrq.402.1624271033599;
        Mon, 21 Jun 2021 03:23:53 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id u15sm18477761wmq.48.2021.06.21.03.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 03:23:53 -0700 (PDT)
Date:   Mon, 21 Jun 2021 11:23:51 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@pengutronix.de, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 1/2] backlight: lm3630a: fix return code of
 .update_status() callback
Message-ID: <20210621102351.45m2oznsmg5nfv6t@maple.lan>
References: <20210620193928.14467-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210620193928.14467-1-u.kleine-koenig@pengutronix.de>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Sun, Jun 20, 2021 at 09:39:27PM +0200, Uwe Kleine-König wrote:
> According to <linux/backlight.h> .update_status() is supposed to
> return 0 on success and a negative error code otherwise. Adapt
> lm3630a_bank_a_update_status() to actually do it.
> 
> While touching that also add the error code to the failure message.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Thanks for this!

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.


> ---
>  drivers/video/backlight/lm3630a_bl.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/backlight/lm3630a_bl.c
> index e88a2b0e5904..16a2658a72e1 100644
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
> 
> base-commit: 6efb943b8616ec53a5e444193dccf1af9ad627b5
> -- 
> 2.30.2
> 
