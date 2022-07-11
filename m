Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 099B3C43334
	for <linux-fbdev@archiver.kernel.org>; Mon, 11 Jul 2022 11:41:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbiGKLlJ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 11 Jul 2022 07:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbiGKLku (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 11 Jul 2022 07:40:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1486F1EC45
        for <linux-fbdev@vger.kernel.org>; Mon, 11 Jul 2022 04:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657538954;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RT3petxY8Mc8sRJ6vFuAVMWzCJ23AGysMIvMZ0enDtM=;
        b=IMxmIKliCO5d6kq366VW7HAI/cjOND8Gzb4jEfG//aiRz53KzvZ0FsbD0FrrhiusDUAZfe
        fFKv0Tv5HtffYxcQWPetLHNSkJ7jHTjJJjt21/tuLcWFWQmChEkCeRBa88KzJdMkAovA6S
        GLv7mfsy9kwctTsvf2dxEKTx9bJrJX0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-212-LDKyFVsUOXyHeQxn9tRBFw-1; Mon, 11 Jul 2022 07:29:13 -0400
X-MC-Unique: LDKyFVsUOXyHeQxn9tRBFw-1
Received: by mail-wm1-f70.google.com with SMTP id bg6-20020a05600c3c8600b003a03d5d19e4so2546201wmb.1
        for <linux-fbdev@vger.kernel.org>; Mon, 11 Jul 2022 04:29:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RT3petxY8Mc8sRJ6vFuAVMWzCJ23AGysMIvMZ0enDtM=;
        b=zDhdnLoc5IrTJychrpRwGNvEYls1jPH7AzcScVudZQh6jViWFKEW1YxFgt0KPMwXg0
         C+cLshrUZLk8RqxZmhjxCldXo0rsTsNtdUCHaVkpykjExUpQpyXdDsctaJnkcFZ6TKvw
         yMP8n/4qgL5lXaTfNomvZu4CkKXJvdVaj6oXw27slljjaNZQ7gSCRtdlVhjEFaw2ahZM
         r+ZB0mXgxgc8+sbOZyaW23tDLDKhj6m4Y3uXrnb21Yay4/XJ2NUKlqS6xgkGCpfCL69d
         oKRN3xq5NbX5BjhMC8huUC8mkbE8wF3nu6NTNzPi/3ZFM2Yqi1YmAfBSLrQqtktoQV1Z
         93Bw==
X-Gm-Message-State: AJIora/YMZdmUNAPWt9ce+njDoYWTsWMqXDHV8/4iXee0iGKf4QZH1P0
        bHWTA/FxZM6Dq0ar42vmc6Tc6zPfQyuCLvIlyGwqbCTr5lNYxigSHdCJtYb/2oy03Hl7cXLjMiA
        UhuTEuV/KZmgoCum9J0FmSdY=
X-Received: by 2002:a05:6000:617:b0:21d:9873:bbf4 with SMTP id bn23-20020a056000061700b0021d9873bbf4mr10913062wrb.389.1657538951602;
        Mon, 11 Jul 2022 04:29:11 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vvC/M+fY0ZZDYvsO2CNoVptaM7dK1K21A3mz/ozhjRY8+6xu1Vcu63XmcV3f4+Js5dGVbFSQ==
X-Received: by 2002:a05:6000:617:b0:21d:9873:bbf4 with SMTP id bn23-20020a056000061700b0021d9873bbf4mr10913050wrb.389.1657538951426;
        Mon, 11 Jul 2022 04:29:11 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id t8-20020a05600c198800b003a04722d745sm2521753wmq.23.2022.07.11.04.29.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 04:29:10 -0700 (PDT)
Message-ID: <3f22174e-e1ee-1c1e-c643-37d437af7578@redhat.com>
Date:   Mon, 11 Jul 2022 13:29:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 10/11] fbdev: Acquire framebuffer apertures for firmware
 devices
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de,
        daniel@ffwll.ch, sam@ravnborg.org, maxime@cerno.tech
Cc:     linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        dri-devel@lists.freedesktop.org
References: <20220707153952.32264-1-tzimmermann@suse.de>
 <20220707153952.32264-11-tzimmermann@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220707153952.32264-11-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 7/7/22 17:39, Thomas Zimmermann wrote:
> When registering a generic framebuffer, automatically acquire ownership
> of the framebuffer's I/O range. The device will now be handled by the
> aperture helpers. Fbdev-based conflict handling is no longer required.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/video/fbdev/core/fbmem.c | 33 ++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> index 2237049327db..e556ad69f48f 100644
> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -13,6 +13,7 @@
>  
>  #include <linux/module.h>
>  
> +#include <linux/aperture.h>
>  #include <linux/compat.h>
>  #include <linux/types.h>
>  #include <linux/errno.h>
> @@ -1739,6 +1740,32 @@ static void do_unregister_framebuffer(struct fb_info *fb_info)
>  	put_fb_info(fb_info);
>  }
>  
> +static int fbm_aperture_acquire_for_platform_device(struct fb_info *fb_info)
> +{

What's the meaning of 'm' here ? Misc, memory ? I would just call it 'fb_'.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

