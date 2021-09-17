Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 452F8C433F5
	for <linux-fbdev@archiver.kernel.org>; Fri, 17 Sep 2021 09:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 257DA61100
	for <linux-fbdev@archiver.kernel.org>; Fri, 17 Sep 2021 09:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239006AbhIQJT7 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 17 Sep 2021 05:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239061AbhIQJTI (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 17 Sep 2021 05:19:08 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F41F8C061574
        for <linux-fbdev@vger.kernel.org>; Fri, 17 Sep 2021 02:17:32 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id c190-20020a1c9ac7000000b0030b459ea869so917771wme.4
        for <linux-fbdev@vger.kernel.org>; Fri, 17 Sep 2021 02:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4hOBpaSYMnA8iXHA1EVV20O7A0NeSkpoXYY1w1e2akY=;
        b=Na9BN6IXqEtILfxmjrbI3/Guf6JjAUedlnkEhGnoF/Z/L/QUMo24uTQOQykju7rAJa
         qxgoYwhQtDdLb+ouAUxb1uSgjJ60x6y8lkcHjOMBowX3lJ8x4LmDVsrFQXvjF9dtFChO
         V0s6lbPs+4YIJhJU4/N5tLNF7zn8kD2aBeYxM2XAPuLBVab7e4I04M1b8JGBoY31qCpO
         jSS3YqhBnndDMJw3YyruplpahsrLm/8mrB7CJ0VOVbFwW7PuQ/z7x2nHd8/szYct2xgO
         x6UKZYIDamnV2wxI5Q55kHnoiHYWcvH1qmJjw23ccIVEhAAlI5mtjwiX/ManbS4UaONg
         J9FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4hOBpaSYMnA8iXHA1EVV20O7A0NeSkpoXYY1w1e2akY=;
        b=l4MDXtqVvgpfet2QJZMqUIDiu4aNbHyqj9gruy8uMEBHbLyljgwPoJRkBnJ1hSy4ym
         3k5stb1KAf7M2OMx/E4hvQo0aQH2SfALjd0v8rDuTXHChYbsYBHQm8HtDs58ilPhl7BM
         26P99KEx7icNkTjNwRHFQI0jODjR/jOG/nIcpnUCYPEvN4Ka13bpWLErM55gZKYTfL1/
         7DNfAAVl/iQNIP0gqxZeSfEcBXuA56vcLFDhlcNtzOI4ehQu/rsH4dda7lXG5d+jFB0H
         0N1IJdvWnPtqugtBlH1kLVM/cBIt/Z4BZkhbtSra0BZjW1xeVUYea/1BbCmRmkD9NuPa
         rNKw==
X-Gm-Message-State: AOAM531RR5kVAQMKholM4Ph5WgjCYlqz9/9fffDU8Yq4K5UBUbJ+rsz4
        ehr5kvxAqAABEYLSmQkoHx5ETg==
X-Google-Smtp-Source: ABdhPJzhBBPiZwBw7BzkhtCwaxmD5I1QXsXhSnrh+ezZgcIWQXpUb03mSpfeLbcpKpnFo+XTe0eYXA==
X-Received: by 2002:a7b:cb45:: with SMTP id v5mr13647501wmj.184.1631870251485;
        Fri, 17 Sep 2021 02:17:31 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id p4sm5716272wmg.16.2021.09.17.02.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 02:17:30 -0700 (PDT)
Date:   Fri, 17 Sep 2021 10:17:29 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] backlight: bd6107: Make use of the helper function
 dev_err_probe()
Message-ID: <20210917091729.elpngrzpvmp43wns@maple.lan>
References: <20210917031308.17623-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210917031308.17623-1-caihuoqing@baidu.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Fri, Sep 17, 2021 at 11:13:06AM +0800, Cai Huoqing wrote:
> When possible use dev_err_probe help to properly deal with the
> PROBE_DEFER error, the benefit is that DEFER issue will be logged
> in the devices_deferred debugfs file.
> Using dev_err_probe() can reduce code size, and the error value
> gets printed.
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>

Change seems OK but does this really need to be done one file at a time?
I'd prefer to see all of backlight handled in one go (given the scope of
this change if applied across the kernel it needs automatic tooling
anyway).


Daniel.


> ---
>  drivers/video/backlight/bd6107.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/video/backlight/bd6107.c b/drivers/video/backlight/bd6107.c
> index 515184fbe33a..e21b793302a2 100644
> --- a/drivers/video/backlight/bd6107.c
> +++ b/drivers/video/backlight/bd6107.c
> @@ -120,7 +120,6 @@ static int bd6107_probe(struct i2c_client *client,
>  	struct backlight_device *backlight;
>  	struct backlight_properties props;
>  	struct bd6107 *bd;
> -	int ret;
>  
>  	if (pdata == NULL) {
>  		dev_err(&client->dev, "No platform data\n");
> @@ -148,11 +147,9 @@ static int bd6107_probe(struct i2c_client *client,
>  	 * the reset.
>  	 */
>  	bd->reset = devm_gpiod_get(&client->dev, "reset", GPIOD_OUT_HIGH);
> -	if (IS_ERR(bd->reset)) {
> -		dev_err(&client->dev, "unable to request reset GPIO\n");
> -		ret = PTR_ERR(bd->reset);
> -		return ret;
> -	}
> +	if (IS_ERR(bd->reset))
> +		return dev_err_probe(&client->dev, PTR_ERR(bd->reset),
> +				     "unable to request reset GPIO\n");
>  
>  	memset(&props, 0, sizeof(props));
>  	props.type = BACKLIGHT_RAW;
> @@ -164,10 +161,9 @@ static int bd6107_probe(struct i2c_client *client,
>  					      dev_name(&client->dev),
>  					      &bd->client->dev, bd,
>  					      &bd6107_backlight_ops, &props);
> -	if (IS_ERR(backlight)) {
> -		dev_err(&client->dev, "failed to register backlight\n");
> -		return PTR_ERR(backlight);
> -	}
> +	if (IS_ERR(backlight))
> +		return dev_err_probe(&client->dev, PTR_ERR(backlight),
> +				     "failed to register backlight\n");
>  
>  	backlight_update_status(backlight);
>  	i2c_set_clientdata(client, backlight);
> -- 
> 2.25.1
> 
