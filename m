Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62710C433EF
	for <linux-fbdev@archiver.kernel.org>; Fri,  5 Nov 2021 09:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C22C61268
	for <linux-fbdev@archiver.kernel.org>; Fri,  5 Nov 2021 09:55:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbhKEJ6b (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 5 Nov 2021 05:58:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21887 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232974AbhKEJ6Y (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 5 Nov 2021 05:58:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636106144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oZ67s9sbnfsD5fqdtGG0nGBmSdAaIG5RWNWBFufx9E8=;
        b=TkztJmfb0Z4d5Q7UrtQL+DyWHuqpVNqfrdsLFZ+WiVfpGFPuMhNLrJ6F0nv5PsMlaarAZb
        Vygb0wLA0cRBG+/tiSf4jFiiLaL74ejFHMHrXXXujjjbzKMNx7ZJmLQBW7khPh6LFcMIPc
        JR7ikaxBoCVEu4dcI2OiMs+xAg75I6U=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-6Pzdm-OzOAuiQsbutDX0dQ-1; Fri, 05 Nov 2021 05:55:43 -0400
X-MC-Unique: 6Pzdm-OzOAuiQsbutDX0dQ-1
Received: by mail-wr1-f70.google.com with SMTP id d7-20020a5d6447000000b00186a113463dso2136449wrw.10
        for <linux-fbdev@vger.kernel.org>; Fri, 05 Nov 2021 02:55:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oZ67s9sbnfsD5fqdtGG0nGBmSdAaIG5RWNWBFufx9E8=;
        b=fY5TKRoCkQN9hT6iQz+SiCOfuLNHKDRRDRU2xprj3GLgrx3/N3Qh5huMFdn2s2spcX
         azgb0HcJFVIbzW+iUIaVWDTQkwL31i6YEq+pgPjOb79dbLxIF7C3lwnDqb8UHpNjZVY3
         wg/8KuBbvbb99suf/LcbHpCotXdhe5wlAzTVVXeBNT9GTNW47oSE5AQVQuerPgVeAODE
         mtHSGzSBjJBKqZW/ZNI3ToA5HwMkCW1PV9WohfosJpJ2zTuNwcmlJNRm1LkL4vIJIPYV
         emp65FQkl0u2iMoMcQMEaPeQN/IORh5IaetCv9MYWhSZa4slPVA0ZzHCcfk8d/vjN+Aa
         hkKg==
X-Gm-Message-State: AOAM532NiAjfe7qKO0HUW+d8zu1oJk505KWmchiYXltJQppBpH+SJQ1i
        wGKNbJBl2aHmbjDrs369gHh36m5OCn8SHxCJZCCky2SY/s91oWTJyXj/I+6tT6BT5hcdPUGS8Wv
        Hkix67qnlqCX8HALKYnEp0vc=
X-Received: by 2002:a7b:c8d5:: with SMTP id f21mr27635794wml.146.1636106142194;
        Fri, 05 Nov 2021 02:55:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyT8viACi1U7JY5S3rkG/MaHma60ZlmQ0NQODpS8eTcPcWv9ZvZPYhizNzNYarjDaHcIaJjnA==
X-Received: by 2002:a7b:c8d5:: with SMTP id f21mr27635740wml.146.1636106141897;
        Fri, 05 Nov 2021 02:55:41 -0700 (PDT)
Received: from [192.168.1.128] ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id s26sm5390804wmc.0.2021.11.05.02.55.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Nov 2021 02:55:41 -0700 (PDT)
Message-ID: <847c2315-b4a2-3bd1-e048-4263b5f496ed@redhat.com>
Date:   Fri, 5 Nov 2021 10:55:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 2/2] drm: Move nomodeset kernel parameter to the DRM
 subsystem
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
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
        Jani Nikula <jani.nikula@linux.intel.com>,
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
 <f2c40b22-04bf-e8f2-9839-36d6d26189a1@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <f2c40b22-04bf-e8f2-9839-36d6d26189a1@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 11/5/21 10:00, Thomas Zimmermann wrote:

[snip]

>> +
>> +static int __init disable_modeset(char *str)
>> +{
>> +	drm_nomodeset = true;
>> +
>> +	pr_warn("You have booted with nomodeset. This means your GPU drivers are DISABLED\n");
>> +	pr_warn("Any video related functionality will be severely degraded, and you may not even be able to suspend the system properly\n");
>> +	pr_warn("Unless you actually understand what nomodeset does, you should reboot without enabling it\n");
> 
> I'd update this text to be less sensational.
>

This is indeed quite sensational. But think we can do it as a follow-up patch.

Since we will have to stick with nomodeset for backward compatibility, I was
planning to add documentation to explain what this parameter is about and what
is the actual effect of setting it.

So I think we can change this as a part of that patch-set.
 
>> +
>> +	return 1;
>> +}
>> +
>> +/* Disable kernel modesetting */
>> +__setup("nomodeset", disable_modeset);
>> diff --git a/drivers/gpu/drm/i915/i915_module.c b/drivers/gpu/drm/i915/i915_module.c
>> index 45cb3e540eff..c890c1ca20c4 100644
>> --- a/drivers/gpu/drm/i915/i915_module.c
>> +++ b/drivers/gpu/drm/i915/i915_module.c
>> @@ -4,8 +4,6 @@
>>    * Copyright © 2021 Intel Corporation
>>    */
>>   
>> -#include <linux/console.h>
>> -
>
> These changes should be in patch 1?
>

Yes, I forgot to move these when changed the order of the patches.

Best regards, -- 
Javier Martinez Canillas
Linux Engineering
Red Hat

