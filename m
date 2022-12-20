Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC0CC4332F
	for <linux-fbdev@archiver.kernel.org>; Tue, 20 Dec 2022 09:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiLTJY6 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 20 Dec 2022 04:24:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiLTJY5 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 20 Dec 2022 04:24:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC607BE9
        for <linux-fbdev@vger.kernel.org>; Tue, 20 Dec 2022 01:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671528258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hYMKnwowgCZbmQLyZb+O1xPkwcQc1vWKiI5mpSCZQTU=;
        b=A/7LC0W2LuPNDh009vMU274Iqay9dstaNyxACKvN8N2Dffxm6s9f3z/jeDT1hRGmBhQzrF
        6BH3yuhnv4vO/wwBvLvxPbhFAe2dQ1KJDVSgfZUn85FqU7s7edA908fx/Migxx9YZrlQvp
        jt9lDkhJEvYBqGlBNlGCfzYdUZ+LklY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-171-1JDa4zoFOuagt2OrbYqwKw-1; Tue, 20 Dec 2022 04:24:09 -0500
X-MC-Unique: 1JDa4zoFOuagt2OrbYqwKw-1
Received: by mail-wm1-f70.google.com with SMTP id i187-20020a1c3bc4000000b003d634aca337so137970wma.1
        for <linux-fbdev@vger.kernel.org>; Tue, 20 Dec 2022 01:24:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hYMKnwowgCZbmQLyZb+O1xPkwcQc1vWKiI5mpSCZQTU=;
        b=iBK4dUZgjDDQcUJSzubmXSPofGmW26tLnz+7yz5XSjLSEC77ldGTs7Ymv6sDQUPmPI
         lUlPn8TkW/5cfRRAJ3zKMwey1Gv8Vb6y3odFRQnHdEXFFAerVjPRF1a8Mcl4FQAhZQ93
         MFn0Mm+qZFM4UyiC0TZ0+1a8y3AEHG/mp+JST9aFplKOAEU8HpiFS7RkDCEK7NxZ5M3B
         pXm6hYlosOdFin1n0QapV4nupYcDjKNlgb8wAsjZK0He8zWbOfbeME2gqGvwUJGeh33u
         YTu1LN8/2OMZrkPzceS132H09zzgGiOZgtYGqrqLc/H/VYsmbUX+xYwxG4h5VHOGB62M
         1cIQ==
X-Gm-Message-State: ANoB5plx3nU9zxxiO9l4o4J2UB2C8XAKt3i3KdjkcmuzN6G8LB7TvsyS
        TAh8MoWvWuuXHZnsffFWU7cdTpATHrtJcb+V0BMdxiuxh/ETPUi4nHZvkx6cyAY9rx+G5W43Hqn
        9XjyG9I2hXrc7iR0nolpHPt0=
X-Received: by 2002:a05:600c:3592:b0:3d1:bc32:2447 with SMTP id p18-20020a05600c359200b003d1bc322447mr34442427wmq.21.1671528248085;
        Tue, 20 Dec 2022 01:24:08 -0800 (PST)
X-Google-Smtp-Source: AA0mqf63KxuIxT0M/bl3iLHanyFrnj5hgoC/KBz3bLt1CmA/PA7eDrziJ0q3Lz1WCcHGowxEUJxpPQ==
X-Received: by 2002:a05:600c:3592:b0:3d1:bc32:2447 with SMTP id p18-20020a05600c359200b003d1bc322447mr34442411wmq.21.1671528247925;
        Tue, 20 Dec 2022 01:24:07 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id k18-20020a05600c1c9200b003a84375d0d1sm24663667wms.44.2022.12.20.01.24.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 01:24:07 -0800 (PST)
Message-ID: <e807855d-cfaa-ebab-8aff-7a3e78b1967d@redhat.com>
Date:   Tue, 20 Dec 2022 10:24:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 07/18] fbdev/clps711x-fb: Do not set struct
 fb_info.apertures
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        airlied@gmail.com, deller@gmx.de
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org
References: <20221219160516.23436-1-tzimmermann@suse.de>
 <20221219160516.23436-8-tzimmermann@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221219160516.23436-8-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 12/19/22 17:05, Thomas Zimmermann wrote:
> Generic fbdev drivers use the apertures field in struct fb_info to
> control ownership of the framebuffer memory and graphics device. Do
> not set the values in clps711x-fb.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

