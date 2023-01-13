Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23996C54EBD
	for <linux-fbdev@archiver.kernel.org>; Fri, 13 Jan 2023 16:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjAMQ0L (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 13 Jan 2023 11:26:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjAMQZc (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 13 Jan 2023 11:25:32 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA4F63F77
        for <linux-fbdev@vger.kernel.org>; Fri, 13 Jan 2023 08:19:16 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id j34-20020a05600c1c2200b003da1b054057so3413132wms.5
        for <linux-fbdev@vger.kernel.org>; Fri, 13 Jan 2023 08:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zhz9fWOoERNBAN38ex2htt2h7c3lJT7eoS2NI1GaWwA=;
        b=CbuR3CX0p4skKGw4xsujWI8bAF7IwZzXvafQLAFYWfdT0cxwQOuyzMYog3nQApK4yI
         mCW7BeHY/pvbQTUb59i30dWLoZhyWomHHyOS+sGJxH8Y/dR2vu5seIdkLfGG+7YsA9Fb
         qpQWX+O6m5BmLLqlpzcxO9JUiBRoRmS4yzxX3efqbhb3HvpWz5lhknuFi+wKcE0psmb1
         lj0uMe9tPyg41MpQ13/XWD74HsAN+WUzcJz53QwLEpIaoCIY11CH3xkk++CgkGN/fZzh
         4bo/t6CCMyiBaClf424D7IxEmdHPI7DinlsDlmKY/ne9mgijFk51gpnJU8oLiap7TS7G
         MQ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zhz9fWOoERNBAN38ex2htt2h7c3lJT7eoS2NI1GaWwA=;
        b=Pj9uxecS9Vk+iEKDNPC2xECRPD6Hv7VgnezzKxCeYwmQQXAjueDbB55RuNUKgbFEOF
         3B+xV71r/xRob9tkpv6tDnTleFZc+nBinQdLEqI+pqxEvXS6bBY1k01giPJnwan5gLr8
         lPdOdm2s9JJ+Ys1V/k3dBfFJKE3OzPRtCiwIoysEM4+mDmss4VWRhkUkET1/1kVQUFwg
         9ImsLuByb6lMMvVYofFnUIDk8s2SqZ/ZExPc+u/ANf+3a+Zh/ytX0M5j6TihXIlPKi95
         u0Ovh6ekdyN6pLpWrhEWoDEbwEST9TKUFWVcShg9KTex8ybgEcz0IRogKoiAodixvg1z
         8/Xw==
X-Gm-Message-State: AFqh2kpsCQUPvH0YcFbti44wX3UoIAZjLmf64harJm2hUo+A4D+V7NB+
        H/EpytgJd/8jQ04Dvc0L3pL8iw==
X-Google-Smtp-Source: AMrXdXtIgncPdiydx2VlDE0pGuWdm7d/in7Wu/0hk+2SCGaU6GE63Rke3KKAMtwlBX6B8wIfaEEE0g==
X-Received: by 2002:a05:600c:3844:b0:3d2:191d:2420 with SMTP id s4-20020a05600c384400b003d2191d2420mr59847990wmr.7.1673626754635;
        Fri, 13 Jan 2023 08:19:14 -0800 (PST)
Received: from aspen.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id j6-20020a05600c42c600b003b492753826sm23729637wme.43.2023.01.13.08.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 08:19:13 -0800 (PST)
Date:   Fri, 13 Jan 2023 16:19:12 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
Subject: Re: [PATCH] backlight: ili922x: fix kernel-doc warnings
Message-ID: <Y8GEgFlw+q0P+2em@aspen.lan>
References: <20230113064108.29172-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113064108.29172-1-rdunlap@infradead.org>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Thu, Jan 12, 2023 at 10:41:08PM -0800, Randy Dunlap wrote:
> Convert comments for START_BYTE() and CHECK_FREQ_REG() macros into
> kernel-doc notation to avoid these kernel-doc warnings:
>
> drivers/video/backlight/ili922x.c:85: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>  * START_BYTE(id, rs, rw)
> drivers/video/backlight/ili922x.c:118: warning: expecting prototype for CHECK_FREQ_REG(spi_device s, spi_transfer x)(). Prototype was for CHECK_FREQ_REG() instead
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Lee Jones <lee@kernel.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-fbdev@vger.kernel.org

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
