Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3977DC433E0
	for <linux-fbdev@archiver.kernel.org>; Tue,  2 Feb 2021 08:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEB9C64EC3
	for <linux-fbdev@archiver.kernel.org>; Tue,  2 Feb 2021 08:29:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbhBBI3U (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 2 Feb 2021 03:29:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbhBBI3R (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 2 Feb 2021 03:29:17 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB441C061573
        for <linux-fbdev@vger.kernel.org>; Tue,  2 Feb 2021 00:28:35 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id m2so1549114wmm.1
        for <linux-fbdev@vger.kernel.org>; Tue, 02 Feb 2021 00:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=bFiTMfrDGaWBCg0p94Ve9DO2sWATZ48G3jOzHUgim7g=;
        b=FBJWMelLQhMEkkiGfS95RqrQWLdNPopNfuEOE3bVIxGKfpwQzmatH39kKmkCK+R/mE
         ZvUxBJXkz7bdlKErQVVoxi1XU4wYu8x5Y5C3HVICYvbeLJE7qDi5AzKix0j6Dyl0fPlA
         RaqGwGzrSDDdtAKpu5J7b8iyrYt+1P7FTQ2MsyQ8xulPyL7sWSBxaI4PlOxlnrtv2XDT
         whS+HWuU5CMrHrjCxXKmxWxTfvVBHyexLGTDyIITFCvjri9PwPCPhlntXiDOoxBlbZ9l
         6cXKT9y1z1e8VoX6qC/Vdf0Z+2Yrh9jJFyi6dEdzDff+dIdrCFcj16HaYFLwju7GauDu
         ktzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=bFiTMfrDGaWBCg0p94Ve9DO2sWATZ48G3jOzHUgim7g=;
        b=A7NEXZ7njdEmMLsi3Gzh4+quViDxQImyhSzadUi769ScARkJ65QZyHuarjd3BCvIGZ
         f+rGKGkQ2bACtBFo7yyL55gJ8X0V2K9AlEEln067DgfRNuiVnAT0q7/WMtDbdtdVNfQs
         9XDo7JJtamVHF/H8u5q8kQmkVk+nyKAa9VF5cNehHsLfg1xPb2cJf74s0SbCI+nUnGV/
         sC8i2xlZuTI1EOxUujagTagaPAZO7UO9zCd7CgLrjGzRBAdzEtXGbXsgWaM8VqvZKGBe
         Ni07j9qzfBBuqf/zWV24zqKtgGgC6Hpl3+rHJfDnwUqgs9MNbZc3aPUxGHUL5HPdaSDR
         Bwdg==
X-Gm-Message-State: AOAM532OTubl4dlB5pv/ykM8JitHue0c5p7Pufa2S+qMsMlnRPrV3/wA
        C+s+xSIpsVrX4brUeC695rFRog==
X-Google-Smtp-Source: ABdhPJxlkgBIS/VbsDJv1LdNt0bSAI4XsoXwQotmWBDepPddTczE/Ide+Q97wd0zG6r/nHPHYmU+3A==
X-Received: by 2002:a1c:9692:: with SMTP id y140mr2471242wmd.128.1612254514666;
        Tue, 02 Feb 2021 00:28:34 -0800 (PST)
Received: from dell ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id l1sm29630262wrp.40.2021.02.02.00.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 00:28:34 -0800 (PST)
Date:   Tue, 2 Feb 2021 08:28:32 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Wenjia Zhao <driverfuzzing@gmail.com>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backlight: pcf50633: pdata may be a null pointer, null
 pointer dereference cause crash
Message-ID: <20210202082832.GA4774@dell>
References: <1612190499-73818-1-git-send-email-driverfuzzing@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1612190499-73818-1-git-send-email-driverfuzzing@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Mon, 01 Feb 2021, Wenjia Zhao wrote:

Please provide a suitable commit messages.

Describe the problem.
Describe the issue was found.
Describe the solution.  

> Signed-off-by: Wenjia Zhao <driverfuzzing@gmail.com>
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

A tab should be 8 chars in Linux.

>  	/*
>  	 * Should be different from bl_props.brightness, so we do not exit

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
