Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63787C43460
	for <linux-fbdev@archiver.kernel.org>; Mon, 19 Apr 2021 07:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A555610A1
	for <linux-fbdev@archiver.kernel.org>; Mon, 19 Apr 2021 07:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237703AbhDSHXF (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 19 Apr 2021 03:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237682AbhDSHXE (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 19 Apr 2021 03:23:04 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFEF8C061760
        for <linux-fbdev@vger.kernel.org>; Mon, 19 Apr 2021 00:22:33 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id e7so23847867wrs.11
        for <linux-fbdev@vger.kernel.org>; Mon, 19 Apr 2021 00:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=SyHfgB6+zRTrv/Haj5bvpwPiVHLCQUxHRjTDe9iiH6E=;
        b=dU/4LDGRRx8nJXozQ+Zxr4ntLfl8eJOmmOdmXn29QZwsESpQ2dTw3PM0u45Vr9LIpr
         3tyvaCuWfV0joiMGdJrFXQ3Ga/UdF2t10SuyDvOVZwxxWVA6ZFtyuri5pN0Gwy/XLJJV
         8nXTPRk/sCWQfj7F0gjmd+gLMZ5Cuk2CPaUyDzT6PmoGLqdrcGfRS5LdMTr0aoGGIK5L
         EiZGvmreJlkSeVDdLGTuZvqfJsG7oD08F9/O4yRfrH3g53scMBan2Mrrkq3tUeupeI+w
         Lre0xFKk9J+sQFEpneE6rYGagHWsMSrNRNIyOpuW9M1AF3GCiNuNBD0V6Huwt4Xfrj3R
         iZDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=SyHfgB6+zRTrv/Haj5bvpwPiVHLCQUxHRjTDe9iiH6E=;
        b=oLuDfCCpDkBvX70+oRKJ9iV1XYfVwCX3cLVUPilN+dQl3YNHqUpLBX9izkfq86AG08
         YF9CBlrkxFKZO0jyAelnR6ICydpXQs6DE4vTYvi5tR2SNYNmo93kPWoTwl8ac5BEjpvl
         NYzh/Nb1/AYYCMtQtqjI1xtXJ4cPAs12rvtoIWgKBRJH2yOZR41+R9US4mtku/Efps+E
         Ih0d1XGH800Llxxvwlc+ikt5yohX5V2pFfHvDqVISIeNjZVjF7w+ArOLUILoA+W9dIr/
         ljkjAtL9EZLhCOya3uLpIGUSizRwpx6MgnoSn+2aTRz7yqQ6yA7pRAd0KP+wtJLc082M
         BH7g==
X-Gm-Message-State: AOAM5332zVGxPxttR0lpytPPjS9q0t8uL2PB3B8oVCsFuOJgKsAVOXdb
        og+hr2AXuJpOGmZFnRfo+pdAmQ==
X-Google-Smtp-Source: ABdhPJxh18Iex/zR5QdzoK6VikkBPDY8E2/oAyYW/dloMMublMlaJLI0hJSIcJwBfxJ2wTpMKDi89A==
X-Received: by 2002:adf:e650:: with SMTP id b16mr12543937wrn.273.1618816952381;
        Mon, 19 Apr 2021 00:22:32 -0700 (PDT)
Received: from dell ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id l7sm23627114wrb.35.2021.04.19.00.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 00:22:31 -0700 (PDT)
Date:   Mon, 19 Apr 2021 08:22:29 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     ChiYuan Huang <u0084500@gmail.com>
Cc:     lgirdwood@gmail.com, Mark Brown <broonie@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        jingoohan1@gmail.com, b.zolnierkie@samsung.com,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        ChiYuan Huang <cy_huang@richtek.com>
Subject: Re: [PATCH v6 1/4] mfd: rt4831: Adds support for Richtek RT4831
Message-ID: <20210419072229.GA4869@dell>
References: <1616945059-8718-1-git-send-email-u0084500@gmail.com>
 <CADiBU3-d3_L8RTeYCirnfjJdG=ea6UVenAi8O8GO_LvOaB7OdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADiBU3-d3_L8RTeYCirnfjJdG=ea6UVenAi8O8GO_LvOaB7OdA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Mon, 19 Apr 2021, ChiYuan Huang wrote:

> Hi, Linux mfd reviewers:
>    It's been three weeks not to get any response from you.
> Is there something wrong about this mfd patch?
> If yes, please feel free to let me know.

Couple of things:

First, if you think a patch had fallen through the gaps, which does
happen sometimes, it is generally considered acceptable to submit a
[RESEND] ~2 weeks after the initial submission.  FYI: This was such a
patch.  It was not on, or had fallen off of my radar for some reason.

Secondly, we are really late in the release cycle.  -rc8 has just been
released.  Quite a few maintainers slow down at ~-rc6.  Particularly
for new drivers.

No need to resubmit this driver this time.  It is now on my to-review
list and I will tend to it shortly.

Thanks for your patience.

> cy_huang <u0084500@gmail.com> 於 2021年3月28日 週日 下午11:24寫道：
> >
> > From: ChiYuan Huang <cy_huang@richtek.com>
> >
> > This adds support Richtek RT4831 core. It includes four channel WLED driver
> > and Display Bias Voltage outputs.
> >
> > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > ---
> > The RT4831 regulator patches are already on main stream, and can be referred to
> > 9351ab8b0cb6 regulator: rt4831: Adds support for Richtek RT4831 DSV regulator
> > 934b05e81862 regulator: rt4831: Adds DT binding document for Richtek RT4831 DSV regulator
> >
> > since v6
> > - Respin the date from 2020 to 2021.
> > - Rmove the shutdown routine.
> > - Change the macro OF_MFD_CELL to MFD_CELL_OF.
> >
> >
> > since v5
> > - Rename file name from rt4831-core.c to rt4831.c
> > - Change RICHTEK_VID to RICHTEK_VENDOR_ID.
> > - Change gpio_desc nameing from 'enable' to 'enable_gpio' in probe.
> > - Change variable 'val' to the meaningful name 'chip_id'.
> > - Refine the error log when vendor id is not matched.
> > - Remove of_match_ptr.
> >
> > since v2
> > - Refine Kconfig descriptions.
> > - Add copyright.
> > - Refine error logs in probe.
> > - Refine comment lines in remove and shutdown.
> > ---
> >  drivers/mfd/Kconfig  |  10 +++++
> >  drivers/mfd/Makefile |   1 +
> >  drivers/mfd/rt4831.c | 115 +++++++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 126 insertions(+)
> >  create mode 100644 drivers/mfd/rt4831.c

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
