Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 842D3C433F5
	for <linux-fbdev@archiver.kernel.org>; Thu, 23 Sep 2021 09:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66D2A60F70
	for <linux-fbdev@archiver.kernel.org>; Thu, 23 Sep 2021 09:48:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240270AbhIWJuK (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 23 Sep 2021 05:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240267AbhIWJuK (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 23 Sep 2021 05:50:10 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7C0C061756
        for <linux-fbdev@vger.kernel.org>; Thu, 23 Sep 2021 02:48:38 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id t18so15532095wrb.0
        for <linux-fbdev@vger.kernel.org>; Thu, 23 Sep 2021 02:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=6+eKVp8taoHSdR1ibPn1ZGg0knOd1Pb0ImjfZkR19aI=;
        b=GTnuaG2v8n/EfVqZaGG/LrTewIRWMm7WeWMV3j9m4TQfzK6B0a4MoXuq7vYMKR5sRe
         OhoSOfgq+MGSmZTFC4dvGYouByjVRmagaBS3cEfzpPL+bxGgJi88cjdg6u/Q8NdSHlnr
         TpmTZ8f9YvBm66pwkXvPEHOTo1NB6sQLvtvYiAGLUfBVIxL8WW+ScDnGVm6p0pMIKP9r
         IjZoQkoj9ZzeOJzbf75qrDRdryulrO0JYGBlK59x+4zuwE2eYvEVvBFRwLgVuVscci48
         Jto3AO2FZ9nqFAOzVOhfpYEIAnXDM00By37MSsbuC3c/36E4Y5BPxSno7NjlJkfb7C8+
         KtJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=6+eKVp8taoHSdR1ibPn1ZGg0knOd1Pb0ImjfZkR19aI=;
        b=UxuonQfco9mMKDNwFZ3HpNxSK1t+ba4Cxj0DuiOknjuMuRiTJRzAKZgl3ZL88UTpsD
         wUzpzjvpd3L/tlcanUSPoPzyXPWpJG3lNI9vCVfuAV/WfKlvwABZxjCeJja0y46/hc4L
         0GbmW/2XwdG7+N2d8o4nCRxnNs2LDhfst9yqw8Y5OB2TrhsmLipPGlaQ7AYIHXmHxcA9
         irgaocgOhCxQAgpVcNZ1tV6VxyeLwPkqcRFUDn3BAXGUoxyOxK7uuQkE6eK//qUMtfjz
         l5NP5KTxtGfkvpfBuAhxLTkECVPvopkdBKwd/9DuvuIGvf3ndu4LxrBqw0KtDqMU4TIj
         +k9w==
X-Gm-Message-State: AOAM5304lGge4VJro9ds7j4SQ+vQSBZQFT2kGCZSR/+4Adj/hWOf9j9O
        NQTjRRMCFQhbPHGMEyQjDJlllpNKAckDaw==
X-Google-Smtp-Source: ABdhPJyibbde3vB1FCGt9d/JYvsj6NAS6zqNEXkWGRfCVwpJ0z2rvlY7kgpkBqqwzYJkFqg5Tz1gKg==
X-Received: by 2002:a05:600c:4105:: with SMTP id j5mr3402523wmi.138.1632390517246;
        Thu, 23 Sep 2021 02:48:37 -0700 (PDT)
Received: from google.com ([95.148.6.233])
        by smtp.gmail.com with ESMTPSA id g22sm7965648wmp.39.2021.09.23.02.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 02:48:36 -0700 (PDT)
Date:   Thu, 23 Sep 2021 10:48:35 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] backlight: propagate errors from get_brightness()
Message-ID: <YUxNczBccLQeQGA5@google.com>
References: <20210907124751.6404-1-linux@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210907124751.6404-1-linux@weissschuh.net>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Tue, 07 Sep 2021, Thomas Weißschuh wrote:

> backlight.h documents "struct backlight_ops->get_brightness()" to return
> a negative errno on failure.
> So far these errors have not been handled in the backlight core.
> This leads to negative values being exposed through sysfs although only
> positive values are documented to be reported.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
> 
> v1: https://lore.kernel.org/dri-devel/20210906215525.15418-1-linux@weissschuh.net/
> 
> v1 -> v2:
> * use dev_err() instead of dev_warn() (Daniel Thompson)
> * Finish logging format string with newline (Daniel Thompson)
> * Log errno via dedicated error pointer format (Daniel Thompson)
> 
>  drivers/video/backlight/backlight.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
