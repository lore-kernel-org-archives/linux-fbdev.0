Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDDACC433F5
	for <linux-fbdev@archiver.kernel.org>; Tue,  7 Sep 2021 13:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5078610C8
	for <linux-fbdev@archiver.kernel.org>; Tue,  7 Sep 2021 13:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344744AbhIGNLS (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 7 Sep 2021 09:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344706AbhIGNLP (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 7 Sep 2021 09:11:15 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E02AC061575
        for <linux-fbdev@vger.kernel.org>; Tue,  7 Sep 2021 06:10:09 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id t18so3618700wrb.0
        for <linux-fbdev@vger.kernel.org>; Tue, 07 Sep 2021 06:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=fRe+EPMUwWj2M5Apqi2GDfNODatGPkQ+oE9vKhc5lu0=;
        b=sn5sYlIFR6j1thAuLuKoDY8+NftEOJsdyEGJEYgwAw1XzkKk8bMhsa7QsOvUP5XGZi
         P0miprH2OD1QYt7XgWV79jRh7aPy1Km1GMddyCRK/Ezqor5WNZNNefN1In41stJ2Ek6i
         EHtcsz+aP4t67QeT6sfens/B/RxJZ8dE/G9/fKGcuIMpreBYP3vKjSsw7NYXzQO36cOx
         KdgQT+JqxEhm11jwDhejXbLySjaWyPSNs2sIFmZShH8vJCEWwq+MisaUXP0E6geY3zuX
         wfy2/wdYqAASVz65NCdRxVeQzDdPIv0SonGEV+Lcul6pEdOxpOPFYFpXqJZQ/Gw6UHyt
         FN8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=fRe+EPMUwWj2M5Apqi2GDfNODatGPkQ+oE9vKhc5lu0=;
        b=XLjhgca7wWJcJY7xXRRdEAcsJcKDSoqwKfmv+Ao6yhDBwQRXN8RE6lZS+El9zZb2Fe
         ii2wXkQuf3nIFArAutnuJzhaRdfJ4zo5Lpo7ug0ACX6Gu2wOrG341QtffH+ygpsld3qn
         6ao9MdOet2KYFackODH/ESZmxskVR+X7Jn20mx8u/hbKdmXsKhVv0Pm5wX39S70rKjxC
         z1ijbYrhILyuGDzI8VLhVHM3tI4naSPWmA3XVfivj48gDXPYCJPBceUY1Xwg3i1rAjxx
         ix3GXqqT4gMamVtkW5dwAbMdIF+YtGQbAD85wCskYtGcmhdzD7+sL4CCyJspolhkaH16
         D/cQ==
X-Gm-Message-State: AOAM531I31JZIt43fkIjSc6DOZwbhufqCFB+KjGJrWKC3cDg1Xzv/QKv
        KSsy2IESuu5xh4KYLdUpHeDs5Q==
X-Google-Smtp-Source: ABdhPJyZW+A8BZFEW9N28JwAelkHJ5S4BMFMip0moUTN7OPQu/LTNoSTNRHuD5+mKvM80vtJWXSobA==
X-Received: by 2002:a5d:4305:: with SMTP id h5mr12597549wrq.4.1631020207896;
        Tue, 07 Sep 2021 06:10:07 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id f3sm2369823wmj.28.2021.09.07.06.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 06:10:07 -0700 (PDT)
Date:   Tue, 7 Sep 2021 14:10:05 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] backlight: propagate errors from get_brightness()
Message-ID: <20210907131005.vvaitvcllbte37zp@maple.lan>
References: <20210907124751.6404-1-linux@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210907124751.6404-1-linux@weissschuh.net>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Tue, Sep 07, 2021 at 02:47:51PM +0200, Thomas Weiﬂschuh wrote:
> backlight.h documents "struct backlight_ops->get_brightness()" to return
> a negative errno on failure.
> So far these errors have not been handled in the backlight core.
> This leads to negative values being exposed through sysfs although only
> positive values are documented to be reported.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


> ---
> 
> v1: https://lore.kernel.org/dri-devel/20210906215525.15418-1-linux@weissschuh.net/
> 
> v1 -> v2:
> * use dev_err() instead of dev_warn() (Daniel Thompson)
> * Finish logging format string with newline (Daniel Thompson)
> * Log errno via dedicated error pointer format (Daniel Thompson)
> 
>  drivers/video/backlight/backlight.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
> index 537fe1b376ad..4658cfb75aa2 100644
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
> +			dev_err(&bd->dev,
> +				"Could not update brightness from device: %pe\n",
> +				ERR_PTR(brightness));
> +	}
>  	mutex_unlock(&bd->ops_lock);
>  	backlight_generate_event(bd, reason);
>  }
> 
> base-commit: 79fad92f2e596f5a8dd085788a24f540263ef887
> -- 
> 2.33.0
> 
