Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A37CEC433F5
	for <linux-fbdev@archiver.kernel.org>; Fri, 20 May 2022 05:18:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240907AbiETFSR (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 20 May 2022 01:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238048AbiETFSR (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 20 May 2022 01:18:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8F33FCEBA8
        for <linux-fbdev@vger.kernel.org>; Thu, 19 May 2022 22:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653023894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AojK9fdDlk+robhCF8PY6mP/b2uer1ZGJkY3jjz44AE=;
        b=C3u3QdFNFOwJyMZRUsb/mBXYgz2bzyXfK7T9Rjn7YqnvSZ/OnfMYVI6qXGStYXezP5Af0S
        VR4CBwHn4Bt84jkCl2Lw94CShp9ldJeG1Q6FjrTN83kWIB7qGyi9r7DF3Ogy5LHzBvUkmN
        pEjQDS5dyCYTMrwwW+ST76yu7zgRCVk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-392-r5ERlxzhP5O1SWqQweY4Ew-1; Fri, 20 May 2022 01:18:13 -0400
X-MC-Unique: r5ERlxzhP5O1SWqQweY4Ew-1
Received: by mail-wm1-f72.google.com with SMTP id m186-20020a1c26c3000000b003943e12185dso2701391wmm.7
        for <linux-fbdev@vger.kernel.org>; Thu, 19 May 2022 22:18:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AojK9fdDlk+robhCF8PY6mP/b2uer1ZGJkY3jjz44AE=;
        b=2Q4CxN/oUXmAAru4a+g1/sVSaenWd4AU65KAGAFXMdT1HO9y/EpSwcLQEc0UlcU/Pj
         VZHM3vwwuTTCikYoL7vwWMhbAe++2LSFCquYron3qaoeiO7xbaTFJRgAVKGvJvBu7YKM
         AW1pzmO7JLx8MlEGd54XJfmuBEOTk/CTUWvaiafe0Rxxs6nEmnEFG7npQ4a5k3du3eRa
         l6/aS4Cr1UoD6MDXuXOJch10r85Dkz+xDRR9Kciq1b0WAQQduwpcGIVMzEcXKJXHB5MZ
         p9DqGYJWlpzstP4FlC/qEYy7FwcS7af1SDntzlyigjHXCMhd3jWv80m2W1OaDM3ZM3yd
         Wmhw==
X-Gm-Message-State: AOAM533JDp+JcZoqICMFA5l0kFH40qVjXkRnVxiCuzKWb9RTwoTIoAx2
        O6M/tQAVvp+HLSKUlBF8QzIdPMQAE/JsOpzjWE5eEZm1mnxtlsizUWYgbeWu6ec3V0SiyMr3nPb
        +LQlyXMeEeLnVqkf+5eKzNio=
X-Received: by 2002:adf:fe42:0:b0:20d:297:f86e with SMTP id m2-20020adffe42000000b0020d0297f86emr6731310wrs.382.1653023891706;
        Thu, 19 May 2022 22:18:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyZXqQy9NPRkq8RsuzAXsi3g2v9mePIB4+gjaCXquJOoX1jBb5+EgH3gcFfRjFHtBJgLajfaw==
X-Received: by 2002:adf:fe42:0:b0:20d:297:f86e with SMTP id m2-20020adffe42000000b0020d0297f86emr6731295wrs.382.1653023891497;
        Thu, 19 May 2022 22:18:11 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o9-20020adf8b89000000b0020d0351dbb6sm1345823wra.80.2022.05.19.22.18.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 22:18:11 -0700 (PDT)
Message-ID: <1f63406f-5160-462a-2e79-0938421057a9@redhat.com>
Date:   Fri, 20 May 2022 07:18:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 1/2] MAINTAINERS: Broaden scope of simpledrm entry
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, airlied@linux.ie,
        daniel@ffwll.ch, deller@gmx.de, maxime@cerno.tech,
        sam@ravnborg.org, msuchanek@suse.de, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
References: <20220518183006.14548-1-tzimmermann@suse.de>
 <20220518183006.14548-2-tzimmermann@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220518183006.14548-2-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello Thomas,

On 5/18/22 20:30, Thomas Zimmermann wrote:
> There will be more DRM drivers for firmware-provided framebuffers. Use
> the existing entry for simpledrm instead of adding a new one for each
> driver. Also add DRM's aperture helpers, which are part of the driver's
> infrastructure.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

I think you could push this without waiting for 2/2 to be ready.

>  MAINTAINERS | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5c1fd93d9050..43d833273ae9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6388,13 +6388,15 @@ S:	Orphan / Obsolete
>  F:	drivers/gpu/drm/savage/
>  F:	include/uapi/drm/savage_drm.h
>  
> -DRM DRIVER FOR SIMPLE FRAMEBUFFERS
> +DRM DRIVER FOR FIRMWARE FRAMEBUFFERS
>  M:	Thomas Zimmermann <tzimmermann@suse.de>
>  M:	Javier Martinez Canillas <javierm@redhat.com>
>  L:	dri-devel@lists.freedesktop.org
>  S:	Maintained
>  T:	git git://anongit.freedesktop.org/drm/drm-misc
> +F:	drivers/gpu/drm/drm_aperture.c
>  F:	drivers/gpu/drm/tiny/simpledrm.c
> +F:	include/drm/drm_aperture.h

I wonder if we could add drivers/firmware/sysfb* as well, it certainly is
related since is the place where different platforms register the device.

But it's not in drivers/gpu, hence the question if we could include it 
(and possibly merge it through drm-misc as well, etc).

Dave, Daniel, what do you think ?

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

