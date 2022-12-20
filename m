Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A25C4332F
	for <linux-fbdev@archiver.kernel.org>; Tue, 20 Dec 2022 09:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiLTJlk (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 20 Dec 2022 04:41:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233537AbiLTJlU (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 20 Dec 2022 04:41:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4641CD86
        for <linux-fbdev@vger.kernel.org>; Tue, 20 Dec 2022 01:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671529233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1J4eLv+5To8BjnLItTbs6pq8g5LjZHk9PMjLEQIi8Lo=;
        b=DhiHk/HyImR4HtOMcFN2LQsGDLUfzWRwh3sFdcTSOXC1iJq7ca4jlIQNnXv1idjBWtUnKP
        IOOySZuIBlswiIhQ7Zj5LMjCwJEspwvGbdp4Q6uBkUk9hverLhJ51jx3ipewVNL1569JWy
        BztCJxnbz4qb3FNgdCDwlF4NWX9JRBM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-338-hbGBNC_nPSWMnLJbKGu0pQ-1; Tue, 20 Dec 2022 04:40:32 -0500
X-MC-Unique: hbGBNC_nPSWMnLJbKGu0pQ-1
Received: by mail-wm1-f72.google.com with SMTP id a6-20020a05600c224600b003d1f3ed49adso2403975wmm.4
        for <linux-fbdev@vger.kernel.org>; Tue, 20 Dec 2022 01:40:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1J4eLv+5To8BjnLItTbs6pq8g5LjZHk9PMjLEQIi8Lo=;
        b=liToIhqdSAjLjiziLhwJU0U3jNOE5FzaTU/L4vRZX//MMBglclp/qFyI1h812wsvvH
         OqqZJ7yblYeDy1+/6tvaQZXJnQKwGnHZ9YZbj4cyv3MSwivn54I5S0A4vC919HBWBbyx
         HuoBXcPuxEDbqL2VMkOhdYSJq8/NeIy0tMhmSNp4EwtmbHBmOni55feG3n9SfCvXL24I
         zt0ISZ7PsXTXdtlZp76fTNWDHB3XV1rhplDDYZeez3yXq1PVxajMSTSL1InaUh0wb+/c
         6+uPfyDmmV2kyhTIgPozqrgbVsJvC0uN7DUV9PEwDH3UL7XuqQoC9zYn8ZdIMAuZZTVK
         yUdQ==
X-Gm-Message-State: ANoB5pmXpgHYomuCXhT/TJo4xeXe3aqBss/zHE0U+hNlHpY1ze3Et52P
        tWZTIvK6Wlb5AsY/+v9d9O35cZvOceb3PYYEnywzCcSkEwvJJnShhXzsRkvNT+U/B2GevD1jLxZ
        H7CmK/haf+g5sQO/40T3o95w=
X-Received: by 2002:a05:600c:1c14:b0:3d0:965f:63ed with SMTP id j20-20020a05600c1c1400b003d0965f63edmr33960390wms.23.1671529231163;
        Tue, 20 Dec 2022 01:40:31 -0800 (PST)
X-Google-Smtp-Source: AA0mqf71wOlxFtTuSNW/9jMXBnVwUZwb2b/kuKlWfvoG3RUuoMrRINee90ZtVa/GrwK8ITxjbcPFuQ==
X-Received: by 2002:a05:600c:1c14:b0:3d0:965f:63ed with SMTP id j20-20020a05600c1c1400b003d0965f63edmr33960383wms.23.1671529230999;
        Tue, 20 Dec 2022 01:40:30 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id p2-20020a05600c358200b003d1f2c3e571sm24392373wmq.33.2022.12.20.01.40.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 01:40:30 -0800 (PST)
Message-ID: <1dd11b16-bf9d-4b86-14c7-095804a2f66d@redhat.com>
Date:   Tue, 20 Dec 2022 10:40:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 14/18] fbdev/simplefb: Do not use struct fb_info.apertures
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        airlied@gmail.com, deller@gmx.de
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org
References: <20221219160516.23436-1-tzimmermann@suse.de>
 <20221219160516.23436-15-tzimmermann@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221219160516.23436-15-tzimmermann@suse.de>
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

