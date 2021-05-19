Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A63C43462
	for <linux-fbdev@archiver.kernel.org>; Wed, 19 May 2021 14:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA48E6105A
	for <linux-fbdev@archiver.kernel.org>; Wed, 19 May 2021 14:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354838AbhESOwX (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 19 May 2021 10:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354833AbhESOwW (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 19 May 2021 10:52:22 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14029C061760
        for <linux-fbdev@vger.kernel.org>; Wed, 19 May 2021 07:51:02 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id u4-20020a05600c00c4b02901774b80945cso3608607wmm.3
        for <linux-fbdev@vger.kernel.org>; Wed, 19 May 2021 07:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=9hWo+oUpcm6brp7QVlWP1qMLhPG7on+ugtgTIWdWGgk=;
        b=DkbY+S6Kg6quQSONCtHMXfCOVH4OqhINL2j5T2IQkq270nlPjxKYMOHAvn7NWQh8X3
         Jhma/fsIgCa0KwMhVLvInBhtvcRSi7uxPlGlTwbvO6clzDTUen87CWrbzK5cRjybbWRP
         PhJn84d1pBheNl2WpfksWb0E2d+ClU+7OKVwGil1F+lQanIzMlgNYDRkpjv5F54gFZAF
         JqAdn/Wh9QK5zpJOpgWnqRxeQRToHI85pqtl/YpVaxYF47j9Nz2GikmJ0e3/mhMoEV2F
         Fr0AE4zoSCrxSgKOhdk2qoKqrJ8Bsm9nTRjKH8MfzK/wIo1B8JlgqujcclkxDnRVOdcB
         2MVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=9hWo+oUpcm6brp7QVlWP1qMLhPG7on+ugtgTIWdWGgk=;
        b=hOwioCyUA+6sOIC2kjavJl0qMDWxTd7UHjmAr2QHUMieFxxYGdzzbRde634LtRaiz+
         v/Ms8HtXb0MYQuytohZn5YOj5j4rbWMvxMIrluu4BvU7KP/9Oo1eZYa3e7N8wjEZCH4F
         1oz4N9MpjFsUE2rof5R7lgA+AAAH1vAre30S1qkmQ7I1vyCxr+BRBCkSWG27ALsqgn1t
         q39m2tTq9SEDnMVAGWbPkt7JWA1gsuLJFYBm4FWeOhn6VlSW9ong0Mp7DOgK4yKlgQfX
         K24Q4wCiPZLBlnPkejN4ZzNbm750wlAt97+qZ+ime5fwGrCxBM4ug6dfj7gzOod1uAds
         h0zg==
X-Gm-Message-State: AOAM532S7iJj3lOlUCz5cz6LsTba7zju0P9RGtkjr3W3HZezNS2BR5Ib
        rZ72a0hpOgifhiaAuOpWliBPyQ==
X-Google-Smtp-Source: ABdhPJxq4yOvrbz4+GMdrRqg0XGhy30GzDMOvEMevBFgiblHVaKtLBRosn/C9Txh2zMPl8KgwasAgQ==
X-Received: by 2002:a05:600c:4f4d:: with SMTP id m13mr12270205wmq.4.1621435860634;
        Wed, 19 May 2021 07:51:00 -0700 (PDT)
Received: from dell ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id l8sm7188514wry.55.2021.05.19.07.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 07:51:00 -0700 (PDT)
Date:   Wed, 19 May 2021 15:50:58 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     cy_huang <u0084500@gmail.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        daniel.thompson@linaro.org, jingoohan1@gmail.com,
        b.zolnierkie@samsung.com, pavel@ucw.cz, robh+dt@kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, cy_huang@richtek.com
Subject: Re: [PATCH v7 3/4] mfd: rt4831: Adds DT binding document for Richtek
 RT4831
Message-ID: <20210519145058.GF2549456@dell>
References: <1621262161-9972-1-git-send-email-u0084500@gmail.com>
 <1621262161-9972-3-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1621262161-9972-3-git-send-email-u0084500@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Mon, 17 May 2021, cy_huang wrote:

> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Adds DT binding document for Richtek RT4831.
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/mfd/richtek,rt4831.yaml    | 90 ++++++++++++++++++++++
>  1 file changed, 90 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/richtek,rt4831.yaml

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
