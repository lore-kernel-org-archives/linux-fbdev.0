Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B30BC433F5
	for <linux-fbdev@archiver.kernel.org>; Mon, 24 Jan 2022 10:53:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237175AbiAXKxX (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 24 Jan 2022 05:53:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237128AbiAXKxS (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 24 Jan 2022 05:53:18 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF80CC06173B
        for <linux-fbdev@vger.kernel.org>; Mon, 24 Jan 2022 02:53:17 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id w11so600669wra.4
        for <linux-fbdev@vger.kernel.org>; Mon, 24 Jan 2022 02:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=AWyFv6pGSlo5DklimzoRbZU1SIfMIBepmw9wE4YDVeo=;
        b=koQzdbfOEuh0RiAzV1r6d12nfvmRNGlCkk3husGtJd9DwCn4I26dh5I719KqzIQEru
         VxBafBluv7aRzZd/LjJ6MtQoyDQ550qXtjZYWLlYWBEf2x6RRDjrT54V29gpuFeXuYpn
         WXUleMGWssXxtZVRvIZxXDG2Rk8tC3J2LNIJQ80PqsVJFi2XYpb6yvFxbZsDoOrxWCGt
         Z8NG91onuecWNEUOmaqdAC0ZlFREXBPQHTGCyp6/UxmH7b427nGiXEmjKyJoAaXdGt71
         B0pFrHwJIs5/Kv4aVyyJ37n63ha+Yv5nTcEEF8aDWPLiRle6n4+KOwKj1rJ2+Us74VXu
         vaLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=AWyFv6pGSlo5DklimzoRbZU1SIfMIBepmw9wE4YDVeo=;
        b=NNVlEdZyBJ0+E79vTI/k/jGL190RpqikGTAIv6ho2gfaveI7YKVBFQxaTPiaxaowFw
         fWde4yk792ThSP250DWB/WBJTKNgUa0fF/gKHNor4HSwf79klvIJh+09SgVqkW51Kdmk
         shCr0iyIyOoZOH8XyQLxRle4BUxRVrkiZj1Z+6nZRzSliSkFtXmr54YCI7F/54abI9pR
         b9KHWwvwJS7l51D3mdW11I4uTdtWLLwwzjTbKdhRgCjoCg4TBZV3Rg7c0R2FliXgguIo
         v5QTmw0kNJsAPZd2EBD+qj03gUoJtZ8Gs8I8DPUR2xv5Yln4zhqO1BTjI7YQ47Bn5/6B
         doSg==
X-Gm-Message-State: AOAM533gFeRlcFemciktiMs8T3FLQ+19jkEb78pNh7xkn9U1inOUlnr5
        XiE0Dr1uyh1kmu0kKVNAKNyHYypqhrPwDQ==
X-Google-Smtp-Source: ABdhPJzJ0fM/5P4fiblE5AHsartrM9QQbDW+P9/ZhxZAzoai2fjsYFQvSzMoj4/VZN+WbA3fpvbaFg==
X-Received: by 2002:adf:f80a:: with SMTP id s10mr13307344wrp.416.1643021596270;
        Mon, 24 Jan 2022 02:53:16 -0800 (PST)
Received: from google.com (cpc106310-bagu17-2-0-cust853.1-3.cable.virginm.net. [86.15.223.86])
        by smtp.gmail.com with ESMTPSA id a1sm14343535wrf.42.2022.01.24.02.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 02:53:15 -0800 (PST)
Date:   Mon, 24 Jan 2022 10:53:13 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Luiz Sampaio <sampaio.ime@gmail.com>
Cc:     daniel.thompson@linaro.org, michael.hennerich@analog.com,
        jingoohan1@gmail.com, deller@gmx.de, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 24/31] video: backlight: changing LED_* from enum
 led_brightness to actual value
Message-ID: <Ye6FGUPJ7KH5gYdf@google.com>
References: <20220121170540.w6c4wqwrqzpde2lm@maple.lan>
 <20220121180948.2501-1-sampaio.ime@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220121180948.2501-1-sampaio.ime@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Fri, 21 Jan 2022, Luiz Sampaio wrote:

> Hello, Daniel
> 
> Thanks for your reply. This is one of my first patches, so I am still
> learning. This series of patches affects others subsystems too (hid,
> leds, sound etc). Should I create series for each subsystem
> separately, instead of creating one series for everyone?
> What do you mean by "this patch might wants to land in one tree"?

Can the individual patches be applied on their own without causing
issues (warnings/errors) with the build?  If so, they can be applied
separately via their associated subsystem trees.  If not, someone will
have to collect them all and take them via a single tree with Acks
from the other subsystem maintainers.

It's difficult to make that decision for ourselves since you didn't
share all of the patches with all of the maintainers.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
