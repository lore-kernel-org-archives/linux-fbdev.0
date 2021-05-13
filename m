Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17DB4C433B4
	for <linux-fbdev@archiver.kernel.org>; Thu, 13 May 2021 10:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD5A16143E
	for <linux-fbdev@archiver.kernel.org>; Thu, 13 May 2021 10:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbhEMKi7 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 13 May 2021 06:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbhEMKi6 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 13 May 2021 06:38:58 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0448C061574
        for <linux-fbdev@vger.kernel.org>; Thu, 13 May 2021 03:37:48 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id b19-20020a05600c06d3b029014258a636e8so4426834wmn.2
        for <linux-fbdev@vger.kernel.org>; Thu, 13 May 2021 03:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8MRW+RUNJca4AXa5eHgAo8GAC0ZpSS8t7RdPzv49j74=;
        b=B0gbejrpLRfJnc7OaHsvMS1QG7k7XLm1B6NA5cayaUI06UjWco1rLnhAee8TPlEsR9
         79AZv5M633+8rl0sKu5uH7Al0KyzlWejVWvOm2eTc4HRIOhDOynreJ9KATnRnd1BsOCt
         eSp/VhInDLsmakAqEHgBYSDOckMIGwrLNo3ufADJrB+ElQsMpTLL6zUbSXuhm62XSyII
         Eqc1UT+YS71HYtLU977IyIbFDY+y1ZNvApNRrXJcbYCMjrZYxdGyclZaSu6KaqY2zrK5
         nt2hAujitIAuD47AfiArnounyddMEmb3fMh8MndjQMENjuL9G4ilVYa13saRTEgJN0Qy
         j1eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8MRW+RUNJca4AXa5eHgAo8GAC0ZpSS8t7RdPzv49j74=;
        b=fNqB/sQHDIL4UoSTgvqa4ogJfOo15n2/19uMpZ77jhXT3X6Y5euwUPLcjrGk2yxcXe
         D6FFL1AKsO7vR4uk8O36OUWC2lpg93sUllyqMyJRVercekMgiF+6onR8rl9uOwclU9Wk
         9+NrvyxcbOewdoV0DVI/KyDqdxgNQpMN8/2AX7OG7ay+ELXEHQLjXajJiPklX0IPM8Kh
         A9MrH4eSdbRsanTqEeM2UTcB4quGw8K3NHMb+C+WN2hsOlVBLENnkVEGuKreBWH5QtTP
         GvicK61eiicbMYeGzjfUVGDxJA9wSxHRMwTn1IbLYBJHAyHXe8X0SwcY6YQ/b3z1/PnM
         JF7g==
X-Gm-Message-State: AOAM532SkuACbUr2xFA9CraywbLdeeJcj+rnIBmFbiwVq7joDRc1a1Ko
        Hyfbw0uw1DLWyXA8lMYvFT0Hvg==
X-Google-Smtp-Source: ABdhPJxkdOua6E6ia1U9hG/mRkJmaLRXHDGr+I8c7GOqimHlksaxK1gjHzcXbYjFWt/DNACfe855qw==
X-Received: by 2002:a7b:c252:: with SMTP id b18mr43936215wmj.32.1620902267606;
        Thu, 13 May 2021 03:37:47 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id m6sm2417459wrp.29.2021.05.13.03.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 03:37:47 -0700 (PDT)
Date:   Thu, 13 May 2021 11:37:45 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jingoo Han <jingoohan1@gmail.com>,
        Brian Masney <masneyb@onstation.org>,
        Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH v1 1/1] backlight: lm3630a_bl: Put fwnode in error case
 during ->probe()
Message-ID: <20210513103745.2dzawk7c63ku2vz6@maple.lan>
References: <20210510095716.3302910-1-andy.shevchenko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210510095716.3302910-1-andy.shevchenko@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Mon, May 10, 2021 at 12:57:16PM +0300, Andy Shevchenko wrote:
> device_for_each_child_node() bumps a reference counting of a returned variable.
> We have to balance it whenever we return to the caller.
> 
> Fixes: 8fbce8efe15cd ("backlight: lm3630a: Add firmware node support")
> Cc: Brian Masney <masneyb@onstation.org>
> Cc: Dan Murphy <dmurphy@ti.com>
> Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


> ---
>  drivers/video/backlight/lm3630a_bl.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/backlight/lm3630a_bl.c
> index e88a2b0e5904..662029d6a3dc 100644
> --- a/drivers/video/backlight/lm3630a_bl.c
> +++ b/drivers/video/backlight/lm3630a_bl.c
> @@ -482,8 +482,10 @@ static int lm3630a_parse_node(struct lm3630a_chip *pchip,
>  
>  	device_for_each_child_node(pchip->dev, node) {
>  		ret = lm3630a_parse_bank(pdata, node, &seen_led_sources);
> -		if (ret)
> +		if (ret) {
> +			fwnode_handle_put(node);
>  			return ret;
> +		}
>  	}
>  
>  	return ret;
> -- 
> 2.31.1
> 
