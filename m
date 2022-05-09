Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04414C433EF
	for <linux-fbdev@archiver.kernel.org>; Mon,  9 May 2022 16:33:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239177AbiEIQhr (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 9 May 2022 12:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239174AbiEIQhq (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 9 May 2022 12:37:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 94E6A28ED28
        for <linux-fbdev@vger.kernel.org>; Mon,  9 May 2022 09:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652114030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zaU6wCec1EMQuT5ULCUqY7NTQ3dkhl3bP6/9uWSpRY0=;
        b=KY3Hw9tEznsUne+dQbBXq+/NoEr3RtIr45zdpDnhxNaNjvbkpYfmtVoat3P62HT89qp0xh
        I1Fll234+M1PZrItQgFBQeTaMVGm3Kwl2agyqP4DeHF9GLAqI2WyjLCMXL0kriLLzwnGwO
        KLMHEL1t6qIQRPzEOHjdEGax8pzIAyA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-214-E_oyPZ_8P6q8TliMMJ6m4w-1; Mon, 09 May 2022 12:33:49 -0400
X-MC-Unique: E_oyPZ_8P6q8TliMMJ6m4w-1
Received: by mail-wr1-f72.google.com with SMTP id u11-20020a056000038b00b0020c9ea8b64fso4701582wrf.2
        for <linux-fbdev@vger.kernel.org>; Mon, 09 May 2022 09:33:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zaU6wCec1EMQuT5ULCUqY7NTQ3dkhl3bP6/9uWSpRY0=;
        b=THouq+w3vpHbsTzgwJaYJewa+oLuoHxbDctpMh8zUKh5QNSO7hxtZzMsYkFSdZlkde
         FU+6ZigX1foKnevXhrwiH4kPRQFtZLC0a1KhhliCtvSxEaUZySm5Ii4MQq12sYupOTUq
         AIUQsb0g3MQj0k8m0bIhKMrXxKDZz8xomUO63GZd5leAvLoyjONkttTyOSiQIOUYCwql
         qHQ0x+uKOeNFS0ETnnXLLohK5EMLvmokrrSeugwQhsZt2Skp+O5Zq4XpilSN1RnDuaWC
         k5NQ37I5eGoLxBW5kXryhnx1s1JdSyePVd82cFzat3Hg2QUA1hq6H7JP2ov/6uaOfHTH
         15HA==
X-Gm-Message-State: AOAM533kzISAXtwAvDbsx8QahPR/vmprucdAeoT+fwdzPdIrY/0kuyjW
        put/Pu9M6NQmFbaktFB7ELEPUGQh6ZY249huXPVR78/dcFqXp+jmo7ciPAnxU2Bmm7Of6fLvhqi
        b6j+CX8KR+9ZJX7zgvWmCwRQ=
X-Received: by 2002:a7b:c3c2:0:b0:394:9229:3b40 with SMTP id t2-20020a7bc3c2000000b0039492293b40mr5126307wmj.195.1652114027776;
        Mon, 09 May 2022 09:33:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz7bKnj6TnYeYMJ8WQEUK1qVaIvYRO7Ss8XM5JhYhOquufFe51hhnCGnSjqUxw1TY5t+U+8cQ==
X-Received: by 2002:a7b:c3c2:0:b0:394:9229:3b40 with SMTP id t2-20020a7bc3c2000000b0039492293b40mr5126294wmj.195.1652114027554;
        Mon, 09 May 2022 09:33:47 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id h3-20020a5d6883000000b0020c5253d91asm11484506wru.102.2022.05.09.09.33.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 09:33:47 -0700 (PDT)
Message-ID: <3b7fe4fe-fdec-cef2-4e0e-309d9dc4a8af@redhat.com>
Date:   Mon, 9 May 2022 18:33:46 +0200
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
 <1f788b8f-0bea-1818-349e-b1bc907bf251@redhat.com>
 <a339df59-9e00-c7cb-e33d-2ac626443639@intel.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <a339df59-9e00-c7cb-e33d-2ac626443639@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 5/9/22 17:51, Andrzej Hajda wrote:

[snip]

>>>> +
>>> Regarding drm:
>>> What about drm_fb_helper_fini? It calls also framebuffer_release and is
>>> called often from _remove paths (checked intel/radeon/nouveau). I guess
>>> it should be fixed as well. Do you plan to fix it?
>>>
>> I think you are correct. Maybe we need something like the following?
>>
>> diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
>> index d265a73313c9..b09598f7af28 100644
>> --- a/drivers/gpu/drm/drm_fb_helper.c
>> +++ b/drivers/gpu/drm/drm_fb_helper.c
>> @@ -631,7 +631,6 @@ void drm_fb_helper_fini(struct drm_fb_helper *fb_helper)
>>          if (info) {
>>                  if (info->cmap.len)
>>                          fb_dealloc_cmap(&info->cmap);
>> -               framebuffer_release(info);
> 
> What about cmap? I am not an fb expert, but IMO cmap can be accessed 
> from userspace as well.
> 

I actually thought about the same but then remembered what Daniel said in [0]
(AFAIU at least) that these should be done in .remove() so the current code
looks like matches that and only framebuffer_release() should be moved.

For vesafb a previous patch proposed to also move a release_region() call to
.fb_destroy() and Daniel also said that it was iffy and shouldn't be done [1].

But I'm also not fb expert so happy to move fb_dealloc_cmap() as well if that
is the correct thing to do.

[0]: https://www.spinics.net/lists/dri-devel/msg346257.html
[1]: https://www.spinics.net/lists/dri-devel/msg346261.html

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

