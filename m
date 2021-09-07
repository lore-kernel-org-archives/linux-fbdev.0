Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1244BC433EF
	for <linux-fbdev@archiver.kernel.org>; Tue,  7 Sep 2021 09:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2D4360F25
	for <linux-fbdev@archiver.kernel.org>; Tue,  7 Sep 2021 09:31:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbhIGJdA (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 7 Sep 2021 05:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbhIGJc7 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 7 Sep 2021 05:32:59 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90323C061757
        for <linux-fbdev@vger.kernel.org>; Tue,  7 Sep 2021 02:31:53 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id i3so6317995wmq.3
        for <linux-fbdev@vger.kernel.org>; Tue, 07 Sep 2021 02:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=AqCBcpOKIxaebNIokP1AWBP6ZbSBum5V1BZ707Wyq8E=;
        b=Dwk4JEWWYgCYK7blSsU8LQW0rDzpzhFhAxeuq3wDz3+XejZ1XNJVCvUvhGMPzkQBbK
         hNvSVNdQZ1J67BTL+JT3z5IPD/gfrk5oLhuHwVrDLLB9l+4fYT7OsAiAXgElk7VcFimw
         C4nxfRf8CWVE+gwn0qqZ+Ktlw56o6kS34lIDEZ22R4SFhcZofZmImejrlLpf96KDD7DI
         MNz8v5EoniqHVbMPEuSQ7kkCvHk6XStFzNCzYVAWIpDu9+Pvkxnf8Nqdf3NK3KiZny55
         QGGMfKUkQjrsJMnSUcetQ/lXgEpa/BZZGGuA9Nz/mWWj4nmTjv+mwXdgN76nYKZYnXxZ
         Wuww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=AqCBcpOKIxaebNIokP1AWBP6ZbSBum5V1BZ707Wyq8E=;
        b=QeF916ngc9G37Ecz8xHUgOrln5TvYCqp9isVPN2GMxbYImDTw6TM+V2chY4jK9+lri
         OEGMq9NBd7r8uzl+j8Cf1C1m3G8zqy9Awa1lGHPJs2v5QwLQdDbf3xpEqmdQfkzSKnla
         Rtq9iChKbOR8pYi33PhpVCinLNsYl/C3UG9lnr5OWB+ZaXWKC58wC9M8/cNE3lwpMukA
         /ueGRJsIExg1dyaHqSSCiJUoeoXUuvLfNA8Kra4yCkP9jDeDtjz0CWIQuQ8qrTFDcvZg
         Hzxs4c2qBlqlhQ6QNZmLAS59aL2C2tRDrzFXfTXPHi2tfM8MVDnhzdePqMDbbLGIpt6e
         06yw==
X-Gm-Message-State: AOAM530hh2tqW0o9XrhzIZwT884okt8nkLyIsfllMv7a54fxed9Hk4eS
        0UVdsLcnNbamyd1Q3UXvDxB7JA==
X-Google-Smtp-Source: ABdhPJz0j9H3loRG3Z9thA8ApTEszOgaQ+1fEKo5SFusKiSgqd/P1ZoCuwReB4WAx9eOP6pYg0SWoA==
X-Received: by 2002:a1c:f206:: with SMTP id s6mr2885572wmc.15.1631007112023;
        Tue, 07 Sep 2021 02:31:52 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id y24sm2202846wma.9.2021.09.07.02.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 02:31:51 -0700 (PDT)
Date:   Tue, 7 Sep 2021 10:31:49 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backlight: propagate errors from get_brightness()
Message-ID: <20210907093149.2sk3d2jsrekearpa@maple.lan>
References: <20210906215525.15418-1-linux@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210906215525.15418-1-linux@weissschuh.net>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Mon, Sep 06, 2021 at 11:55:25PM +0200, Thomas Weiﬂschuh wrote:
> backlight.h documents "struct backlight_ops->get_brightness()" to return
> a negative errno on failure.
> So far these errors have not been handled in the backlight core.
> This leads to negative values being exposed through sysfs although only
> positive values are documented to be reported.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>

Change looks good overall but I've raised a few quibbles about the new
error message below.


> ---
>  drivers/video/backlight/backlight.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
> index 537fe1b376ad..d681962f8509 100644
> --- a/drivers/video/backlight/backlight.c
> +++ b/drivers/video/backlight/backlight.c
> @@ -292,10 +292,13 @@ static ssize_t actual_brightness_show(struct device *dev,
>  	struct backlight_device *bd = to_backlight_device(dev);
>  
>  	mutex_lock(&bd->ops_lock);
> -	if (bd->ops && bd->ops->get_brightness)
> -		rc = sprintf(buf, "%d\n", bd->ops->get_brightness(bd));
> -	else
> +	if (bd->ops && bd->ops->get_brightness) {
> +		rc = bd->ops->get_brightness(bd);
> +		if (rc >= 0)
> +			rc = sprintf(buf, "%d\n", rc);
> +	} else {
>  		rc = sprintf(buf, "%d\n", bd->props.brightness);
> +	}
>  	mutex_unlock(&bd->ops_lock);
>  
>  	return rc;
> @@ -381,9 +384,18 @@ ATTRIBUTE_GROUPS(bl_device);
>  void backlight_force_update(struct backlight_device *bd,
>  			    enum backlight_update_reason reason)
>  {
> +	int brightness;
> +
>  	mutex_lock(&bd->ops_lock);
> -	if (bd->ops && bd->ops->get_brightness)
> -		bd->props.brightness = bd->ops->get_brightness(bd);
> +	if (bd->ops && bd->ops->get_brightness) {
> +		brightness = bd->ops->get_brightness(bd);
> +		if (brightness >= 0)
> +			bd->props.brightness = brightness;
> +		else
> +			dev_warn(&bd->dev,
> +				 "Could not update brightness from device: errno = %d",
> +				 -brightness);

The format string is missing a \n and should it really be a dev_warn()?
Is dev_err() more appropriate?

Also please print the error symbolically (which is self explaining
meaning we don't need the errno prefix):

		"Could not update brightness from device: %pe\n",
		ERR_PTR(brightness)



Daniel.


> +	}
>  	mutex_unlock(&bd->ops_lock);
>  	backlight_generate_event(bd, reason);
>  }
> 
> base-commit: 79fad92f2e596f5a8dd085788a24f540263ef887
> -- 
> 2.33.0
> 
