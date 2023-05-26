Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23377C7EE23
	for <linux-fbdev@archiver.kernel.org>; Fri, 26 May 2023 10:27:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236835AbjEZK1R (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 26 May 2023 06:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjEZK1R (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 26 May 2023 06:27:17 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2BE10A
        for <linux-fbdev@vger.kernel.org>; Fri, 26 May 2023 03:27:12 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f6d01d390bso6236365e9.2
        for <linux-fbdev@vger.kernel.org>; Fri, 26 May 2023 03:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685096831; x=1687688831;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YfIXJEMjywgbIaPnMejEqfeJlu29DLDhW+hRk8nBYC4=;
        b=WYZCFJVExeDVYp9MYxoWE58L9LDV10iEHG8v3I8k6jtl930DQwLlq7iZSV6CDtyHdD
         eQoA0t0VfzgWmxBKmXy9SX16Av1QD2N1bSTTCZMqaT6Uz+v+r+FTQhPURpRiSNdKsqiM
         IASMSZDBvGoLIsMDJwg8dCLsh0SulVWbLVni8bJ9S+dCOynjfEyvMiJsxO71uR3xHc/a
         eTz3FbvivrNbYU5oIziujcPbzvWnkd3RhLyVmuYOQLaORhPbmWOBaDpx4D+FxU5p+ig/
         SH0lnSMs+moJ7aH0ytEW+b6cRz2w4Vd5laCpLD9Fq1GFfIhGXa77qlBaKmEmxXmoWEcV
         BMnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685096831; x=1687688831;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YfIXJEMjywgbIaPnMejEqfeJlu29DLDhW+hRk8nBYC4=;
        b=cIyZvCyAUsal/kPhS0VHO5zmHn9nViAetk0G2e89SSgnX2/25LxvrIFrvI45qxSXF+
         366Vxue0oWZo/ulfcLopCam2/RToEDZgdCWoBFeP7ia0peiUY27loU0nkRnOq+g62/f7
         Kk9NwGbHei23hAQo3mbKAIZjliE9ljfO6msKTsDUtIU6jtZDuVq23KW7NXLMu3PKjahP
         1xH460njhoBUlfXsiovWgJOsp5U7GxfLBniRray6DcpH0qTgWgODG5URMnb0AWOwZ+0I
         gV14Ojr4VYlpzhA0AFdZ8fOBfO45OvGfae0xW/L3bnY0EvZoA3UiZ5nOEJsDcQ9Ri1vX
         ENQA==
X-Gm-Message-State: AC+VfDyvLGmbkG9JFSzbq8rLIgAFw6R4El1WwrOYC6YccqNsDtNvV3UC
        OwqIxnrdY2EiVuTLUgrxUQdnEg==
X-Google-Smtp-Source: ACHHUZ6IzvKAf5IPmjt8K9b1nutegl78hAyGPJdoaYhRnE2oMuBVUeelQwu3T/SDLVPuKWVVJeKIcQ==
X-Received: by 2002:a05:600c:2042:b0:3f4:2e13:ccdc with SMTP id p2-20020a05600c204200b003f42e13ccdcmr1326649wmg.0.1685096831092;
        Fri, 26 May 2023 03:27:11 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id l22-20020a1c7916000000b003f607875e5csm8452340wme.24.2023.05.26.03.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 03:27:10 -0700 (PDT)
Date:   Fri, 26 May 2023 11:27:08 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Alexandru Ardelean <alex@shruggie.ro>
Cc:     dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fbdev@vger.kernel.org, lee@kernel.org, jingoohan1@gmail.com,
        pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        deller@gmx.de, Yannick Fertre <yannick.fertre@foss.st.com>,
        Philippe CORNU <philippe.cornu@foss.st.com>
Subject: Re: [PATCH 1/2] backlight: gpio_backlight: add new property
 default-brightness-level
Message-ID: <20230526102708.GC626291@aspen.lan>
References: <20230519200520.10657-1-alex@shruggie.ro>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230519200520.10657-1-alex@shruggie.ro>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Fri, May 19, 2023 at 11:05:19PM +0300, Alexandru Ardelean wrote:
> From: Yannick Fertre <yannick.fertre@foss.st.com>
>
> Add new property to set a brightness by default at probe.
>
> Reviewed-by: Philippe CORNU <philippe.cornu@foss.st.com>
> Signed-off-by: Yannick Fertre <yannick.fertre@foss.st.com>
> Signed-off-by: Alexandru Ardelean <alex@shruggie.ro>

Patch order should be reversed for v2. Nevertheless:
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.

>  	struct backlight_device *bl;
>  	struct gpio_backlight *gbl;
>  	int ret, init_brightness, def_value;
> +	u32 value;
>
>  	gbl = devm_kzalloc(dev, sizeof(*gbl), GFP_KERNEL);
>  	if (gbl == NULL)
> @@ -93,7 +94,11 @@ static int gpio_backlight_probe(struct platform_device *pdev)
>  	else
>  		bl->props.power = FB_BLANK_UNBLANK;
>
> -	bl->props.brightness = 1;
> +	ret = device_property_read_u32(dev, "default-brightness-level", &value);
> +	if (!ret && value <= props.max_brightness)
> +		bl->props.brightness = value;
> +	else
> +		bl->props.brightness = 1;
>
>  	init_brightness = backlight_get_brightness(bl);
>  	ret = gpiod_direction_output(gbl->gpiod, init_brightness);
> --
> 2.40.1
>
