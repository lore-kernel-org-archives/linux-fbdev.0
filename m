Return-Path: <SRS0=wnYw=ED=vger.kernel.org=linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF8FC55179
	for <linux-fbdev@archiver.kernel.org>; Wed, 28 Oct 2020 21:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3C31246CD
	for <linux-fbdev@archiver.kernel.org>; Wed, 28 Oct 2020 21:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ILXuE1Fu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbgJ1Vzt (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 28 Oct 2020 17:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728514AbgJ1Vzs (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 28 Oct 2020 17:55:48 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25218C0613CF
        for <linux-fbdev@vger.kernel.org>; Wed, 28 Oct 2020 14:55:48 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id a7so703544lfk.9
        for <linux-fbdev@vger.kernel.org>; Wed, 28 Oct 2020 14:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=l4u4x3wqcamFjVhNhf6xSDsxJDF4ia7ZULeYQGII8mw=;
        b=ILXuE1FuPImvS0DqL5IMRBIlL6RZds+hGRxbUKX2fa3Jb+p0i0FfZNnJbTmkYt64BZ
         IkBsZrgp2cHPDVPsSjnIKqN1/P4dJLa0IwrECAb23FygPzfJRHZ/TqvwLlSC+OYLopST
         mfZn/1onAzkuNMiuX+7fJo9bwL6hP0R8JObt3U6IID7loQ4hX1w7QFMw3tUm6koym7hw
         EwdWEE7k8ny3zQeSSZLwuWBrKgTCDDAVsOg+Sjxd2sy3jS9T6gTXbCA2TZLmddXiOWUa
         PG9DUcWHtS11SC1hHzAy/UElkE9HmhHcxPVrEM9fBOj4yvK6Fill0qfq3iJIcENygqOT
         lu/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l4u4x3wqcamFjVhNhf6xSDsxJDF4ia7ZULeYQGII8mw=;
        b=DOuaS0kStHLrloq1baUSXHnOcFhUvre5JELCEeGoFaQXLR9PEK1dj3x/kizG2YTTNH
         9gUZuxHaLm2+w61hTlXbTUFI40S3zHwa66809nu/CmmZO+D0SnpCb1vtPOElMmBtKFHH
         cq9YkgmLHbtDvq9GEkmRQDC8fZal8dQ6oXghmF1w2GvL2qLVQMYWuMH5JU9TnRv7XPia
         gh+LI0SNAOcwIivsDGSk92ES8QdS0lJNPmzqcYEJRBSrQ9FFnIsa4DqBCa42I2QRXjJ0
         WH9Ibp4hkL2Z2dLkckiA1Pa8NDffeYsXET6FRXRtAm8oYWtT0EjnYoFJ2dOJHva7jCUQ
         iPUw==
X-Gm-Message-State: AOAM5330kruLVx1ywFfj3R+TFYf8HpLJJRvaUG3XoLhg2GIakyppt/oA
        m/nQ/MHmg45aGl3ApiA210tYZ2jHUTI0fg==
X-Google-Smtp-Source: ABdhPJwyi+wHXJ2cOvhZn68n5CD1XcT8uEuh3II80NOAVMoEVT9S3UDw7HAkoUOuK4zYQVybjj4JCA==
X-Received: by 2002:adf:80c8:: with SMTP id 66mr9768069wrl.415.1603897934446;
        Wed, 28 Oct 2020 08:12:14 -0700 (PDT)
Received: from holly.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id u5sm8619996wru.63.2020.10.28.08.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 08:12:13 -0700 (PDT)
Date:   Wed, 28 Oct 2020 15:12:10 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Alexandru Stan <amstan@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v3 3/3] backlight: pwm_bl: Fix interpolation
Message-ID: <20201028151210.7e765hbq2k7i3url@holly.lan>
References: <20201022050445.930403-1-amstan@chromium.org>
 <20201021220404.v3.3.I4dcea1c90e9da3902d466033aa73351e19e49c49@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021220404.v3.3.I4dcea1c90e9da3902d466033aa73351e19e49c49@changeid>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, Oct 21, 2020 at 10:04:45PM -0700, Alexandru Stan wrote:
> The previous behavior was a little unexpected, its properties/problems:
> 1. It was designed to generate strictly increasing values (no repeats)
> 2. It had quantization errors when calculating step size. Resulting in
> unexpected jumps near the end of some segments.
> 
> Example settings:
> 	brightness-levels = <0 1 2 4 8 16 32 64 128 256>;
> 	num-interpolated-steps = <16>;
> 
> Whenever num-interpolated-steps was larger than the distance
> between 2 consecutive brightness levels the table would get really
> discontinuous. The slope of the interpolation would stick with
> integers only and if it was 0 the whole line segment would get skipped.
> 
> The distances between 1 2 4 and 8 would be 1 (property #1 fighting us),
> and only starting with 16 it would start to interpolate properly.
> 
> Property #1 is not enough. The goal here is more than just monotonically
> increasing. We should still care about the shape of the curve. Repeated
> points might be desired if we're in the part of the curve where we want
> to go slow (aka slope near 0).
> 
> Problem #2 is plainly a bug. Imagine if the 64 entry was 63 instead,
> the calculated slope on the 32-63 segment will be almost half as it
> should be.
> 
> The most expected and simplest algorithm for interpolation is linear
> interpolation, which would handle both problems.
> Let's just implement that!
> 
> Take pairs of points from the brightness-levels array and linearly
> interpolate between them. On the X axis (what userspace sees) we'll
> now have equally sized intervals (num-interpolated-steps sized,
> as opposed to before where we were at the mercy of quantization).
> 
> END

INTERESTING.

I guess this a copy 'n paste error from some internal log book?
Better removed... but I won't lose sleep over it.


> Signed-off-by: Alexandru Stan <amstan@chromium.org>

I've waited a bit to see how strong the feelings were w.r.t. getting rid
of the division from the table initialization. It was something I was
aware of during an earlier review but it was below my personal nitpicking
threshold (which could be badly calibrated... hence waiting). However
it's all been quiet so:

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
