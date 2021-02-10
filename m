Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30515C433E6
	for <linux-fbdev@archiver.kernel.org>; Wed, 10 Feb 2021 08:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D11F660231
	for <linux-fbdev@archiver.kernel.org>; Wed, 10 Feb 2021 08:24:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233745AbhBJIYg (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 10 Feb 2021 03:24:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232776AbhBJIYZ (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 10 Feb 2021 03:24:25 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4308CC061574
        for <linux-fbdev@vger.kernel.org>; Wed, 10 Feb 2021 00:23:45 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id b3so1451444wrj.5
        for <linux-fbdev@vger.kernel.org>; Wed, 10 Feb 2021 00:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=MJzRoK5AHHgr8V25vpyceNTWmZxiFyKsyjhqQm8Vxxc=;
        b=d/b3ponHrtEaGh9+nR4CHVGjqOHtnpraE5raOOOMutWd3Y/vW/uw1i/PmwjfcCAOlI
         hSBPogoT7cAULj0g3PmoKbO+SoDAWMPSOECHnT1Hf4DW/HG3NgCZs5Oz4yycpbsGpbXz
         6aDc3GNQtnk1ZzXHSwQCVv4LOVj0FL2tcZrnkEKPH22CeUw6azGEwO6gqPhOeo/UTzC8
         CAGMYMu0CibvYCRJgy2fuPg3TqVZbhGt5gHufNtUof0Gw0FDR3KgWX5KWtTvRU2bJCB3
         6J8LXoac3H1R5/6ZWZ8wIHim0sOUZG312tHezmcG2vA/YZDFQNq2NLrC7BlZj/TPwF8d
         LG7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=MJzRoK5AHHgr8V25vpyceNTWmZxiFyKsyjhqQm8Vxxc=;
        b=EWT2cneZKhu0zxy1yHoKyYbqP9LV2pp6GRrP8eOWpWVXmreSaE59HXmkmw8O49MYYs
         WejmXCoPNTAni/KJSltMFRZ4PRCR2CHWNBMPBAqOBdZkZeo/Gxb0K/7M9LJca/apMK57
         wnEL0TQ/wUKZoIJ+okwci2ofGx/0g5Ilvk+MS23eq1m6ImTFH/iSJsjxXPB28+TVa6is
         hxAsIp1Lz24/tzZ9WOAL4UUXgRdj/S/0ejntPpGYk+kTT9lL8yofIGsXaAypn5Kvmy2w
         SZ6VbScOw7O8lOFcFEHYGewn4ufytiR5NQGtyyocs3rX1a6JQ8cbuKsRHRSwGqDSZ6oZ
         TCMQ==
X-Gm-Message-State: AOAM530igzwG1afWvhnvDUHxb3Y2tu6zVzapiZ9U63fQYngxCEpxdq3m
        v4e6ly4+Wt2WmWbQpqlY2T70JQ==
X-Google-Smtp-Source: ABdhPJzpmLKGtf/B7RhbJlQwrCAP0Mb8Tyioqci54O7y0v57o4U82PROFirmSWr5+lJk79X2A0kouQ==
X-Received: by 2002:a05:6000:2cf:: with SMTP id o15mr2236419wry.184.1612945423966;
        Wed, 10 Feb 2021 00:23:43 -0800 (PST)
Received: from dell ([91.110.221.237])
        by smtp.gmail.com with ESMTPSA id h9sm1850897wrc.94.2021.02.10.00.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 00:23:43 -0800 (PST)
Date:   Wed, 10 Feb 2021 08:23:41 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     Fabio Estevam <festevam@gmail.com>,
        kernel-janitors@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Michal Simek <michal.simek@xilinx.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH] video: use getter/setter functions
Message-ID: <20210210082341.GH220368@dell>
References: <20210209211325.1261842-1-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210209211325.1261842-1-Julia.Lawall@inria.fr>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Tue, 09 Feb 2021, Julia Lawall wrote:

> Use getter and setter functions, for platform_device structures and a
> spi_device structure.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> 
> ---
>  drivers/video/backlight/qcom-wled.c                                  |    2 +-

This patch is fine.

Could you please split it out and submit it separately though please.

>  drivers/video/fbdev/amifb.c                                          |    4 ++--
>  drivers/video/fbdev/da8xx-fb.c                                       |    4 ++--
>  drivers/video/fbdev/imxfb.c                                          |    2 +-
>  drivers/video/fbdev/omap2/omapfb/displays/panel-lgphilips-lb035q02.c |    6 +++---
>  drivers/video/fbdev/omap2/omapfb/dss/dpi.c                           |    4 ++--
>  drivers/video/fbdev/omap2/omapfb/dss/dsi.c                           |    4 ++--
>  drivers/video/fbdev/omap2/omapfb/dss/hdmi4.c                         |    2 +-
>  drivers/video/fbdev/omap2/omapfb/dss/hdmi5.c                         |    2 +-
>  drivers/video/fbdev/xilinxfb.c                                       |    2 +-
>  10 files changed, 16 insertions(+), 16 deletions(-)

...]

> diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
> index 3bc7800eb0a9..091f07e7c145 100644
> --- a/drivers/video/backlight/qcom-wled.c
> +++ b/drivers/video/backlight/qcom-wled.c
> @@ -1692,7 +1692,7 @@ static int wled_probe(struct platform_device *pdev)
>  
>  static int wled_remove(struct platform_device *pdev)
>  {
> -	struct wled *wled = dev_get_drvdata(&pdev->dev);
> +	struct wled *wled = platform_get_drvdata(pdev);
>  
>  	mutex_destroy(&wled->lock);
>  	cancel_delayed_work_sync(&wled->ovp_work);

For my own reference (apply this as-is to your sign-off block):

  Acked-for-Backlight-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
