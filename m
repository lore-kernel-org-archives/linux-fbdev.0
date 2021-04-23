Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DFD5C433B4
	for <linux-fbdev@archiver.kernel.org>; Fri, 23 Apr 2021 08:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68324613F5
	for <linux-fbdev@archiver.kernel.org>; Fri, 23 Apr 2021 08:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241196AbhDWI21 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 23 Apr 2021 04:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbhDWI20 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 23 Apr 2021 04:28:26 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F54C06174A
        for <linux-fbdev@vger.kernel.org>; Fri, 23 Apr 2021 01:27:50 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id q123-20020a1c43810000b029012c7d852459so5392944wma.0
        for <linux-fbdev@vger.kernel.org>; Fri, 23 Apr 2021 01:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=UGXDfU5CAuOew8JInuwwVL1OHr7a7FSfU2FNvlz4Ij4=;
        b=emp4dDwd9PW6Fg/HM2hVaJrFpWpn8ZtTqNcC7f9ehqJYLI8fs+GUqak1KpF0nzQ2K2
         gnf6KyeoYABc+RalTF278v+mawYXSueUhCdTCv3quN0nfdto/xkj6YCWpbp+/f3Wjy7W
         pk7yKGyJ0uRSkqCW7eHT953S8kjV9uKjTq6tfEqYEJIvq+JamAbsGOokScjXZU4dpWcu
         D8T+Cc4pDVbxBWDRATJ/zPB+Ea3MDgZEbyJi3JhyduV7VsmPNyJRfSKFkFo3VQqU2ooy
         wOyMnQ0dMvyuIzL1GzlnPZXLXZFoSqWu2i1F+BMjMkn8iUBg0NTJfwR7ebWt/azpQ/nX
         rcZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=UGXDfU5CAuOew8JInuwwVL1OHr7a7FSfU2FNvlz4Ij4=;
        b=hbsGU9UzEBqzj3a++ihVMltxROJSeqtSmn74UHuhAgzuXILhiYixA76/NNvxvs3f4W
         ZHafzV6C/gkxE4ByuO2b+iqRds3vYXytn4Nmh89YiWG5o7vu+BG/RS6w6m4DK7NmD7p4
         7DiNDkUCtc32Jb6EShEkJ6/4etJS4bFOiWkND5arOMfYKc9fkw+Im2HRcSP37AghbnBu
         k5ct+MacaTqHpxnHvEDx462zdwgeQmogh8Xn0BRXCPPFMibJ33DKCpsp0Y3rMXxurC+D
         KX59TAMbF9b7Z5lMqGF9yMUf5Y5yFrcSJRp7J3NbZbQID+DrlHZIdat/cSJ6UH/mNxt8
         Yu+Q==
X-Gm-Message-State: AOAM532mmoxX+GB2xbyXWL4N0468Wzk3gCXnoWueqPkIA19c6Xnp0wrk
        vzGvu6K3hH4EI95PUpfIUmH46w==
X-Google-Smtp-Source: ABdhPJzZ8uASD6Dq0I5Tj0ljrEATP/sYaFUzbpIiT4c4Z9o46Ssr3PF77tivFsnKAlb6yYXdeNjJPQ==
X-Received: by 2002:a1c:6a06:: with SMTP id f6mr2867470wmc.179.1619166469406;
        Fri, 23 Apr 2021 01:27:49 -0700 (PDT)
Received: from dell ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id s64sm7169435wmf.2.2021.04.23.01.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 01:27:48 -0700 (PDT)
Date:   Fri, 23 Apr 2021 09:27:46 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     ChiYuan Huang <u0084500@gmail.com>
Cc:     lgirdwood@gmail.com, Mark Brown <broonie@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        jingoohan1@gmail.com, b.zolnierkie@samsung.com,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        ChiYuan Huang <cy_huang@richtek.com>
Subject: Re: [PATCH v6 1/4] mfd: rt4831: Adds support for Richtek RT4831
Message-ID: <20210423082746.GC6446@dell>
References: <1616945059-8718-1-git-send-email-u0084500@gmail.com>
 <CADiBU3-d3_L8RTeYCirnfjJdG=ea6UVenAi8O8GO_LvOaB7OdA@mail.gmail.com>
 <20210419072229.GA4869@dell>
 <20210419072317.GB4869@dell>
 <20210419072403.GC4869@dell>
 <CADiBU38bMuH00Bcx5hJas2=yAon00ffcGokT4u89vX-LJYuxNA@mail.gmail.com>
 <CADiBU39F4nHC5U+G+fJJemAJgeYxDimi0cXYkm25+YC8qO5yDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADiBU39F4nHC5U+G+fJJemAJgeYxDimi0cXYkm25+YC8qO5yDA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Fri, 23 Apr 2021, ChiYuan Huang wrote:

> Hi, Lee:
> 
> ChiYuan Huang <u0084500@gmail.com> 於 2021年4月19日 週一 下午5:55寫道：
> >
> > Lee Jones <lee.jones@linaro.org> 於 2021年4月19日 週一 下午3:24寫道：
> > >
> > > On Mon, 19 Apr 2021, Lee Jones wrote:
> > >
> > > > On Mon, 19 Apr 2021, Lee Jones wrote:
> > > >
> > > > > On Mon, 19 Apr 2021, ChiYuan Huang wrote:
> > > > >
> > > > > > Hi, Linux mfd reviewers:
> > > > > >    It's been three weeks not to get any response from you.
> > > > > > Is there something wrong about this mfd patch?
> > > > > > If yes, please feel free to let me know.
> > > > >
> > > > > Couple of things:
> > > > >
> > > > > First, if you think a patch had fallen through the gaps, which does
> > > > > happen sometimes, it is generally considered acceptable to submit a
> > > > > [RESEND] ~2 weeks after the initial submission.  FYI: This was such a
> > > > > patch.  It was not on, or had fallen off of my radar for some reason.
> > > > >
> > > > > Secondly, we are really late in the release cycle.  -rc8 has just been
> > > > > released.  Quite a few maintainers slow down at ~-rc6.  Particularly
> > > > > for new drivers.
> > > > >
> > > > > No need to resubmit this driver this time.  It is now on my to-review
> > > > > list and I will tend to it shortly.
> > > > >
> > > > > Thanks for your patience.
> > > >
> > > > Also you are missing a DT review on patch 4.
> > >
> > > ... looks like you forgot to Cc them!
> > >
> > Yap, really. I''ll resend patch 4 and cc them. Thx.
> 
> Should I resend the patch and loop DT reviewers?

Yes, please.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
