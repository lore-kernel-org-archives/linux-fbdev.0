Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EFE2C4320A
	for <linux-fbdev@archiver.kernel.org>; Fri, 27 Aug 2021 22:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CF8A60EB0
	for <linux-fbdev@archiver.kernel.org>; Fri, 27 Aug 2021 22:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbhH0WDR (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 27 Aug 2021 18:03:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59245 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232078AbhH0WDQ (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 27 Aug 2021 18:03:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630101746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F6xavDxclU2457G1Vw6lUkX39komt2IDfPFEDUjuZSY=;
        b=fsjO1Mue/JzuzabqY4fPvM7IGJnaENDcRL9WilQsbLASZKAYekQDWqGP9ASJxcIj5/JrmX
        if8rEtNgXtkJnF8mkIqDOEgfNzX2DMP8Fu5msX/ywMDdW+cPZv3k9cSYczvbt8GzL9D21F
        Q3ce1wadtEK9U5kiauVVhRvaCZMjV2M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-YcDboKqNNVCGvVWw2kccGw-1; Fri, 27 Aug 2021 18:02:25 -0400
X-MC-Unique: YcDboKqNNVCGvVWw2kccGw-1
Received: by mail-wm1-f70.google.com with SMTP id m33-20020a05600c3b2100b002e87a0542efso2110246wms.2
        for <linux-fbdev@vger.kernel.org>; Fri, 27 Aug 2021 15:02:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F6xavDxclU2457G1Vw6lUkX39komt2IDfPFEDUjuZSY=;
        b=L8K/8JHSMR6tWPC49NexJQLs5y4xY7cuYstovuMrOb7Op4JljqVsGKnhAIIFXL+QIl
         coXiJSZbRBKL9ZghmhWanwe5sfy58QgiwcfvwxbCGS2F2ydHteXcjyjhZvWMs5THoQab
         fprUgflI/ZggbXKVWSy/e0setSkYxX4jpWvckKLiF/vhHaFGHwTpuP4ysS9u8d3oSNWO
         XeGP+wHaEWbVRmsDrXoX04epoZchpFaT9kqHZCnITnGrDOIq/2ksFe+cSua7TOAG224j
         fxv37xyj9zyPt4tYKVw+ZQ2pDuk6AOj66MiZdefcd4E6UKH6mbL5BnOKsQpaoIhIGOZj
         f4DA==
X-Gm-Message-State: AOAM530u3qur3Jr+wzfBbrzGY/JA8Oy1SSCR66tn0M0ZBY7o7hj5FAW+
        T2eWi+wFanWl11ep9MYzRlFW3MGF2jKm9nvAGvLjP/ImKeweBxpcjoCNLREJjYAV+DZmPflto7M
        iRAPcK9bxrB6bv1e4qmj7hF0=
X-Received: by 2002:a5d:6cb0:: with SMTP id a16mr11883619wra.245.1630101743845;
        Fri, 27 Aug 2021 15:02:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx0sjJPekqAFrzI+I21wArpuNqneRzwvRM7qmHiOpufcRJPM7zXryENkyja4nv3/Jn1chky2g==
X-Received: by 2002:a5d:6cb0:: with SMTP id a16mr11883596wra.245.1630101743658;
        Fri, 27 Aug 2021 15:02:23 -0700 (PDT)
Received: from [192.168.1.101] ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id z126sm6853997wmc.11.2021.08.27.15.02.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Aug 2021 15:02:23 -0700 (PDT)
Subject: Re: [RFC PATCH 0/4] Allow to use DRM fbdev emulation layer with
 CONFIG_FB disabled
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fbdev@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Maxime Ripard <mripard@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Peter Robinson <pbrobinson@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        dri-devel@lists.freedesktop.org, Ingo Molnar <mingo@redhat.com>,
        David Airlie <airlied@linux.ie>
References: <20210827100027.1577561-1-javierm@redhat.com>
 <bb5d045c-c9de-b6df-cf45-32b1a866264a@suse.de>
 <YSlI+ryYqoRxM7aB@phenom.ffwll.local>
From:   Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <a7395626-f022-5c89-07cd-c30d0d52d3dd@redhat.com>
Date:   Sat, 28 Aug 2021 00:02:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YSlI+ryYqoRxM7aB@phenom.ffwll.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello Daniel and Thomas,

On 8/27/21 10:20 PM, Daniel Vetter wrote:
> On Fri, Aug 27, 2021 at 07:50:23PM +0200, Thomas Zimmermann wrote:
>> Hi
>>
>> Am 27.08.21 um 12:00 schrieb Javier Martinez Canillas:
>>> This patch series splits the fbdev core support in two different Kconfig
>>> symbols: FB and FB_CORE. The motivation for this is to allow CONFIG_FB to
>>> be disabled, while still using fbcon with the DRM fbdev emulation layer.
>>
>> I'm skeptical. DRM's fbdev emulation is not just the console emulation, it's
>> a full fbdev device. You can see the related device file as /dev/fb*.
>> Providing the file while having CONFIG_FB disabled doesn't make much sense
>> to me. I know it's not pretty, but it's consistent at least.
>>
>> If you want to remove fbdev, you could try to untangle fbdev and the console
>> emulation such that DRM can set up a console by itself. Old fbdev drives
>> would also set up the console individually.
> 
> Yeah given the horrendous security track record of all that code, and the
> maze of handover we have (stuff like flicker free boot and all that) I'm
> wondering whether typing a new drmcon wouldn't be faster and a lot more
> maintainable.
> 

We talked about a drmcon with Peter Robinson as well but then decided that a
way to disable CONFIG_FB but still having the DRM fbdev emulation could be a
intermediary step, hence these RFC patches.

But yes, I agree that a drmcon would be the proper approach for this, to not
need any fbdev support at all. We will just keep the explicit disable for the
fbdev drivers then in the meantime.

Thanks a lot for your feedback.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

