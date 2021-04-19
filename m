Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9887CC433B4
	for <linux-fbdev@archiver.kernel.org>; Mon, 19 Apr 2021 07:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 712726102A
	for <linux-fbdev@archiver.kernel.org>; Mon, 19 Apr 2021 07:23:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237703AbhDSHX6 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 19 Apr 2021 03:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237563AbhDSHXu (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 19 Apr 2021 03:23:50 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEAC7C06174A
        for <linux-fbdev@vger.kernel.org>; Mon, 19 Apr 2021 00:23:20 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id e5so4159506wrg.7
        for <linux-fbdev@vger.kernel.org>; Mon, 19 Apr 2021 00:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=MwIN+TU+KqrTV8oEDf/hF37W/wlPfyPFBOGXtanMm7A=;
        b=mvKP3FYTQyjhiyXdbsSScTdmxz1JdALtfbp3+iAG13OF6eHuyLflOnEhKZqi7NefnI
         Ka/vu+MRQlQLQ1Wf8/dEGDJ25gGU2a9Ch58/yIKB1ny09smf3tC56NSGVJxWDjaddEs4
         Jtv6Lca8f3LeUYHLqp0B13sEJD2noyBhtVawAlQZHkk0XqI2Y3I6InNVrmlEQL9Jvt0h
         UiPhiEP4s2/GdqC8vmMETym4jlcdSAg2pfw+C/ijAxND3z+bkfIJsA4Y6/MYL8RuniMj
         cCEfJuyRjbQ8oJdvPaiAlSczpYRofo47AY6e21JwaRmJnDLkoT2ICuJLVknjcDEf5JyW
         s4sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=MwIN+TU+KqrTV8oEDf/hF37W/wlPfyPFBOGXtanMm7A=;
        b=Ds4KiBOXvV5/1vPfmgfl2zWToWsxokmlf8TqmKUuY5oU2SXcfOQCM0LjsnUfRnKmHr
         N+3riSadrBDYbpa12KYitROZ4CCOFczq/bgRPyFzOWIlwLvsnMHIlStvyLPO6XBvO1PC
         U14UbG8xxCh3zNqBdmOPniNJ5+3Ln+MeNvsQyYWqq5flEy3221tryr4+qM1VIcUHOrWT
         5ST31eSUGGbHw0iaBONBXTJK110tG8oeBrl17AscIqbaNIfB3JOdPif3vh34xYO+hP3H
         +RHfg5WFHV3r+fTrgN9cNGBRT0FYm0HUi1M90aiG6z8VDeKlaxfF8vWWNP+sZw++JAmk
         XiAg==
X-Gm-Message-State: AOAM530ADd0mB6HAQs1dsNBAuxGB5z4c6/gKLDuxYBYAY7nCAhJABCTH
        vsaZgxXYM50cA6hSAUxgN3MRLw==
X-Google-Smtp-Source: ABdhPJxU4UayMloZjPVsgjxamNBwWhUQHvtZnZx6PsAQFTcukFY8alah33zSIRsDldU+wQ0gpgaz6A==
X-Received: by 2002:adf:bbd2:: with SMTP id z18mr12686252wrg.274.1618816999770;
        Mon, 19 Apr 2021 00:23:19 -0700 (PDT)
Received: from dell ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id a22sm20364077wrc.59.2021.04.19.00.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 00:23:19 -0700 (PDT)
Date:   Mon, 19 Apr 2021 08:23:17 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     ChiYuan Huang <u0084500@gmail.com>
Cc:     lgirdwood@gmail.com, Mark Brown <broonie@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        jingoohan1@gmail.com, b.zolnierkie@samsung.com,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        ChiYuan Huang <cy_huang@richtek.com>
Subject: Re: [PATCH v6 1/4] mfd: rt4831: Adds support for Richtek RT4831
Message-ID: <20210419072317.GB4869@dell>
References: <1616945059-8718-1-git-send-email-u0084500@gmail.com>
 <CADiBU3-d3_L8RTeYCirnfjJdG=ea6UVenAi8O8GO_LvOaB7OdA@mail.gmail.com>
 <20210419072229.GA4869@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210419072229.GA4869@dell>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Mon, 19 Apr 2021, Lee Jones wrote:

> On Mon, 19 Apr 2021, ChiYuan Huang wrote:
> 
> > Hi, Linux mfd reviewers:
> >    It's been three weeks not to get any response from you.
> > Is there something wrong about this mfd patch?
> > If yes, please feel free to let me know.
> 
> Couple of things:
> 
> First, if you think a patch had fallen through the gaps, which does
> happen sometimes, it is generally considered acceptable to submit a
> [RESEND] ~2 weeks after the initial submission.  FYI: This was such a
> patch.  It was not on, or had fallen off of my radar for some reason.
> 
> Secondly, we are really late in the release cycle.  -rc8 has just been
> released.  Quite a few maintainers slow down at ~-rc6.  Particularly
> for new drivers.
> 
> No need to resubmit this driver this time.  It is now on my to-review
> list and I will tend to it shortly.
> 
> Thanks for your patience.

Also you are missing a DT review on patch 4.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
