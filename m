Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A10C07E9C
	for <linux-fbdev@archiver.kernel.org>; Fri,  9 Jul 2021 11:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF46961351
	for <linux-fbdev@archiver.kernel.org>; Fri,  9 Jul 2021 11:03:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbhGILGD (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 9 Jul 2021 07:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbhGILGD (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Fri, 9 Jul 2021 07:06:03 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9021FC0613DD
        for <linux-fbdev@vger.kernel.org>; Fri,  9 Jul 2021 04:03:19 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id t14-20020a05600c198eb029020c8aac53d4so24764698wmq.1
        for <linux-fbdev@vger.kernel.org>; Fri, 09 Jul 2021 04:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=yUs8PRqylG5pw2F+BSj/uHB4lBzrI+dmhEpI9HrKsag=;
        b=NYu6MKv1ag5T/qtvOwA/cfvzMKCB5yuwT5NiD6948QjCdLPrGjv0KsU4OvGQV67iP/
         a/AHnu7lGmAKDDtYJMcjn9n6LBofnmB0biDO529GkiieIDco/Ik80e2BjJNc4zack0+X
         ViAtQMG+4IDkQGuWEQ3/K0k2ehkLa/SQEIxxK/RFugV0cCM4T9AhKFEzG8kDTk9TflnD
         fhyOvykMho/pOxVI+Gatlsj4yypkMMyGqujiHDaLqPaIXSEE+hAvI99TomM9PymBjVcT
         faVdx8Bh1QbOhcSv1RNKlBmnRXcblW67iM/jObcqLHHOi4iYQtXXHeyJN8DbjoJbJkA7
         mf6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=yUs8PRqylG5pw2F+BSj/uHB4lBzrI+dmhEpI9HrKsag=;
        b=Bqz337hCvjGa1A/roluUSXZod073mUMtcvjjVhM/BM0sHbO1VdVJBft9nyejleLVJ6
         gJ84t0YhR60N980MqfI//QPkr2r/8wZoNJm0Vz+sO/7855Qcwqgcti+CPwDeFt/ya11f
         FujqjvghI8TAmDDVTELeEpcfyUGjk88JUpFsyz1vvaOEsK5ss8ht0KnkNb3d50BAVPV4
         ib8fP5wGxnB5pdGl695W8Uz/GmThzf5zHIdoo+qqKrj/Xv5tz/0emdqjXoUgDXWhkWnc
         6yF17Jax6lgJm7dwTrD0nL8XcpGw2QzSX38+ICynk57zAtOyLx9d0rlpo3xX8QSoxKae
         aaug==
X-Gm-Message-State: AOAM533nIDEZ3ULJYGTbcKz7vC/UT/7SDlxoxz9IkAaKCDNwb1oz4vG0
        jGAC2cdzQTV/bxAMuamFZ4FUvw==
X-Google-Smtp-Source: ABdhPJyZQQZc0WhhxvN/Ijm638MsRc29LHo+mO3AHTNG3zDfdq5v1bDjYbFsAwqY6Suc0lXW4MlnuQ==
X-Received: by 2002:a1c:7ec3:: with SMTP id z186mr38687689wmc.83.1625828598023;
        Fri, 09 Jul 2021 04:03:18 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id v206sm4176653wmg.37.2021.07.09.04.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 04:03:17 -0700 (PDT)
Date:   Fri, 9 Jul 2021 12:03:15 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Marek Vasut <marex@denx.de>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Meghana Madhyastha <meghana.madhyastha@gmail.com>,
        Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Sean Paul <seanpaul@chromium.org>,
        Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH] video: backlight: Only set maximum brightness for
 gpio-backlight
Message-ID: <20210709110315.vv5hbngg26o4vj63@maple.lan>
References: <20210708091058.56317-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210708091058.56317-1-marex@denx.de>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Thu, Jul 08, 2021 at 11:10:58AM +0200, Marek Vasut wrote:
> The note in c2adda27d202f ("video: backlight: Add of_find_backlight helper
> in backlight.c") says that gpio-backlight uses brightness as power state.
> Other backlight drivers do not, so limit this workaround to gpio-backlight.
> 
> This fixes the case where e.g. pwm-backlight can perfectly well be set to
> brightness 0 on boot in DT, which without this patch leads to the display
> brightness to be max instead of off.
> 
> Fixes: c2adda27d202f ("video: backlight: Add of_find_backlight helper in backlight.c")
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Meghana Madhyastha <meghana.madhyastha@gmail.com>
> Cc: Noralf Trønnes <noralf@tronnes.org>
> Cc: Sean Paul <seanpaul@chromium.org>
> Cc: Thierry Reding <treding@nvidia.com>

I have to admit that this patch really does makes it clear just how
nasty the hack in of_find_backlight() currently is.

Moreover I think it is also be obsolete. gpio-backlight power mode
handling was pretty broken when this code was introduced. It was fixed
in 2019 by ec665b756e6f ("backlight: gpio backlight: Correct initial
power state handling") by trying to match the behaviour of PWM
backlight.  The new code always sets the brightness to 1 so I think we
can just remove the hack from of_find_backlight() since I think it is
unreachable.


Daniel.



> ---
>  drivers/video/backlight/backlight.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
> index 537fe1b376ad7..dfb66171dec41 100644
> --- a/drivers/video/backlight/backlight.c
> +++ b/drivers/video/backlight/backlight.c
> @@ -676,6 +676,7 @@ EXPORT_SYMBOL(of_find_backlight_by_node);
>  static struct backlight_device *of_find_backlight(struct device *dev)
>  {
>  	struct backlight_device *bd = NULL;
> +	bool is_gpio_backlight = false;
>  	struct device_node *np;
>  
>  	if (!dev)
> @@ -685,6 +686,8 @@ static struct backlight_device *of_find_backlight(struct device *dev)
>  		np = of_parse_phandle(dev->of_node, "backlight", 0);
>  		if (np) {
>  			bd = of_find_backlight_by_node(np);
> +			is_gpio_backlight =
> +				of_device_is_compatible(np, "gpio-backlight");
>  			of_node_put(np);
>  			if (!bd)
>  				return ERR_PTR(-EPROBE_DEFER);
> @@ -692,7 +695,7 @@ static struct backlight_device *of_find_backlight(struct device *dev)
>  			 * Note: gpio_backlight uses brightness as
>  			 * power state during probe
>  			 */
> -			if (!bd->props.brightness)
> +			if (is_gpio_backlight && !bd->props.brightness)
>  				bd->props.brightness = bd->props.max_brightness;
>  		}
>  	}
> -- 
> 2.30.2
