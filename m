Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10DC4C433F5
	for <linux-fbdev@archiver.kernel.org>; Mon, 27 Sep 2021 09:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA8E761157
	for <linux-fbdev@archiver.kernel.org>; Mon, 27 Sep 2021 09:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233664AbhI0Jnm (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 27 Sep 2021 05:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233587AbhI0Jnm (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 27 Sep 2021 05:43:42 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85482C061575
        for <linux-fbdev@vger.kernel.org>; Mon, 27 Sep 2021 02:42:04 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id s21so10610937wra.7
        for <linux-fbdev@vger.kernel.org>; Mon, 27 Sep 2021 02:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AOd3DSSJEh7FjHG/mu9DSVCacQHAVqSPOn9FFZX+TDo=;
        b=bJ/6URt8mZ58hZVR1HRraD8UFutUqCyIH+v76AnMaiuYUB2S78EKqrFdru+Y0ocBuK
         LZWNMwcSxP0OV5mTMvO7iKSIJNxtUw9m9HX9XFp4v/pBjazDAMHgnTKfkxaPE0/XVY6k
         s2S8cIKDq+q1vF1tN90Yb+wVZS5qt/4+vqceeqP55zewqx2SP/JxHD0DMQxmeEJGbR4v
         8I6BY2zWSrFxWFalk8GiZddb0PM5futGtBOBMxVND+EQZnYvG9IXYfI4dlOjtJZa7d6q
         TPnt8KHEDorwbB2g3MvMxUfLhm/KFi5SmBrpthYt9lwo9FTS1a1yyesI99YeDT//PzJj
         oCAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AOd3DSSJEh7FjHG/mu9DSVCacQHAVqSPOn9FFZX+TDo=;
        b=nF+JsZYSqeKV0BAEjodJqErkT9422bNlOL5jwZ0ZKCPNPtQDkEAD9V8z8ndx2Qf64e
         KmxNuXOYHIaMX96F5tGbJY7grg3gMEhgchy6+RvfkuDgXBwAlg1MzWt5zH/bBLm+cy0F
         nsPtTIHcRr/t6wbPlSF5UeRfBL5+HIpkbPkF+b6lpidXeUKuBjt/ZGTCMLfezUDA/cip
         sIxNUuPd+xKnXRGZKjBCi4q22fJ4MIp6fFThI1Wj6eEy1+iWv7RJV6edgrQDQPy+nwmT
         1dHu6G0CGy+we2PgVWxO3WE2bRStqrgXok2RGmtRgIDU+euqwEJOPIfkO9ABkTYdyNj+
         Km8w==
X-Gm-Message-State: AOAM533rdFCkkt/gaFpU393VPmtRDSs0+NIQ+WXAA02/tkWWZZ5iAH2w
        ni8wlpSrOM+ht6lqBSREfGqQh0/pcllCHsHI
X-Google-Smtp-Source: ABdhPJwuBfuf1mGVJGpqb6JLQPeqaPjF7TGxssF9xcq1RpummfDkKDco8qTM4I+v2BUXVl9U/SqDJw==
X-Received: by 2002:adf:f94b:: with SMTP id q11mr16116559wrr.408.1632735723038;
        Mon, 27 Sep 2021 02:42:03 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id z79sm16927330wmc.17.2021.09.27.02.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 02:42:02 -0700 (PDT)
Date:   Mon, 27 Sep 2021 10:42:00 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH] backlight: hx8357: Add SPI device ID table
Message-ID: <20210927094200.a7d73sl2k4x5xjch@maple.lan>
References: <20210922151014.49719-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210922151014.49719-1-broonie@kernel.org>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, Sep 22, 2021 at 04:10:14PM +0100, Mark Brown wrote:
> Currently autoloading for SPI devices does not use the DT ID table, it uses
> SPI modalises. Supporting OF modalises is going to be difficult if not
> impractical, an attempt was made but has been reverted, so ensure that
> module autoloading works for this driver by adding a SPI device ID table.
> 
> Fixes: 96c8395e2166 ("spi: Revert modalias changes")
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  drivers/video/backlight/hx8357.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/video/backlight/hx8357.c b/drivers/video/backlight/hx8357.c
> index 9b50bc96e00f..c64b1fbe027f 100644
> --- a/drivers/video/backlight/hx8357.c
> +++ b/drivers/video/backlight/hx8357.c
> @@ -565,6 +565,19 @@ static struct lcd_ops hx8357_ops = {
>  	.get_power	= hx8357_get_power,
>  };
>  
> +static const struct spi_device_id hx8357_spi_ids[] = {
> +	{
> +		.name = "hx8357",
> +		.driver_data = (kernel_ulong_t)hx8357_lcd_init,

Based on this I had expected to find spi_get_device_id() and a ->driver_data
somewhere in this patch.

Where will this .driver_data be consumed? 


Daniel.


> +	},
> +	{
> +		.name = "hx8369",
> +		.driver_data = (kernel_ulong_t)hx8369_lcd_init,
> +	},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(spi, hx8357_spi_ids);
> +
>  static const struct of_device_id hx8357_dt_ids[] = {
>  	{
>  		.compatible = "himax,hx8357",
> @@ -672,6 +685,7 @@ static struct spi_driver hx8357_driver = {
>  		.name = "hx8357",
>  		.of_match_table = hx8357_dt_ids,
>  	},
> +	.id_table = hx8357_spi_ids,
>  };
>  
>  module_spi_driver(hx8357_driver);
> -- 
> 2.20.1
> 
