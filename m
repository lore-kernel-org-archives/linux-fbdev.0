Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08698C433FE
	for <linux-fbdev@archiver.kernel.org>; Wed,  3 Nov 2021 15:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5C0160FC4
	for <linux-fbdev@archiver.kernel.org>; Wed,  3 Nov 2021 15:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbhKCPD3 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 3 Nov 2021 11:03:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43662 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229587AbhKCPD3 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 3 Nov 2021 11:03:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635951652;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uwI0Y59Q5jmF4PHv+uLDkwhNmEWKp2IZoCsuOpcoatA=;
        b=V8hupRDi7JW+MC8owgkOu+/x5Qo5KaggJE3sSIstfNGwbQoL9+gRulz1GWQFi/8GxGc41a
        enkqUtLyhFFkpJTFmMNpm+gZLs/uvyOcF+btSBtMsx0ql6i57D9Ot9z146O6p1kWLNpk7M
        zPe2NrI7r68797d6wlshTQaNDptLT/A=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-cvTfjZQWMdOV7UUhjuJrQQ-1; Wed, 03 Nov 2021 11:00:51 -0400
X-MC-Unique: cvTfjZQWMdOV7UUhjuJrQQ-1
Received: by mail-wm1-f71.google.com with SMTP id j25-20020a05600c1c1900b00332372c252dso1220077wms.1
        for <linux-fbdev@vger.kernel.org>; Wed, 03 Nov 2021 08:00:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uwI0Y59Q5jmF4PHv+uLDkwhNmEWKp2IZoCsuOpcoatA=;
        b=5WcB+6z9W+IsowjGzM0bQ4LXusYxuKF08qfTbWKn5Gy0rfawsA9i7RpOpu/okSHHXF
         sjwX4yVg3YOj4P7TQkc6F57XVx0u6L/KgXaKxSu8C8LDkt295btTbXRiKbxu8Vkjrl0+
         L4PeNegBOFvx+IoYeGU5R3Wz/m2xlUz533YfXUhosYEBx8O4vIJ4eCn2whAU3O4mLgIO
         yn1J04ZLobawhVoiyJyOHw9b6I8QNYJRIwm3BYxOZJWPKIUqD627W4h683Vrcw4YJy9o
         ZPDF3zGGHgQl7TCR2SqT436ZmBdIwNwAIkdnG9he8NMeoO7/rJh6zmxsZmKOV/dx6sZX
         MyeA==
X-Gm-Message-State: AOAM531Zc1NdxH/QoJQ7PMl/CsoSi3SNVU44rIXJcxYOqhMH2+YMqjSk
        +le6Dztb/DxDCLjO4vDyp4mmnB0gbamYjKoo5HtfawoC0ad3EKWFNN+nay0WVv3pA80nqwuoOt3
        zqLj8fvR0KUsbf9urwzk+LHo=
X-Received: by 2002:a1c:740e:: with SMTP id p14mr15702641wmc.109.1635951650068;
        Wed, 03 Nov 2021 08:00:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzlHYGSvfJmLDivVAOaT4xxbH7zmwqgCefExXH/bfigpAgkjWjbQ8meeoW65MqFlJvktgySGg==
X-Received: by 2002:a1c:740e:: with SMTP id p14mr15702572wmc.109.1635951649817;
        Wed, 03 Nov 2021 08:00:49 -0700 (PDT)
Received: from [192.168.1.128] ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id q1sm2089857wmj.20.2021.11.03.08.00.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Nov 2021 08:00:49 -0700 (PDT)
Message-ID: <dbdbaf95-8625-aec9-4446-d39db77b23f2@redhat.com>
Date:   Wed, 3 Nov 2021 16:00:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RESEND PATCH 0/5] Cleanups for the nomodeset kernel command line
 parameter logic
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     Peter Robinson <pbrobinson@gmail.com>,
        =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Neal Gompa <ngompa13@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Ben Skeggs <bskeggs@redhat.com>, Chia-I Wu <olvaffe@gmail.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Zack Rusin <zackr@vmware.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, nouveau@lists.freedesktop.org,
        spice-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
References: <20211103122809.1040754-1-javierm@redhat.com>
 <e02d23be-1a1c-570d-e76f-dbea76b6dd55@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <e02d23be-1a1c-570d-e76f-dbea76b6dd55@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello Thomas,

On 11/3/21 14:01, Thomas Zimmermann wrote:

[snip]

>>
>>
>> Javier Martinez Canillas (5):
>>    drm/i915: Fix comment about modeset parameters
>>    drm: Move nomodeset kernel parameter handler to the DRM subsystem
>>    drm: Rename vgacon_text_force() function to drm_modeset_disabled()
>>    drm: Add a drm_drv_enabled() helper function
>>    drm: Use drm_drv_enabled() instead of drm_modeset_disabled()
> 
> There's too much churn here IMHO. Please merge patches 2+3 and 4+5. And 
> I'd put patch (4+5) first, so you have the drivers out of the way. After 
> that patch (2+3) should only modify drm_drv_enabled().
>

Sure, I'm happy with less patches.

Thanks for your feedback.
 
> Best regards
> Thomas
> 
Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

