Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B85C4332F
	for <linux-fbdev@archiver.kernel.org>; Thu, 26 May 2022 08:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238922AbiEZIGW (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 26 May 2022 04:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243234AbiEZIGT (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 26 May 2022 04:06:19 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9264465A6
        for <linux-fbdev@vger.kernel.org>; Thu, 26 May 2022 01:06:17 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id u20so869883edd.6
        for <linux-fbdev@vger.kernel.org>; Thu, 26 May 2022 01:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=sUkmzj/ADcLd5/ZTwCBIMC1VkofTmfRrB5QzPtIaDYU=;
        b=v+j82K8mfWplzPhJgQTvvkdsrW4ep2fg0akniwwQRvQGw1N1vv6rzKO8bLSE87v6RH
         qHY7bpwZM4pu3NQ1CWJElgwg7x4jSDN38D7qilYSji7vcXlebCDtj6I7jFHSHQiC0HVM
         HA16tLdBsMZV6BPjfg2vFdSOUvYRdf4YiRQxFFGyJZB3RXTGPuY1Ie8jQ0HMAnqScPzE
         cGHhqogr+jYP5YubxOScrh6Q0O0ip+lfBTf9CC2M1W34s5MYT4O177ip0u7YSIzThoku
         ZSIu7YadVYQRnw71EncaJBmsf3GGQwvvnSPsKVhggXGFGntOmSVEUsDJDxW89x6vRzDv
         iPPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sUkmzj/ADcLd5/ZTwCBIMC1VkofTmfRrB5QzPtIaDYU=;
        b=7lmbfPsvQV2wYbYpBnL4LLChxHE/UCK4GcNj89SpX2Pfo6NseU7bBvtNQlQ9Zbc/vh
         erHlNGjAJphRM3/a786U8AOxQs2QnTjgCRCbWsVpFVy+pmvLRtpEWX0b0bli7RHGiPPD
         8dOx/SpccGJ1qGyIgbPN7ZQrvN56L3talLkzgtshin+SxAr9mZBcXxA3vKQXw5sXEL7S
         AuzV3qcOP32QqbLQW9S9mDkwFTt4Ccua8N2QxS5T98rzytbfSnXpoDP1EvmgeQyKBh06
         iEHq2Xbt7dh19nKYEM4alRBumBnBvj2CSP8G7TBqy6VgyLe/4nkqoSp2+eSiuLEnrCF+
         g5jA==
X-Gm-Message-State: AOAM5329xpPb3TYUkTL23KL2uSLs/bPzTCMGuwQYmvAM4CV7IWKKybVg
        JzaPs4B06Qade7fdFVyXxpo+jw==
X-Google-Smtp-Source: ABdhPJxWjuIfxzMKDXFsg01+5Vhg8sivYXhTKhgry/uxO/ijt7GFzDqruEKAGFJicT2JghXL094i6Q==
X-Received: by 2002:a05:6402:34c1:b0:42b:4047:20b8 with SMTP id w1-20020a05640234c100b0042b404720b8mr26707436edc.88.1653552376113;
        Thu, 26 May 2022 01:06:16 -0700 (PDT)
Received: from [192.168.0.177] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id u10-20020a50950a000000b0042617ba63a5sm458132eda.47.2022.05.26.01.06.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 May 2022 01:06:15 -0700 (PDT)
Message-ID: <1c7ab94c-a736-c629-bd8c-8a974803e2b9@linaro.org>
Date:   Thu, 26 May 2022 10:06:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/2] dt-bindings: backlight: rt4831: Add the new property
 for ocp level selection
Content-Language: en-US
To:     cy_huang <u0084500@gmail.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee.jones@linaro.org,
        daniel.thompson@linaro.org, jingoohan1@gmail.com
Cc:     pavel@ucw.cz, deller@gmx.de, cy_huang@richtek.com,
        lucas_tsai@richtek.com, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1653534995-30794-1-git-send-email-u0084500@gmail.com>
 <1653534995-30794-2-git-send-email-u0084500@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1653534995-30794-2-git-send-email-u0084500@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 26/05/2022 05:16, cy_huang wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Add the new property for ocp level selection.
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
>  .../bindings/leds/backlight/richtek,rt4831-backlight.yaml         | 8 ++++++++
>  include/dt-bindings/leds/rt4831-backlight.h                       | 5 +++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/leds/backlight/richtek,rt4831-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/richtek,rt4831-backlight.yaml
> index e0ac686..c1c59de 100644
> --- a/Documentation/devicetree/bindings/leds/backlight/richtek,rt4831-backlight.yaml
> +++ b/Documentation/devicetree/bindings/leds/backlight/richtek,rt4831-backlight.yaml
> @@ -47,6 +47,14 @@ properties:
>      minimum: 0
>      maximum: 3
>  
> +  richtek,bled-ocp-sel:

Skip "sel" as it is a shortcut of selection. Name instead:
"richtek,backlight-ocp"


> +    description: |
> +      Backlight OCP level selection, currently support 0.9A/1.2A/1.5A/1.8A

Could you explain here what is OCP (unfold the acronym)?


Best regards,
Krzysztof
