Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D13A6C46467
	for <linux-fbdev@archiver.kernel.org>; Tue, 10 Jan 2023 16:17:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbjAJQRW (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 10 Jan 2023 11:17:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233867AbjAJQRV (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 10 Jan 2023 11:17:21 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD098FC8
        for <linux-fbdev@vger.kernel.org>; Tue, 10 Jan 2023 08:17:20 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id j16-20020a05600c1c1000b003d9ef8c274bso6111451wms.0
        for <linux-fbdev@vger.kernel.org>; Tue, 10 Jan 2023 08:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9aNO7QvYwDQS+jP6UmKWe479dR/ZyNUMn3qprKjVB9I=;
        b=wIFmlQ/NS1cd3Ft15IPF5Qt6fSCo5kzlfVvC6NwxMqnEPLSx7IXbm6E5MlcxsTvI/I
         Q3DoELKpnsXbU4QL74nZ9Ynj8at68VE0sCNfWdGPBA8x+SdIK69ws7qT4RUbGm3Hq6nO
         ClaxsemmRkEjTAeBk8iha6ZGxiRQaNUxknlWjtDxzXrQRHbgppNP8MbHtgvtT/2LuFjB
         X0EOfWRmvFL8tW1L4YnYLcRqPoFrNBn3rNIoCKyqhmP/S+hPSzm2uue7ZlXYUmUi6CVm
         8cbu7Pb00PfpS7NPmVxM4VZA6GtZrVUQLcIiEYcb+a34ixYrcngaFnQXcSfUwEbfsTFI
         6rsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9aNO7QvYwDQS+jP6UmKWe479dR/ZyNUMn3qprKjVB9I=;
        b=skg8FvUsC/6Fb3rydFvOQ6ubznuV38do6bkpH+SyrFCDWWGO8K95flGzfx4uQZz8o/
         c0DpCG6KBcFf+VrH9aZmnZOkVlOaaLs/2AynIbcxzrfkt9Ui/n93nnfjqdMttHkecspK
         6He/ipDyDOC1AfPqykXjbzYWzcQ4E3sh6ym8qRLfU/OSUUNTz8prSesNDYhB8JfRL9lQ
         JgGBdln07qbvjqfC8oK2xPsWxmrRqPsgMZUh1AV0V7etlQnxOvUmOTFIuEzj+fLjYRc9
         BglcMRUTh8CMlKLFxweUiQKXpA41g39x1a4gzlgY+0PkkPyACkAts+OhLBNN3hGVjtVY
         06Xw==
X-Gm-Message-State: AFqh2krcNIEIX5BPaEHVrv48JkkFXsDOlet3+/eFXvOwpGaz1tQ4BnVN
        5ZtpAY5c2ziyp5FyHqhypvmNNw==
X-Google-Smtp-Source: AMrXdXtdHYGAOOA7IWrfaGhGuGxVKglU2btUiZ2nxiwOMk16l4FnFGqCikuGoCHjUCJQ1uEszp15Qg==
X-Received: by 2002:a05:600c:1d03:b0:3d3:4aa6:4fe6 with SMTP id l3-20020a05600c1d0300b003d34aa64fe6mr48900851wms.3.1673367439208;
        Tue, 10 Jan 2023 08:17:19 -0800 (PST)
Received: from aspen.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id x14-20020a1c7c0e000000b003d9f15efcd5sm6597893wmc.6.2023.01.10.08.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 08:17:18 -0800 (PST)
Date:   Tue, 10 Jan 2023 16:17:16 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 1/2] backlight: pwm_bl: configure pwm only once per
 backlight toggle
Message-ID: <Y72PjEh8QuLdw1hw@aspen.lan>
References: <20230109204758.610400-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230109204758.610400-1-u.kleine-koenig@pengutronix.de>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Mon, Jan 09, 2023 at 09:47:57PM +0100, Uwe Kleine-König wrote:
> When the function pwm_backlight_update_status() was called with
> brightness > 0, pwm_get_state() was called twice (once directly and once
> in compute_duty_cycle). Also pwm_apply_state() was called twice (once in
> pwm_backlight_power_on() and once directly).
>
> Optimize this to do both calls only once.
>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

This will reverse the order in which the regulator is toggled versus the
PWM starting/stopping. It would be nice to that in the description.

However I can't see why it would be a problem (since both remain in the
same place relative to the sleeps) so:
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
