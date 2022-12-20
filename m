Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44640C4332F
	for <linux-fbdev@archiver.kernel.org>; Tue, 20 Dec 2022 09:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbiLTJjh (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 20 Dec 2022 04:39:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiLTJjf (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 20 Dec 2022 04:39:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC519B5F
        for <linux-fbdev@vger.kernel.org>; Tue, 20 Dec 2022 01:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671529128;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1J4eLv+5To8BjnLItTbs6pq8g5LjZHk9PMjLEQIi8Lo=;
        b=UOLLyp9FAvIIlWcTeMOsKJI87NsM5atYMF/1Q43l0t/WjpgKd9O1RrStL4I+XES9P1dCE9
        S1fdKX2ubiguiBHOL/hFg5G3M0QcubgRmyv62dL5pzidDTDhwKTc38fzAK+acRkvQJ+tZb
        ZuPA3jde2392DuZ6LJyFNRpldZeXgus=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-568-r8--1VXQP1GOHm0fYygtKQ-1; Tue, 20 Dec 2022 04:38:46 -0500
X-MC-Unique: r8--1VXQP1GOHm0fYygtKQ-1
Received: by mail-wm1-f69.google.com with SMTP id m38-20020a05600c3b2600b003d23f8c6ebdso375632wms.0
        for <linux-fbdev@vger.kernel.org>; Tue, 20 Dec 2022 01:38:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1J4eLv+5To8BjnLItTbs6pq8g5LjZHk9PMjLEQIi8Lo=;
        b=hddlLH1nj3G6/fsomBX8bxIZl1trjpJPiDcb6nsV088ztid5qOx4EltZf7fXUwn5Xf
         Uxwn4ojf/8xCY/7GeOe2mpGmYkYhmdRw9GoitA3HiLcH4FxKzDS70MMe+GlCCQSBgTIM
         DpOoRXLyUIAIDlYejY8XKyg6ZdILweolo9X7BDG9uucmufvHD3SvxSjMDljWYrrVnc2K
         vZxLhPjV9nx9k/ONI2gYB1qF6+/tGd5yTGTC7MIMFJ8r3QuNIRfH1yqqbdGGNyDhcVzF
         30HOMzFWzhw+5Fi9Oa705tsvTtr/tTXJBSoJbn9C5Sr3K5Ek+ryuuLvkC8gMAve+gsjr
         WYog==
X-Gm-Message-State: AFqh2kop8yZszeJbXDY/r6MXoH/B+AveTskDJSgGlFHTfWolp0ktlf3e
        SS+uTSPxRGsEvXnEGe4y+3vKTxlHRTYsxgti9tavypwy5fMF9UNziCz/y7iaNdJe5pNr9nAlnH0
        XAAegq3lDwIQaVMEgXhuF4FU=
X-Received: by 2002:a05:600c:1d89:b0:3d5:64bf:ccc2 with SMTP id p9-20020a05600c1d8900b003d564bfccc2mr972465wms.32.1671529125272;
        Tue, 20 Dec 2022 01:38:45 -0800 (PST)
X-Google-Smtp-Source: AMrXdXslpFNWgJA7+1mAYcupIJ/r6e/d06O54fNaPmM/ERkGUAWuMMiWYBSHcxiARgbY+lIJOxnk0g==
X-Received: by 2002:a05:600c:1d89:b0:3d5:64bf:ccc2 with SMTP id p9-20020a05600c1d8900b003d564bfccc2mr972452wms.32.1671529125099;
        Tue, 20 Dec 2022 01:38:45 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id i27-20020a05600c4b1b00b003d220ef3232sm14481191wmp.34.2022.12.20.01.38.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 01:38:44 -0800 (PST)
Message-ID: <bc75ba60-9fb4-dec9-c7fd-23e50942f7f0@redhat.com>
Date:   Tue, 20 Dec 2022 10:38:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 13/18] fbdev/offb: Do not use struct fb_info.apertures
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        airlied@gmail.com, deller@gmx.de
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org
References: <20221219160516.23436-1-tzimmermann@suse.de>
 <20221219160516.23436-14-tzimmermann@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221219160516.23436-14-tzimmermann@suse.de>
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

