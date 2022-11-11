Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75B5C433FE
	for <linux-fbdev@archiver.kernel.org>; Fri, 11 Nov 2022 09:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233350AbiKKJa1 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 11 Nov 2022 04:30:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233559AbiKKJaS (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 11 Nov 2022 04:30:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A10C71F03
        for <linux-fbdev@vger.kernel.org>; Fri, 11 Nov 2022 01:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668158937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fi2SE1B7lTw9mdq0VS6e9xO7m6BadB4tfHCV89qdFtE=;
        b=hmcFF/wuu+YxBRL97flWTXw9VYjEofAg0nApthy+N6q9xbJAeewQayeFjXI3ybdPQw8scG
        nXgG8jNyCOhEL53JjTpYnPcdlzHuvEpw7PKPCMtoglMcRc+/BFrGetnqhiVSbQBpT2i6Oy
        Yfpnw2GVF/nmtMehhX7pTQlv5kyRR/c=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-413-9pkED4QWMAKWamWQosLdLQ-1; Fri, 11 Nov 2022 04:28:54 -0500
X-MC-Unique: 9pkED4QWMAKWamWQosLdLQ-1
Received: by mail-wm1-f70.google.com with SMTP id bg25-20020a05600c3c9900b003cf3ed7e27bso2311163wmb.4
        for <linux-fbdev@vger.kernel.org>; Fri, 11 Nov 2022 01:28:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fi2SE1B7lTw9mdq0VS6e9xO7m6BadB4tfHCV89qdFtE=;
        b=M4ZTOBeBxlj3DovKlM6YarCEhadPtjGyoBH5zbPyHResLDeEj9QlIvQ4Lry17ld7Qg
         GcAJ/zen6KmVqw9kQHnDT0FjJ9kpVf2KmsoM6Ewfk/tYN8iDEkhYKv3aIZaHZCxTLFHm
         XJCejRJAEZfhaWoGrDKqih9Za1YkpjVpjJjGag4w/Tik07SENAUNIspZOTSgWltuZCvd
         MV//7jtj9nxpTR/l4Hv5A87VXHEahWDuS7E9moRgv0HbrCbKuuYnk359ftk0tZ30Zdu/
         I2rtNHeGJ3i1KTog5fwScfNtAAXaNAkWyWp5YYObWMriBeHjDe6fLzY3T1gem+Pr5iFF
         Dkug==
X-Gm-Message-State: ANoB5plso8zl7mM9LJqBlpX9I7J4y1szzgCxWNYoMf/thVDtQwHZBuBC
        n506Qm1iiVyD/QAgMsQAAGFdPGNb1xCpzlhW2g7fiyuO97b1jZJXCkgAZoha0DO8+FwVPZptwqu
        RaT6STCE6pvmWp7n2VZ//2PY=
X-Received: by 2002:a05:600c:501f:b0:3cf:7801:c780 with SMTP id n31-20020a05600c501f00b003cf7801c780mr665760wmr.29.1668158933143;
        Fri, 11 Nov 2022 01:28:53 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6gggVWY5XHMDcKBvOquzjta+/8rIcI2BSxVmt+9jHIw0LxNFF/HyaBPWPLAepS/LDlWXKyyA==
X-Received: by 2002:a05:600c:501f:b0:3cf:7801:c780 with SMTP id n31-20020a05600c501f00b003cf7801c780mr665754wmr.29.1668158932932;
        Fri, 11 Nov 2022 01:28:52 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id m10-20020a5d56ca000000b00241736714c3sm342853wrw.14.2022.11.11.01.28.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Nov 2022 01:28:52 -0800 (PST)
Message-ID: <8447ae65-3f44-6e96-2c0e-f62a06b3e712@redhat.com>
Date:   Fri, 11 Nov 2022 10:28:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 1/2] drm: Move nomodeset kernel parameter to drivers/video
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de,
        daniel@ffwll.ch
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20221107104916.18733-1-tzimmermann@suse.de>
 <20221107104916.18733-2-tzimmermann@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221107104916.18733-2-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello Thomas,

On 11/7/22 11:49, Thomas Zimmermann wrote:

[...]

> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index a465d5242774a..70178c5f53956 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3777,7 +3777,7 @@
>  			shutdown the other cpus.  Instead use the REBOOT_VECTOR
>  			irq.
>  
> -	nomodeset	Disable kernel modesetting. DRM drivers will not perform
> +	nomodeset	Disable kernel modesetting. Graphics drivers will not perform
>  			display-mode changes or accelerated rendering. Only the
>  			system framebuffer will be available for use if this was
>  			set-up by the firmware or boot loader.

Not really part of your patch but probably we should reword this a little bit.

Because as this is written, it implies that not only DRM drivers with feature
DRIVER_MODESET will not be available but also drivers with DRIVER_RENDER. But
that's not the case, render-only drivers usually just ignore this parameter
(but not all IIRC), so I wonder how we could make this comment more accurate.

Also maybe we can mention in the comment fbdev and DRM? Just to make it clear
that this will affect to both subsystems? When I first worked on this, there
were a lot of assumptions in the stack (gdm, mutter, plymouth) that nomodeset
basically meant "no DRM but fbdev".

[...]

>  
>  int drm_dev_set_unique(struct drm_device *dev, const char *name);
>  
> -extern bool drm_firmware_drivers_only(void);
> +/* TODO: Inline drm_firmware_drivers_only() in all its callers. */

I guess you plan to do that as follow-up patches once this series land? Just
to avoid the churn to require acks for all the drivers to merge this series?

The changes looks good to me.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

