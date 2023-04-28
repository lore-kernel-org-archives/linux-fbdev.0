Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E605C77B60
	for <linux-fbdev@archiver.kernel.org>; Fri, 28 Apr 2023 13:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346249AbjD1Ngl (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 28 Apr 2023 09:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346239AbjD1Ngl (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 28 Apr 2023 09:36:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD00059EA
        for <linux-fbdev@vger.kernel.org>; Fri, 28 Apr 2023 06:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682688952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T6nMtf6Gzq3uJ6hYj+VP/gNrA7S63KDC0HhAUOQNVRE=;
        b=MBaXSMiYw/2jtpYOgFcx4L05tCMAsAYZVNWfkQDPD9We4k1gO4iPPyP9Q1rGDIg9yXRCcP
        V6fHbfpoBG+72EpKaBtF6FcefTKtPprshcdG/t6LiaurjkWHTZCLEES0KRFaAdaiS0DUXL
        6f/e4v/9JE3YFp+SEXGORHOYCjIS4yU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-pILHMhr2OXiBsUfLyLPmBQ-1; Fri, 28 Apr 2023 09:35:50 -0400
X-MC-Unique: pILHMhr2OXiBsUfLyLPmBQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f1793d6363so35657835e9.1
        for <linux-fbdev@vger.kernel.org>; Fri, 28 Apr 2023 06:35:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682688950; x=1685280950;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T6nMtf6Gzq3uJ6hYj+VP/gNrA7S63KDC0HhAUOQNVRE=;
        b=Z84laFXaOklvikVquOeS9GjSqRE2VOFqaQBJd59JSIqwzz4M4CuC5JjRwNWJWd91Va
         jZAFhFpN45j7XRd0p6GyOSv0kzuU0oNGa+5c/TnmR7pAd/9/uO1KzsABYWV7BGxyI/4/
         EjcYhimuqX1/sBTW1zm5HvkP6Nmi45P8jsT0hiO5fdsz2ftoXKQHYJCFuSM/TLBO/alX
         22txGP5FcQnTsNaa4XHAa3lXH53p6F4dojs3KOwesSPUXKkkwU7RfUoXtWrL5Z8f4mh8
         BgAt421iWBs6kRUhFUD+4F+7Al5ZSPDu9DQsOmI000GtTuFKEbbo87HMnwmIH1lZu2sl
         nvtA==
X-Gm-Message-State: AC+VfDxMpvX/hA7K2B15EgjvO23v8SibPxNW87KuVc3DwF1KmtRyQaM4
        SaEAj2+zputil2JJa6Rryveg1+nsmEEvx2Ap4Qa6nbyDTcJvNMHdzH+yg4TWwi/GwVWPD89Samf
        coTDSI5Antdgy4jQVLyXuMps=
X-Received: by 2002:a05:600c:3787:b0:3f1:9540:d5fe with SMTP id o7-20020a05600c378700b003f19540d5femr4051770wmr.21.1682688949732;
        Fri, 28 Apr 2023 06:35:49 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7/iFaoJZ3rsWlljzHqhReT6yt4/v8GHbSfXzBE1A6dFaGWOiZETix4CxAv9bDK3RcekxAnWg==
X-Received: by 2002:a05:600c:3787:b0:3f1:9540:d5fe with SMTP id o7-20020a05600c378700b003f19540d5femr4051750wmr.21.1682688949452;
        Fri, 28 Apr 2023 06:35:49 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c228b00b003f1736fdfedsm24460490wmf.10.2023.04.28.06.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 06:35:49 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@gmail.com, daniel@ffwll.ch, deller@gmx.de,
        geert@linux-m68k.org, sudipm.mukherjee@gmail.com,
        teddy.wang@siliconmotion.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v2 04/19] fbdev/arcfb: Use struct fb_info.screen_buffer
In-Reply-To: <20230428122452.4856-5-tzimmermann@suse.de>
References: <20230428122452.4856-1-tzimmermann@suse.de>
 <20230428122452.4856-5-tzimmermann@suse.de>
Date:   Fri, 28 Apr 2023 15:35:48 +0200
Message-ID: <87a5ysgmdn.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Use info->screen_buffer when reading and writing framebuffers in
> system memory. It's the correct pointer for this address space.
>
> The struct fb_info has a union to store the framebuffer memory. This can
> either be info->screen_base if the framebuffer is stored in I/O memory,
> or info->screen_buffer if the framebuffer is stored in system memory.
>
> As the driver operates on the latter address space, it is wrong to use
> .screen_base and .screen_buffer must be used instead. This also gets
> rid of casting needed due to not using the correct data type.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

