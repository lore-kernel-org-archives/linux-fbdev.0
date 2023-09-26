Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC6B4E8181A
	for <linux-fbdev@archiver.kernel.org>; Tue, 26 Sep 2023 11:11:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjIZLLv (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 26 Sep 2023 07:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjIZLLv (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 26 Sep 2023 07:11:51 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFDE11B6
        for <linux-fbdev@vger.kernel.org>; Tue, 26 Sep 2023 04:11:41 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-31f7400cb74so7731305f8f.2
        for <linux-fbdev@vger.kernel.org>; Tue, 26 Sep 2023 04:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695726700; x=1696331500; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=u/MLMSmJRNmBGSS9dRqNvrvgUZYmB0L9NSn0EiK9+Hs=;
        b=tg1HnJIlfginnSQyWvdanP83HKucSwQFf8FeYPPCLqbZA9DdwBQaJi8EQXpjjC1Xhn
         pdHYTNETtd77W8EdnfGOguLHiJ7W6BYiv+R2GmFQq8mCRjLR2GQO05LF5LO8Uc/kPVnR
         12LdgmsIr+DgyBzC8l9JSdV/trcWoAndp8GpEfTuoDzHZaxhjW+kwQ/+yzRxVbDcE9TR
         Ihv1r6I14sIqTGHdbfOwHo+CHe32c7YUrCukCoefZ9K8zoGSLApLI4tL2qlpbkr0Xzcs
         64FW4XR/gpxypXWSu9JtnWgnqAukZmuKd2CXe2fliejDj3O5Av3MlgCS5bhgcKWXSSpY
         UCJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695726700; x=1696331500;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u/MLMSmJRNmBGSS9dRqNvrvgUZYmB0L9NSn0EiK9+Hs=;
        b=aU5Dd73Y+i7wWnZmCmeuRW3XIMARUnrff5b+V4LXY5gQmwk79mX04wqbsVBjBVwbWs
         Jc3XFMZZKeoUArA/FR9RIdDivLSn+fBJ020lNU87KfoWZTL3yMBkBnLnq3LwjLbdxunY
         H0j5C1g9kK6kelm0ll4P+sk9IcJmMv94fMdyO3z7lCINQ/A++/mS5me0LHnE7/clYkhn
         35ixpFybPu1jZMWxvRLbFqWB0jHKN+IjsSemf3O9ps4E7clB0M2G/Loaiv/i/R+dpmMa
         N+KKl3ur+s96tGToEt9GC6jt/sbTOVw/4EzrrzXAoL+RZ9EmaPiwDhuPpU20F0lOTz8s
         khlQ==
X-Gm-Message-State: AOJu0YyOe3LsMLaNiGq1YSeu+ausTtYvXJPxBBNl+Z28dW+ik9Cqgbtu
        M80IRxbdLG5DFDWqjq38pq2ZJQ==
X-Google-Smtp-Source: AGHT+IGgmiei3dmVPVwM/+kLjJAqZ4Dui7T/b864294DUFjV9lzha2Kyb8LLBEIC7UGG1WF/w42vgQ==
X-Received: by 2002:adf:9d85:0:b0:323:37af:c7c7 with SMTP id p5-20020adf9d85000000b0032337afc7c7mr1177540wre.69.1695726699756;
        Tue, 26 Sep 2023 04:11:39 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id t16-20020a5d49d0000000b0031c5b380291sm14405871wrs.110.2023.09.26.04.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 04:11:39 -0700 (PDT)
Date:   Tue, 26 Sep 2023 12:11:37 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Helge Deller <deller@gmx.de>, linux-pwm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        kernel@pengutronix.de, Aisheng Dong <aisheng.dong@nxp.com>,
        Aisheng Dong <asheng.dong@nxp.com>
Subject: Re: [PATCH v2] backlight: pwm_bl: Disable PWM on shutdown and suspend
Message-ID: <20230926111137.GA4356@aspen.lan>
References: <20230926084612.2074692-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230926084612.2074692-1-u.kleine-koenig@pengutronix.de>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Tue, Sep 26, 2023 at 10:46:12AM +0200, Uwe Kleine-König wrote:
> Since commit 00e7e698bff1 ("backlight: pwm_bl: Configure pwm only once
> per backlight toggle") calling pwm_backlight_power_off() doesn't disable
> the PWM any more. However this is necessary to suspend because PWM
> drivers usually refuse to suspend if they are still enabled.
>
> Also adapt shutdown to disable the PWM for similar reasons.
>
> Fixes: 00e7e698bff1 ("backlight: pwm_bl: Configure pwm only once per backlight toggle")
> Reported-by: Aisheng Dong <aisheng.dong@nxp.com>
> Tested-by: Aisheng Dong <asheng.dong@nxp.com>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Changes proposed look good (and the comment about badly designed boards
going to HiZ state we super helpful).

Only thing from my is why there is no attempt to disable the PWM
from the .remove_new() callback.


Daniel.
