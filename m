Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C3C2C433ED
	for <linux-fbdev@archiver.kernel.org>; Mon, 19 Apr 2021 07:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D28F61077
	for <linux-fbdev@archiver.kernel.org>; Mon, 19 Apr 2021 07:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237757AbhDSHYi (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 19 Apr 2021 03:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237756AbhDSHYh (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 19 Apr 2021 03:24:37 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B18C061760
        for <linux-fbdev@vger.kernel.org>; Mon, 19 Apr 2021 00:24:07 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id t14-20020a05600c198eb029012eeb3edfaeso7573284wmq.2
        for <linux-fbdev@vger.kernel.org>; Mon, 19 Apr 2021 00:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=5/I7OjlPA23XMnl0fWhyfFcD+/MgnUHTP9oGcEYHgNI=;
        b=C3nDX1FO4/ry5WxQSYLVZoj6oePzIMjyWfTPtvVUYfPHryP+JrdktRBEhPb68Syvr8
         5TD3RfFRflAXjwqMdQ4dix0mGoTxYjoGIB5l/k24emlcBbT8o64h1rSXeJsOIBkLt/Wk
         pNs7GPV6sNRAmCoVMDmrfPfpN7NHar74zQQ/pkwllUy1LA0mmE8eG+9RRsAA7YvZTsJF
         sBQcBFj0HZq5YM53mt79eb4TT0SYn24ruOlJJrg+pv9b9/NpZYT7v0diNuRwRDJ4jq3R
         8diFjwmSXL0/jrefm52TyE99agVDX0IVlLC2UXYfw8EBZnXQw7RDUoEsLDAaUZRffitr
         vX8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=5/I7OjlPA23XMnl0fWhyfFcD+/MgnUHTP9oGcEYHgNI=;
        b=tALaeKbb939DxSwrwFh3pcgTr6Q3bHsF+f1fIXKZ/GN9hjm3Gy7LerFugVscSfQ0tg
         NaoujGsSDZuqsisnuZQ6ofUMWn7lQVOdsd9joM3FyI7eB5Hp3MSvmLtpz/DEonuaPfpQ
         MpraZNUzJa0ALS+mh+M7NNH959ltO1viOfiWCDYyvtGntarTcLtgTV3+fct7ibfzLG6U
         KqMshbggwICyO8J+doGQYnZaLVYIR6pcT/n64VxR+HDVm6+15p5OAd00o6wg3nzLX437
         +Pryh9BeFc1eB53X4XPShkuHrS0h1Ji8x/pf4iXgdan+JuBTRqjRc5kenZRgGnH6iDyJ
         miMQ==
X-Gm-Message-State: AOAM531cKR9w8n4dMDGLQ1PXQvwY8sdOAsCKZXx3YSv+ZDQpBbDVdvbR
        U+94vf4i4QAHH534LlQc55R6Hg==
X-Google-Smtp-Source: ABdhPJye4l/i7HK7FwHbnHzpTfHSCGPiuZeatN7ljMUy6e9Tge+FyCdpTNGKhcRomYfbQP9fYFSkkQ==
X-Received: by 2002:a1c:1d14:: with SMTP id d20mr20836963wmd.49.1618817046058;
        Mon, 19 Apr 2021 00:24:06 -0700 (PDT)
Received: from dell ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id b16sm19428764wmb.39.2021.04.19.00.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 00:24:05 -0700 (PDT)
Date:   Mon, 19 Apr 2021 08:24:03 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     ChiYuan Huang <u0084500@gmail.com>
Cc:     lgirdwood@gmail.com, Mark Brown <broonie@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        jingoohan1@gmail.com, b.zolnierkie@samsung.com,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        ChiYuan Huang <cy_huang@richtek.com>
Subject: Re: [PATCH v6 1/4] mfd: rt4831: Adds support for Richtek RT4831
Message-ID: <20210419072403.GC4869@dell>
References: <1616945059-8718-1-git-send-email-u0084500@gmail.com>
 <CADiBU3-d3_L8RTeYCirnfjJdG=ea6UVenAi8O8GO_LvOaB7OdA@mail.gmail.com>
 <20210419072229.GA4869@dell>
 <20210419072317.GB4869@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210419072317.GB4869@dell>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Mon, 19 Apr 2021, Lee Jones wrote:

> On Mon, 19 Apr 2021, Lee Jones wrote:
> 
> > On Mon, 19 Apr 2021, ChiYuan Huang wrote:
> > 
> > > Hi, Linux mfd reviewers:
> > >    It's been three weeks not to get any response from you.
> > > Is there something wrong about this mfd patch?
> > > If yes, please feel free to let me know.
> > 
> > Couple of things:
> > 
> > First, if you think a patch had fallen through the gaps, which does
> > happen sometimes, it is generally considered acceptable to submit a
> > [RESEND] ~2 weeks after the initial submission.  FYI: This was such a
> > patch.  It was not on, or had fallen off of my radar for some reason.
> > 
> > Secondly, we are really late in the release cycle.  -rc8 has just been
> > released.  Quite a few maintainers slow down at ~-rc6.  Particularly
> > for new drivers.
> > 
> > No need to resubmit this driver this time.  It is now on my to-review
> > list and I will tend to it shortly.
> > 
> > Thanks for your patience.
> 
> Also you are missing a DT review on patch 4.

... looks like you forgot to Cc them!

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
