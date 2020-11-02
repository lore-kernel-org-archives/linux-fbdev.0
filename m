Return-Path: <SRS0=+7Ut=EI=vger.kernel.org=linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D303C00A89
	for <linux-fbdev@archiver.kernel.org>; Mon,  2 Nov 2020 18:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14EEE22268
	for <linux-fbdev@archiver.kernel.org>; Mon,  2 Nov 2020 18:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dIaNxAcc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725846AbgKBSxc (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 2 Nov 2020 13:53:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbgKBSx3 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 2 Nov 2020 13:53:29 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA01EC061A47
        for <linux-fbdev@vger.kernel.org>; Mon,  2 Nov 2020 10:53:28 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id cw8so6751652ejb.8
        for <linux-fbdev@vger.kernel.org>; Mon, 02 Nov 2020 10:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GlGtTyawZz1U+foaHuQJleVoISpzv2DwJ6xp8D1Hwk4=;
        b=dIaNxAccndYlWhHDapF/MDgfnKgAGECRY/zIOGm650eR7riKJDY+LJNCZbF3ThLlRr
         +jEuZq6zopeOu3FTISuAv02VhSA429Uhgs7h9o100X+Jy67bARpU0p7k6SJahy6TgPZQ
         vl8C5qfffPSjxCQ+Z0E5TUGJki8xexMTou9E0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GlGtTyawZz1U+foaHuQJleVoISpzv2DwJ6xp8D1Hwk4=;
        b=LATooNaAE/0MSLVUtX7lPLLnMnsPoyK9lpukKX8wcMwnlcGWMkt7qys2rCFegy46cB
         LcRJ0sytCqHdSM6Kn/pXsvKUWeqjT4hzfyb1PzrlxKZniro8mIBL/aX3LAbprkYw1OnB
         n6T5Ekp1GfePq0u/wmkqj6ZvoGyA0adnBIVk8x1Iw7ki0LPKpkQoFki6Anyo4DcxGpiW
         XnoE74NjRWLzFPBX/8B1DhGk/AqHoCXYDTIedly5iioux03qGECmWg9Lq5WS8TJV/n5v
         j/soYZ0oXiCkU8CqA7GoEAsnOc3Qm+lA3037386iME+ikyNMdJQIaKWYW+WAQp07IDzh
         dGxQ==
X-Gm-Message-State: AOAM530S2wC1WL2RmK4AJmBld+99B9y3vap7+tehwW2kkpNcsO4Es3U0
        RArTPihS7T8u2Hsuwa+t64PXykJONI5Rrw==
X-Google-Smtp-Source: ABdhPJybwQFWUVnE1UiGBJ9EihbrqAWZrwZC4XqEJiRn6LJokOAsBv4J7s4HHbXIYF+l+KFzgkStOg==
X-Received: by 2002:a17:906:2818:: with SMTP id r24mr9441267ejc.100.1604343207201;
        Mon, 02 Nov 2020 10:53:27 -0800 (PST)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id i14sm9886245ejp.2.2020.11.02.10.53.25
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2020 10:53:25 -0800 (PST)
Received: by mail-ed1-f41.google.com with SMTP id ay21so2043420edb.2
        for <linux-fbdev@vger.kernel.org>; Mon, 02 Nov 2020 10:53:25 -0800 (PST)
X-Received: by 2002:a05:6402:a57:: with SMTP id bt23mr6977135edb.62.1604343204920;
 Mon, 02 Nov 2020 10:53:24 -0800 (PST)
MIME-Version: 1.0
References: <20201022050445.930403-1-amstan@chromium.org> <20201021220404.v3.3.I4dcea1c90e9da3902d466033aa73351e19e49c49@changeid>
 <20201028151210.7e765hbq2k7i3url@holly.lan>
In-Reply-To: <20201028151210.7e765hbq2k7i3url@holly.lan>
From:   Alexandru M Stan <amstan@chromium.org>
Date:   Mon, 2 Nov 2020 10:52:49 -0800
X-Gmail-Original-Message-ID: <CAHNYxRy4hg4rZsc-xi3MzK+RapMq76+=hGj0_E-aGcFUPB1wMA@mail.gmail.com>
Message-ID: <CAHNYxRy4hg4rZsc-xi3MzK+RapMq76+=hGj0_E-aGcFUPB1wMA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] backlight: pwm_bl: Fix interpolation
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, Oct 28, 2020 at 8:12 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Wed, Oct 21, 2020 at 10:04:45PM -0700, Alexandru Stan wrote:
> > The previous behavior was a little unexpected, its properties/problems:
> > 1. It was designed to generate strictly increasing values (no repeats)
> > 2. It had quantization errors when calculating step size. Resulting in
> > unexpected jumps near the end of some segments.
> >
> > Example settings:
> >       brightness-levels = <0 1 2 4 8 16 32 64 128 256>;
> >       num-interpolated-steps = <16>;
> >
> > Whenever num-interpolated-steps was larger than the distance
> > between 2 consecutive brightness levels the table would get really
> > discontinuous. The slope of the interpolation would stick with
> > integers only and if it was 0 the whole line segment would get skipped.
> >
> > The distances between 1 2 4 and 8 would be 1 (property #1 fighting us),
> > and only starting with 16 it would start to interpolate properly.
> >
> > Property #1 is not enough. The goal here is more than just monotonically
> > increasing. We should still care about the shape of the curve. Repeated
> > points might be desired if we're in the part of the curve where we want
> > to go slow (aka slope near 0).
> >
> > Problem #2 is plainly a bug. Imagine if the 64 entry was 63 instead,
> > the calculated slope on the 32-63 segment will be almost half as it
> > should be.
> >
> > The most expected and simplest algorithm for interpolation is linear
> > interpolation, which would handle both problems.
> > Let's just implement that!
> >
> > Take pairs of points from the brightness-levels array and linearly
> > interpolate between them. On the X axis (what userspace sees) we'll
> > now have equally sized intervals (num-interpolated-steps sized,
> > as opposed to before where we were at the mercy of quantization).
> >
> > END
>
> INTERESTING.
>
> I guess this a copy 'n paste error from some internal log book?
> Better removed... but I won't lose sleep over it.

Sorry! Yeah, I mistakenly duplicated the "END" line in patman.

>
>
> > Signed-off-by: Alexandru Stan <amstan@chromium.org>
>
> I've waited a bit to see how strong the feelings were w.r.t. getting rid
> of the division from the table initialization. It was something I was
> aware of during an earlier review but it was below my personal nitpicking
> threshold (which could be badly calibrated... hence waiting). However
> it's all been quiet so:
>
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
>
>
> Daniel.


Alexandru Stan (amstan)
