Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857ECC43334
	for <linux-fbdev@archiver.kernel.org>; Mon, 18 Jul 2022 08:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233250AbiGRI36 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 18 Jul 2022 04:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233496AbiGRI36 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 18 Jul 2022 04:29:58 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8713117AB3
        for <linux-fbdev@vger.kernel.org>; Mon, 18 Jul 2022 01:29:54 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id z12so15946366wrq.7
        for <linux-fbdev@vger.kernel.org>; Mon, 18 Jul 2022 01:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Pvrgndmmn8YktJ8T281XpjP9LliHnMlSYEnEf1KWrn8=;
        b=w/VI4XpE1c0gfAglNbNRXAhqPaRGANN0H3VlIihlDxCg0AFssRZyH9JH2CMhjh+m16
         r9kx4cxZCwdPZHxM0QdTBdRa5GCRRy41dnLXaFC6kIw9J1f5Ud1bVQRDVEUOu+LjUtdS
         0y0tP5IbD4pC0v7bW4NL3pvVOPG6p3ApdqDU1kFlB76VT7bI00QQ0lrVHyUiX7XOGp7o
         j1sVgLaVztKSzwMJSZyw6MYGaI14FICoLPBg+neREy/8xVc3QW7pyhn80waPTWnR9x2t
         9XNnDuiZm3q7jQ/GPmcSMQk6KrtZeHHA+RqZ7x6QBYgKE/kYnQPnRe2srklOqQJOWrb7
         icHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Pvrgndmmn8YktJ8T281XpjP9LliHnMlSYEnEf1KWrn8=;
        b=5RronX8A5I20+VSRCcoszA3Z03cSHg2w65FM4pusmeqDvvBk57O22en0Wc4OyJ86fF
         MoasCLJ9nGw85o3vml32rWaBlbc6JOVrpCvzU0YHTnEjQopkTxKPDVxZv2K9411+ovyt
         Kc4YaHjCW0N4HBJ0h4iB4rUHoju+UIjOA9m7aNN1pj9EcxBCMPG4ZjT3Dbl0o8vnTUUV
         kyLdkrSuEQ493MGE3cqEMQEHrn2xJ7/T1tbkqK+gtdIRVHDFse/HZiSW33zCUy0gcGOd
         uf2+uZM1rHV/I0AF64UeTK3V14Tez4dPhDYddn14yawTqdszwhpontsAhIQwL9KC1wvU
         0y/Q==
X-Gm-Message-State: AJIora/H7CrYDfHHdMhT0Bs5iHLHRoBhiEu7ynlUwEj3c9Tep0LRnYHX
        O5lPgqUP6Y2HRoAp4q6s4G8Cyw==
X-Google-Smtp-Source: AGRyM1veFFWv0Q5z9BYX2jyf571R7JB8ReLTZNwWeeEEwHqF1qW4UQ6d0Kq8k4zFKqezBHF1hXY/XQ==
X-Received: by 2002:a5d:64a3:0:b0:21d:adaa:ce4c with SMTP id m3-20020a5d64a3000000b0021dadaace4cmr21808418wrp.161.1658132992989;
        Mon, 18 Jul 2022 01:29:52 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id n30-20020a05600c3b9e00b003a2ed2a40e4sm17076668wms.17.2022.07.18.01.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 01:29:52 -0700 (PDT)
Date:   Mon, 18 Jul 2022 09:29:50 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     =?iso-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>
Cc:     daniel.thompson@linaro.org, jingoohan1@gmail.com,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH RESEND v6] backlight: lp855x: Switch to atomic PWM API
Message-ID: <YtUZ/ojZjcPlzTHi@google.com>
References: <20220714215334.78226-1-mairacanal@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220714215334.78226-1-mairacanal@riseup.net>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Thu, 14 Jul 2022, Maíra Canal wrote:

> Remove legacy PWM interface (pwm_config, pwm_enable, pwm_disable) and
> replace it for the atomic PWM API.
> 
> Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> Signed-off-by: Maíra Canal <mairacanal@riseup.net>

Nit: This should be chronological.

> ---
> V1 -> V2: Initialize variable and simplify conditional loop
> V2 -> V3: Fix assignment of NULL variable
> V3 -> V4: Replace division for pwm_set_relative_duty_cycle
> V4 -> V5: Fix overwrite of state.period
> V5 -> V6: Fix duty cycle rounding and set period outside conditional loop
> ---
>  drivers/video/backlight/lp855x_bl.c | 21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
