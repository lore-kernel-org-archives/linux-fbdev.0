Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E6FEC43334
	for <linux-fbdev@archiver.kernel.org>; Thu,  9 Jun 2022 09:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239337AbiFIJ0q (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 9 Jun 2022 05:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234473AbiFIJ0m (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 9 Jun 2022 05:26:42 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B24227CFF
        for <linux-fbdev@vger.kernel.org>; Thu,  9 Jun 2022 02:26:39 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id p10so31535960wrg.12
        for <linux-fbdev@vger.kernel.org>; Thu, 09 Jun 2022 02:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=doJDwgeNCCpGAVqsr1zYgJtRpwsMml2sELB5t/MLY5M=;
        b=VPq3f0ZdO06SkOgMTlkS3D7YZmul+nXO/J0BjMk+stYpad6L9H5cOp2IBGHQEJn+Sl
         1DMRophNR04WNcXUHOqrs6OdfQB6HANh/JIw0MbdRNMPdyNkUr80U6L24XxRCD+MDAjQ
         b8uHt8YM3EAoR9QEqHA6AWl3jKoB4Qv35ji2cAwqZiUJ19jKK2galnmED0gVBj+49+66
         /qGVkju5ZMhYZOrCdmwHdn/4FpDWyJv/LT9amthGPdsenZoaAJkV3WM4pcG5dhO2/6AC
         O8TCD9uWN5YA+b2+xx6Tzxnp/uPXS1CUQ9z2beYU40E9pslWPHdTUZeMIWzAmccv0CRG
         zrng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=doJDwgeNCCpGAVqsr1zYgJtRpwsMml2sELB5t/MLY5M=;
        b=ktKgi0sFXWDznjqO7VOwVHyUbIv1cx9dSKXhtmMrlhYTzy5FCUK/4YZII7EMPD+Nco
         qq0tKPsrn4Q+VJHirjI222mzN++Kq6e9UGNo+oAzzbeg5jfQSxYSxzwwy8LpqwayaaCY
         NL1XhwQBnzCdjCf7kwqESP3eLCksmvSdgtUXCEiuBw1Z2UZ3531Qn6OB/naFeZKissPN
         Fcew2o1KSTctiwW2dPX+7wJj9KuWqas1d7AgRK6EeF6UX2OnUxgNR/+Jsehf+8RFOOwA
         OsrdWXDrjdI9/Fltcy34Hq3c60P+HKG9Udg87C7YSjfiiWYtXkpNnlXLy3UkLTdj1FdC
         8grQ==
X-Gm-Message-State: AOAM530BJS8qlsUcP90n6G+T7MLgOLSn0+neabjgQU74hzCMYBQ+7Tdy
        bPI+LUjkGvvjbCZGLWKnwZStYw==
X-Google-Smtp-Source: ABdhPJwHbfMoTUujhvRpFZUQSGO8P5QHWho99EELCVbHKvomYjfYHQdY9sivEWq9/Zf7ddPDSfJWtA==
X-Received: by 2002:adf:f750:0:b0:210:2ef5:7c5c with SMTP id z16-20020adff750000000b002102ef57c5cmr36424281wrp.416.1654766797986;
        Thu, 09 Jun 2022 02:26:37 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id b15-20020adfde0f000000b002103136623esm24819171wrm.85.2022.06.09.02.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 02:26:37 -0700 (PDT)
Date:   Thu, 9 Jun 2022 10:26:35 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     cy_huang <u0084500@gmail.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee.jones@linaro.org, jingoohan1@gmail.com, pavel@ucw.cz,
        deller@gmx.de, cy_huang@richtek.com, lucas_tsai@richtek.com,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: backlight: rt4831: Add the new ocp
 level property
Message-ID: <20220609092635.ew3wqfi2uv6d3smj@maple.lan>
References: <1654741339-12756-1-git-send-email-u0084500@gmail.com>
 <1654741339-12756-2-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1654741339-12756-2-git-send-email-u0084500@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Thu, Jun 09, 2022 at 10:22:18AM +0800, cy_huang wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Add 'richtek,bled-ocp-microamp' property to make it chooseable.
> 
> The wrong backlight ocp level may affect the backlight channel output
> current smaller than configured.
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
