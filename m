Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B8EC4332F
	for <linux-fbdev@archiver.kernel.org>; Tue, 20 Dec 2022 09:36:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233486AbiLTJg3 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 20 Dec 2022 04:36:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233479AbiLTJgV (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 20 Dec 2022 04:36:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72CA717889
        for <linux-fbdev@vger.kernel.org>; Tue, 20 Dec 2022 01:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671528935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1J4eLv+5To8BjnLItTbs6pq8g5LjZHk9PMjLEQIi8Lo=;
        b=MvgP7d23zJJhJfNNtZXmaBwB7Yd8Vi68/FEO1UWvjSoBMAbWSvD8TvOu+Nlw7sMn28zIug
        CmK3+15pHFd/uK9lWWfpQuZ+W8byVpS/39khSnuagMJ/NfH7xyV68mzmpgfY7gFoJMsm8P
        3xsVIEG6AUhYkXuCWPTfBrGZUIMkYro=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-622-gcArTgzBNKCPbYEydQytXw-1; Tue, 20 Dec 2022 04:35:34 -0500
X-MC-Unique: gcArTgzBNKCPbYEydQytXw-1
Received: by mail-wm1-f71.google.com with SMTP id 125-20020a1c0283000000b003d1d8d7f266so6294028wmc.7
        for <linux-fbdev@vger.kernel.org>; Tue, 20 Dec 2022 01:35:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1J4eLv+5To8BjnLItTbs6pq8g5LjZHk9PMjLEQIi8Lo=;
        b=TNXDoAecST1Nf7zdhU3lU25LI38igrVB1Sg5ImZUNtZBiZ0DdCEFkngO+bSY1Bs8aW
         2J4/nJoEW2FoOEKZhYCDdbJaRo7fAPGafG3vauqh3d2mNNag8VXfsecc1b6Gc+RyJxDP
         ij+zwqz3CEM/lYdbzuy7DSUFyrnM4tzZpHE2uGwZWksiZJN4owb54agLlX/9PorAzCix
         Z6PcTgAkJRUfl5C2akfvwkMzy6Xf8ciukAfGJZzP0LUWhKz+odTnhucxV6vwaV7VluCH
         NRElZd5TjYDP7Iqu/9bxo67S4nG8+2Avpro+uKcdQTfYmFquuLhgkBBR8fEwLcVaplwB
         ln+A==
X-Gm-Message-State: ANoB5pn+If+w+YDrKTZutOJTDvVXhAqWTGe8llNAtlYdLHVhde/fQHhq
        yKpnk7xhwHWd2MZWcGdkc+D+jQJ/MpOhrvVooo4xrqv4x8TUSS9t9RY30NaxBTQR2eszB6LjA5t
        WF5+uxsthOZ2yvqJM/ZjidRA=
X-Received: by 2002:a5d:550c:0:b0:242:2713:1fb9 with SMTP id b12-20020a5d550c000000b0024227131fb9mr24605040wrv.16.1671528933090;
        Tue, 20 Dec 2022 01:35:33 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5UgRh9FZeAQW/rgYS4tJcqcpMr2W2F1LauhongkzEysTbAsUBQfYpe3JzD17C7VFjb9x9qPQ==
X-Received: by 2002:a5d:550c:0:b0:242:2713:1fb9 with SMTP id b12-20020a5d550c000000b0024227131fb9mr24605033wrv.16.1671528932912;
        Tue, 20 Dec 2022 01:35:32 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id y18-20020a5d4ad2000000b002365cd93d05sm12313762wrs.102.2022.12.20.01.35.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 01:35:32 -0800 (PST)
Message-ID: <c8c3d52d-896b-b38b-00ac-b1686fc4ecaa@redhat.com>
Date:   Tue, 20 Dec 2022 10:35:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 11/18] fbdev/efifb: Do not use struct fb_info.apertures
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        airlied@gmail.com, deller@gmx.de
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org
References: <20221219160516.23436-1-tzimmermann@suse.de>
 <20221219160516.23436-12-tzimmermann@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221219160516.23436-12-tzimmermann@suse.de>
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

