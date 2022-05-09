Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 353FEC433EF
	for <linux-fbdev@archiver.kernel.org>; Mon,  9 May 2022 15:30:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238306AbiEIPeY (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 9 May 2022 11:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238213AbiEIPeW (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 9 May 2022 11:34:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 14D7F10275B
        for <linux-fbdev@vger.kernel.org>; Mon,  9 May 2022 08:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652110228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=32O50jez/PbrMF8EQrDMnibyIcUmfYiL4OMerJWfOrc=;
        b=euhwlSnNLp5WhjbMN9ZTyppuM8zK7xQZNVPVPcIw0V2OhdhvLCC01G4gMMBgXMtCgLkYiK
        us2596edZxn8eAq4BQYEqOG6xnNV7CIyE7FQGPOFaXoNMhdSK5NQ3tvyIpfRz6Kus+ulwo
        enBJNBfLnWmLQbyW42MDkOUZlq1dbKs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-52-Ai2O4GxrMNi3qj6Gj9OytA-1; Mon, 09 May 2022 11:30:27 -0400
X-MC-Unique: Ai2O4GxrMNi3qj6Gj9OytA-1
Received: by mail-wm1-f71.google.com with SMTP id c125-20020a1c3583000000b0038e3f6e871aso4390826wma.8
        for <linux-fbdev@vger.kernel.org>; Mon, 09 May 2022 08:30:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=32O50jez/PbrMF8EQrDMnibyIcUmfYiL4OMerJWfOrc=;
        b=aSl+Bv3bH4S3qeqyYy1RzrxmVxw5Pa9G75LUZ3VQdpkcwbNbJ78QOuu3SKXEtkVjG2
         OlBlLHx50sdHGZax3J4g4A3k1QZcNbWflSKFnrpQsaXSNFuZ6H5liI7V3yIRO6vaXhPd
         H9Wwvrr3IDrascVOu4/9NKHQ5hUYLJ3jd5kYHiGMRaX1KixmcnRjPkTfMMR/1RZvIlkf
         V+Aad2wjZ7fNvNvJDogOoVc21DyNhdP9TtNYQctvn8TsFIxX5teibhD1frlGlEjp6NTs
         PNW1yhrwsNlrBC+V46+F4aN9xv86C39sOAdEIF0jZCJ55603ANW6QHQNoqEHnxxWeCfs
         BTNA==
X-Gm-Message-State: AOAM533T2fl+Ze9jtvFBuu21lPVawPKOC4LYDF240xjjCYtr6cpfu+gW
        iOACXFoxl6oKSt131tF4GsIlF37+AYFhsXlWkzC8uCMjpC22HyPlqBOxiUc4Ol3pmFhYvZRpazD
        Op6JwGx1ctCN9T5FtWN2tRIA=
X-Received: by 2002:a1c:e916:0:b0:38e:ac96:f477 with SMTP id q22-20020a1ce916000000b0038eac96f477mr23110370wmc.160.1652110225681;
        Mon, 09 May 2022 08:30:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx2OJQhUhbDP19T1Ygw1cNWeWjH+vy1pamLfQvh45VT2yujXYJ3AxWzNA16UgHpJIS114J32Q==
X-Received: by 2002:a1c:e916:0:b0:38e:ac96:f477 with SMTP id q22-20020a1ce916000000b0038eac96f477mr23110328wmc.160.1652110225343;
        Mon, 09 May 2022 08:30:25 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o9-20020a5d62c9000000b0020c5253d903sm11552799wrv.79.2022.05.09.08.30.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 08:30:25 -0700 (PDT)
Message-ID: <1f788b8f-0bea-1818-349e-b1bc907bf251@redhat.com>
Date:   Mon, 9 May 2022 17:30:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3 1/4] fbdev: Prevent possible use-after-free in
 fb_release()
Content-Language: en-US
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-fbdev@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@intel.com>
References: <20220505215947.364694-1-javierm@redhat.com>
 <20220505220413.365977-1-javierm@redhat.com>
 <753d0350-42dc-389b-b10b-4533ddcf32ac@intel.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <753d0350-42dc-389b-b10b-4533ddcf32ac@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello Andrzej,

On 5/9/22 16:56, Andrzej Hajda wrote:
> On 06.05.2022 00:04, Javier Martinez Canillas wrote:
>> From: Daniel Vetter <daniel.vetter@ffwll.ch>
>>
>> Most fbdev drivers have issues with the fb_info lifetime, because call to
>> framebuffer_release() from their driver's .remove callback, rather than
>> doing from fbops.fb_destroy callback.
>>
>> Doing that will destroy the fb_info too early, while references to it may
>> still exist, leading to a use-after-free error.
>>
>> To prevent this, check the fb_info reference counter when attempting to
>> kfree the data structure in framebuffer_release(). That will leak it but
>> at least will prevent the mentioned error.
>>
>> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
>> ---
>>
>> (no changes since v1)
>>
>>   drivers/video/fbdev/core/fbsysfs.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/video/fbdev/core/fbsysfs.c b/drivers/video/fbdev/core/fbsysfs.c
>> index 8c1ee9ecec3d..c2a60b187467 100644
>> --- a/drivers/video/fbdev/core/fbsysfs.c
>> +++ b/drivers/video/fbdev/core/fbsysfs.c
>> @@ -80,6 +80,10 @@ void framebuffer_release(struct fb_info *info)
>>   {
>>   	if (!info)
>>   		return;
>> +
>> +	if (WARN_ON(refcount_read(&info->count)))
>> +		return;
>> +
> 
> Regarding drm:
> What about drm_fb_helper_fini? It calls also framebuffer_release and is 
> called often from _remove paths (checked intel/radeon/nouveau). I guess 
> it should be fixed as well. Do you plan to fix it?
>

I think you are correct. Maybe we need something like the following?

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index d265a73313c9..b09598f7af28 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -631,7 +631,6 @@ void drm_fb_helper_fini(struct drm_fb_helper *fb_helper)
        if (info) {
                if (info->cmap.len)
                        fb_dealloc_cmap(&info->cmap);
-               framebuffer_release(info);
        }
        fb_helper->fbdev = NULL;
 
@@ -2112,6 +2111,7 @@ static void drm_fbdev_release(struct drm_fb_helper *fb_helper)
 static void drm_fbdev_fb_destroy(struct fb_info *info)
 {
        drm_fbdev_release(info->par);
+       framebuffer_release(info);
 }
 
 static int drm_fbdev_fb_mmap(struct fb_info *info, struct vm_area_struct *vma)

> 
> Regarding fb drivers, just for stats:
> git grep -p framebuffer_release | grep _remove | wc -l
> Suggests there is at least 70 incorrect users of this :)
>

Yes, Daniel already mentioned that most of them get this wrong but I was
mostly interested in {simple,efi,vesa}fb since are used with "nomodeset".

But given that I only touched those tree and still managed to introduce
a regression, I won't attempt to fix the others.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

