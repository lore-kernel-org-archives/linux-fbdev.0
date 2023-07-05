Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62124EB64DA
	for <linux-fbdev@archiver.kernel.org>; Wed,  5 Jul 2023 08:50:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbjGEIuZ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 5 Jul 2023 04:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbjGEIuY (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 5 Jul 2023 04:50:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0520319B
        for <linux-fbdev@vger.kernel.org>; Wed,  5 Jul 2023 01:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688546984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mygE2eC1+1F6RcP4Lm9OLsM0G/twLQqV8R8dIF6r2eA=;
        b=J/YsifluszoJ343eM3UBt1Wy4p+tKaqfCyTi5o3g2JPs6eCM71LWJ5TF/U6pkD6uic/Ege
        R7vAlgWY/QK5nfalTqHLcNKWMvCqXhROtTyMV8IUyLWP07Y2oIjV1QWmxsiIlDz4Frh7PG
        Jh9oDtvY2DvxhL8JoBHbZHBkxNNng6I=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-S-TDVqhzNLylHc9srr-zzQ-1; Wed, 05 Jul 2023 04:49:43 -0400
X-MC-Unique: S-TDVqhzNLylHc9srr-zzQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-314326f6e23so1828771f8f.2
        for <linux-fbdev@vger.kernel.org>; Wed, 05 Jul 2023 01:49:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688546982; x=1691138982;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mygE2eC1+1F6RcP4Lm9OLsM0G/twLQqV8R8dIF6r2eA=;
        b=VEayaXZQ78vOEVF2DxACc9ghR7oREtpuvu4UFo9aTdIssXeoIxHgPPtwOq7TUYxo8s
         lDrdTDkY9TXRimDWE+RRNXmk3Vjyb0f/XtIhUwaeCAeQulKjfqTUua6LPzr2tYhDzocm
         yqk803C4ahGcO01ofNz104OVUXm46XwLgTVZQNk+4OMXvNziJhpkp3rRJZKnPWc7wvMn
         +WmrQ3oYTAArAK8okNyg1+ckdagnOjDpgJFa9az8zbBalVtoEL/fSPAcWFKi4KXv41Tu
         QtG6HDKI3Nxy01O3WnbdNy/noQox38i8IjhAkZyezz58Ef1+OCZNZ68AyHR2RdKfh34m
         HKMQ==
X-Gm-Message-State: ABy/qLZHof4FqAVZrI+tPZzuZ6aB2zqk2F+aMQ6lhzyr5zPeNZs7vGrK
        UkJ4fxfnN/bTnCCO2tKMOvXbwzvVEyG4+FyVj8TVh35DP3xCGOTk0jtksN0q95BFHPZbBsqMRgp
        fWy5Mqn/CP3U/J86tfZLuXhc=
X-Received: by 2002:adf:e44d:0:b0:313:f97c:d87f with SMTP id t13-20020adfe44d000000b00313f97cd87fmr12842679wrm.67.1688546982145;
        Wed, 05 Jul 2023 01:49:42 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHiFHQIX6+LSUFE4lngdNXwrF3KteEAZwZqL0tALqI5G9uCMk9AA+C1J9hJqpvVRrGAzg2C2Q==
X-Received: by 2002:adf:e44d:0:b0:313:f97c:d87f with SMTP id t13-20020adfe44d000000b00313f97cd87fmr12842658wrm.67.1688546981884;
        Wed, 05 Jul 2023 01:49:41 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id x18-20020adff0d2000000b003141e86e751sm14564867wro.5.2023.07.05.01.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 01:49:41 -0700 (PDT)
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
Subject: Re: [PATCH 06/10] drm/exynos: Set fbdev flags
In-Reply-To: <20230704160133.20261-7-tzimmermann@suse.de>
References: <20230704160133.20261-1-tzimmermann@suse.de>
 <20230704160133.20261-7-tzimmermann@suse.de>
Date:   Wed, 05 Jul 2023 10:49:40 +0200
Message-ID: <87r0pmrbdn.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Set fbdev default flags FBNFO_DEFAULT and mark the framebuffer with

FBINFO_DEFAULT, or did you meand FBINFO_FLAG_DEFAULT (the flag your patch
is actually using) ?

I just noticed that are the same... and in patch 04/10 you used the former
for the tegra driver, but here you are using the latter. Is on purpose or
just a mistake ?

> FBINFO_VIRTFB. The framebuffer range is in DMA-able memory and should
> be accessed with the CPU's regular memory ops.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Inki Dae <inki.dae@samsung.com>
> Cc: Seung-Woo Kim <sw0312.kim@samsung.com>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Cc: Alim Akhtar <alim.akhtar@samsung.com>
> ---
>  drivers/gpu/drm/exynos/exynos_drm_fbdev.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_fbdev.c b/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
> index 7ca3424b59ce..28dc398d6e10 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
> @@ -72,6 +72,7 @@ static int exynos_drm_fbdev_update(struct drm_fb_helper *helper,
>  		return PTR_ERR(fbi);
>  	}
>  
> +	fbi->flags = FBINFO_FLAG_DEFAULT;

The #define FBINFO_FLAG_DEFAULT	FBINFO_DEFAULT seems to be there since the
original v2.6.12-rc2 git import in commit 1da177e4c3f4, so is hard to know
why was introduced. FBINFO_DEFAULT is more used, I will just stick to that:

$ git grep FBINFO_DEFAULT | wc -l
92

$ git grep FBINFO_FLAG_DEFAULT | wc -l
38

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

