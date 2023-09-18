Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C02CD37B0
	for <linux-fbdev@archiver.kernel.org>; Mon, 18 Sep 2023 08:59:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233174AbjIRI7F (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 18 Sep 2023 04:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237157AbjIRI6q (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 18 Sep 2023 04:58:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCA4C5
        for <linux-fbdev@vger.kernel.org>; Mon, 18 Sep 2023 01:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695027473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qyKdzQXW09x6MEXHXxxG+nlHUmD9Upbh0B3MwI8uyUs=;
        b=gqj4UcapYRKRIkriOfuYcwYUgh0UFApr/r4CClt2gQrmK+isSZBU3Ke069dYmHIxeA+Rlz
        TYnJYBt0Fy+Hsx1eIrRd46pILjxdKKOCeJJRgzO1Im7ZsCj1ccV1k8kFVeH8qbH7WTe6UN
        6ib79gvIrqnV8kylNKU10frxFnH63Uk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-399-o0Y9FjMeMymGnuk9yUrxKA-1; Mon, 18 Sep 2023 04:57:48 -0400
X-MC-Unique: o0Y9FjMeMymGnuk9yUrxKA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-31fd48da316so2985811f8f.3
        for <linux-fbdev@vger.kernel.org>; Mon, 18 Sep 2023 01:57:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695027467; x=1695632267;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qyKdzQXW09x6MEXHXxxG+nlHUmD9Upbh0B3MwI8uyUs=;
        b=IBJiTnqqeoj2UTEaRsnYGzbBOVKK9lSZfK3f9qPYEJ/wrWbGVx4xhvixO9Xj4OqfVP
         6I3y3u/GxNw/G8lprcmFQRZHXR/PL5Lis+m5/4oNKg5ihodoijfb8JcaOdP9mCqa27ou
         AchhOj7dNEXo0JjEK1QgYHyF5hF1nO5jy6Sog8rrllx+ZKZ1Bw2e/dZm7JFrFteBQu4y
         MxZzI8QJ3BCJ5PIlWjz/2rfqXOciPW7Cr5rHoD1350IacYLYQ3+4bFuLoVFmmQoGhbAq
         xpQ0kIFh4XyyGTdp6jY0prx/AIQLIF4XgATECky9jZ2j8C0RgXjIAWMgUA/eEgUjA2Yi
         O5fg==
X-Gm-Message-State: AOJu0YzWX/lvOSvEsFTnXH6M5yaaupcgANBxU1tw7s4DtvdL3LGba86o
        7MA+SMmP0MwadeVkeW51rV2pyoQDxvENS6y0aonlivGgFY0sku5onNSaaRC7tAcHimidql8OrIM
        yJKJcOd6VO8Fc30wdEfICAKM=
X-Received: by 2002:a5d:66c7:0:b0:31a:e744:1297 with SMTP id k7-20020a5d66c7000000b0031ae7441297mr7396709wrw.50.1695027467459;
        Mon, 18 Sep 2023 01:57:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHh82k9EsEnX0jxsbjPY0Fo6+RHb1RPgMoMZx6OcS4zMw8+Pv1zpozGayE9LfYPLqYeBM/rmQ==
X-Received: by 2002:a5d:66c7:0:b0:31a:e744:1297 with SMTP id k7-20020a5d66c7000000b0031ae7441297mr7396691wrw.50.1695027467110;
        Mon, 18 Sep 2023 01:57:47 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id u8-20020a5d6ac8000000b003179b3fd837sm11908680wrw.33.2023.09.18.01.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 01:57:46 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Arnd Bergmann <arnd@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>,
        Dave Airlie <airlied@redhat.com>,
        Jim Cromie <jim.cromie@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Arthur Grillo <arthurgrillo@riseup.net>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-fbdev@vger.kernel.org
Subject: Re: [PATCH] drm: fix up fbdev Kconfig defaults
In-Reply-To: <971f1e86-bcc4-4462-81c7-571a05748b46@suse.de>
References: <20230911205338.2385278-1-arnd@kernel.org>
 <971f1e86-bcc4-4462-81c7-571a05748b46@suse.de>
Date:   Mon, 18 Sep 2023 10:57:45 +0200
Message-ID: <87r0mv5052.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Hi
>
> Am 11.09.23 um 22:52 schrieb Arnd Bergmann:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> As a result of the recent Kconfig reworks, the default settings for the
>> framebuffer interfaces changed in unexpected ways:
>> 
>> Configurations that leave CONFIG_FB disabled but use DRM now get
>> DRM_FBDEV_EMULATION by default. This also turns on the deprecated /dev/fb
>> device nodes for machines that don't actually want it.
>> 
>> In turn, configurations that previously had DRM_FBDEV_EMULATION enabled
>> now only get the /dev/fb front-end but not the more useful framebuffer
>> console, which is not selected any more.
>> 
>> We had previously decided that any combination of the three frontends
>> (FB_DEVICE, FRAMEBUFFER_CONSOLE and LOGO) should be selectable, but the
>> new default settings mean that a lot of defconfig files would have to
>> get adapted.
>> 
>> Change the defaults back to what they were in Linux 6.5:
>> 
>>   - Leave DRM_FBDEV_EMULATION turned off unless CONFIG_FB
>>     is enabled. Previously this was a hard dependency but now the two are
>>     independent. However, configurations that enable CONFIG_FB probably
>>     also want to keep the emulation for DRM, while those without FB
>>     presumably did that intentionally in the past.
>> 
>>   - Leave FB_DEVICE turned off for FB=n. Following the same
>>     logic, the deprecated option should not automatically get enabled
>>     here, most users that had FB turned off in the past do not want it,
>>     even if they want the console
>> 
>>   - Turn the FRAMEBUFFER_CONSOLE option on if
>>     DRM_FBDEV_EMULATION is set to avoid having to change defconfig
>>     files that relied on it being selected unconditionally in the past.
>>     This also makes sense since both LOGO and FB_DEVICE are now disabled
>>     by default for builds without CONFIG_FB, but DRM_FBDEV_EMULATION
>>     would make no sense if all three are disabled.
>> 
>> Fixes: a5ae331edb02b ("drm: Drop select FRAMEBUFFER_CONSOLE for DRM_FBDEV_EMULATION")
>> Fixes: 701d2054fa317 ("fbdev: Make support for userspace interfaces configurable")
>> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
>

Pushed to drm-misc (drm-misc-fixes). Thanks!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

