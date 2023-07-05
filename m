Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CCD1EB64DA
	for <linux-fbdev@archiver.kernel.org>; Wed,  5 Jul 2023 08:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbjGEIjR (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 5 Jul 2023 04:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbjGEIjQ (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 5 Jul 2023 04:39:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66629CA
        for <linux-fbdev@vger.kernel.org>; Wed,  5 Jul 2023 01:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688546319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0ev84vUzUh8ZH6f1TjRoMQmaeXWVKy1q8JlkhwPTuuw=;
        b=d4P3/wJedq4/9u52+s60wkaaG4H5xhmk62Pk+v75tvkDJk0kDMJwPG8AdirL7mIL3Un4SY
        YednNuS+HC8ruF7vvusz08LSI6Rouu++lnih55cIo7J6GzRdhw0qRGhiMG+NrSFIHm88Yo
        g0NAWX4cTErOLkRGtClEtaOYKseapQQ=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-4-1mm0-kNzOGTIs3OkSFpQ-1; Wed, 05 Jul 2023 04:38:38 -0400
X-MC-Unique: 4-1mm0-kNzOGTIs3OkSFpQ-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-4fb89482cd6so6433064e87.1
        for <linux-fbdev@vger.kernel.org>; Wed, 05 Jul 2023 01:38:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688546317; x=1691138317;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0ev84vUzUh8ZH6f1TjRoMQmaeXWVKy1q8JlkhwPTuuw=;
        b=iGRy4PSuIbBDrwHimj0IkS0mCbZ2Cwe3YyzaKq/uxcPuuLBhPVCRHWjqQW5JMt/l0W
         Sb017NPijHptK1mmiC0PUU3tgK1nKxLELNFFmn7qgrDIbBJHWUflEwcDM7c1BWx5Cu3L
         GUczgsRYjrQ4LoOMWRHh+4nJt+IKnxuRK3DgnlgY14hslUbaD4h/ZeaTNwUx6ELZN07P
         5rL0dwHyOI1dj2LMpPv9Sk91NRWRik8rrTeoFYxBRuke9HWkv2u+DxOb05r8P0ErFmFf
         eAnAn6TadkjWP2DtYu/cotSX+J4Z27RaWUMAMa1+7r0iNkwmD4+Oq+7olBJnHFBeKWpi
         bWwA==
X-Gm-Message-State: ABy/qLbKxcPtAvoFrxQY1yMEAzy1r3kskwqqkhlISbtGn3mN1GOsTO3n
        IPwYlo47xK6IIen8/VN989v7cSzyn35zyCqDfn4eGDwvEuIeE7uXfoK7yj1Aj5JNYJ9j+pUIVl5
        nRGd1N0zI+vFOuadtY89J+xM=
X-Received: by 2002:a05:6512:2211:b0:4fb:8948:2b2b with SMTP id h17-20020a056512221100b004fb89482b2bmr14099216lfu.48.1688546317009;
        Wed, 05 Jul 2023 01:38:37 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHw/8+9xxPRw7DNATPC6lakSSCvVuMDKfqLB9aRt/ZUrBO5oK9Z8Als1e5OzgdL2qBEpY21lQ==
X-Received: by 2002:a05:6512:2211:b0:4fb:8948:2b2b with SMTP id h17-20020a056512221100b004fb89482b2bmr14099194lfu.48.1688546316638;
        Wed, 05 Jul 2023 01:38:36 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id m3-20020a056000180300b003141e9e2f81sm14564718wrh.4.2023.07.05.01.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 01:38:36 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Inki Dae <inki.dae@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Subject: Re: [PATCH 05/10] drm/exynos: Use fbdev DMA helpers
In-Reply-To: <20230704160133.20261-6-tzimmermann@suse.de>
References: <20230704160133.20261-1-tzimmermann@suse.de>
 <20230704160133.20261-6-tzimmermann@suse.de>
Date:   Wed, 05 Jul 2023 10:38:35 +0200
Message-ID: <87ttuirbw4.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Use fbdev's DMA helpers for fbdev emulation. They drivers previously

s/They/The

> used the I/O-memory helpers, while allocating DMA-able system memory.
> This could (in theory) result in bus errors from accessing the memory
> range.
>
> This bug has been present since the exynos driver was first added.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: 1c248b7d2960 ("DRM: add DRM Driver for Samsung SoC EXYNOS4210.")

Wonder the value of this "Fixes:" tag since this patch depends on the DMA
helpers introduced in 1/10?  I would just drop it, since it might confuse
the different kernel stable scripts that attempt to backport by looking at
this tag.

As you said, it has been present from the beginning of this driver.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

