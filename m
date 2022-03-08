Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B739C433EF
	for <linux-fbdev@archiver.kernel.org>; Tue,  8 Mar 2022 19:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241171AbiCHTin (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 8 Mar 2022 14:38:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233118AbiCHTin (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 8 Mar 2022 14:38:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5606D17AA0
        for <linux-fbdev@vger.kernel.org>; Tue,  8 Mar 2022 11:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646768264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+2k8YN3Ua/MfrbcPLU4d/FurtW2MEzsF3PwIrji3KUA=;
        b=AoFgmBIsuwZ8BDkjZmAYOMIvx+VY6QIISXMZeBH6up79w0NXMaAQg+fuyY6FI/g6ifRrHc
        jlB49mQDAHiFVEwB0yzFArC3YiEY7zzG0S1i3I+aZ+jwnAFunD3iKvjhEYQRGpXrz9nqyu
        iKpk2DoXKxDRvHADGsMjmP8j0AEXAZs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-73-gLV9qEK4PL24g-4vS8CVfA-1; Tue, 08 Mar 2022 14:37:43 -0500
X-MC-Unique: gLV9qEK4PL24g-4vS8CVfA-1
Received: by mail-wr1-f72.google.com with SMTP id o9-20020adfca09000000b001ea79f7edf8so5774205wrh.16
        for <linux-fbdev@vger.kernel.org>; Tue, 08 Mar 2022 11:37:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+2k8YN3Ua/MfrbcPLU4d/FurtW2MEzsF3PwIrji3KUA=;
        b=MJPtAETujAftSteWJsqtQvH51n57PDmmEW8ap5Sko47ylg8kkzPut2wB/MExd6iZWR
         pJ4iwT0CcLoQFgQfpfll5qC5VZNQz2WyPGYkrJ+F6uZAa+2POgcUz8k3SDm69vQW6wNP
         MqqUKjprMJKjZhZGMdjBgFrxI94SntK9EcDTlnNorppFk0djVn9hnAkc3ZAwNkIVTw1H
         wvESij0VpHoRaZBZwyw77T1I/iD5rVGsIWxmXVJF8/fT8ikQXEU+wsiR2AGZd3e38efu
         O56ER7mN9PBgAhp31IDEcvSfTh54gHiKWZHNYU5ffRVG+jML8qIipRpJCslw7LFlXe/M
         PM9A==
X-Gm-Message-State: AOAM531acSBDa81/IWFED/FDHYfBZAHL55o3vcasLgH6pNWb1SjtjQsJ
        KWDBBisC6XJl3wTotKVP3LijqA8RsKE2prkJNAFovX6p1J/Qz1OXOgSsYe2/Z8Gmk2xw9C0hsHv
        NKTHYqW6jDUp8KeGmPyeeuoc=
X-Received: by 2002:a5d:5707:0:b0:1f0:1815:be86 with SMTP id a7-20020a5d5707000000b001f01815be86mr13648919wrv.383.1646768262277;
        Tue, 08 Mar 2022 11:37:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzQDbHk0Oyh98eHSFSfeioEZRSnYXr6P9e7XMlZU3xU/Hyrpx++ggBV0z8kJBT7QQ599GCKow==
X-Received: by 2002:a5d:5707:0:b0:1f0:1815:be86 with SMTP id a7-20020a5d5707000000b001f01815be86mr13648907wrv.383.1646768262062;
        Tue, 08 Mar 2022 11:37:42 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id w9-20020a5d6089000000b001f0256761b9sm23862348wrt.45.2022.03.08.11.37.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 11:37:41 -0800 (PST)
Message-ID: <b1af16e7-a20f-5499-6234-c5090349305f@redhat.com>
Date:   Tue, 8 Mar 2022 20:37:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 9/9] drm/virtio: Implement dumb_create_fbdev with GEM
 SHMEM helpers
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        airlied@linux.ie, mripard@kernel.org,
        maarten.lankhorst@linux.intel.com, deller@gmx.de
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
References: <20220303205839.28484-1-tzimmermann@suse.de>
 <20220303205839.28484-10-tzimmermann@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220303205839.28484-10-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 3/3/22 21:58, Thomas Zimmermann wrote:
> Implement struct drm_driver.dumb_create_fbdev with the helpers
> provided by GEM SHMEM. Fbdev deferred I/O will now work without
> an intermediate shadow buffer for mmap.
> 
> As the virtio driver replaces several of the regular GEM SHMEM
> functions with its own implementation, some additional code is
> necessary make fbdev optimization work. Especially, the driver
> has to provide buffer-object functions for fbdev. Add the hook
> struct drm_driver.gem_create_object_fbdev, which is similar to
> struct drm_driver.gem_create_object and allows for the creation
> of dedicated fbdev buffer objects. Wire things up within GEM
> SHMEM.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/gpu/drm/drm_gem_shmem_helper.c  |  7 +++-
>  drivers/gpu/drm/virtio/virtgpu_drv.c    |  2 +
>  drivers/gpu/drm/virtio/virtgpu_drv.h    |  2 +
>  drivers/gpu/drm/virtio/virtgpu_object.c | 54 +++++++++++++++++++++++--
>  include/drm/drm_drv.h                   | 10 +++++
>  5 files changed, 71 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
> index ab7cb7d896c3..225aa17895bd 100644
> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> @@ -71,7 +71,12 @@ __drm_gem_shmem_create(struct drm_device *dev, size_t size, bool private, bool f
>  
>  	size = PAGE_ALIGN(size);
>  
> -	if (dev->driver->gem_create_object) {
> +	if (dev->driver->gem_create_object_fbdev && fbdev) {

Same comment here to check if fbdev emulation is enabled or maybe is not
worht it ? But I think this hints the compiler to optimize the if branch.

[snip]

> +}
> +#else
> +struct drm_gem_object *virtio_gpu_create_object_fbdev(struct drm_device *dev,
> +						      size_t size)
> +{
> +	return ERR_PTR(-ENOSYS);
> +}

As mentioned, I believe this should be ERR_PTR(-ENOTSUPP) instead.

Feel free to ignore all this nits if you consider that are not applicable.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

