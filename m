Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACEB2C433F5
	for <linux-fbdev@archiver.kernel.org>; Wed, 11 May 2022 11:57:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238042AbiEKL56 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 11 May 2022 07:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbiEKL5z (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 11 May 2022 07:57:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1BF0B3B287
        for <linux-fbdev@vger.kernel.org>; Wed, 11 May 2022 04:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652270273;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ej854CR7sjtYFdE3sImjC64n7WhVCOgxuIOus5Vy29E=;
        b=Dd5QwR6E5buZAjnGCbuw+AkjwhrCOERlnAfGRG+1lDw5BUCXPdSqMJDQTCnTzA9SLcsdUy
        nzHTG15sI2NwLpfRwbto2cBEzzf/Um3YiKrDgzfpsv/UD1KQdtf2JgEZeaAtLZVFsZRLu/
        3S4VAo73mG2CgNuolM8tfJIa9SyKyrE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-496-AmLTz_mGNj-g6Bp6OqVo6w-1; Wed, 11 May 2022 07:57:52 -0400
X-MC-Unique: AmLTz_mGNj-g6Bp6OqVo6w-1
Received: by mail-wm1-f72.google.com with SMTP id e9-20020a05600c4e4900b00394779649b1so2738092wmq.3
        for <linux-fbdev@vger.kernel.org>; Wed, 11 May 2022 04:57:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ej854CR7sjtYFdE3sImjC64n7WhVCOgxuIOus5Vy29E=;
        b=OqZ+9g1C9Lae1+rHUChz2DmpYN3grMabYwxySSk0W0VPHpbCCdzNRI90SbNF1VnfzS
         4tIZ2sLep0pSkOAfxP/5iP4dwGSPW8/dIxhvDPWgvXeukJdgoUfdeoP02P6LvIkU3w25
         vVkIo+DKnURcbwJm5I13608JvRU+wX3Z2/q1yuz/xWq06idJrg86oKeZuhNvMCDh/MDW
         hXt9CwGCHH0ZdubX2dcJ0qlktG/pLwTmsPJ3ZoQIM641YLALynmY+mPb/kSnd6JCMvGv
         +3gnHVL/Pyd4vYfy/a26pesaHvA9ws/pIWlxKehi2XXfDCpm/lj91y2GrLnthi5Was7Y
         FsCQ==
X-Gm-Message-State: AOAM530NKrvAI2K0zwiDfx159HxVPB55mOr9oWzwQlrPD9BI5P+703cn
        u+QX8Yxsb6uzHuRNP0EaGNmN3f5WhPpGa+Rqvc9l1sBAdsgXfyfqqQEYqayjQjOQ2aVowukkqxE
        /apG+KJLZNPDDDHEAXluOXVg=
X-Received: by 2002:a05:6000:2cc:b0:20c:5c31:1120 with SMTP id o12-20020a05600002cc00b0020c5c311120mr22951570wry.105.1652270270702;
        Wed, 11 May 2022 04:57:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzwx9aLP2JJ/CLGyt+kNia9KejENyTsMYfDrJSFT3ZMYJR/pCAxu1qiLtl7C2ddCWenOmQ+cA==
X-Received: by 2002:a05:6000:2cc:b0:20c:5c31:1120 with SMTP id o12-20020a05600002cc00b0020c5c311120mr22951554wry.105.1652270270492;
        Wed, 11 May 2022 04:57:50 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id t16-20020a5d49d0000000b0020c5253d8edsm1498471wrs.57.2022.05.11.04.57.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 04:57:50 -0700 (PDT)
Message-ID: <4727ce99-7107-d806-cbea-cd45c6ce6106@redhat.com>
Date:   Wed, 11 May 2022 13:57:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v5 3/7] fbdev: Restart conflicting fb removal loop when
 unregistering devices
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Helge Deller <deller@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20220511112438.1251024-1-javierm@redhat.com>
 <20220511113039.1252432-1-javierm@redhat.com>
 <2156c28c-9c9c-555e-ce19-933cdc8d5e74@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <2156c28c-9c9c-555e-ce19-933cdc8d5e74@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello Thomas,

On 5/11/22 13:47, Thomas Zimmermann wrote:
> Hi Javier
> 
> Am 11.05.22 um 13:30 schrieb Javier Martinez Canillas:
>> Drivers that want to remove registered conflicting framebuffers prior to
>> register their own framebuffer, calls remove_conflicting_framebuffers().
>>
>> This function takes the registration_lock mutex, to prevent a races when
>> drivers register framebuffer devices. But if a conflicting framebuffer
>> device is found, the underlaying platform device is unregistered and this
>> will lead to the platform driver .remove callback to be called, which in
>> turn will call to the unregister_framebuffer() that takes the same lock.
>>
>> To prevent this, a struct fb_info.forced_out field was used as indication
>> to unregister_framebuffer() whether the mutex has to be grabbed or not.
>>
>> A cleaner solution is to drop the lock before platform_device_unregister()
>> so unregister_framebuffer() can take it when called from the fbdev driver,
>> and just grab the lock again after the device has been registered and do
>> a removal loop restart.
>>
>> Since the framebuffer devices will already be removed, the loop would just
>> finish when no more conflicting framebuffers are found.
>>
>> Suggested-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> 
> I'd like to shrink this patchset. This looks like it can be merged 

Same. At least this version dropped a few patches that we had in v4
(related to DRM_FIRMWARE capability flag).

> immediately?
>

Yes, this one is independent of the others and could be merged already.

> Best regards
> Thomas
> 

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

