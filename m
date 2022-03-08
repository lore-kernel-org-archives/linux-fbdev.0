Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C39DC433EF
	for <linux-fbdev@archiver.kernel.org>; Tue,  8 Mar 2022 19:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243493AbiCHTam (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 8 Mar 2022 14:30:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235125AbiCHTal (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 8 Mar 2022 14:30:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4748C30F64
        for <linux-fbdev@vger.kernel.org>; Tue,  8 Mar 2022 11:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646767783;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kX1L2re/YQHASfVzqrCRvIe3dgRuIIIu9OGl7xqxUdw=;
        b=FpsQD/D7bVNFZ/6RL1qC6W/Ov6H2PAn6zpRcWVYQtL5NC3FrCRHyJ8UkaKvYnf6Dy4rSt5
        8t2aF6hGwJM84iBCFiU8Z2nFzi7P4jt8/pqQXJPYyEmw01w+p1zufs5qsoyY6HJLUbJiiK
        a/ngdA+LC1+hjMnFSpI4hdgaw+wW9g0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-647-9vLCGIjOMACVtGl1maF7QQ-1; Tue, 08 Mar 2022 14:29:42 -0500
X-MC-Unique: 9vLCGIjOMACVtGl1maF7QQ-1
Received: by mail-wm1-f71.google.com with SMTP id 20-20020a05600c231400b00389886f6b23so109648wmo.6
        for <linux-fbdev@vger.kernel.org>; Tue, 08 Mar 2022 11:29:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kX1L2re/YQHASfVzqrCRvIe3dgRuIIIu9OGl7xqxUdw=;
        b=P4ysBOt+cQ3sSZHurtYjpgSrREUuJuqKeeYNBJ8p6HA3WoTXaqURp1ncVQBse1eLLb
         QUCW9n/KV8pmbsX+0orvMEkjNWNNkmJxBl0u/+F9tJaD+C9KOVav7hfE4hN16hn8UWIN
         /HZiyJvhP4x4jtXYQ5hRD5w1rvwPSVIEv+E134RGjbTHQrfKUhkgPBf/A4taLKVAs1Pd
         GOPvGA0BdQtHaV7UyriggD90FienNjE0W/NFMUBklpX302SMUo8sYwC4+DddrxSyO3FW
         z2+QRAaoR1c28f8pNyjB+ee2ARNnvAT085h534SblMJ03DEYBm0tI3+piwtjRjEnIuoS
         GSaw==
X-Gm-Message-State: AOAM530YVHSYeUJEumbJQCo5tl70JXuGhgneeIJsDJW2V1JXi5DQ+1Yu
        WhjlsU0ZOARUUl2kcwN8Pupb2bFCqDGE9mc/o4yha8NVHguAoIB7GyKCJjYHvHzfSewfgIr6zkA
        a3Aw9IhbwCS4N9hweHHaNcaw=
X-Received: by 2002:a05:600c:3512:b0:382:ee82:b3d1 with SMTP id h18-20020a05600c351200b00382ee82b3d1mr633485wmq.126.1646767780764;
        Tue, 08 Mar 2022 11:29:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwzv2iTUZ4J35siqwIsOcPJMq6FNTOWfc6gKh8An0gveT64fVSFOk5vBAdPowGEG/7kETlglA==
X-Received: by 2002:a05:600c:3512:b0:382:ee82:b3d1 with SMTP id h18-20020a05600c351200b00382ee82b3d1mr633469wmq.126.1646767780513;
        Tue, 08 Mar 2022 11:29:40 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id i186-20020a1c3bc3000000b00382b25f6c9fsm2998305wma.42.2022.03.08.11.29.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 11:29:40 -0800 (PST)
Message-ID: <265aba53-ff78-e1ab-8596-e2226dff23f0@redhat.com>
Date:   Tue, 8 Mar 2022 20:29:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 8/9] drm/gem-shmem: Implement fbdev dumb buffer and mmap
 helpers
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        airlied@linux.ie, mripard@kernel.org,
        maarten.lankhorst@linux.intel.com, deller@gmx.de
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
References: <20220303205839.28484-1-tzimmermann@suse.de>
 <20220303205839.28484-9-tzimmermann@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220303205839.28484-9-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 3/3/22 21:58, Thomas Zimmermann wrote:
> Implement struct drm_driver.dumb_create_fbdev for GEM SHMEM. The
> created buffer object returned by this function implements deferred
> I/O for its mmap operation.
> 
> Add this feature to a number of drivers that use GEM SHMEM helpers
> as shadow planes over their regular video memory. The new macro
> DRM_GEM_SHMEM_DRIVER_OPS_WITH_SHADOW_PLANES sets the regular GEM
> functions and dumb_create_fbdev in struct drm_driver. Fbdev emulation
> on these drivers will now mmap the GEM SHMEM pages directly with
> deferred I/O without an intermediate shadow buffer.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

[snip]

> @@ -49,8 +50,20 @@ static const struct drm_gem_object_funcs drm_gem_shmem_funcs = {
>  	.vm_ops = &drm_gem_shmem_vm_ops,
>  };
>  
> +static const struct drm_gem_object_funcs drm_gem_shmem_funcs_fbdev = {
> +	.free = drm_gem_shmem_object_free,
> +	.print_info = drm_gem_shmem_object_print_info,
> +	.pin = drm_gem_shmem_object_pin,
> +	.unpin = drm_gem_shmem_object_unpin,
> +	.get_sg_table = drm_gem_shmem_object_get_sg_table,
> +	.vmap = drm_gem_shmem_object_vmap,
> +	.vunmap = drm_gem_shmem_object_vunmap,
> +	.mmap = drm_gem_shmem_object_mmap_fbdev,
> +	.vm_ops = &drm_gem_shmem_vm_ops_fbdev,

The drm_gem_shmem_funcs_fbdev is the same than drm_gem_shmem_funcs but
.mmap and .vm_ops callbacks. Maybe adding a macro to declare these two
struct drm_gem_object_funcs could make easier to maintain it long term ?

> +};
> +
>  static struct drm_gem_shmem_object *
> -__drm_gem_shmem_create(struct drm_device *dev, size_t size, bool private)
> +__drm_gem_shmem_create(struct drm_device *dev, size_t size, bool private, bool fbdev)
>  {
>  	struct drm_gem_shmem_object *shmem;
>  	struct drm_gem_object *obj;
> @@ -70,8 +83,12 @@ __drm_gem_shmem_create(struct drm_device *dev, size_t size, bool private)
>  		obj = &shmem->base;
>  	}
>  
> -	if (!obj->funcs)
> -		obj->funcs = &drm_gem_shmem_funcs;
> +	if (!obj->funcs) {
> +		if (fbdev)

Same question than in patch #6, maybe

                if (defined(CONFIG_DRM_FBDEV_EMULATION) && fbdev) ?

[snip]

> + */
> +int drm_gem_shmem_dumb_create_fbdev(struct drm_file *file, struct drm_device *dev,
> +				    struct drm_mode_create_dumb *args)
> +{
> +#if defined(CONFIG_DRM_FBDEV_EMULATION)
> +	return __drm_gem_shmem_dumb_create(file, dev, true, args);
> +#else
> +	return -ENOSYS;
> +#endif
> +}

I believe the correct errno code here should be -ENOTSUPP.

[snip]

> +	/* We don't use vmf->pgoff since that has the fake offset */
> +	page_offset = (vmf->address - vma->vm_start) >> PAGE_SHIFT;

I see this (vmf->address - vma->vm_start) calculation in many places of
this series. Maybe we could add a macro to calculate the offset instead ?

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

