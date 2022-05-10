Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48AD8C433EF
	for <linux-fbdev@archiver.kernel.org>; Tue, 10 May 2022 07:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233967AbiEJHyp (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 10 May 2022 03:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232855AbiEJHyo (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 10 May 2022 03:54:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F3398167C0
        for <linux-fbdev@vger.kernel.org>; Tue, 10 May 2022 00:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652169043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X8I80A1MFc0J/yZVJgHBHlpH5enDkuIotq+SGXDDvEU=;
        b=hgObJdU/HTejUk5CsJS5MxbfQi4bhaKyIGHVD4111dKLsEpmbGjcdRW5saHEcq63V1Fu4k
        h3aXFiN6sVb8eknV7y2DWCKfDulxlhH7kCHeZ3sQCOvCld9OsGQhzjgz03CD++Sd7L0oAt
        yqgQIlrPeWoNSQMrccOBJML7fbLqAF4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-404-aSlzB1jTPz2WRbXb1SPLlw-1; Tue, 10 May 2022 03:50:41 -0400
X-MC-Unique: aSlzB1jTPz2WRbXb1SPLlw-1
Received: by mail-wm1-f69.google.com with SMTP id e9-20020a05600c4e4900b00394779649b1so893867wmq.3
        for <linux-fbdev@vger.kernel.org>; Tue, 10 May 2022 00:50:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=X8I80A1MFc0J/yZVJgHBHlpH5enDkuIotq+SGXDDvEU=;
        b=bu8BdqsjzWjaWAvsDay+hHI2XGUm3W5phhhAdbmgeChIl5h5VIWVGu1zGvvhVMCPdY
         LNIL4XZs+JdKTA0vMUDeBoQ6Nrd8aN3/ccqhcYWjakWXz1A56NyS+z0OcjWQW1ZuoXi0
         Mz40y4QqELEGBziAEmoIf4HWfFlRa0OETb5ceAFLEgEKEq1k3BNV3HOXQTQVavtFynHf
         KJhz0zdKFn65Ue9dpEo5z+kxpJj9tBqduS9vMTUQfZhqWCpmwgugnInI5Y+9l428Z0nE
         6At+4bEZiR10QbxeX7NwGp/8F2HdIOvu6KjewqZEbXBip4w0Z8gi/9Pa1Y07m9mVAg7/
         fm1A==
X-Gm-Message-State: AOAM530wL6AlsA1FQwbqIEO8w5tpgNbWeXMMMAwJvNmWATQsV52cRSmq
        tvY52Bj8FhTb8OZYjXfNko+t1d83soKjH5AVOkYwu6aHEO5tz6ousrpB6PJd/Dd4JmVwPQ3NR10
        rPidElvOl0Plv+Lbe57/Lmto=
X-Received: by 2002:adf:e0cc:0:b0:207:b690:acb8 with SMTP id m12-20020adfe0cc000000b00207b690acb8mr17049526wri.412.1652169040387;
        Tue, 10 May 2022 00:50:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxt1PXXZ4GfsjU4JVU3VAyn3tFLEyxIj8zvNpeAQhxz0Dh39tYNxE2S/Hqlk3T8BEeisJpmCQ==
X-Received: by 2002:adf:e0cc:0:b0:207:b690:acb8 with SMTP id m12-20020adfe0cc000000b00207b690acb8mr17049501wri.412.1652169040086;
        Tue, 10 May 2022 00:50:40 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id b19-20020a05600c4e1300b003942a244ec7sm1700839wmq.12.2022.05.10.00.50.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 00:50:39 -0700 (PDT)
Message-ID: <42fe44ae-de02-5506-d1b4-059af0419366@redhat.com>
Date:   Tue, 10 May 2022 09:50:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3 1/4] fbdev: Prevent possible use-after-free in
 fb_release()
Content-Language: en-US
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     linux-fbdev@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@intel.com>
References: <20220505215947.364694-1-javierm@redhat.com>
 <20220505220413.365977-1-javierm@redhat.com>
 <753d0350-42dc-389b-b10b-4533ddcf32ac@intel.com>
 <1f788b8f-0bea-1818-349e-b1bc907bf251@redhat.com>
 <a339df59-9e00-c7cb-e33d-2ac626443639@intel.com>
 <3b7fe4fe-fdec-cef2-4e0e-309d9dc4a8af@redhat.com>
 <b5ab1c49-04e7-36c3-677d-2989b79e50ca@suse.de>
 <2bf27b09-0896-1849-254f-d5b19abdc892@redhat.com>
 <fc3e8a40-664f-07ae-7474-c0412a1ab1b5@intel.com>
 <1c36d431-d5c0-7278-c9e0-61867e9dc174@redhat.com>
 <8401c328-ed67-8d5e-4ba2-b487f256e139@intel.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <8401c328-ed67-8d5e-4ba2-b487f256e139@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 5/10/22 09:19, Andrzej Hajda wrote:
> 
> 
> On 10.05.2022 00:42, Javier Martinez Canillas wrote:
>> On 5/10/22 00:22, Andrzej Hajda wrote:
>>
>> [snip]
>>
>>>>    static void drm_fbdev_fb_destroy(struct fb_info *info)
>>>>    {
>>>> +       if (info->cmap.len)
>>>> +               fb_dealloc_cmap(&info->cmap);
>>>> +
>>>>           drm_fbdev_release(info->par);
>>>> +       framebuffer_release(info);
>>> I would put drm_fbdev_release at the beginning - it cancels workers
>>> which could expect cmap to be still valid.
>>>
>> Indeed, you are correct again. [0] is the final version of the patch I've
>> but don't have an i915 test machine to give it a try. I'll test tomorrow
>> on my test systems to verify that it doesn't cause any regressions since
>> with other DRM drivers.
>>
>> I think that besides this patch, drivers shouldn't need to call to the
>> drm_fb_helper_fini() function directly. Since that would be called during
>> drm_fbdev_fb_destroy() anyways.
>>
>> We should probably remove that call in all drivers and make this helper
>> function static and just private to drm_fb_helper functions.
>>
>> Or am I missing something here ?
> 
> This is question for experts :)

Fair. I'm definitely not one of them :)

> I do not know what are user API/ABI expectations regarding removal of 
> fbdev driver, I wonder if they are documented somewhere :)

I don't know. At least I haven't found them.

> Apparently we have some process of 'zombification'  here - we need to 
> remove the driver without waiting for userspace closing framebuffer(???) 
> (to unbind ops-es and remove references to driver related things), but 
> we need to leave some structures to fool userspace, 'info' seems to be 
> one of them.

That's correct, yes. I think that any driver that provides a .mmap file
operation would have the same issue. But drivers keep an internal state
and just return -ENODEV or whatever on read/write/close after a removal.

The fbdev subsystem is different though since as you said it, the fbdev
core unconditionally calls to the driver .fb_release() callback with a
struct fb_info reference as argument.

I tried to prevent that with commit aafa025c76dc ("fbdev: Make fb_release()
return -ENODEV if fbdev was unregistered") but Daniel pointed out that
is was wrong since could leak memory allocated and was expected to be
freed on release.

That's why I instead fixed the issue in the fbdev drivers and just added
a warn on fb_release(), that is $SUBJECT.

> So I guess there should be something called on driver's _remove path, 
> and sth on destroy path.
>

That was my question actually, do we need something to be called in the
destroy path ? Since that could just be internal to the DRM fb helpers.

In other words, drivers should only care about setting a generic fbdev
by calling drm_fbdev_generic_setup(), and then do any HW cleanup in the
removal path, but let the fb helpers to handle the SW cleanup in destroy.
 
-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

