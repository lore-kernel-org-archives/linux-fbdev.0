Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D4C6C4167B
	for <linux-fbdev@archiver.kernel.org>; Tue, 20 Dec 2022 09:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbiLTJVB (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 20 Dec 2022 04:21:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233316AbiLTJUx (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 20 Dec 2022 04:20:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276D9F5A6
        for <linux-fbdev@vger.kernel.org>; Tue, 20 Dec 2022 01:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671528003;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1OcEOi6wfApoNJ5QX9xUUF80M6DZAUCfFxv9pSqRsVA=;
        b=WnPihU+vfoHV2bn1BbhoanVL1Ohe6aVQ+nQoht4oRG1UB5JFTKWn5YRgn2w4mI1Bprt+EG
        fikBvyf23yllhuoU96+8Irj/POOpM4UMqPZV6VbYixO21TcFCBplFwEubl9wujgq+1Mm3R
        TCiFigS6kcLYld5hTCqBrvgk8r7mZ2M=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-662--40iFVSqPcOL2gqV-Edf-w-1; Tue, 20 Dec 2022 04:20:02 -0500
X-MC-Unique: -40iFVSqPcOL2gqV-Edf-w-1
Received: by mail-wm1-f69.google.com with SMTP id 9-20020a1c0209000000b003d1c0a147f6so7780985wmc.4
        for <linux-fbdev@vger.kernel.org>; Tue, 20 Dec 2022 01:20:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1OcEOi6wfApoNJ5QX9xUUF80M6DZAUCfFxv9pSqRsVA=;
        b=nMzmyOxL3hZ8kTJuofB0NRVojGmPv5EZ6PuvjfS54q/Ynkmr8JHThGYah8LXY/vZMp
         l5D4NJo1EAtMwaNhwRUY5E7B9X804H6O9w3NQZZtMTau9sxzvMSvXBLXK9CCmTIzlo//
         eSSDA5OFY8jgg1As0D6rTA+e9WTdvhBQLTzMarxtlbbUonfXSlFs+PRP9XWa3g1EdDHi
         zz78/t/VFNixAhTS0KCWsORz4vV9J9OioN+ilj7fHM3l3ygNo1BKGdbYOjwRGEvRBgNe
         9otvILbwQ5SrIrJNtaywYRfJNcGj2wEk1zWIVXBYUorMye9VAz1V6hICVy3l0IOW4Px5
         nyCw==
X-Gm-Message-State: ANoB5pmcn0vEr51aHexNyn6XLzNNURSbn5gjULPjoTou46mFtUGdmQnI
        3vJTlr07WFYQaSyCMjd7JUXwm0bkIve/vwvpTkDVZjvtP7Dp9wLxPgtXlSIZW+pSLkNvzhapcQn
        Wg0PmMzk7iz1rUVdl28D36TE=
X-Received: by 2002:a05:600c:4f85:b0:3cf:93de:14e8 with SMTP id n5-20020a05600c4f8500b003cf93de14e8mr33662651wmq.39.1671528001148;
        Tue, 20 Dec 2022 01:20:01 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7YfyRC8GN1CmHHU+h6zQnG8fHr/grTiv22vuNVltDRj2C7JBfNLZj3eqwiClNyExLknW6NJw==
X-Received: by 2002:a05:600c:4f85:b0:3cf:93de:14e8 with SMTP id n5-20020a05600c4f8500b003cf93de14e8mr33662634wmq.39.1671528000916;
        Tue, 20 Dec 2022 01:20:00 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id p16-20020a1c5450000000b003d07de1698asm21890206wmi.46.2022.12.20.01.20.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 01:20:00 -0800 (PST)
Message-ID: <bf88b4bf-4c81-29d3-3518-ef149f93265d@redhat.com>
Date:   Tue, 20 Dec 2022 10:19:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 05/18] drm/radeon: Do not set struct fb_info.apertures
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        airlied@gmail.com, deller@gmx.de
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org
References: <20221219160516.23436-1-tzimmermann@suse.de>
 <20221219160516.23436-6-tzimmermann@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221219160516.23436-6-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 12/19/22 17:05, Thomas Zimmermann wrote:
> Generic fbdev drivers use the apertures field in struct fb_info to
> control ownership of the framebuffer memory and graphics device. Do
> not set the values in radeon.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

