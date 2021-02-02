Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07DE1C433DB
	for <linux-fbdev@archiver.kernel.org>; Tue,  2 Feb 2021 09:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E02F64E9B
	for <linux-fbdev@archiver.kernel.org>; Tue,  2 Feb 2021 09:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232924AbhBBJ0a (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 2 Feb 2021 04:26:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232874AbhBBJ00 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 2 Feb 2021 04:26:26 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7EC9C0613ED
        for <linux-fbdev@vger.kernel.org>; Tue,  2 Feb 2021 01:25:45 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id l12so19649890wry.2
        for <linux-fbdev@vger.kernel.org>; Tue, 02 Feb 2021 01:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=a1OCFu7h0TcIowMDv7zHkZMNSiLVb4YwniBrbKA3xlU=;
        b=uF0X2tH0q3rC8OeRvULloT49lCKeBEQIIw6QI9tlhujC4RF3Y6JwL4phRurV64uvih
         vIy/Bkwwwa+OwUknuhm87RzJbo3TmKLf4F4bTWnWohj0xvbesjcgJf0vvzfBB/IuDpr2
         T5sGY0IN4mRqFiNIkf4AjHGbM1BMcLte31RgDWX4v3q3MchbIgY1ke2jBZT8K57WRNa5
         pIM1hekoQS2WUKBuoyDGNSrnzcifBgBLcCwgYgsxQpKhEok5Eamv5Ksvda7NJQk69CUw
         d2ITCAYRN0sV3AErdVtbrN7+deweE3u94fcS9QmF00PXgEkmZJ1YQlK7NALcXBFTO2LM
         R6bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a1OCFu7h0TcIowMDv7zHkZMNSiLVb4YwniBrbKA3xlU=;
        b=DVdReqyHHbJnZqH+/TRf6zr/dnLudzJ/uK83mu5xxftggZJ+yreQ3AakBIWpYN31Y0
         dGi1ZFVqzNExNtR2DsYhgPKe353+PBfZVvNl3QE9rdUOLmjJH0oLk6b1tkcI8xgtkeSo
         knIG9sn5ZxQBspsMSFGCxaK5qT2iCQb9RaF2fIgdAd4+Iiu7OKL+iEGdy/6uibqaVWHL
         GHq+RJIzAhACIk71CkZg1cy/nJuK2o+Qfb78H0xE0yRdoy9dXr/HqnWvM/L6zDI7gCCG
         dWCQfVHUpZZLOi3s6rQ0vxhpVXDjd8wosZcbtUsxRaS6e3DoN9cIXNO50gnDNbuRRHyR
         8Bqg==
X-Gm-Message-State: AOAM531ltCfBa2MNLN1UAF4R4y8UijXpdeY42NzMrBs8Zz+dYMazOWfX
        CO9WDGVdY3GcCSkAhdYnN6HipA==
X-Google-Smtp-Source: ABdhPJy7kfZ4o7WstsegOSMCSFJFOfW1Ibzofjf5AFjyCjsHJFeZ5+FIwpQN0elV9b07P6x7DgPmdw==
X-Received: by 2002:adf:fc8a:: with SMTP id g10mr23343632wrr.189.1612257944619;
        Tue, 02 Feb 2021 01:25:44 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id q24sm2040048wmq.24.2021.02.02.01.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 01:25:43 -0800 (PST)
Date:   Tue, 2 Feb 2021 09:25:41 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Wenjia Zhao <driverfuzzing@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backlight: pcf50633: pdata may be a null pointer, null
 pointer dereference cause crash
Message-ID: <20210202092541.2wvzpe53mavrd47x@maple.lan>
References: <1612190499-73818-1-git-send-email-driverfuzzing@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612190499-73818-1-git-send-email-driverfuzzing@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Mon, Feb 01, 2021 at 08:41:38AM -0600, Wenjia Zhao wrote:
> Signed-off-by: Wenjia Zhao <driverfuzzing@gmail.com>

There should be a patch description here explaining why the patch
is needed and how it works.


> ---
>  drivers/video/backlight/pcf50633-backlight.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/video/backlight/pcf50633-backlight.c b/drivers/video/backlight/pcf50633-backlight.c
> index 540dd338..43267af 100644
> --- a/drivers/video/backlight/pcf50633-backlight.c
> +++ b/drivers/video/backlight/pcf50633-backlight.c
> @@ -127,7 +127,8 @@ static int pcf50633_bl_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, pcf_bl);
>  
> -	pcf50633_reg_write(pcf_bl->pcf, PCF50633_REG_LEDDIM, pdata->ramp_time);
> +  if (pdata)
> +    pcf50633_reg_write(pcf_bl->pcf, PCF50633_REG_LEDDIM, pdata->ramp_time);

Assuming you found this issue using a static analyzer then I think it
might be better to if an "if (!pdata) return -EINVAL" further up the
file instead.

In other words it is better to "document" (via the return code) that the
code does not support pdata == NULL than to add another untested code
path.


Daniel.
