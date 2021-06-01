Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0402BC47080
	for <linux-fbdev@archiver.kernel.org>; Tue,  1 Jun 2021 12:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2D6F61396
	for <linux-fbdev@archiver.kernel.org>; Tue,  1 Jun 2021 12:37:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233336AbhFAMiz (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 1 Jun 2021 08:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233584AbhFAMiy (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 1 Jun 2021 08:38:54 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5FAC061574
        for <linux-fbdev@vger.kernel.org>; Tue,  1 Jun 2021 05:37:12 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id c5so2968247wrq.9
        for <linux-fbdev@vger.kernel.org>; Tue, 01 Jun 2021 05:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=q0VBZ1AmByAwe483WcR/T7rzmaJh9QClItlEm17BvFI=;
        b=d2Hgau+jcqalZ4sy6NlOFUwOXyUHs4G8vNJNITWkEyxo6ZTyRi0W+W7PkycmX1qqM1
         L2MXvn4TJ/hQsqIjFiXcuXZ8PPNjEBm5UHAseOTHzAhWiyJhmQNfJroG0qDHmhBVpnkQ
         fdbn0Xx5DBVT1+FqgqWHbRbvatcuxeg5apstgUHyoJfqoEbx/CQadfM9af7BQL3ZxXvU
         KJCmMhbuq0nj8S/7W0oMu522gOGO3Pz4d+yOiMzKi75fYABMUfVkWEQ0Fwf7Xlvq5Ip1
         0QQg+LNGMQWrdzySFIqcrJFQTO7nJwNhIIXtjT4/r3dDzwYp+JyoTiPeX5j+yJvIrUtQ
         SxBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=q0VBZ1AmByAwe483WcR/T7rzmaJh9QClItlEm17BvFI=;
        b=ONlOnxlpAu4qsoM2/9T03yGElU4ffuX/7x5kudsaxtY+/fk0p4ma8+hyhtaMgSPjK8
         DeptK3M7EL8paSmK/2GRyDiJLALf+Ap8KOIyEX6Gg2ErRT0MxqNdzUmq6V71kSSXw9mB
         /5Dxv0pEKEGZNGgkKDNElYj98VPa/BhkausAzgrbOkAMS0TMb/8pqv3XgP1FOhG9+rWB
         xWpNSjxRT1smzkEArgzMsI0r8gwEcoZCWwb+SrC12ZIQVGoLuz+7BZXJT1uo67o6+4B1
         eEwAvlaAzNPWpCo1CJXFbu0yRvbnfvoZ+6Tnge0/j5GwnrBUX11PKI5E0lJx4EeyVGcP
         gCrA==
X-Gm-Message-State: AOAM5307RcW8y3q+8bGBXPYGW68UmI4SW43JrLS9Zj2Z2zt2lgf0HYxW
        8+QBDVMesXMVWw0FnuyESs/1kA==
X-Google-Smtp-Source: ABdhPJx+WkixZCBNz3HyAM2qy3S4l/JY78r8hqeHHTCllSX5rLccBj2FPCaEijRD6IGJi7GnZig83w==
X-Received: by 2002:a5d:6484:: with SMTP id o4mr26822370wri.8.1622551030771;
        Tue, 01 Jun 2021 05:37:10 -0700 (PDT)
Received: from dell ([91.110.221.249])
        by smtp.gmail.com with ESMTPSA id b10sm3900609wrr.27.2021.06.01.05.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 05:37:10 -0700 (PDT)
Date:   Tue, 1 Jun 2021 13:37:08 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Juerg Haefliger <juerg.haefliger@canonical.com>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@canonical.com>
Subject: Re: [PATCH v2] backlight: Kconfig whitespace and indentation cleanups
Message-ID: <20210601123708.GF543307@dell>
References: <20210517095839.81833-1-juergh@canonical.com>
 <20210519110300.17918-1-juergh@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210519110300.17918-1-juergh@canonical.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, 19 May 2021, Juerg Haefliger wrote:

> Remove leading whitespaces, replace multi spaces with tabs, and fix help
> text indentation.
> 
> Signed-off-by: Juerg Haefliger <juergh@canonical.com>
> ---
>  drivers/video/backlight/Kconfig | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
