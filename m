Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE829C433EF
	for <linux-fbdev@archiver.kernel.org>; Tue, 25 Jan 2022 13:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352316AbiAYNns (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 25 Jan 2022 08:43:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51901 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1382562AbiAYNlQ (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 25 Jan 2022 08:41:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643118068;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yaxR451unEN0VqDa1LZ9sTihcGWyaF1DYfUc0HCmDjg=;
        b=fFG/qTb+laieAh9v4OK/alXSRwFd5hbbccQt23Lk6Z9dF5GKdAgh7YNMLZc78pyEY6qt4O
        9WElMcdHntKKZ7O2ZglFCGVE6SRVf5+IeUGelxinRhhMXuNEIXjdNR0BPKXLZOpxm8Pv5V
        lCoQL76Yg/cV+9pu9bU9VW+k6cVJYyA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-322-8qkHbeAqPT6g9_yWHRAIsQ-1; Tue, 25 Jan 2022 08:41:07 -0500
X-MC-Unique: 8qkHbeAqPT6g9_yWHRAIsQ-1
Received: by mail-wm1-f72.google.com with SMTP id n7-20020a1c7207000000b0034ec3d8ce0aso1480425wmc.8
        for <linux-fbdev@vger.kernel.org>; Tue, 25 Jan 2022 05:41:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yaxR451unEN0VqDa1LZ9sTihcGWyaF1DYfUc0HCmDjg=;
        b=ku362Emw2zG2sr5qx0NreDTbxpia+ieORxPW5fs7BbmRtJoHAdR1+GhiOUuRDZoMHH
         a7bitbBHJ6I32rf3SLbN98SPIDbGV/Xg3DtHoVvbkipIoUw5E2p/kB/HV7fwei99I4qA
         1ei4tba0BVGZUe/Crb4gqCR9Q3N9kZML7UaUIB3hZkkv48Tz4TsJVcNZYBO0oD4QaGKx
         X2BqtkQVW6WHBg03O8DFq31sLPYrQ2OYRv9UIfAsWiLRMnP6QGOrNg4DdICqZhT7xdKN
         oshCfaTSp/Bgs1vXCZXjIgEuNvnIuRWhsmgRgbohEbz0ab0tfI+5Zp1cf7hHRK+vaOhQ
         VMXQ==
X-Gm-Message-State: AOAM5304+LpZLY4dIIDbCPpZ1Lvon9NnbtA78oK7dN1nwDwfEAkfx9Rc
        bSbWK7blA1YMNhWix4jlWezGyRLDRFlRbPKGSWELtpedOZ3hUk3vE5wb78Wgc7hCflDwM0lvcfE
        9V3goUMnu6JumXg+lTYefBzs=
X-Received: by 2002:a5d:50ce:: with SMTP id f14mr17789771wrt.276.1643118066183;
        Tue, 25 Jan 2022 05:41:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxJVtjlhwtvlhUHqUCDybStr89WT6KBO170dmA+WW0xrnh32qxT1qxswdISyu4AeKaldFygFw==
X-Received: by 2002:a5d:50ce:: with SMTP id f14mr17789762wrt.276.1643118065983;
        Tue, 25 Jan 2022 05:41:05 -0800 (PST)
Received: from ?IPV6:2a01:e0a:c:37e0:f4b2:2105:b039:7367? ([2a01:e0a:c:37e0:f4b2:2105:b039:7367])
        by smtp.gmail.com with ESMTPSA id k12sm16609328wrd.98.2022.01.25.05.41.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jan 2022 05:41:05 -0800 (PST)
Message-ID: <6b016dc8-85f5-b859-b918-bd9c492b5ac3@redhat.com>
Date:   Tue, 25 Jan 2022 14:41:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 3/5] drm/simpledrm: Request memory region in driver
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, zackr@vmware.com,
        javierm@redhat.com, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, airlied@linux.ie, daniel@ffwll.ch,
        deller@gmx.de, hdegoede@redhat.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
References: <20220125091222.21457-1-tzimmermann@suse.de>
 <20220125091222.21457-4-tzimmermann@suse.de>
From:   Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20220125091222.21457-4-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi,

Thanks for the fix.

On 25/01/2022 10:12, Thomas Zimmermann wrote:
> Requesting the framebuffer memory in simpledrm marks the memory
> range as busy. This used to be done by the firmware sysfb code,
> but the driver is the correct place.
> 
> v2:
> 	* use I/O memory if request_mem_region() fails (Jocelyn)
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>

-- 

Jocelyn Falempe

