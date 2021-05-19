Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF4A0C433B4
	for <linux-fbdev@archiver.kernel.org>; Wed, 19 May 2021 15:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC79760D07
	for <linux-fbdev@archiver.kernel.org>; Wed, 19 May 2021 15:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233065AbhESPpt (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 19 May 2021 11:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354715AbhESPpn (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 19 May 2021 11:45:43 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37AE7C06175F
        for <linux-fbdev@vger.kernel.org>; Wed, 19 May 2021 08:44:23 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id z85-20020a1c7e580000b029017a76f3afbaso1062493wmc.2
        for <linux-fbdev@vger.kernel.org>; Wed, 19 May 2021 08:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4nu3OSdvPAQ7VkA5Lu/t0kQYvXnt9HghzAhj6ZR5wXc=;
        b=KW4jncRtsVJ0qOZ8xXM9WdklXP/wPTxhSi5g4UQZUOyLMg5rF0WFjn6wOI3G5tB1X+
         wvH5LtDvcBr0gj+jyw9Y3DzVQek2meyK5G0iRkndiLobnkoEtVdKkjvUNIeTGF5xJ29D
         HeXVJcFy+WVxXf8muJp4RNBPVa9e2hShFmstZsEZLy7NWK0rJCnuDNTHdAGXh3vhGGwD
         V+zB7FaW6abbE218yv3F3NKmajccjq4im07xAPAB2M6E8GOjs6wzmBmDrChrbi/4PGUR
         WH/qzpOQISHnWW7+DMT4j9Emc+1TFBFXtARDDrlJX7Mm7im/5w68aG63BPt+IFfe6XyF
         xqiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4nu3OSdvPAQ7VkA5Lu/t0kQYvXnt9HghzAhj6ZR5wXc=;
        b=VsswiyjeYDAHONq6mwGZd2NbSwcJ604xX2iFE3NPtkm4tNoySNCF3hvAmWxP5HJtwz
         kll1HnzuHdIHnhV9OgPHoIff1ToddFPZvvdaGinqL8ittr0C2v7zwpV5jQu34a/EAN5C
         qbEo1vHwLwWLYp1W8T4x0cBi1z6P18EAul15tI+jHeElT1CgNTn0thceK3JAftIPS+f+
         giQ0JIm7hvDjrshgkdxmMMuYkIOvXdlvA9cLS1eqZR+ocl9IrbYPQ52OwrSgOPyPL4mm
         rCwJmvraZLNOHDi9Y02tqSpFQoLJg6OIYTb18EuAsf3LXibrlDzf4TSjKc+4m9qksz6o
         vAXw==
X-Gm-Message-State: AOAM530/ROE5DI6PC2WCX6x6q7xxMmiJMfwz4MTTUlSkW7w6foMOiTUe
        cxwgSzyXmWQdTAApBch9gMgsAQ==
X-Google-Smtp-Source: ABdhPJxm3DicWObRp7AE2/siDsEzYxCeS+fBjpBkSEKmMtJQ29aNWO0Wp4a8UD/rCQih9Wz3T4VICQ==
X-Received: by 2002:a1c:f70d:: with SMTP id v13mr11921329wmh.183.1621439061770;
        Wed, 19 May 2021 08:44:21 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id q1sm6200684wmq.48.2021.05.19.08.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 08:44:21 -0700 (PDT)
Date:   Wed, 19 May 2021 16:44:19 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Juerg Haefliger <juerg.haefliger@canonical.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@canonical.com>
Subject: Re: [PATCH v2] backlight: Kconfig whitespace and indentation cleanups
Message-ID: <20210519154419.n74hcf7lnqvmuuvf@maple.lan>
References: <20210517095839.81833-1-juergh@canonical.com>
 <20210519110300.17918-1-juergh@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210519110300.17918-1-juergh@canonical.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, May 19, 2021 at 01:03:00PM +0200, Juerg Haefliger wrote:
> Remove leading whitespaces, replace multi spaces with tabs, and fix help
> text indentation.
> 
> Signed-off-by: Juerg Haefliger <juergh@canonical.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.

> ---
>  drivers/video/backlight/Kconfig | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
> index d83c87b902c1..c887338de386 100644
> --- a/drivers/video/backlight/Kconfig
> +++ b/drivers/video/backlight/Kconfig
> @@ -128,12 +128,12 @@ config LCD_HX8357
>  	  If you have a HX-8357 LCD panel, say Y to enable its LCD control
>  	  driver.
>  
> -  config LCD_OTM3225A
> -  	tristate "ORISE Technology OTM3225A support"
> -  	depends on SPI
> -  	help
> -  	  If you have a panel based on the OTM3225A controller
> -  	  chip then say y to include a driver for it.
> +config LCD_OTM3225A
> +	tristate "ORISE Technology OTM3225A support"
> +	depends on SPI
> +	help
> +	  If you have a panel based on the OTM3225A controller
> +	  chip then say y to include a driver for it.
>  
>  endif # LCD_CLASS_DEVICE
>  
> @@ -269,11 +269,11 @@ config BACKLIGHT_MAX8925
>  	  WLED output, say Y here to enable this driver.
>  
>  config BACKLIGHT_APPLE
> -       tristate "Apple Backlight Driver"
> -       depends on X86 && ACPI
> -       help
> -	 If you have an Intel-based Apple say Y to enable a driver for its
> -	 backlight.
> +	tristate "Apple Backlight Driver"
> +	depends on X86 && ACPI
> +	help
> +	  If you have an Intel-based Apple say Y to enable a driver for its
> +	  backlight.
>  
>  config BACKLIGHT_TOSA
>  	tristate "Sharp SL-6000 Backlight Driver"
> -- 
> 2.27.0
> 
