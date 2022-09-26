Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C19DAC32771
	for <linux-fbdev@archiver.kernel.org>; Mon, 26 Sep 2022 15:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235781AbiIZPJg (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 26 Sep 2022 11:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235917AbiIZPIv (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 26 Sep 2022 11:08:51 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A8B1C417
        for <linux-fbdev@vger.kernel.org>; Mon, 26 Sep 2022 06:41:53 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id y5so10306997wrh.3
        for <linux-fbdev@vger.kernel.org>; Mon, 26 Sep 2022 06:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=2nV3OnX8WCDnxp7VmTZBQLJ8CRRFanST3tqzj4Y4KE8=;
        b=YA1QVKi9UhBceT8AYoU50XlwYm1lOjXb2nuUznMFTiWrlEK+LzOJWcLB2yqp+o1A6w
         bI1XP1RJWoBGDcNWWwN6OL265YVGYxudeRrZpoEVwxxW4/4Yi7xovqZ1h/YBF+6gkjMr
         HD3HUKt0HkfkclClzLJrVUh9gxPgYo+je1bhwvBmyAxMsghzNrnwi8k+HhBT6EvMW5nI
         YBI7y2/Aa6SDSE/3mYbNhWbQxOOgGf3NKXs4Q4banlgt57gqTvNqu2cwK89pTdN1Ip0T
         mOAys+URoeP83ML0gNV7IAxuTikg89HfJsEh0Tnbi2XkCTZ2VkdQUaslAuYWWbYRqApY
         8KuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=2nV3OnX8WCDnxp7VmTZBQLJ8CRRFanST3tqzj4Y4KE8=;
        b=00L4TNkf5HxpWTYHsjyHtdY56A/hCvsk+3NeYGo+b+E4wHAJhyP78F9IV+4nh/w5I5
         4AIM6FGxgqKWGrEr9b2RvZqOuvnuT9CuyVq33MIoqIk8qWWeRUFTnRy+gxsypc56osSu
         3wxx0/lWPq8lyuOnqFdtgi90rwplid7uGfaIiQMuYEXsTD+Oqut2Z6nK4FWeibXjly7c
         WjFmjaoLjxfO2v9tV7AdtIcOqLiaCMXhUvKX9HMiqcaadmqxYENBgPOMb1NgFd9/ZKfb
         U51excy6LDWqxyjD/ec6RF5wbeiyVG6A0XX2m0FZGZlr/jJDoAJRIfjbgeSSxmM3gWMO
         03IA==
X-Gm-Message-State: ACrzQf07NZzP3/HRTGw1SfxIbpFX0SrSDwG1ONkRu+wU734OBaAaTC0v
        6Y+XhB6wMLb9JARrwJ1VkxtMd58qXUlKzOLu
X-Google-Smtp-Source: AMsMyM4Uq3HSM4U6VhE/gf8dGJYxbyoeho5aabOD87EFFcvHpRSUKodVZ5it2S0OCse+91AeNK77+A==
X-Received: by 2002:a05:6000:2cd:b0:22a:4831:dfd with SMTP id o13-20020a05600002cd00b0022a48310dfdmr13309159wry.706.1664199712029;
        Mon, 26 Sep 2022 06:41:52 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id x2-20020a5d6b42000000b00225307f43fbsm14449467wrw.44.2022.09.26.06.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 06:41:51 -0700 (PDT)
Date:   Mon, 26 Sep 2022 14:41:49 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-fbdev@vger.kernel.org, linux-pwm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee@kernel.org
Subject: Re: [PATCH -next] backlight: pwm_bl: Switch to use dev_err_probe()
 helper
Message-ID: <YzGsHadJ+HGJETJv@maple.lan>
References: <20220926133258.1104850-1-yangyingliang@huawei.com>
 <YzGrLsNrwEyL98nP@maple.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzGrLsNrwEyL98nP@maple.lan>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Mon, Sep 26, 2022 at 02:37:50PM +0100, Daniel Thompson wrote:
> On Mon, Sep 26, 2022 at 09:32:58PM +0800, Yang Yingliang wrote:
> > In the probe path, dev_err() can be replaced with dev_err_probe()
> > which will check if error code is -EPROBE_DEFER and prints the
> > error name. It also sets the defer probe reason which can be
> > checked later through debugfs. It's more simple in error path.
>
> I'd prefer to have received these patches as a patchset rather than
> individual patches... but it is a good change so:
>
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>

Oops. My last mail neglected to mention that you did not sign off your
changes (meaning we cannot accept them). When you re-send this please
add a SoB and combine with the other similar patches.


Daniel.
