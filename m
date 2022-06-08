Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E48C43334
	for <linux-fbdev@archiver.kernel.org>; Wed,  8 Jun 2022 14:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241114AbiFHOcj (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 8 Jun 2022 10:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241422AbiFHOci (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 8 Jun 2022 10:32:38 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5F62228FB
        for <linux-fbdev@vger.kernel.org>; Wed,  8 Jun 2022 07:32:37 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id q15so7867236wmj.2
        for <linux-fbdev@vger.kernel.org>; Wed, 08 Jun 2022 07:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mHZcc87752dCD5EakMLSwQMgSNKMbCnC16gyyFD++5I=;
        b=iRZ0wVla5u9zp0SUCSyUiAxjH9RAE3J3FBcCkxHdsTvZIAvAoIiTfT3tGOS1jmquHP
         Enoc55DWAOCNnBOHOmwCwtXBbjlfVIHI6d3yv8fr49HgEeyDerdVlFc0Z06gG6D9H2Zc
         ynOKMPLCV8XcC63V2GeH92kmwKS4cmctokNnA27r/B7x0K8MVdJDWThBTADofYW2KKUa
         TxgX4BUGEdEdWdUi38Bw7CeqWaY27VL6grEHQPI5VPySkrXILGpvdxV0CJQlRePRGivJ
         +nc2kRpn2YpwEzoG93IWD2tGyGJzfgXAni+5vvNxb3gXzfbLcKH6SCQSOXtZzcUMxV7T
         u7BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mHZcc87752dCD5EakMLSwQMgSNKMbCnC16gyyFD++5I=;
        b=ALWJyw+jUmP0ZBR4TdfMX50R4MgG03XIejg5DRxH8hvXPyi1ImXBEgkUKD/kRsORtd
         Di5mmaf39toa54+rXjaO07K/eXP9YwToUG8HxBeo2zgDDhbhoxuDcrzrVDz5sJfAWazQ
         Jn7A023TvpiopFm2Ov3g4u7ARMb8rcLSOQkc77Kicce+xwOgKEEh+RB7Xiai1BJl+Gn4
         BOYOMm5w4VvxDGgbOGdhJBwUgKVgHlEYy7BJTHoBiCsN7b7eRk6t4Yo0jq1ZShct131C
         8xH/stJAmldrMBIC3HErtIohQG0taGjK3R/xsWXCHxtT9nuDptJZJ/oTllutvhYoUr0O
         uQ8g==
X-Gm-Message-State: AOAM533Pg4migloJPBGrS5fC15hS+2roHxmr3zKFPZ9s5k9EY/VFwnqV
        OAqoTZ//yD/81Ae8AeYx4WV9hQ==
X-Google-Smtp-Source: ABdhPJwXEQ4i7ZpLaMkGxRTUYH9S/yoGBN8D+OBla3n/ONr6sTpO9FmexKwaO58/OLLltjA4Tnbt+Q==
X-Received: by 2002:a05:600c:3b2a:b0:397:3e63:3db8 with SMTP id m42-20020a05600c3b2a00b003973e633db8mr62698557wms.40.1654698755974;
        Wed, 08 Jun 2022 07:32:35 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id b12-20020a5d4b8c000000b0020feb9c44c2sm21540231wrt.20.2022.06.08.07.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 07:32:35 -0700 (PDT)
Date:   Wed, 8 Jun 2022 15:32:33 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] backlight: aat2870: Use backlight helper
Message-ID: <20220608143233.l5pbopafqc4n6uwq@maple.lan>
References: <20220607190925.1134737-1-steve@sk2.org>
 <20220607190925.1134737-2-steve@sk2.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607190925.1134737-2-steve@sk2.org>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Tue, Jun 07, 2022 at 09:09:22PM +0200, Stephen Kitt wrote:
> Instead of retrieving the backlight brightness in struct
> backlight_properties manually, and then checking whether the backlight
> should be on at all, use backlight_get_brightness() which does all
> this and insulates this from future changes.
> 
> Signed-off-by: Stephen Kitt <steve@sk2.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-fbdev@vger.kernel.org

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
