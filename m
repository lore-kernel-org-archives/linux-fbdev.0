Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0153C43381
	for <linux-fbdev@archiver.kernel.org>; Wed, 10 Mar 2021 09:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49C3964FE2
	for <linux-fbdev@archiver.kernel.org>; Wed, 10 Mar 2021 09:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbhCJJVy (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 10 Mar 2021 04:21:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbhCJJVp (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 10 Mar 2021 04:21:45 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563D3C06174A
        for <linux-fbdev@vger.kernel.org>; Wed, 10 Mar 2021 01:21:45 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id f12so22453949wrx.8
        for <linux-fbdev@vger.kernel.org>; Wed, 10 Mar 2021 01:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=1dMDsRJi6X7RFDQQQ96QgnONRBTG+sEDdR1IWXfZlxI=;
        b=W+DJoNj9bBYATgZUAqeGOcJC+D6Hm0fUTfpOX/nfrQorUYX0n4GMgTKiGPm9maOEGo
         jJEbPk9YxrksTMIUWEKLTMMPZUE3K3JD1uzy2/YgERbc+DtReqEclprcHzcXbUZkCtgK
         dofcYGgRLjspqQ02wswCtKFFlcgHYCG7pI64jxsoFj6wjEdDKRS1gt8ucvtPMr1+wiXH
         V/ZWINFeo54CPqxA/rG5FASsH7SuIr/xMoPbF+VsDdIRqKv/UxlwLwcteDBdVTSJWc0O
         mMDifDG6brOm+PToPYN85FgTl6AZyRU9xfUh9opj8fWJz2+IRQ0JWOsQc08QN5F0mrcp
         5KcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=1dMDsRJi6X7RFDQQQ96QgnONRBTG+sEDdR1IWXfZlxI=;
        b=iwwjtnWp4C8fD+8XcepNTHSLF5l+TO3IXd67T8+k+Gj9PxLTgv6goBpDAnRdQso6xq
         4wYXEnDtvp5i2GkuEor0L9LZVdezEb0OHwTIFSNfexLvX/jZJojQOEsJ++NdDyN7tX3E
         bT7G5FmAhgDXD0lM9wlb/JvdGbo15S+urWyR17KCS0RTYaYROnMDzAE788pJ3BEVa8nk
         kcUbi0ZCOgtUA5K31d6IgEZiAqHJfCph54XD+93iwmzemT1UBuseIFjZKcHf2d/Fiam/
         MOp4QlFiJMPx4f1Y0ilUc/wK6wTAt7bvYEwQOU2w4vN1eB0BO6o10LqqdW10EtQT/95D
         PPJA==
X-Gm-Message-State: AOAM532Wosr225Y+rKDuAdX3AR9ecjAzXDq5U1mnQ1hcyNx1R90YfYOl
        dVkOhOC6/B0RERW83A2Q6z69xw==
X-Google-Smtp-Source: ABdhPJxuPtNe3ElR6uJROL0vscwDtpq5CtKpwKbdJ63dZObdhgzH/OA+daBodljwBXleRgt+pFfpUg==
X-Received: by 2002:a5d:4485:: with SMTP id j5mr2393819wrq.339.1615368104145;
        Wed, 10 Mar 2021 01:21:44 -0800 (PST)
Received: from dell ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id a131sm8233043wmc.48.2021.03.10.01.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 01:21:43 -0800 (PST)
Date:   Wed, 10 Mar 2021 09:21:41 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Dan Murphy <dmurphy@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kiran Gunda <kgunda@codeaurora.org>,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: leds: backlight: qcom-wled: Add PMI8994
 compatible
Message-ID: <20210310092141.GO4931@dell>
References: <20210228124106.135812-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210228124106.135812-1-konrad.dybcio@somainline.org>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Sun, 28 Feb 2021, Konrad Dybcio wrote:

> Document the newly added PMI8994 compatible.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
