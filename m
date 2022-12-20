Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D494BC4167B
	for <linux-fbdev@archiver.kernel.org>; Tue, 20 Dec 2022 09:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233189AbiLTJrS (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 20 Dec 2022 04:47:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233195AbiLTJrI (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 20 Dec 2022 04:47:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AADF018E2D
        for <linux-fbdev@vger.kernel.org>; Tue, 20 Dec 2022 01:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671529494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1J4eLv+5To8BjnLItTbs6pq8g5LjZHk9PMjLEQIi8Lo=;
        b=IwhJ1TnMPfZUbZ7tPKa6oNzi3XFasCTygm/h3L4s5eQg+txyIoqVQh5S8A8IJZjsuqCzud
        3qgTO9buphS/BGOFWNOSVoBqiWEaYEYbh5yLDJFNMHzGDQOAXwPyUUiJzhRyUctC0fVOwu
        U0I91t9VQadKHfNJPZYV7mvSHTLwb9M=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-153-5zfUFcnzN1Ge11bhryAgaQ-1; Tue, 20 Dec 2022 04:44:53 -0500
X-MC-Unique: 5zfUFcnzN1Ge11bhryAgaQ-1
Received: by mail-wm1-f72.google.com with SMTP id t24-20020a1c7718000000b003d1fd0b866fso2414590wmi.3
        for <linux-fbdev@vger.kernel.org>; Tue, 20 Dec 2022 01:44:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1J4eLv+5To8BjnLItTbs6pq8g5LjZHk9PMjLEQIi8Lo=;
        b=ZKNx2AMEgU2+2LHe9c3y6TxLNRbKAh6esodmikIsBeDkrXS88LMAWoTwsMpioQU6tL
         Lsh6thmPWtBwYj8KW/UB72HnePelFMd1hyjtefh5Iboq6zKRCFbBwmCyjncGzgmZxy72
         6P1SQMs0LZRLFTSd8iFq2edUgyhmKdyW8cBRy8PJD+svJtm0BN5UWvaP5yH6MgsqCq4d
         OkOvEqkm339YONXeoMVhl0a7gh08N+OjwbK8X0Iaxcw13laJs575rtMXrFm7GNA5eive
         d62GYXg1RoYe3u9jkCGPK07gD7zfUxtQer1GkBpaym0MpKGjbE0qHZMPneUjTrxw3dbL
         F3jg==
X-Gm-Message-State: ANoB5pnQYMmOspTsTl/irU0RMTcwzmj3rLQK/kD0bQBBGL4A6mYwV4rC
        Toty00X3DzHvyZfeInsa1R7KOZwrt/PZyQy6qq3SRZ6tclgzF23WZtr2oU/CwBXBY+m6GpG8RzN
        i7D8P2lEBu1T08gRyEqCsEJw=
X-Received: by 2002:a05:600c:3508:b0:3cf:b73f:bf8f with SMTP id h8-20020a05600c350800b003cfb73fbf8fmr34866237wmq.7.1671529492808;
        Tue, 20 Dec 2022 01:44:52 -0800 (PST)
X-Google-Smtp-Source: AA0mqf74M8Sm1ZUMeD1MRSt8ye6pyF2JALOeT/hhACXzocPTXyP3LI6efvyoi2Xa1weHvEDgcZ0pkQ==
X-Received: by 2002:a05:600c:3508:b0:3cf:b73f:bf8f with SMTP id h8-20020a05600c350800b003cfb73fbf8fmr34866233wmq.7.1671529492648;
        Tue, 20 Dec 2022 01:44:52 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id t16-20020a1c7710000000b003c6f3f6675bsm21680659wmi.26.2022.12.20.01.44.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 01:44:52 -0800 (PST)
Message-ID: <cb8af91b-4d5a-6d0a-6604-d99fc4a0f0e9@redhat.com>
Date:   Tue, 20 Dec 2022 10:44:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 17/18] fbdev/vga16fb: Do not use struct fb_info.apertures
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        airlied@gmail.com, deller@gmx.de
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org
References: <20221219160516.23436-1-tzimmermann@suse.de>
 <20221219160516.23436-18-tzimmermann@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221219160516.23436-18-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 12/19/22 17:05, Thomas Zimmermann wrote:
> Acquire ownership of the firmware scanout buffer by calling Linux'
> aperture helpers. Remove the use of struct fb_info.apertures and do
> not set FBINFO_MISC_FIRMWARE; both of which previously configured
> buffer ownership.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

