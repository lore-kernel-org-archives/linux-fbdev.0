Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A7FC433ED
	for <linux-fbdev@archiver.kernel.org>; Mon, 17 May 2021 16:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5081B610E9
	for <linux-fbdev@archiver.kernel.org>; Mon, 17 May 2021 16:34:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245319AbhEQQff (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 17 May 2021 12:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244888AbhEQQf2 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 17 May 2021 12:35:28 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA477C01CD55
        for <linux-fbdev@vger.kernel.org>; Mon, 17 May 2021 08:28:01 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id z17so6847132wrq.7
        for <linux-fbdev@vger.kernel.org>; Mon, 17 May 2021 08:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0JwxGBKfDoUxq2NZLsErnRvzPdT2eYfu4gWuQeo9vCM=;
        b=j1J70RTbH+qyRmD8QqmKri5WuNEcnX+J4adv/ycgORjHO5/WAJsOeJ65SrOYzUnVTP
         VG3uUlqBj/EQMg9qfGG/nXtfTlY6ZLKRp2SQEaQiSmH7R+0WfsT2Otk71jl9cXMr2uWs
         lv6P0aLshi5yaJ3YHGy4YH6gXZ6eGOOlkuT0VEtB5JwR0vRjFyyOx2BIq3tTJwrSyva3
         zXyVDwm4utj0rSUQQR5h6hnEpgIu/WmZEkVoXxNdOE0mLuayt8biCpIw1qRCJ023YzUF
         RF+nlucQSrsui7y4n+FDQuWg4Km5I/qb/leF70mGmkreZNJuKjKpFUJY2lxeMlL4uxYJ
         aNMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0JwxGBKfDoUxq2NZLsErnRvzPdT2eYfu4gWuQeo9vCM=;
        b=JZwQYEwrWIDOqz8WHuQChJ3EaVHDp9LdC/xghHOtosiX/5DwhtYsGaK0l8N+UqH5s4
         5DoVSukJ939zCKocsc+3SEALS8M7GkakpwjwKm9z0VBxtAV8uPc6aOsXU169lDXcQbVV
         uVvHgUpbwn3V2Mo1GuN6+BTAGJ3jDn8MILJkwoxeP2RmEbgsv0UIpUtkFRvNFzBTKxEe
         8gRnD8NzJoUkJBtzAcyC4+be1oQZ9gNVl7Bmkaory25Mnlv18TSp26nddWc4Szgp3grV
         wE6befahn89ixBI4UYtiapi10urPZdCnQx/jqqR6oGqnu7AMl3hWwWX7eMR9Rflwhyu2
         c32A==
X-Gm-Message-State: AOAM532j2CxsVtt+ZNuR528VFKWuzFIYtG148au+3gMhQi0QFSyDCa3j
        sXAzDP5Su0FkYnD7+IZiALfLOmInAGeSYY0b
X-Google-Smtp-Source: ABdhPJwuwOUHqhdgm9HQRD81VC7JS4eqLC5JQc4toY1qtK7WE6GphAF3qIqwNcqwalRX4HpnUsEzSA==
X-Received: by 2002:a5d:4e91:: with SMTP id e17mr296464wru.396.1621265280618;
        Mon, 17 May 2021 08:28:00 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id f13sm14745840wrt.86.2021.05.17.08.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 08:27:59 -0700 (PDT)
Date:   Mon, 17 May 2021 16:27:58 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Juerg Haefliger <juerg.haefliger@canonical.com>
Cc:     lee.jones@linaro.org, jingoohan1@gmail.com,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, juergh@canonical.com
Subject: Re: [PATCH] backlight: Remove leading spaces in Kconfig
Message-ID: <20210517152758.lqwmborindqvavwo@maple.lan>
References: <20210517095839.81833-1-juergh@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210517095839.81833-1-juergh@canonical.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Mon, May 17, 2021 at 11:58:39AM +0200, Juerg Haefliger wrote:
> Remove leading spaces before tabs in Kconfig file(s) by running the
> following command:
> 
>   $ find drivers/video/backlight -name 'Kconfig*' | \
>     xargs sed -r -i 's/^[ ]+\t/\t/'
> 
> Signed-off-by: Juerg Haefliger <juergh@canonical.com>
> ---
>  drivers/video/backlight/Kconfig | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
> index d83c87b902c1..a967974f6cd6 100644
> --- a/drivers/video/backlight/Kconfig
> +++ b/drivers/video/backlight/Kconfig
> @@ -129,11 +129,11 @@ config LCD_HX8357
>  	  driver.
>  
>    config LCD_OTM3225A

Whilst removing the unwanted spaces (two of them on each line) could we
also remove the two unwanted spaces from the config line as well.


Daniel.


> -  	tristate "ORISE Technology OTM3225A support"
> -  	depends on SPI
> -  	help
> -  	  If you have a panel based on the OTM3225A controller
> -  	  chip then say y to include a driver for it.
> +	tristate "ORISE Technology OTM3225A support"
> +	depends on SPI
> +	help
> +	  If you have a panel based on the OTM3225A controller
> +	  chip then say y to include a driver for it.
>  
>  endif # LCD_CLASS_DEVICE
>  
> -- 
> 2.27.0
> 
