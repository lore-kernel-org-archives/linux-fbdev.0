Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E034C433C1
	for <linux-fbdev@archiver.kernel.org>; Tue, 23 Mar 2021 09:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AFFB619B9
	for <linux-fbdev@archiver.kernel.org>; Tue, 23 Mar 2021 09:41:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbhCWJky (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 23 Mar 2021 05:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbhCWJkr (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 23 Mar 2021 05:40:47 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94496C061763
        for <linux-fbdev@vger.kernel.org>; Tue, 23 Mar 2021 02:40:46 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id u21so8007345ejo.13
        for <linux-fbdev@vger.kernel.org>; Tue, 23 Mar 2021 02:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=zXs5SbjReTCcPNHIOjgz/S/VxQjjjOm2F5VH26PFX/A=;
        b=vj5G9pjhGIJnSvkO3MxGjzGfY8QUgcgIr8he+j8CuGbyyEfP5EQNfrmrCqoMO2CZZR
         bdckdLSvsCoLrRu48EzAHYo4oxQAXRsUdNra/JouZ1qUvhf0uMbOSV9a8F/maOBLtAGe
         RV8MmfA3GtVVlaVinDJ3S/lzsL0qE8O+YupeIpqcYG0BGXJHE1Cmp6/9QWlQ43zL/NC1
         yqNdlWiaSh5Wv3ibiPp3WlVe3b07LVjSxW+cyyrOQWmSgGZNcN5r0izAQP2icBVact0v
         03lDSR3Wp+6bfpj+WhlvsvC7QM5dX/IjE1uKpWf59cRSsmbH828i6f8T/ahuVCQ1UXlk
         uGJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=zXs5SbjReTCcPNHIOjgz/S/VxQjjjOm2F5VH26PFX/A=;
        b=I67Ovrs3Sy5o5vs5PChxXNeDRAXC9qPgUNkg1lJa+KLHHZIujNULj2mo8uMSwiByTt
         aGizgICJABBCzcEdruXlUtr9hHNV8daPByuGSmKmI3KtryBkTb/Xb85UbaXpStYPYwNP
         VwvngQX5o1LpH/hofxPPv72iOnSQhWd0l2WZL6V/Hfx8ZdGxNdpg8MDneMDKOh7cT69S
         UGwz+d03wzSNJjFX1gilXy1/uJtIuXZLhmS70N4//c5pWmafjLBkPsPIw/rHHK7GWg1Y
         pnGf3mvkzOPWh53mhtLX4P1m0goCw1Ds8J3YKcG3y47nBHCZvpsiKIlxGPfrWKnw7dZK
         99Pw==
X-Gm-Message-State: AOAM533KYTF6wZ7C+yqBCU4Qx7DEna2bIQ/w8eRDrLNEGPvXzvBuzsQ/
        fLGLSJcNAVEIk6ys6VkSJopEVQ==
X-Google-Smtp-Source: ABdhPJwpBn5eyAJHqJLdU0Wab+Ro1IIWRDZ1hGuA1iPJeA/Fp0ww4Ebsg8Pw9LsY5dn4holDmh/FWw==
X-Received: by 2002:a17:906:53d7:: with SMTP id p23mr4111539ejo.140.1616492445327;
        Tue, 23 Mar 2021 02:40:45 -0700 (PDT)
Received: from dell ([91.110.221.180])
        by smtp.gmail.com with ESMTPSA id 90sm12948482edf.31.2021.03.23.02.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 02:40:44 -0700 (PDT)
Date:   Tue, 23 Mar 2021 09:40:41 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Kiran Gunda <kgunda@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, jingoohan1@gmail.com,
        b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        daniel.thompson@linaro.org, jacek.anaszewski@gmail.com,
        pavel@ucw.cz, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-fbdev@vger.kernel.org
Subject: Re: [PATCH V5 2/2] backlight: qcom-wled: Correct the sync_toggle
 sequence
Message-ID: <20210323094041.GT2916463@dell>
References: <1616071180-24493-1-git-send-email-kgunda@codeaurora.org>
 <1616071180-24493-3-git-send-email-kgunda@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1616071180-24493-3-git-send-email-kgunda@codeaurora.org>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Thu, 18 Mar 2021, Kiran Gunda wrote:

> As per the current implementation, after FSC (Full Scale Current)
> and brightness update the sync bits are set-then-cleared.
> But, the FSC and brightness sync takes place when the sync bits are
> set (e.g. on a rising edge). So the hardware team recommends a
> clear-then-set approach in order to guarantee such a transition
> regardless of the previous register state.
> 
> Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
>  drivers/video/backlight/qcom-wled.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
