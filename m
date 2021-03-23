Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18DE9C433DB
	for <linux-fbdev@archiver.kernel.org>; Tue, 23 Mar 2021 09:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD09E6197F
	for <linux-fbdev@archiver.kernel.org>; Tue, 23 Mar 2021 09:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbhCWJng (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 23 Mar 2021 05:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbhCWJnS (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 23 Mar 2021 05:43:18 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51895C061574
        for <linux-fbdev@vger.kernel.org>; Tue, 23 Mar 2021 02:43:18 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id bf3so22699242edb.6
        for <linux-fbdev@vger.kernel.org>; Tue, 23 Mar 2021 02:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=0hkbYACOMfkrmU9Itv7aBZoZaQN614rwNKXnBs92y0U=;
        b=KFK7Gl6Loz5yCvngMmCyE/TcVpLAju6hCgi8R6DLg/KHgWlEvE0PmzfRnJByr6f1dz
         y1JF5RZjDJumy3xAkwhWz1LkOa9b1w3jXof53gbR7gRw4PcDJBhoC2SbKsKsQ3NraBkX
         oj/WRAdbq1BTlNYCgbY6SsaZzTWabF9u7JN986LiHT98xbkcQsCjKui3PWoAN6QOkqIx
         LFP2D2GOjHRk4bdSI5RwZsZwau1ta9+kMzTD8+nHII+bFvg1e7JYNP1KjyEdNrdJfQX6
         eKipxfAVe3VDY1D4NrXIC6A22Jyn5KTg6jxLq1LcjuFu5EJcFZnt/4QqfND3c6UrhIkw
         qhIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=0hkbYACOMfkrmU9Itv7aBZoZaQN614rwNKXnBs92y0U=;
        b=U5TlPkvyIGPBbuPe/EAQXsANvAsiI5S0xgLLHdWrKQlNqsH8T/9DURNTuO7MguGB9I
         2WbW1WAUBMj6vLYqdz3klLEXLpH8hpp1D42Y5jNFa6MSCN20YHtLCYrZgX4VYnJSowvn
         GI5rqPOQigzQFHKAm7lZpuagN1sKUPK5PjEHVS56Cy7jV81VplZvW9JMPoDR9vB6256X
         WiS6/UuVEVZLEoDmvkM9FxhtluuFYKUrcW8pAL4gUt68P+0Cbv6uXMVXUx2kv0ljvC+X
         GgrX3GFtyYcFYzah9egjyjdH7HehGxt3uQxJe+Ulh172KapDStVPUQFDBhh4QP9e3jCR
         8VKw==
X-Gm-Message-State: AOAM531FMje1MpZgiqGDelnjOcEd8+LGhuUEpyI53rg/dqt/+1sM9BRZ
        eDUyIdIN+8p3yPWSF/pTOKUB1w==
X-Google-Smtp-Source: ABdhPJwfXBUZdaB1Qmf/e0goN/7hGlbXHdwvzBP8U1kMkO9nlQ2EQtfMy25rK2nJlLpWfLzwSL+1cw==
X-Received: by 2002:a05:6402:1d19:: with SMTP id dg25mr3789557edb.218.1616492597099;
        Tue, 23 Mar 2021 02:43:17 -0700 (PDT)
Received: from dell ([91.110.221.180])
        by smtp.gmail.com with ESMTPSA id s9sm12075958edd.16.2021.03.23.02.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 02:43:16 -0700 (PDT)
Date:   Tue, 23 Mar 2021 09:43:14 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Kristoffer Ericson <kristoffer.ericson@gmail.com>,
        Richard Purdie <rpurdie@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backlight: journada720: fix Wmisleading-indentation
 warning
Message-ID: <20210323094314.GV2916463@dell>
References: <20210322164134.827091-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210322164134.827091-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Mon, 22 Mar 2021, Arnd Bergmann wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> With gcc-11, we get a warning about code that looks correct
> but badly indented:
> 
> drivers/video/backlight/jornada720_bl.c: In function ‘jornada_bl_update_status’:
> drivers/video/backlight/jornada720_bl.c:66:11: error: this ‘else’ clause does not guard... [-Werror=misleading-indentation]
>    66 |         } else  /* turn on backlight */
>       |           ^~~~
> 
> Change the formatting according to our normal conventions.
> 
> Fixes: 13a7b5dc0d17 ("backlight: Adds HP Jornada 700 series backlight driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/video/backlight/jornada720_bl.c | 44 ++++++++++++-------------
>  1 file changed, 22 insertions(+), 22 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
