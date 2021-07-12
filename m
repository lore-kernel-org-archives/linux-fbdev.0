Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB29DC07E99
	for <linux-fbdev@archiver.kernel.org>; Mon, 12 Jul 2021 10:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 860D461004
	for <linux-fbdev@archiver.kernel.org>; Mon, 12 Jul 2021 10:26:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbhGLK2q (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 12 Jul 2021 06:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhGLK2p (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 12 Jul 2021 06:28:45 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3BCC0613DD
        for <linux-fbdev@vger.kernel.org>; Mon, 12 Jul 2021 03:25:57 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id j25-20020a05600c1c19b02902269686f585so849076wms.0
        for <linux-fbdev@vger.kernel.org>; Mon, 12 Jul 2021 03:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=lLjUDjdWxPclbryuFR9izI75sQqrpyAMRrc80ykdjNY=;
        b=awyJadfSI81+vFylzF4VuEQTlG1d+tBVabVVugUGOXe0DCvV/DveP6MFR2Aei/nrNc
         +zK9YhQqWQUjxLJCcgiiskDw9IXv6PrWlUMiGuduvSGUk1GSoZOIjUNwxXZHR0tkrld3
         7THO61XKQfgFfxbSkDhDktf8x0IZ8VsTsDihZ/vlu3FttAlTpAiYzyuyVGUn7QsVheE6
         vQrqtmAXXaqBOCPiS6YYbLQd3CJSJRwhUxYfzdqcyo5y6ySMkODOC7QUUL9yC3iI+qMs
         0GlUsGcihNcriVKLmFla4idBo89BQUHCAe3YcqzJ8bhyOaL1UAaDoIctzj54lrp9yQCa
         ewOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=lLjUDjdWxPclbryuFR9izI75sQqrpyAMRrc80ykdjNY=;
        b=dzy8JL6ryH23eXj/q9YBlfGWtIg7j7HILRNA6u4AGso9SAigWZOd3tM5ZV5In5RdXS
         wlCdvspst/JUPCHQITsRRNhFBOY4N1RHM5HpBUL/bNlPh5GGuM3TnAVCYgUWD6AeeIkX
         /H4jVBY8nmLSVUDfKmNIpooi+mRklpCUsm0Rz9d2PF0A7bPArb9DK1sT+nhFrKoSsQxo
         xJ41ZGVAuQQv4rzrs+RY43VDwkPOvVtvqAoMBvttt0H1NnxXJxSudJAYIkvutyulqFoL
         sbjNUqfk38DI4adZeOKlpcvvq/Ws2LfQmxS8+f0tH/Ca3aVGISf7N7LKgI0/YOoQICEM
         +ufw==
X-Gm-Message-State: AOAM5339EjQxTC84uYUAuO9xDQsaAmBdjhsq3gxWHn65qcQSgz8Jdwwk
        mMBSvR82xthz7tY6mibaAHJxKA==
X-Google-Smtp-Source: ABdhPJyboP90WE/DsXxubQCq3b4TFqGRmnfmdseq3xPSGUo2tQZ11zJw2RRXien+JB0uKG1A6gtTQg==
X-Received: by 2002:a05:600c:4fc7:: with SMTP id o7mr53768712wmq.16.1626085555727;
        Mon, 12 Jul 2021 03:25:55 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id b9sm16533947wrh.81.2021.07.12.03.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 03:25:55 -0700 (PDT)
Date:   Mon, 12 Jul 2021 11:25:53 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>
Cc:     Marek Vasut <marex@denx.de>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org,
        Meghana Madhyastha <meghana.madhyastha@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH] video: backlight: Drop maximum brightness override for
 brightness zero
Message-ID: <20210712102553.ehsgp2ozrveuwaxv@maple.lan>
References: <20210709132600.5417-1-marex@denx.de>
 <0822c219-c1c6-0bb4-f379-e73f40adfa8e@tronnes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0822c219-c1c6-0bb4-f379-e73f40adfa8e@tronnes.org>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Fri, Jul 09, 2021 at 03:53:16PM +0200, Noralf Trønnes wrote:
> 
> 
> Den 09.07.2021 15.26, skrev Marek Vasut:
> > The note in c2adda27d202f ("video: backlight: Add of_find_backlight helper
> > in backlight.c") says that gpio-backlight uses brightness as power state.
> > This has been fixed since in ec665b756e6f7 ("backlight: gpio-backlight:
> > Correct initial power state handling") and other backlight drivers do not
> > require this workaround. Drop the workaround.
> > 
> > This fixes the case where e.g. pwm-backlight can perfectly well be set to
> > brightness 0 on boot in DT, which without this patch leads to the display
> > brightness to be max instead of off.
> > 
> > Fixes: c2adda27d202f ("video: backlight: Add of_find_backlight helper in backlight.c")
> 
> I not sure about the rules, but if this is automatically picked up for
> stable, maybe this is needed to avoid changing behaviour on 4.19:
> 
> 
> of_find_backlight() was added in 4.17 and the gpio fix in 5.4.
> 
> Or perhaps there are other ways to signal this dependency.

Agree we need to make sure the Fixes: tag doesn't provoke regressions
in v4.19.

Is this the syntax appropriate?

Cc: <stable@vger.kernel.org> # 5.4+
Cc: <stable@vger.kernel.org> # 4.19.x: ec665b756e6f7: backlight: gpio-backlight: Correct initial power state handling


> > Signed-off-by: Marek Vasut <marex@denx.de>
> > Cc: Daniel Thompson <daniel.thompson@linaro.org>
> > Cc: Meghana Madhyastha <meghana.madhyastha@gmail.com>
> > Cc: Noralf Trønnes <noralf@tronnes.org>
> > Cc: Sean Paul <seanpaul@chromium.org>
> > Cc: Thierry Reding <treding@nvidia.com>
> > ---
> 
> Acked-by: Noralf Trønnes <noralf@tronnes.org>

With the above (or something similar to avoid problems with v4.19):
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
