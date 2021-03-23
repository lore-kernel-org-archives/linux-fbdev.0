Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96988C433E4
	for <linux-fbdev@archiver.kernel.org>; Tue, 23 Mar 2021 09:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5145C619BF
	for <linux-fbdev@archiver.kernel.org>; Tue, 23 Mar 2021 09:43:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbhCWJnD (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 23 Mar 2021 05:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbhCWJmf (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 23 Mar 2021 05:42:35 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB95C061764
        for <linux-fbdev@vger.kernel.org>; Tue, 23 Mar 2021 02:42:34 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id b7so25999892ejv.1
        for <linux-fbdev@vger.kernel.org>; Tue, 23 Mar 2021 02:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=RJI1ZulJI/N1c2SHSzXG2bAltLew6mzjF/sjYCXcM5o=;
        b=JUN66A/8cTYU/eCzY1rGy5pu3Ui6LtQGLfl6KYjMr29YoVG/cdEJDdLL3Rx7rc5i2l
         QtXpb4pWe9w0bC1DCL7OK/oYYh+mOMk9IAxiy2bA4M8WH+Njssh46rgJrBNVNOhpAKIV
         VMXATaJV4nZUAxzKlMh2F06xFz+zdQwrb2BJv2VNWWIbB0utRYUhknkLfmbQSr7VGycf
         1w3WosdRggV3OYeQOERJdI4dNRjvCEwSlEAUsSGgeCWWyRWjEOHRCUDdNu3dO4GPwUGi
         TIW0ZgHSwC5mRhD3CUAVE533pNm9bdOIDFmJiagr5hE/VViE+ajDPRfkOJZh7hdjpZk/
         L/Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=RJI1ZulJI/N1c2SHSzXG2bAltLew6mzjF/sjYCXcM5o=;
        b=tL+b+RRhqeYrZ3zLwVSTj3QaZxJP0y7o5BBcymYzrIhX5+Ub8Rl77eHG+L0MTbMScY
         mCuvbbb9JTbzB4+i5FpELsrKrfxRhwJq/RIXuFQ6tLHXkeNm4tmFRLHXA6W7zRLQL7+k
         yRLkih/YQZr7w9vq0aewKRSjWAtkgqlPVR3ase3owkd9SCaZCTb7Satbpwo8wEEg/mzr
         Ec3CPdmWPdZXjvhWDCR2KbUx8AHYKZPZ4bsuAyU4+E7xTPVNFUSn0aLVrxd7gxNFQ8+J
         GEVmETV2AdzlMHPlfkKsACHGz55kHomCWA43Pb1jDdlvOfb1s6L7sz8ogKNz+kzMVKuO
         bq8Q==
X-Gm-Message-State: AOAM531tCu4HL7GIuEExQeN6gNC8KzFyQ8ZgAwXZsyR1AT3ePeGtHJtc
        LeVyQwoDhBNvGkMf7t+wwvNWmA==
X-Google-Smtp-Source: ABdhPJxpkafTXkKvGJHA7aA0u50WutkG/PVWSHFxm9DTViiMH8PsMPRMvCNLbKu9rHqMZj1o5whwtg==
X-Received: by 2002:a17:906:ca50:: with SMTP id jx16mr4131927ejb.72.1616492553383;
        Tue, 23 Mar 2021 02:42:33 -0700 (PDT)
Received: from dell ([91.110.221.180])
        by smtp.gmail.com with ESMTPSA id g11sm12635053edt.35.2021.03.23.02.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 02:42:32 -0700 (PDT)
Date:   Tue, 23 Mar 2021 09:42:29 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, Jingoo Han <jingoohan1@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kiran Gunda <kgunda@codeaurora.org>,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 2/2] video: backlight: qcom-wled: Add PMI8994 compatible
Message-ID: <20210323094229.GU2916463@dell>
References: <20210228124106.135812-1-konrad.dybcio@somainline.org>
 <20210228124106.135812-2-konrad.dybcio@somainline.org>
 <20210322161810.biagj2qro66rv4gt@maple.lan>
 <20210323083935.GF2916463@dell>
 <20210323093540.dqrhjlvr6oza3hvt@maple.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210323093540.dqrhjlvr6oza3hvt@maple.lan>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Tue, 23 Mar 2021, Daniel Thompson wrote:

> On Tue, Mar 23, 2021 at 08:39:35AM +0000, Lee Jones wrote:
> > On Mon, 22 Mar 2021, Daniel Thompson wrote:
> > 
> > > On Sun, Feb 28, 2021 at 01:41:05PM +0100, Konrad Dybcio wrote:
> > > > Add a compatible for PMI8994 WLED. It uses the V4 of WLED IP.
> > > > 
> > > > Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> > > 
> > > Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> > 
> > Why are you Reviewing/Acking a patch that was applied on the 10th?
> 
> Simply an oversight. Looks like I forgot to remove it from my backlog
> when it was applied.

I wondered if I'd made a mistake.

No problem.  Thanks for the clarification.

> > > > ---
> > > >  drivers/video/backlight/qcom-wled.c | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > > 
> > > > diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
> > > > index 3bc7800eb0a9..497b9035a908 100644
> > > > --- a/drivers/video/backlight/qcom-wled.c
> > > > +++ b/drivers/video/backlight/qcom-wled.c
> > > > @@ -1704,6 +1704,7 @@ static int wled_remove(struct platform_device *pdev)
> > > >  
> > > >  static const struct of_device_id wled_match_table[] = {
> > > >  	{ .compatible = "qcom,pm8941-wled", .data = (void *)3 },
> > > > +	{ .compatible = "qcom,pmi8994-wled", .data = (void *)4 },
> > > >  	{ .compatible = "qcom,pmi8998-wled", .data = (void *)4 },
> > > >  	{ .compatible = "qcom,pm660l-wled", .data = (void *)4 },
> > > >  	{ .compatible = "qcom,pm8150l-wled", .data = (void *)5 },
> > 

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
