Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A2EC433EF
	for <linux-fbdev@archiver.kernel.org>; Wed,  8 Jun 2022 09:54:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234314AbiFHJyc (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 8 Jun 2022 05:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235852AbiFHJxk (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 8 Jun 2022 05:53:40 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BBF7425D40
        for <linux-fbdev@vger.kernel.org>; Wed,  8 Jun 2022 02:23:38 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id a10so8037392wmj.5
        for <linux-fbdev@vger.kernel.org>; Wed, 08 Jun 2022 02:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8eV6nIYV8SU6cGKfjJH6IuBQJkesB4s+GfYeW1ujbBY=;
        b=yfPJviBzBPAoWfqiRyBev2YmtSekag/ce5R4TXWS48H1P/Evi7E5TB4vT3PR3E8aj3
         W7V+yIRePpReAEdegxUDxKd1K5j3YcZ/X9I2dg95aREfa2ooixPGrI4JNbofdS5Sq1cJ
         W42F5YcmUZk2zJk+QQk0+MVdp0O0W1Pk01mKCNppDXZyCUkjqBW10RbxyMuj7ydHz4dZ
         PfnejUW3iyyNEIkJcCSwpK+9Ki08hmTYbDfedqOsRj+WbfyXvmi6OR4qm+K/cObXS/t9
         HYm9o8wLPshlOpW4G0YGfzNBC2K2TstMcRLWAUaLgN+v2Db+PnvZLxiNHb1dAZfixesi
         jIXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8eV6nIYV8SU6cGKfjJH6IuBQJkesB4s+GfYeW1ujbBY=;
        b=ZAqaQf12hSd/3qv2A7rMWXf7SDfBHY9y8dVO01N+2TMYzb3ABOW8BP7llQZ7CzRnvu
         m3WLMQbtb0fp8j1a7wQUn23zIOWOmQDqEzbwC2k5vVz7kgaHklseFPtP3lGlIAPD131C
         ORoeap/Zl+yACTPonSsF2h5ZZ8Suol7usBvnvU7tdRYDiaQ8mVUN+ejLFroZQyXnCMWe
         HI8Smc0NDqSHBxJyXXA/ZiIRwAEpriGGQ3KG/h6rIHBqXslu9zueJtMPaNHJOBe3Skvj
         Saff4AQhdypOpSUvXuMUUHcWnu1MAewx87wH/zBRjLzu+IyMbiEMry0yjW5AEY+urn3K
         +r5Q==
X-Gm-Message-State: AOAM531cT0feVa00WhiHonvCwDPqTkik0x+KNg5dVLQWP5bevBDvjkEU
        APO4yEs6U9QGzvEO841K+Q0oHw==
X-Google-Smtp-Source: ABdhPJyM+IflvMN2gKuuxgwYkvwPOCyEfY1Cnbc1MlR6mjMqp5ng/HykRi2LIV6jvv1XqHQatPbucg==
X-Received: by 2002:a7b:c5da:0:b0:39c:542a:a07b with SMTP id n26-20020a7bc5da000000b0039c542aa07bmr13928306wmk.83.1654680217388;
        Wed, 08 Jun 2022 02:23:37 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id o18-20020a05600c4fd200b0039744bd664esm27578721wmq.13.2022.06.08.02.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 02:23:36 -0700 (PDT)
Date:   Wed, 8 Jun 2022 10:23:34 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     cy_huang <u0084500@gmail.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee.jones@linaro.org, jingoohan1@gmail.com, pavel@ucw.cz,
        deller@gmx.de, cy_huang@richtek.com, lucas_tsai@richtek.com,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] backlight: rt4831: Apply ocp level from devicetree
Message-ID: <20220608092334.23srjgxsjmj7mwer@maple.lan>
References: <1654677674-15417-1-git-send-email-u0084500@gmail.com>
 <1654677674-15417-3-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1654677674-15417-3-git-send-email-u0084500@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, Jun 08, 2022 at 04:41:14PM +0800, cy_huang wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Add 'richtek,bled-ocp-microamp' property parsing in
> device_property_init function.
> 
> This value may configure prior to the kernel driver. If it's not specified in
> devicetree, keep the original setting. Else, use clamp to align the
> value in min/max range and also roundup to choose the best selector.
> 
> Reported-by: Lucas Tsai <lucas_tsai@richtek.com>
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
