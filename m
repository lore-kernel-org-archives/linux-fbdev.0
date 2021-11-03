Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 957F6C433F5
	for <linux-fbdev@archiver.kernel.org>; Wed,  3 Nov 2021 13:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80DD560F56
	for <linux-fbdev@archiver.kernel.org>; Wed,  3 Nov 2021 13:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbhKCNI5 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 3 Nov 2021 09:08:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56757 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231151AbhKCNIy (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 3 Nov 2021 09:08:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635944778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QbLN+rLSmR4Lu23oOqZ5Rw/0XzuuN+zYLV6sy53LaJM=;
        b=Z1ECO6FMsh7mueLc0e0JCmXm68IqmsRtlyym4Y0m8sYqMgaJvfpE98OP2azZY7Q/nSVUCW
        IVKTHQ9sm9ZhESS9LZ3suNpkDQp777pAbE5SLFnCU8EMtWkMrwYCKVfAW3LPm+GXUxnibw
        OZMHrGS2RC1ki/KtHgIBCH0A73NYXi0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-msMOnxeDPu2F0dei6GzK3g-1; Wed, 03 Nov 2021 09:06:16 -0400
X-MC-Unique: msMOnxeDPu2F0dei6GzK3g-1
Received: by mail-wm1-f72.google.com with SMTP id n189-20020a1c27c6000000b00322f2e380f2so2724792wmn.6
        for <linux-fbdev@vger.kernel.org>; Wed, 03 Nov 2021 06:06:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QbLN+rLSmR4Lu23oOqZ5Rw/0XzuuN+zYLV6sy53LaJM=;
        b=paixFsrAvQ/4A/IM7Ovd2LxqFE4Ukj1FesVFFKdADpD6/M+LwomUuT07VY08gi+uFc
         ksJQh7kRAbQiumdom/NSSHl1N29c2zHsKNe4EcZBEuSaJ7RNDzQk7wQjL5k8ltS+oyfP
         tvRy2slA5vvn7HxnEopBU8Zivb08vnUXnO8W0YlXXhuejDpEMLXTOoRehI5Zg04VeUOt
         lkUgnuVkrO1Ut9vYRFQwZkY0IN8RZvbDXpNYhGVYU9JOfnjtQqmrKnewdQiakrdlT3ib
         Cgy28vJkXQ1MPi5EjP2XTA+2r3kHJu3WtfPHklGWkhEc3MlpxPUZfU1Odpm0WTvQu3l0
         Rmig==
X-Gm-Message-State: AOAM533/+9HcNCTToqRz1YyDr++GDjfm2Pg7+iv93RznXFeUKCjw34HO
        O4dp6QQ4LmGHmCTwVfdMMhL4HcvdLH27r1ZSNq/NHvaSkk8/C4DyFpFpq+z9H8/uY7jQcJcalAS
        xr5ElQXQErGnUHQePTo407n4=
X-Received: by 2002:a7b:c5d4:: with SMTP id n20mr15125818wmk.32.1635944775063;
        Wed, 03 Nov 2021 06:06:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxM0hXFNtYadm5yFc+JONq4iTPFyfiO2VjSzzIrHnbt608JviNYEXO0rXhutOI0PtrTAGlysw==
X-Received: by 2002:a7b:c5d4:: with SMTP id n20mr15125743wmk.32.1635944774765;
        Wed, 03 Nov 2021 06:06:14 -0700 (PDT)
Received: from [192.168.1.128] ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id g2sm1846869wrq.62.2021.11.03.06.06.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Nov 2021 06:06:14 -0700 (PDT)
Message-ID: <fc835469-b908-608b-7a1c-d3b7340d7c20@redhat.com>
Date:   Wed, 3 Nov 2021 14:06:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RESEND PATCH 2/5] drm: Move nomodeset kernel parameter handler
 to the DRM subsystem
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
 <20211103122809.1040754-3-javierm@redhat.com>
 <a95acef3-8647-9fb0-efa7-9c3a35524052@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <a95acef3-8647-9fb0-efa7-9c3a35524052@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello Thomas,

