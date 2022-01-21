Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ADA6C433F5
	for <linux-fbdev@archiver.kernel.org>; Fri, 21 Jan 2022 09:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379707AbiAUJTy (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 21 Jan 2022 04:19:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379715AbiAUJTx (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 21 Jan 2022 04:19:53 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D7EC061747
        for <linux-fbdev@vger.kernel.org>; Fri, 21 Jan 2022 01:19:53 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id n8so16666697wmk.3
        for <linux-fbdev@vger.kernel.org>; Fri, 21 Jan 2022 01:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=GYdREzPPehBfIAVKcYM846GIJdP7RKGamqemruCZcS8=;
        b=YHlPtVnKvW1tZAk5y/iTR0nITKiyB3iCFvLzRlfP41zV6VrKL0c0N7KJsPOXp+5rdL
         32FO6WUkOaOXRi/uBMfATqJ0n21gw/c2z9y7IQ53FIHJXaliEkqH2+50UVCstmNLCcwW
         sGWIqVvk2N8r52eK6/xDqs52pGF0lCEkw7/7aKNPdgQBSuuIZQDO8LcmKWsBA49qQxpk
         xdcqc76bxg8MVzwh7Vz+RwMvN6QaBM3CeaHBbwEEdyeuQqd/Wu7bC2nkpzRBu2AzAHst
         mM0FlaB89t1y/4BXLKpby+rtp7+zK+n7paMshOao6GrdDPU66WTzNOkgiteYUDyKy4a2
         jnxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=GYdREzPPehBfIAVKcYM846GIJdP7RKGamqemruCZcS8=;
        b=72+e1GSzN/SFEU1gb/MnRL7dsvcabNWWR+yV+NGOLNynwW8ohrpgtiOrdzgB6FGW1C
         5FfCBIkuJe4/1ZN0FpdkL25tTfMMFuWRIWW3WTnE7FhFiV0HUrk2z1UJ/RgntNN2UXp7
         BiWIaI6ukBYs61UXM2D5q5QQuhTyNTz5w2Z2NGz1MiEoNuU7ns8JqeDhp3k7l8c4ayDS
         yvaRSUT9mOJxD1o8HcSnjbLCXm8OaGLzTEm1gLvGiNBJKwS/z4zzf/Vf+x8i/4SR/gIQ
         r4wUqZHAyFKzTpDUmeHliCBpUrRWny63F9Sdokm0P4++V6Va/d6tzsk8v4RKwHRRevp7
         0xrg==
X-Gm-Message-State: AOAM530xPJCYwdcyd5rY3KGF3Os3+Q0efvdAVF3LYjY6CMGsd7hjEtCe
        KpHjZ38zHnZY5NLA4sslaMInEw==
X-Google-Smtp-Source: ABdhPJzlxVLbKAQa65mfmbQ6ypNKFfoSvb0OzD41M5HKQ50KGmx7X1+TN0mlVpv4dIJ7DS1bjvlrHw==
X-Received: by 2002:a05:6000:1ac9:: with SMTP id i9mr2958493wry.349.1642756792164;
        Fri, 21 Jan 2022 01:19:52 -0800 (PST)
Received: from google.com (cpc106310-bagu17-2-0-cust853.1-3.cable.virginm.net. [86.15.223.86])
        by smtp.gmail.com with ESMTPSA id k8sm4604422wms.15.2022.01.21.01.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 01:19:51 -0800 (PST)
Date:   Fri, 21 Jan 2022 09:19:49 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
        linux-fbdev@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>
Subject: Re: [GIT PULL] fbdev updates & fixes for v5.17-rc1
Message-ID: <Yep6te0wrK0ZQ8SB@google.com>
References: <Yeg11pHSqx29yg/T@ls3530>
 <CAKMK7uGeGBBvTGFyBxLwvTAxEWwXMS8U1rrYUb_7gbui-jV+KA@mail.gmail.com>
 <87fsph4fr2.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87fsph4fr2.fsf@intel.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Fri, 21 Jan 2022, Jani Nikula wrote:

> On Fri, 21 Jan 2022, Daniel Vetter <daniel@ffwll.ch> wrote:
> > On Wed, Jan 19, 2022 at 5:02 PM Helge Deller <deller@gmx.de> wrote:
> >> A first bunch of updates and fixes for the following fbdev & backlight drivers:
> >> ocfb, aty128fb, mb862xx, omapfb, qcom-wled, dt-bindings, hyperv_fb,
> >> lm3630a_bl, omap2, controlfb, matroxfb
> >>
> >> Nothing really important, mostly cleanups, const conversions, added null
> >> pointer/boundary checks and build fixes.
> >>
> >> Signed-off-by: Helge Deller <deller@gmx.de>
> >
> > Not sure whether Linus missed this or just wanted to let the
> > discussion settle first. But since this is all random patches for
> > drivers that many distros don't even enable anymore there's no issues
> > here, and I very much welcome someone volunteering to pick these up.
> > I'd expect there's a pile more since it's been 1-2 years since Bart
> > took care of these and merged them consistently.
> >
> > Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> 
> ...
> 
> >>  drivers/video/backlight/lm3630a_bl.c                     |  1 -
> >>  drivers/video/backlight/qcom-wled.c                      |  1 +
> 
> Backlight changes usually go through the backlight tree.

Yes, they do.  How were these applied to the DRM tree?

I don't see any mails about them being applied:

  Luca Weiss (2):
        backlight: qcom-wled: Add PM6150L compatible

  https://lore.kernel.org/all/20211229170358.2457006-2-luca.weiss@fairphone.com/

  Xu Wang (2):
        backlight: lm3630a_bl: Remove redundant 'flush_workqueue()' calls

  https://lore.kernel.org/all/20220113084806.13822-1-vulab@iscas.ac.cn/

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
