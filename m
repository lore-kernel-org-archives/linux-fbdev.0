Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 037A7C433EF
	for <linux-fbdev@archiver.kernel.org>; Fri,  5 Nov 2021 09:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF58961284
	for <linux-fbdev@archiver.kernel.org>; Fri,  5 Nov 2021 09:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbhKEKBl (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 5 Nov 2021 06:01:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51704 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232977AbhKEKBj (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 5 Nov 2021 06:01:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636106339;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PAYCTLIu4BclXd+cEViyuoXMMG/fW8iPDkQUaON6iK4=;
        b=C/8KnzySkruZmAcItDg1eTEOWfaUZnWXHfXZHiwjp9nm/iWNZRRnIpI0tAozKCZ4D834ra
        1dedv/ow0D6x/6/8UyLtVGwPOELbgurlFwBtkQ9CuVmjA1KfHmU3sekBW3W2iU/EDhhX3M
        m2NO4u4yTXu1L0/TRLxeOftJmWKkHOI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-WkQWub2pOn-u1I0KL0jp3g-1; Fri, 05 Nov 2021 05:58:58 -0400
X-MC-Unique: WkQWub2pOn-u1I0KL0jp3g-1
Received: by mail-wm1-f71.google.com with SMTP id k25-20020a05600c1c9900b00332f798ba1dso5477552wms.4
        for <linux-fbdev@vger.kernel.org>; Fri, 05 Nov 2021 02:58:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PAYCTLIu4BclXd+cEViyuoXMMG/fW8iPDkQUaON6iK4=;
        b=2fFrfeJ1hTToaFH6x8h5oRKI6a2x+EzrJhkj5oPajn0TJrJWnguTzfrNwt0FyrxNGG
         30XcZfDU13KTN2tu4TzcgdSCzctS/uDoAoDtgV/OBmYYk/jfDkGQZL5f+FO5iCFao8bH
         GPVsQH2ahBnlpUmqqHbafANBGbfoal9Nd4NshfB8X7EYST8IpYwqIFTaenqkVwAAX469
         /jgK+w/TK6q29xTzf93Dwm2pGAGRKbWaRrhbxE1vjwAVxUY9VCsd1wbXmK2x9oFZ72eG
         irXP9Eo4wp2s32XKwxEzxlRwJRLTL8CYx5xijYJeqBKLXNIHCFAZHoEP826FAE5afBZI
         3Kfw==
X-Gm-Message-State: AOAM530MciNk1agFQhoZLXr3+0riG9Gki8LBGe9RrNis4d+i+aPpHy4r
        vYUDv82FfqA9CCicp4MV+RyS7Ib0rGPvI9veUioH0pWkdIBh2anhNVebLunYWwhnaYim7mMPxKq
        PvVPwrPHhVGSEuh1jH8xzIXs=
X-Received: by 2002:adf:ec90:: with SMTP id z16mr46047429wrn.247.1636106336896;
        Fri, 05 Nov 2021 02:58:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyVMn64qcflGLedLN5EhsNM7GWU6o/3vwDL3aOoAYuCZV9//84CDnDeN1gsW9919fwpqQaOmg==
X-Received: by 2002:adf:ec90:: with SMTP id z16mr46047414wrn.247.1636106336738;
        Fri, 05 Nov 2021 02:58:56 -0700 (PDT)
Received: from [192.168.1.128] ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id c17sm7678095wmk.23.2021.11.05.02.58.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Nov 2021 02:58:56 -0700 (PDT)
Message-ID: <87a6bb4a-01ef-4979-f5c2-c0bb0d0a29f9@redhat.com>
Date:   Fri, 5 Nov 2021 10:58:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 2/2] drm: Move nomodeset kernel parameter to the DRM
 subsystem
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Peter Robinson <pbrobinson@gmail.com>,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
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
References: <20211104160707.1407052-1-javierm@redhat.com>
 <20211104160707.1407052-3-javierm@redhat.com>
 <f2c40b22-04bf-e8f2-9839-36d6d26189a1@suse.de> <87cznf9cty.fsf@intel.com>
 <2698c680-6d05-f58d-d7c2-ea76aeb0bb47@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <2698c680-6d05-f58d-d7c2-ea76aeb0bb47@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 11/5/21 10:39, Thomas Zimmermann wrote:

[snip]

>>>>    
>>>> +obj-$(CONFIG_VGA_CONSOLE) += drm_nomodeset.o
>>>> +
>>>
>>> This now depends on the VGA textmode console. Even if you have no VGA
>>> console, you'd want drm_nomodeset.o. Simpledrm might be built-in and can
>>> provide graphics. Non-PC systems don't even have a VGA device.
>>
>> This was discussed in an earlier version, which had this builtin but the
>> header still had a stub for CONFIG_VGA_CONSOLE=n.
>>
>>> I think we really want a separate boolean config option that gets
>>> selected by CONFIG_DRM.
>>
>> Perhaps that should be a separate change on top.
> 
> Sure, make it a separate patch.
>

Agreed. I was planning to do it as a follow-up as well and drop the
#ifdef CONFIG_VGA_CONSOLE guard in the header.
 
> We want to make this work on ARM systems. I even have a request to 
> replace offb on Power architecture by simpledrm. So the final config has 
> to be system agnostic.
>

Same, since we want to drop the fbdev drivers in Fedora, for all arches.
 
> Best regards
> Thomas
> 
Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

