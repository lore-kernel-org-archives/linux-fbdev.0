Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB6BC433F5
	for <linux-fbdev@archiver.kernel.org>; Mon, 25 Apr 2022 08:37:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235942AbiDYIky (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 25 Apr 2022 04:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236099AbiDYIkx (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 25 Apr 2022 04:40:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AA20E6A40E
        for <linux-fbdev@vger.kernel.org>; Mon, 25 Apr 2022 01:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650875868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hcJjktltsy20pk/1TUGpfeSXdGLoP34V6e5SW63r+UU=;
        b=jUmP/IhbgGNglEKcaXPUaH1NKp/VZBxGpTIIurcnSmyrAffLcYVJ3UIMkz4NKi1hmcKGGq
        LJXSLyjVVYioETCKI9TYvQTb5anUrNJkILliUQUfZ7Jt+WXgYqJjkzGjKa4EGLfdijjCdN
        aH56pC2y86SXWWyaPgrPlAhAZ3yssHw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-604-o8-wunOuORe0kPe4NrHcPg-1; Mon, 25 Apr 2022 04:37:46 -0400
X-MC-Unique: o8-wunOuORe0kPe4NrHcPg-1
Received: by mail-wm1-f72.google.com with SMTP id g9-20020a1c4e09000000b0038f20d94f01so9982835wmh.8
        for <linux-fbdev@vger.kernel.org>; Mon, 25 Apr 2022 01:37:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hcJjktltsy20pk/1TUGpfeSXdGLoP34V6e5SW63r+UU=;
        b=BxC08+tURRYnQHeJyunVI7tqwVERDg7506upiimk3W0h5tLFVx0VV8hExlxCEzZMM6
         98IkoAdQ/U7URbf1jTtVfOXlzlm1NEypgCouDllFDN7B+NnvRL/ijiDWIGHXkorWEfuV
         4YIHuCWF9cl/fPhMdLDrVDt2WFyF7KBBKc1lQn9vi/Rg5wXF8hndtvEKI3u1qbkKiG/y
         sK+ORpTF8ytUzBDhPdB7EvRZ4c2DiHlAMmOvWhA31J2gAsrrl++EgJLcOQTIIVKGX82X
         FWw7MttGcxeY65yJqrnZ05MrKaw0vZaO5atcG7ktA8n/H0Yv31YSmz2MN8Q1CXEV3M+W
         j+kQ==
X-Gm-Message-State: AOAM5310+AvSWr+sHOuZBKLuhay+2P3GFBF0GGJe9/i4+KnFWN9/rS2D
        zyWuufTUsEKOzsVRL5f7CkH2Pml/tQpgsJfp31uHVgul6DQHnX00sANuxl3rVzd2wLYrqtxWRMl
        fHHmyJT+g158qOXWiGS6ebUk=
X-Received: by 2002:a1c:3b89:0:b0:38e:b37f:52d with SMTP id i131-20020a1c3b89000000b0038eb37f052dmr15325221wma.197.1650875865762;
        Mon, 25 Apr 2022 01:37:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwkDkiuHJY5bNGU58CjLV3AycTkBgdIf0DyWp+hIAcCSv4pw19dJ8Ap5RCImavOptKADqXHsg==
X-Received: by 2002:a1c:3b89:0:b0:38e:b37f:52d with SMTP id i131-20020a1c3b89000000b0038eb37f052dmr15325190wma.197.1650875865524;
        Mon, 25 Apr 2022 01:37:45 -0700 (PDT)
Received: from [192.168.1.129] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id d29-20020adf9b9d000000b0020ada099ed5sm2698552wrc.17.2022.04.25.01.37.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 01:37:45 -0700 (PDT)
Message-ID: <41362e99-820c-727c-019a-11ec5f38083c@redhat.com>
Date:   Mon, 25 Apr 2022 10:37:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3 3/5] fbdev: Restart conflicting fb removal loop when
 unregistering devices
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-fbdev@vger.kernel.org
References: <20220420085303.100654-1-javierm@redhat.com>
 <20220420085303.100654-4-javierm@redhat.com>
 <44804419-0e83-b584-96d9-a35939b715bf@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <44804419-0e83-b584-96d9-a35939b715bf@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello Thomas,

Thanks for the feedback.

On 4/25/22 10:27, Thomas Zimmermann wrote:
> Hi
> 
> Am 20.04.22 um 10:53 schrieb Javier Martinez Canillas:
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
> 
> I don't see how this patch improves the situation. So far, 
> do_remove_conflicting_framebuffers() had no business in maintaining 
> locks. And now it's doing this in in a goto-loop where it keeps 
> getting/dropping locks.  That's asking for bugs IMHO.
>

It's true that do_remove_conflicting_framebuffers() gets more complicated
with all the locks release/re-acquire but OTOH unregister_framebuffer()
doesn't do conditionally locking, and more importantly the drivers .remove
callback isn't called with the lock held, which IMHO is also quite fragile.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

