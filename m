Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AADCAC43334
	for <linux-fbdev@archiver.kernel.org>; Wed,  6 Jul 2022 08:38:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231982AbiGFIie (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 6 Jul 2022 04:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231962AbiGFIi3 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 6 Jul 2022 04:38:29 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D181260F
        for <linux-fbdev@vger.kernel.org>; Wed,  6 Jul 2022 01:38:28 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id q9so20943067wrd.8
        for <linux-fbdev@vger.kernel.org>; Wed, 06 Jul 2022 01:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jvy9fZnYZOoUrKY4T2EHzyax/+pT0S6ZamgoWmCY7lI=;
        b=Nrhlvi6Z3KY701t0TfH8JnJ1eqEH2mzMamvFfXkAzFp4yCik2wthX5b3eiGElyvktY
         twrPjYnxH4Az3+UmhZZyi4kamjX7dmvkLuZ3fe6Y1Zwwi7fdAUSUWpMsVoLnc6Q6rzvW
         qQU61MwwrRJzMAfPB1T4+5euhuz6TkkhTHBkZjlLyqQmV3/u0RSXtgyy89UsQGTSptFa
         rbxm5yZOIAAt2gicjScl7bUX2ZcLzlqji8MJM9Bzs/Mo7PsrQ05mNlXrxDJiUjYMLehx
         AwXhr7GPmcZZgqAmb6q2D5c6t6TBjdN1QLyjaESLYjidadwhnFPeBL/fEiaKbpTIE6rX
         PlYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jvy9fZnYZOoUrKY4T2EHzyax/+pT0S6ZamgoWmCY7lI=;
        b=dJkedNxnJaUT+lM/bOacu++symFigim0NsS0cw4GWvIAJzx1g1ClfWrkRxK0CFsvG3
         tSurPHnZmPtMq95YGiINVjgt5uDQaZQyiMPoWJ2PXqAGrAtsgUfn5tNb03Z6awume0S7
         ODVrUOKohzeUV2NMxwyRK8IuPTTZ+b7D6j/CxIN5Dqy4Raej99c6DaR2q5GEmwShFgpb
         ps/yJO3iAps/k8DvkA2hXx/uSIPjpUWeq38KFVGn/3NjppUIl03GsSkJ39br4n7zdSrM
         GpNd+kmICaejQPfBE7VZCHj5pKuEFxoLn9FSk769jbcWZN+kSWcLdug3yjdDNDTDcfFK
         24ew==
X-Gm-Message-State: AJIora8QoizBfwpZbEomVpL3SDvKKkXlr1CwYxFe0Ghv3oQh9SLWhn88
        opRFQH8u2ASDVNSX0QN1WKLQdw==
X-Google-Smtp-Source: AGRyM1u3aF0xlinqVbRSOVIwu8dj8kY7lVCFFrYuXzoizRjf/6/698o7/GM5e2My59isg+g9TMgrJg==
X-Received: by 2002:a05:6000:1e10:b0:21b:98c7:d35e with SMTP id bj16-20020a0560001e1000b0021b98c7d35emr38383139wrb.30.1657096706860;
        Wed, 06 Jul 2022 01:38:26 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id j22-20020a05600c1c1600b003a046549a85sm21339238wms.37.2022.07.06.01.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 01:38:26 -0700 (PDT)
Date:   Wed, 6 Jul 2022 09:38:24 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, Jingoo Han <jg1.han@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "drivers/video/backlight/platform_lcd.c: add
 support for device tree based probe"
Message-ID: <20220706083824.yow4e2hqthoqffol@maple.lan>
References: <20220629210024.815761-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629210024.815761-1-robh@kernel.org>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, Jun 29, 2022 at 03:00:23PM -0600, Rob Herring wrote:
> This reverts commit 52e842432f36d5b15227d0ee0d2aa3d2bc3cc0b2.
> 
> The DT support never would have worked because there's no platform_data
> providing ops. There's not any documented binding for it either.
> 
> Cc: Jingoo Han <jg1.han@samsung.com>
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.


> ---
>  drivers/video/backlight/platform_lcd.c | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/drivers/video/backlight/platform_lcd.c b/drivers/video/backlight/platform_lcd.c
> index b2bfbf070200..dc37494baf42 100644
> --- a/drivers/video/backlight/platform_lcd.c
> +++ b/drivers/video/backlight/platform_lcd.c
> @@ -12,7 +12,6 @@
>  #include <linux/fb.h>
>  #include <linux/backlight.h>
>  #include <linux/lcd.h>
> -#include <linux/of.h>
>  #include <linux/slab.h>
>  
>  #include <video/platform_lcd.h>
> @@ -133,19 +132,10 @@ static int platform_lcd_resume(struct device *dev)
>  static SIMPLE_DEV_PM_OPS(platform_lcd_pm_ops, platform_lcd_suspend,
>  			platform_lcd_resume);
>  
> -#ifdef CONFIG_OF
> -static const struct of_device_id platform_lcd_of_match[] = {
> -	{ .compatible = "platform-lcd" },
> -	{},
> -};
> -MODULE_DEVICE_TABLE(of, platform_lcd_of_match);
> -#endif
> -
>  static struct platform_driver platform_lcd_driver = {
>  	.driver		= {
>  		.name	= "platform-lcd",
>  		.pm	= &platform_lcd_pm_ops,
> -		.of_match_table = of_match_ptr(platform_lcd_of_match),
>  	},
>  	.probe		= platform_lcd_probe,
>  };
> -- 
> 2.34.1
> 
