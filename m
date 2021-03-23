Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC0EC433C1
	for <linux-fbdev@archiver.kernel.org>; Tue, 23 Mar 2021 09:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B94461923
	for <linux-fbdev@archiver.kernel.org>; Tue, 23 Mar 2021 09:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbhCWJe2 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 23 Mar 2021 05:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhCWJeJ (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 23 Mar 2021 05:34:09 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8F7C061574
        for <linux-fbdev@vger.kernel.org>; Tue, 23 Mar 2021 02:34:08 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id y6so22664678eds.1
        for <linux-fbdev@vger.kernel.org>; Tue, 23 Mar 2021 02:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=tTpXq5PUWIqX4hPmnIy2Ebapp61tLCl5gNQ4F1z/chY=;
        b=TNAB+pss73oHQ0QY6wXA30Om65d0gL0aeIHBCFOk3CPqvHPRnnK4QRFP7SGztJPHLl
         moJkX27GJrSknpDeDTFKd/kUZj7xJrS0Y0nF8cNGfHetxCLjleifYCzl8becBmOCgEoZ
         jVT6XETkXUpmfJANhCN1wnO3v90XU1347aaeICKefMdjFUlN3e23stBSL08GopcesT8M
         c3mGnxxNSXQu4ElTDtXZLxo9nDvPT5WK8ZAixzcqcmDcf/uSam8+YbffgHjnVh42hIEp
         KzSYKmG04FyT9UkHXN5+V0Zw6ms12V8a4igrSpVxmYB0UpJD5T29oKcFA8SxylbP5eri
         ZTSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=tTpXq5PUWIqX4hPmnIy2Ebapp61tLCl5gNQ4F1z/chY=;
        b=WdSt1OgBKqDNHapq6ncR/dp5TO3Hlb2zP9RkQ6ey6QgclNg4L2NWDt8z1iyGEUBiCj
         zUoU/qLlr4jeV0lucBpHiSN/XRZehgdDaoK0XSZpgaCpB5ziSVtRxRpcisFUwA+FmKZU
         DT09mRhCpXB4KU7CwlzBLwro5+NLc+xNcRKNlmbOKS1PLMy7Y0afeJilzujAhC1KHZsX
         TamT1byMIfyzB9nF6ykI5nZkQszeKx3cb42PJeIDyfCmsP7am0bHK16JjNgL3NpMy7Le
         zU9a/+5YWtq6Q6+cDtuAj9m0xG8GJumPAhCN+NbD7VojKa1Aor7QXwFV4s8aoXjJQL8k
         fv1Q==
X-Gm-Message-State: AOAM532bmv0mqP9Gw50D+LcxJmOLSjCC7SXlAzY33p6MkZqSlCld1ctt
        zX/Awn8Ias5+r5ySRCDtNEHPyg==
X-Google-Smtp-Source: ABdhPJyTUR1gRvZuc0hYkZFukQlamkHYSvNsVGRcUySLVY+CIKooPuVEiEfhmlu4Mqr53FQZjxpogQ==
X-Received: by 2002:a05:6402:b31:: with SMTP id bo17mr3643742edb.113.1616492047679;
        Tue, 23 Mar 2021 02:34:07 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id da17sm12803300edb.83.2021.03.23.02.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 02:34:07 -0700 (PDT)
Date:   Tue, 23 Mar 2021 09:34:05 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Kristoffer Ericson <kristoffer.ericson@gmail.com>,
        Richard Purdie <rpurdie@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backlight: journada720: fix Wmisleading-indentation
 warning
Message-ID: <20210323093405.dp37pgnmxbpqsiif@maple.lan>
References: <20210322164134.827091-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210322164134.827091-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Mon, Mar 22, 2021 at 05:41:28PM +0100, Arnd Bergmann wrote:
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

I'm dubious that the re-indent matches the original authors intent...
but it certainly does match what was actually written and tested so
on that basis:

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.


 ---
>  drivers/video/backlight/jornada720_bl.c | 44 ++++++++++++-------------
>  1 file changed, 22 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/video/backlight/jornada720_bl.c b/drivers/video/backlight/jornada720_bl.c
> index 996f7ba3b373..066d0dc98f60 100644
> --- a/drivers/video/backlight/jornada720_bl.c
> +++ b/drivers/video/backlight/jornada720_bl.c
> @@ -66,30 +66,30 @@ static int jornada_bl_update_status(struct backlight_device *bd)
>  	} else  /* turn on backlight */
>  		PPSR |= PPC_LDD1;
>  
> -		/* send command to our mcu */
> -		if (jornada_ssp_byte(SETBRIGHTNESS) != TXDUMMY) {
> -			dev_info(&bd->dev, "failed to set brightness\n");
> -			ret = -ETIMEDOUT;
> -			goto out;
> -		}
> +	/* send command to our mcu */
> +	if (jornada_ssp_byte(SETBRIGHTNESS) != TXDUMMY) {
> +		dev_info(&bd->dev, "failed to set brightness\n");
> +		ret = -ETIMEDOUT;
> +		goto out;
> +	}
>  
> -		/*
> -		 * at this point we expect that the mcu has accepted
> -		 * our command and is waiting for our new value
> -		 * please note that maximum brightness is 255,
> -		 * but due to physical layout it is equal to 0, so we simply
> -		 * invert the value (MAX VALUE - NEW VALUE).
> -		 */
> -		if (jornada_ssp_byte(BL_MAX_BRIGHT - bd->props.brightness)
> -			!= TXDUMMY) {
> -			dev_err(&bd->dev, "set brightness failed\n");
> -			ret = -ETIMEDOUT;
> -		}
> +	/*
> +	 * at this point we expect that the mcu has accepted
> +	 * our command and is waiting for our new value
> +	 * please note that maximum brightness is 255,
> +	 * but due to physical layout it is equal to 0, so we simply
> +	 * invert the value (MAX VALUE - NEW VALUE).
> +	 */
> +	if (jornada_ssp_byte(BL_MAX_BRIGHT - bd->props.brightness)
> +		!= TXDUMMY) {
> +		dev_err(&bd->dev, "set brightness failed\n");
> +		ret = -ETIMEDOUT;
> +	}
>  
> -		/*
> -		 * If infact we get an TXDUMMY as output we are happy and dont
> -		 * make any further comments about it
> -		 */
> +	/*
> +	 * If infact we get an TXDUMMY as output we are happy and dont
> +	 * make any further comments about it
> +	 */
>  out:
>  	jornada_ssp_end();
>  
> -- 
> 2.29.2
> 
