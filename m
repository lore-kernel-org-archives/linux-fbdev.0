Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7677FC433F5
	for <linux-fbdev@archiver.kernel.org>; Tue, 25 Jan 2022 15:36:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356380AbiAYPg3 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 25 Jan 2022 10:36:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37027 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1356305AbiAYPeZ (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 25 Jan 2022 10:34:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643124849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gYJM0P1mp5NgX5FuvA0vc0pACL34+rgEJ9Vi+JjrcqU=;
        b=ezqerXJ02Pz3etYKGYh0hyTjhCfzr4h4fgWOTbhUvQ/B5Ev5RsXTe0mvRonziFKw6U4uoZ
        dMwot4Y3eSHHO/op42wzT8tKm+Jj9j3QeCRtTTlqUcmi2+S+xoST0M8xJQroVLhQyunA9l
        sai3cs8my0BEHIFLCkXarOOy3QtNRjo=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-360-3KWFtAvSO2yRnTTjLGQXqQ-1; Tue, 25 Jan 2022 10:34:08 -0500
X-MC-Unique: 3KWFtAvSO2yRnTTjLGQXqQ-1
Received: by mail-ed1-f70.google.com with SMTP id v15-20020a50a44f000000b004094f4a8f3bso530244edb.0
        for <linux-fbdev@vger.kernel.org>; Tue, 25 Jan 2022 07:34:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gYJM0P1mp5NgX5FuvA0vc0pACL34+rgEJ9Vi+JjrcqU=;
        b=xcz2BP7Jp7f4DqGZNPUm4WX/2V/sgsuFRQypwT3mihtloGSMWm5kiitzQEjLgNK5c6
         IsZDQR7Tx7j0Et9FndYdberiaO4yjoaJnhjfEt7eWT3hX0nyXt12irKacvDMi6U1SBqb
         b4NlIyVA07A34JqwYFLyCIFcUKyEQDu28Qo9wqvDwiKeMthCAfNAekZsmAU0O6OFbq6L
         jbGc7aQjRPrZHR2PURumKKuvq2YCF/B4gVrAx1+s3k3fExLl5uHt6VkECoGDzs0xidLR
         CBu3qdRay7oN/6ONgiHPQ9I8WMOY6TfmaaFWQ1xoEl8pJNNbUNdr4n8xVe5EMgdJD9cN
         DnMA==
X-Gm-Message-State: AOAM5304kPxognE9rOKXpF78GA7P4Fh6IyzPWs9SOCsSEhED3Rhj66xk
        h3SfDVkI+XftmymKAbTx9QS3CwpFZ3JukSAtdAqZp5u/ijBwNqTre7CwqEeG3F+hD7bGXYjnWPv
        oTa4cqXCKLd4VKFBoTp5Sd5g=
X-Received: by 2002:a17:907:94d4:: with SMTP id dn20mr1803380ejc.77.1643124846819;
        Tue, 25 Jan 2022 07:34:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxWVbzv4cJi6N1cXVjMID/2VItL7lLUsXMZqk6fcGrT+747KuQr+V0NKS0IMkQOYCGfVsrZEg==
X-Received: by 2002:a17:907:94d4:: with SMTP id dn20mr1803357ejc.77.1643124846605;
        Tue, 25 Jan 2022 07:34:06 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id c5sm8455216edk.43.2022.01.25.07.34.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jan 2022 07:34:06 -0800 (PST)
Message-ID: <16f9e064-99cc-4205-d03e-ae41ed034309@redhat.com>
Date:   Tue, 25 Jan 2022 16:34:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 0/5] sysfb: Fix memory-region management
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, zackr@vmware.com,
        javierm@redhat.com, jfalempe@redhat.com,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch, deller@gmx.de
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
References: <20220125091222.21457-1-tzimmermann@suse.de>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220125091222.21457-1-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Thomas,

On 1/25/22 10:12, Thomas Zimmermann wrote:
> Request framebuffer memory in simpledrm and simplefb. Do a hot-unplug
> operation when removing fbdev firmware drivers.
> 
> After being unloaded by a hardware driver, simplefb leaves behind the
> firmware framebuffer's platform device. This prevents other drivers
> from acquiring the memory as reported at [1].
> 
> Patch 1 changes the removal code of remove_conflicting_framebuffers()
> to remove the underlying device and the rsp memory region.
> 
> Patches 2 to 4 update sysfb and its drivers. The sysfb code does no
> longer mark the framebuffer memory with IORESOURCE_BUSY. Instead, the
> device drivers acquire the memory when they probe the device.
> 
> Patch 5 adds a todo item to acquire memory regions in all DRM drivers.
> 
> Tested with simpledrm and simplefb.
> 
> [1] https://lore.kernel.org/dri-devel/20220117180359.18114-1-zack@kde.org/
> 
> v2:
> 	* fix possible NULL deref in simpledrm (Jocelyn)
> 	* various style fixes (Javier)


The entire series looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

for the series.

Regards,

Hans


> 
> Javier Martinez Canillas (1):
>   drivers/firmware: Don't mark as busy the simple-framebuffer IO
>     resource
> 
> Thomas Zimmermann (4):
>   fbdev: Hot-unplug firmware fb devices on forced removal
>   drm/simpledrm: Request memory region in driver
>   fbdev/simplefb: Request memory region in driver
>   drm: Add TODO item for requesting memory regions
> 
>  Documentation/gpu/todo.rst        | 15 +++++++
>  drivers/firmware/sysfb_simplefb.c |  2 +-
>  drivers/gpu/drm/tiny/simpledrm.c  | 22 ++++++++---
>  drivers/video/fbdev/core/fbmem.c  | 29 ++++++++++++--
>  drivers/video/fbdev/simplefb.c    | 65 +++++++++++++++++++++----------
>  include/linux/fb.h                |  1 +
>  6 files changed, 105 insertions(+), 29 deletions(-)
> 
> 
> base-commit: 0bb81b5d6db5f689b67f9d8b35323235c45e890f
> prerequisite-patch-id: c2b2f08f0eccc9f5df0c0da49fa1d36267deb11d
> prerequisite-patch-id: c67e5d886a47b7d0266d81100837557fda34cb24
> prerequisite-patch-id: 8e52143a6cd7b8fb789e656208f6edde71d0f499
> 

