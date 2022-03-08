Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E27AC433F5
	for <linux-fbdev@archiver.kernel.org>; Tue,  8 Mar 2022 09:58:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236472AbiCHJ7Y (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 8 Mar 2022 04:59:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345502AbiCHJ7Y (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 8 Mar 2022 04:59:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 63D6A2A72C
        for <linux-fbdev@vger.kernel.org>; Tue,  8 Mar 2022 01:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646733506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qc/dPF9NCELBNu4QqNWKZSQHX9YzQPWRojivE3+b0CU=;
        b=SBPbYeNbt6p6aKTNdlcWXV5kEYDS+Zb7EqFl/rXDU08+CB+jLP/UdEOWxLvEtuNCOyhOe7
        b7H4FyXD5yHJhego+K0HMyEnVDKyzI57ShoSpPJRtMV0jA1HXR3psI2ijKQSYEtqcYTFLx
        9Nq/CtYlTrwEyonJyPl0roWQWtgLbyE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-391-sKa4d1hmNJuKduxwNNamSg-1; Tue, 08 Mar 2022 04:58:25 -0500
X-MC-Unique: sKa4d1hmNJuKduxwNNamSg-1
Received: by mail-wr1-f72.google.com with SMTP id t15-20020adfdc0f000000b001ef93643476so5270709wri.2
        for <linux-fbdev@vger.kernel.org>; Tue, 08 Mar 2022 01:58:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Qc/dPF9NCELBNu4QqNWKZSQHX9YzQPWRojivE3+b0CU=;
        b=1vjntF41FQeiPH3mDDs7+PHuy2gRhwjJm56VkgnxRsq8N+ciJiw1Ih3XeGlCfmA2uy
         aZgSpZxeOLi7phyrNhYxbNYn/smJnniMt+keGtM85cr02d7380ZYHbHU3Nz7b/3UBH1j
         wLCm39O/hr9se7P7Tp21NBKicIlYMbNWnY/nDe4sYXRm0L+wnr8B3vkgKIeS0EOn3s7X
         IZsWtFK1TEovg9oxiOSZdm2HQQnS0/h5PmmreqLb7vbKKsrx2O9Ajv053u8gpGkZRKHT
         PdSb5roRk65UfMl8PsjTPsRlSJvZrwyaMJHFQ7Ljyil4jaLK6ax/WPwCuK0J2khsXIYm
         cd8A==
X-Gm-Message-State: AOAM531XvKoFbOa2+3ol6ut8ib64VNbC7AD0/FQlQzquFx2tj/Z+rLUR
        P3imLhypJknZ/PqrGxibyO8BtJj2BDzDCnjJzvDIbb0rZvwrqTrOznQbqVvBdOawwBlArIDlDKO
        ARaXRbO6/MiFMLB9J7YCfTm0=
X-Received: by 2002:a05:600c:35d5:b0:389:bd4a:fde0 with SMTP id r21-20020a05600c35d500b00389bd4afde0mr2905726wmq.127.1646733503694;
        Tue, 08 Mar 2022 01:58:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwJtj7RKYw3qkkDGfz/aSVN5Brr3Z9cCTJdq5hynPwmNva1D24fAYp/TKddQMzVWxr4O9YHKw==
X-Received: by 2002:a05:600c:35d5:b0:389:bd4a:fde0 with SMTP id r21-20020a05600c35d500b00389bd4afde0mr2905711wmq.127.1646733503447;
        Tue, 08 Mar 2022 01:58:23 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id 9-20020a1c0209000000b003868897278asm2475185wmc.23.2022.03.08.01.58.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 01:58:23 -0800 (PST)
Message-ID: <f869d4ee-210f-06b4-015b-b3ec78eaf4fb@redhat.com>
Date:   Tue, 8 Mar 2022 10:58:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/9] drm/simpledrm: Use fbdev defaults for shadow
 buffering
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        airlied@linux.ie, mripard@kernel.org,
        maarten.lankhorst@linux.intel.com, deller@gmx.de
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
References: <20220303205839.28484-1-tzimmermann@suse.de>
 <20220303205839.28484-2-tzimmermann@suse.de>
 <a9e7aa2c-9954-94ee-6f7c-0d6822342897@redhat.com>
 <80342fbf-5aee-5769-b439-3e147c44711f@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <80342fbf-5aee-5769-b439-3e147c44711f@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 3/8/22 10:56, Thomas Zimmermann wrote:
> Hi
> 
> Am 08.03.22 um 10:31 schrieb Javier Martinez Canillas:
>> On 3/3/22 21:58, Thomas Zimmermann wrote:
>>> Don't select shadow buffering for the fbdev console explicitly. The
>>> fbdev emulation's heuristic will enable it for any framebuffer with
>>> .dirty callback.
>>>
>>
>> Indeed it does. Not related to your series but looking at this
>> patch I noticed that drivers/gpu/drm/tiny/bochs.c will be the
>> only driver that sets .prefer_shadow_fbdev after this lands.
>>
>> The driver is using GEM so I wonder if after your series this
>> DRM driver could have a .dirty callback and the field just be
>> dropped? Or there would still be a case where it is needed ?
> Bochs uses VRAM helpers (i.e., TTM). Fbdev and userspace would directly 
> write into that buffer memory without a copy. So the dirty function 
> would be empty.
> 
> Other drivers with VRAM helpers (e.g., hibmc, ast) operate on uncached 
> I/O memory AFAICT. So they set .prefer_shadow, which also affects 
> userspace. Bochs uses cached memory and shouldn't need prefer_shadow. 
> Setting prefer_shadow_fbdev is only there for making the fbdev buffer 
> object evictable from video memory.
> 
> As it stands, using prefer_shadow_fbdev is the cleanest solution, even 
> if bochs is the only user of that field.
> 
> Alternatively, we could make it a requirement that qemu provides enough 
> video memory for bochs to unconditionally pin the fbdev BO there without 
> ever evicting. I guess, that would mean 32 MiB of VRAM at least.
>

I see. Thanks a lot for this explanation.
 
> Best regards
> Thomas
> 

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

