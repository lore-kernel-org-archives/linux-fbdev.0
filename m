Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C78C433DB
	for <linux-fbdev@archiver.kernel.org>; Mon, 29 Mar 2021 10:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 986166190A
	for <linux-fbdev@archiver.kernel.org>; Mon, 29 Mar 2021 10:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbhC2K0l (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 29 Mar 2021 06:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbhC2K0f (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 29 Mar 2021 06:26:35 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377E7C061574
        for <linux-fbdev@vger.kernel.org>; Mon, 29 Mar 2021 03:26:35 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id r12so18600902ejr.5
        for <linux-fbdev@vger.kernel.org>; Mon, 29 Mar 2021 03:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1PyRrHa88gP4fv3wzdBtGmE3s8qTaZ8kXi0Y5jLPfiM=;
        b=pOayFRW2XXssf7jvduFdDt/MTNW5dPU7zDIMbPZv7keXD0uhfdyiSib33dcSnA8Hu3
         Nd+m1hKYpbHlPA5PItXcCpemOcZIuqTUxD4CLZmQHKfuDrLWJpKcSE99/2WKCXx/WHae
         hBbdV4k3P9g5FmFGcS75iT5ULopTuJoESaOqijBnXYZRXgmLARrGmpyT/E0jqh/UtuFZ
         cH4x1wJBN7UMJBHfhKKRX49gL9a3nTG/jXjigM2MFXILb4enVacil07wnTKeex7niRpe
         Y2b24ft5kDHQLN5jVRiGZ11LtjeRRJ9Zfvat/PCZQWtGgC29mPTZJST1VdOER7CBbxRr
         zA3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1PyRrHa88gP4fv3wzdBtGmE3s8qTaZ8kXi0Y5jLPfiM=;
        b=nSthmPMZiF0J/BCWHozmN6wec+Z3B60Wc33B/Ef+5/gCC/q01eDReJ+B+DlCK/H9ZK
         PKzwlpHGoegGdDtb+axNmxChLfK1QuBwqvZeqMbJaKOKjlyYXJkYOCAhyQuXWiIGMV0/
         26ghnF8VyEOWV43lSLcM/NpwFTE1YAd41T1XSSJO1oIkvHtV2/5XwK0G5Saw0g5WQjNU
         LvqKpP34DC+vc9wMtQ5jSU0NFQ3wQZsUdQ3lBlaZSdQTba4xp1wvR60J8KwILJdZErFa
         jLcb0pkJM1UZblHh5pUwipv/iKoWen0K+sEPgHynFdijcnAVAvpm/RIFnHGrCrpAu0WK
         vo3Q==
X-Gm-Message-State: AOAM531T2zxth8AYIsAijqNIqnU3UXQ6exzWs61Ctu3OGHWPJmEEOuKd
        qTG0l1HTTeBSi6yISmds1GosRQ==
X-Google-Smtp-Source: ABdhPJwEpp/sTgjo1+tUndCYaoZ9JuP+Qb7/WRdkeCt0wFxr5qiwBvoIfCh+KQZ/+TzyZd8kqkweMA==
X-Received: by 2002:a17:906:3949:: with SMTP id g9mr27002955eje.7.1617013593990;
        Mon, 29 Mar 2021 03:26:33 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id bx2sm8795750edb.80.2021.03.29.03.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 03:26:33 -0700 (PDT)
Date:   Mon, 29 Mar 2021 11:26:31 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     cy_huang <u0084500@gmail.com>
Cc:     lee.jones@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        jingoohan1@gmail.com, b.zolnierkie@samsung.com,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, ChiYuan Huang <cy_huang@richtek.com>
Subject: Re: [PATCH v6 4/4] backlight: rt4831: Adds support for Richtek
 RT4831 backlight
Message-ID: <20210329102631.sh5ttefjvfsfg6tk@maple.lan>
References: <1616945059-8718-1-git-send-email-u0084500@gmail.com>
 <1616945059-8718-4-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1616945059-8718-4-git-send-email-u0084500@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Sun, Mar 28, 2021 at 11:24:19PM +0800, cy_huang wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Adds support for Richtek RT4831 backlight.
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
> since v6
> - Fix Kconfig typo.
> - Remove internal mutex lock.
> - Add the prefix for max brightness.
> - rename init_device_properties to parse_backlight_properties.
> - Remove some warning message if default value is adopted.
> - Add backlight property scale to LINEAR mapping.
> - Fix regmap get to check NULL not IS_ERR.
> ---
>  drivers/video/backlight/Kconfig            |   8 ++
>  drivers/video/backlight/Makefile           |   1 +
>  drivers/video/backlight/rt4831-backlight.c | 203 +++++++++++++++++++++++++++++
>  3 files changed, 212 insertions(+)
>  create mode 100644 drivers/video/backlight/rt4831-backlight.c
> 
> diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
> index d83c87b..de96441 100644
> --- a/drivers/video/backlight/Kconfig
> +++ b/drivers/video/backlight/Kconfig
> @@ -289,6 +289,14 @@ config BACKLIGHT_QCOM_WLED
>  	  If you have the Qualcomm PMIC, say Y to enable a driver for the
>  	  WLED block. Currently it supports PM8941 and PMI8998.
>  
> +config BACKLIGHT_RT4831
> +	tristate "Richtek RT4831 Backlight Driver"
> +	depends on MFD_RT4831
> +	help
> +	  This enables support for Richtek RT4831 Backlight driver.
> +	  It's common used to drive the display WLED. There're four channels

Nitpicking but I was expecting the original typo be converted to
"commonly".


With that addressed:
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
