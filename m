Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E772C433F5
	for <linux-fbdev@archiver.kernel.org>; Tue, 19 Oct 2021 15:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3409861074
	for <linux-fbdev@archiver.kernel.org>; Tue, 19 Oct 2021 15:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232752AbhJSPcy (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 19 Oct 2021 11:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232568AbhJSPcx (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 19 Oct 2021 11:32:53 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2406C06161C
        for <linux-fbdev@vger.kernel.org>; Tue, 19 Oct 2021 08:30:40 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id o24-20020a05600c511800b0030d9da600aeso3604304wms.4
        for <linux-fbdev@vger.kernel.org>; Tue, 19 Oct 2021 08:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=JcOBGQWIiALnfVD80eLJxi3L3e2QVZ5tX5XcjDnwtJ4=;
        b=UU3NxCcU8/tJNhSY4zRZ/6QhY2FKkco/4tO035VZI2I+iZN4J+PMkAODB//2C5Mpoz
         eZoelFhqtwVFvskSk7eTHQS1YgaqiCBurKkVuY06qRsBM2rnJPlpxZBTgpqBNwZBwHhg
         X7MadqBmNKLEZRIutbl6tSFwrkhURBgLC/UjbWJZWT1Tr9SQ/XdGUn0NILr4wouaQvh1
         Qcd0y99oiaPEehK1ocs/JoHYacIIvyRNBuq4Axpmk/X+C4B+hOOmUhTkPnCRALjErQBg
         o2ngCL1LSy5KHfMpCzhcXSwtkkdXqgvqwLL7JfjUxrifPhVxReR+F3PJO4R+yUJ02jYX
         6X/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=JcOBGQWIiALnfVD80eLJxi3L3e2QVZ5tX5XcjDnwtJ4=;
        b=16EWC4hF3iSckJC5gSR6Fcf/Q3+E2Dd4Yl+ENQKmGhIlvWIRpPAFf0cmQajLoJSBnR
         DEaL8KBdwDZfmZzfwusXqny0DDqgAjczdNv35Bu4HaP8FLeGos33J0+4U4McSXLbPRep
         FIBpIZ88skwUp6nYTeBStUKyxRNo0i3DxPgGm79GWFoxhS61qjUXvkvaG+6D/1P6UZ+3
         P20yK1T1UE2c9CzuLu9rauhRD2V+jaQZoRhLGYi8Rthj2+sU+gNPyqK7U9SoMZM/kD3s
         DccRyLuYL9VwESSXnblAXvh8mUQFXD+PNJl/DnGDmHTipmcsjoLSAqv2rDmY5dnFBdVG
         W2Ww==
X-Gm-Message-State: AOAM533YiInAh2Q5G00dx3Dq6XiPXV0SlVgTGtw9JUfuqq6IVbiEmL1D
        +9XB/XXAsqz3B7l5c/LHgJbRSw==
X-Google-Smtp-Source: ABdhPJxkb6TsqRPkGAj4JTTUzeOPBTyJjIk++N2C9S0+Uup6rtKdoLYs53YVxXqsA7eq1JinoJ0Cmw==
X-Received: by 2002:adf:bb8d:: with SMTP id q13mr45596654wrg.327.1634657439300;
        Tue, 19 Oct 2021 08:30:39 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id i24sm2515090wml.26.2021.10.19.08.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 08:30:38 -0700 (PDT)
Date:   Tue, 19 Oct 2021 16:30:37 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH] video: backlight: ili9320: Make ili9320_remove() return
 void
Message-ID: <20211019153037.5uwqixmg7k4m3api@maple.lan>
References: <20211019120927.3822792-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211019120927.3822792-1-u.kleine-koenig@pengutronix.de>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Tue, Oct 19, 2021 at 02:09:27PM +0200, Uwe Kleine-König wrote:
> Up to now ili9320_remove() returns zero unconditionally. Make it return
> void instead which makes it easier to see in the callers that there is
> no error to handle.

Ultimately the actions here boil down to an SPI write which could fail
so we could make an attempt to correct the broken error propagation
inside ili9320.c instead...


> Also the return value of spi remove callbacks is ignored anyway.

... which does inform the above question.

Is this patch a local fix or part of a larger plan to eventually change
the return value of the spi_remove to void?


Daniel.


> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/video/backlight/ili9320.c   | 3 +--
>  drivers/video/backlight/ili9320.h   | 2 +-
>  drivers/video/backlight/vgg2432a4.c | 4 +++-
>  3 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/video/backlight/ili9320.c b/drivers/video/backlight/ili9320.c
> index 168ac79523d7..2acd2708f8ca 100644
> --- a/drivers/video/backlight/ili9320.c
> +++ b/drivers/video/backlight/ili9320.c
> @@ -251,10 +251,9 @@ int ili9320_probe_spi(struct spi_device *spi,
>  }
>  EXPORT_SYMBOL_GPL(ili9320_probe_spi);
>  
> -int ili9320_remove(struct ili9320 *ili)
> +void ili9320_remove(struct ili9320 *ili)
>  {
>  	ili9320_power(ili, FB_BLANK_POWERDOWN);
> -	return 0;
>  }
>  EXPORT_SYMBOL_GPL(ili9320_remove);
>  
> diff --git a/drivers/video/backlight/ili9320.h b/drivers/video/backlight/ili9320.h
> index fc59e389d59a..8213cc6e9184 100644
> --- a/drivers/video/backlight/ili9320.h
> +++ b/drivers/video/backlight/ili9320.h
> @@ -68,7 +68,7 @@ extern int ili9320_write_regs(struct ili9320 *ili,
>  extern int ili9320_probe_spi(struct spi_device *spi,
>  			     struct ili9320_client *cli);
>  
> -extern int ili9320_remove(struct ili9320 *lcd);
> +extern void ili9320_remove(struct ili9320 *lcd);
>  extern void ili9320_shutdown(struct ili9320 *lcd);
>  
>  /* PM */
> diff --git a/drivers/video/backlight/vgg2432a4.c b/drivers/video/backlight/vgg2432a4.c
> index 9bf277ca4ae9..3567b45f9ba9 100644
> --- a/drivers/video/backlight/vgg2432a4.c
> +++ b/drivers/video/backlight/vgg2432a4.c
> @@ -235,7 +235,9 @@ static int vgg2432a4_probe(struct spi_device *spi)
>  
>  static int vgg2432a4_remove(struct spi_device *spi)
>  {
> -	return ili9320_remove(spi_get_drvdata(spi));
> +	ili9320_remove(spi_get_drvdata(spi));
> +
> +	return 0;
>  }
>  
>  static void vgg2432a4_shutdown(struct spi_device *spi)
> -- 
> 2.30.2
> 
