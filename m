Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E4D4C001B0
	for <linux-fbdev@archiver.kernel.org>; Mon, 14 Aug 2023 08:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjHNIlw (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 14 Aug 2023 04:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234153AbjHNIlW (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 14 Aug 2023 04:41:22 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CB310B
        for <linux-fbdev@vger.kernel.org>; Mon, 14 Aug 2023 01:41:21 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fe4cdb724cso37662665e9.1
        for <linux-fbdev@vger.kernel.org>; Mon, 14 Aug 2023 01:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692002480; x=1692607280;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D5aLdYoDzonLAxZ5PSMomSbWxhFnGKGGnvbysSjVTVc=;
        b=nofShKkvBm0DO7xSJvOuELrwERW3RQEALYLWsAtldEaPqBHXOHp5mq6q4Z+IIwAeGI
         YFH55cFn6nnypFsgmDfbucGvylbLdOgahjrrmYN9y0rYFtqHwd9Vc6HaqtOwFVf5b5la
         H370hVR3iiSCbWVK9CKhDvQAjetELuWJC6hTyXN2gjmnJVIPeK32XDAW5R9WmU9Q7FGh
         XWsZ9+Pgg4E/iu3mQUwWrDEPePMo5MatDfAbZsOc674cSBUbaA0nH5R/pjzziJ8ZOBI6
         ho5ASHWnT19j1Cqq5skAl8fPpQydUAX4YW4HK2V3M1SLuQjTjsUNm6QzqpXRoZbUsaQ3
         ODxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692002480; x=1692607280;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D5aLdYoDzonLAxZ5PSMomSbWxhFnGKGGnvbysSjVTVc=;
        b=MoY60sZqVtrB4rR00oaIHx5t+tv4dNnfPVLadoeA+1WaOuErdN3nWO9U5B+5aKrxdB
         98O1wSEBsZ4yCxh4DVRsAQZUPFTBMmEju1HTwhNb1i8fdGanU0EDumjnQlpurzgAX88h
         +jGWkAbEceiQEB+LFYRk+sAiSiqKqX+nc04peToYvxqnFKsriAEmJ2zJoil3bwsEoyDq
         pL+6MA/w2913TlhRugkHgrgkNDrLBhV/6DGwABPxFT/kufMX8D6JLsq8xuy65M75U6Le
         LYuatOH7SGiOtkZN4whT5F1gN+3xbzdEd0cmeWMcNh/YglLjolB5dVH4m/PXln61yLYY
         OOOQ==
X-Gm-Message-State: AOJu0YwSlX2nuWhzrXCdDsUN1U3AN2OXhH9Tlhno+0pYH2jDKqYOpwlt
        kXldmKU1G0vQAIjyREdLxk+9TZ1gm3NtFtXlCfE=
X-Google-Smtp-Source: AGHT+IEjqxBt+uF9fAJFXmoE7E2jsAgWdkYg6ku2TUxOU9VSoYR5tHOmsX19STi7JTMgtzI/v48xfg==
X-Received: by 2002:a7b:c045:0:b0:3fb:e054:903f with SMTP id u5-20020a7bc045000000b003fbe054903fmr6941460wmc.36.1692002479946;
        Mon, 14 Aug 2023 01:41:19 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id v23-20020a05600c215700b003fe1ddd6ac0sm16527413wml.35.2023.08.14.01.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 01:41:19 -0700 (PDT)
Date:   Mon, 14 Aug 2023 09:41:17 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Artur Weber <aweber.kernel@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backlight: lp855x: fix unintialized function return
Message-ID: <20230814084117.GD5056@aspen.lan>
References: <20230811131600.2380519-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811131600.2380519-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Fri, Aug 11, 2023 at 03:15:53PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> The function now returns an error code in some cases, but fails to initialize
> it in others:
>
> drivers/video/backlight/lp855x_bl.c:252:11: error: variable 'ret' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
>         else if (lp->mode == REGISTER_BASED)
>                  ^~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/video/backlight/lp855x_bl.c:256:9: note: uninitialized use occurs here
>         return ret;
>                ^~~
> drivers/video/backlight/lp855x_bl.c:252:7: note: remove the 'if' if its condition is always true
>         else if (lp->mode == REGISTER_BASED)
>              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Since this case should not actually happen, return the -EINVAL code.
>
> Fixes: 5145531be5fba ("backlight: lp855x: Catch errors when changing brightness")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I think we already received a patch for this:
https://lore.kernel.org/lkml/20230809163825.GA5056@aspen.lan/T/


Daniel.