On 11/3/21 13:41, Thomas Zimmermann wrote:
> Hi
> 
> Am 03.11.21 um 13:28 schrieb Javier Martinez Canillas:
>> The "nomodeset" kernel cmdline parameter is handled by the vgacon driver
>> but the exported vgacon_text_force() symbol is only used by DRM drivers.
>>
>> It makes much more sense for the parameter logic to be in the subsystem
>> of the drivers that are making use of it. Let's move that to DRM.
>>
>> Suggested-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>> ---
>>
>>   drivers/gpu/drm/Makefile                |  2 ++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  3 +--
>>   drivers/gpu/drm/ast/ast_drv.c           |  1 -
>>   drivers/gpu/drm/drm_nomodeset.c         | 26 +++++++++++++++++++++++++
>>   drivers/gpu/drm/i915/i915_module.c      |  2 --
>>   drivers/gpu/drm/mgag200/mgag200_drv.c   |  1 -
>>   drivers/gpu/drm/nouveau/nouveau_drm.c   |  1 -
>>   drivers/gpu/drm/qxl/qxl_drv.c           |  1 -
>>   drivers/gpu/drm/radeon/radeon_drv.c     |  1 -
>>   drivers/gpu/drm/tiny/bochs.c            |  1 -
>>   drivers/gpu/drm/tiny/cirrus.c           |  1 -
>>   drivers/gpu/drm/vboxvideo/vbox_drv.c    |  1 -
>>   drivers/gpu/drm/virtio/virtgpu_drv.c    |  1 -
>>   drivers/gpu/drm/vmwgfx/vmwgfx_drv.c     |  1 -
>>   drivers/video/console/vgacon.c          | 21 --------------------
>>   include/drm/drm_mode_config.h           |  6 ++++++
>>   include/linux/console.h                 |  6 ------
>>   17 files changed, 35 insertions(+), 41 deletions(-)
>>   create mode 100644 drivers/gpu/drm/drm_nomodeset.c
>>
>> diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
>> index 1c41156deb5f..0e2d60ea93ca 100644
>> --- a/drivers/gpu/drm/Makefile
>> +++ b/drivers/gpu/drm/Makefile
>> @@ -33,6 +33,8 @@ drm-$(CONFIG_DRM_PRIVACY_SCREEN) += drm_privacy_screen.o drm_privacy_screen_x86.
>>   
>>   obj-$(CONFIG_DRM_DP_AUX_BUS) += drm_dp_aux_bus.o
>>   
>> +obj-y += drm_nomodeset.o
> 
> Repeating my other comment, should this rather be protected by a 
> separate config symbol that is selected by CONFIG_DRM?
>

I actually thought about that and my opinion is that obj-y reflects
what we really want here or do you envision this getting disabled
in some cases ?

Probably the problem is Kbuild descending into the drivers/gpu dir
even when CONFIG_DRM is not set. Maybe what we want is something
like the following instead?

diff --git a/drivers/gpu/Makefile b/drivers/gpu/Makefile
index 835c88318cec..ef12ee05ba6e 100644
--- a/drivers/gpu/Makefile
+++ b/drivers/gpu/Makefile
@@ -3,6 +3,7 @@
 # taken to initialize them in the correct order. Link order is the only way
 # to ensure this currently.
 obj-$(CONFIG_TEGRA_HOST1X)     += host1x/
-obj-y                  += drm/ vga/
+obj-$(CONFIG_DRM)              += drm/
+obj-y                          += vga/
 obj-$(CONFIG_IMX_IPUV3_CORE)   += ipu-v3/
 obj-$(CONFIG_TRACE_GPU_MEM)            += trace/

Best regards, -- 
Javier Martinez Canillas
Linux Engineering
Red Hat

