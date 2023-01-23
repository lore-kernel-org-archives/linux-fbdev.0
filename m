Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4225C54EED
	for <linux-fbdev@archiver.kernel.org>; Mon, 23 Jan 2023 14:31:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbjAWOa7 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 23 Jan 2023 09:30:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjAWOa6 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 23 Jan 2023 09:30:58 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9094E24483
        for <linux-fbdev@vger.kernel.org>; Mon, 23 Jan 2023 06:30:56 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id t5so11013643wrq.1
        for <linux-fbdev@vger.kernel.org>; Mon, 23 Jan 2023 06:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Da+hSgaK1WT1wNbShCQdIMzhNbm+JCBNC1eXaZYQxFk=;
        b=tU8ACDmnm9fiGwunC7HIXCP8Ktp9bCMq5U11MQkNlNME2Huocmq5Et448WBGb5jai+
         ADGxO7Beqc8tuuXO3z+b12QKQgpZ+aw1iuRBTBPpm3V/vbBX8rFVkeoZivusI98OrTFf
         iD4SslwY72kanILbDAP1c7W8dz7RNMYC1W+uV3vThRUFxixBEfLQSsk3rNibOex3HOis
         AwkS3dP6OrrpfquzoZKq76Oe/PAoS0f1zYoWovWErMmxJ4yMlj9wEX1d7dU2eAnmZBqN
         1t8pwAoy3xyrZCfx4wCG/wc1ngIy1x/leAPP/vb8VANwRAjNfO9FuBpmADRF3zZjpTwJ
         1DUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Da+hSgaK1WT1wNbShCQdIMzhNbm+JCBNC1eXaZYQxFk=;
        b=f6e/dAmlMAYsiPC2jSrPRSeBeQLK7WYyHi6/KxTec+bAr3HtldbO/+P3e72EARfUN+
         lSwVKID7dYz73rIXfB4L43qlRKKOmXZcv82L41/KQevAoPowivtkUSWYpZD2G1AhrEnj
         RfmZqwU0yXwakKUs3iPvOgk6aFfE9qoxs+pZZ0ICUoQm2dOtkPcdOHCtk5jz5LkjOEYn
         VJoUPHtRTTHQEEB8QLV4XQvdcn0S+GVE0rlSnMpxqHu+7xGvFwHkG5RUleL9j0AVRx9t
         fA2XkgjD4rMTLWHDgBYhwVWeyy0uMbnmU+AwN3RQmjWTVbugF9/GG1xftFNx2bCfB6iI
         FVwg==
X-Gm-Message-State: AFqh2kp8peN80z8M61xQeWxppBxMKw322ulAlspXSEVLT+ov7X279uka
        uy3BclX0A1E8X16x6GngLLtpooePeqGGbvY7kWc=
X-Google-Smtp-Source: AMrXdXu+/DzWFdvmrnHqMwUtpEwkMO5ieJgcY5ksKjZub1P+gC1GsvWZFBORDjzoRtJl3KmDgpB+2g==
X-Received: by 2002:a05:6000:608:b0:28f:29b3:1a7f with SMTP id bn8-20020a056000060800b0028f29b31a7fmr26030725wrb.36.1674484254755;
        Mon, 23 Jan 2023 06:30:54 -0800 (PST)
Received: from aspen.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id c14-20020a5d4cce000000b002426d0a4048sm5068204wrt.49.2023.01.23.06.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 06:30:54 -0800 (PST)
Date:   Mon, 23 Jan 2023 14:30:52 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Jianhua Lu <lujianhua000@gmail.com>
Cc:     Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Helge Deller <deller@gmx.de>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v9 2/2] backlight: ktz8866: Add support for Kinetic
 KTZ8866 backlight
Message-ID: <Y86aHA5JMHPgkB9A@aspen.lan>
References: <20230120155018.15376-1-lujianhua000@gmail.com>
 <20230120155018.15376-2-lujianhua000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120155018.15376-2-lujianhua000@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Fri, Jan 20, 2023 at 11:50:18PM +0800, Jianhua Lu wrote:
> Add support for Kinetic KTZ8866 backlight, which is used in
> Xiaomi tablet, Mi Pad 5 series. This driver lightly based on
> downstream implementation [1].
> [1] https://github.com/MiCode/Xiaomi_Kernel_OpenSource/blob/elish-r-oss/drivers/video/backlight/ktz8866.c
>
> Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>

Thanks for all the changes!

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
