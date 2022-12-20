Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7772EC10F1E
	for <linux-fbdev@archiver.kernel.org>; Tue, 20 Dec 2022 09:47:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbiLTJry (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 20 Dec 2022 04:47:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233065AbiLTJrf (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 20 Dec 2022 04:47:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B796D53
        for <linux-fbdev@vger.kernel.org>; Tue, 20 Dec 2022 01:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671529606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ykdKuygOSTPkcM25esQW4i241lwYH2V5lSGsmvsr/ls=;
        b=b91FK8aLcaBEycSyVYwfSFFMLTFjye/mLE4W38Nvbx0RPPjXYVVxzevkw3+7iSVZIp5bdF
        O87m9KJdNZ+uJcXwDKHsK+gbNXEMDzEUet0SLiX7mq31eKfPYij52C6uSYKvwpc+cdnp7N
        6JbTGnTZ8kgWQS5b1Kvx9XCIWzWgekQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-522-r3Bl0qOMOICZd3HyN9BOrA-1; Tue, 20 Dec 2022 04:46:37 -0500
X-MC-Unique: r3Bl0qOMOICZd3HyN9BOrA-1
Received: by mail-wm1-f69.google.com with SMTP id r67-20020a1c4446000000b003d09b0fbf54so7804238wma.3
        for <linux-fbdev@vger.kernel.org>; Tue, 20 Dec 2022 01:46:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ykdKuygOSTPkcM25esQW4i241lwYH2V5lSGsmvsr/ls=;
        b=0S0bg1DawFAWZ8HcRWkdNGj3GtUdFaAvPhWE3V9j0yIoCQfwawQoBy+YJG8CRXVz5j
         4GLZNDSOhUV0MrwlNbGxonEwfVFRszxluMHr48GS7qTsbRMMW1qGnmOB1j2ElYcZ1+0K
         bk/5/B72z9pKI2+J6v4uJTP1b1fJ+nwCL3/3GjvPvTnkZOJ1FkQgtP9dGwiwMwBQ8n5a
         wstI+r3+i4FtDS3xRzJBXR9QikiCPAbxfow8aVOz5+FeL9Rhexn09HoU7rq84bSfiRQq
         ahGIaMfOqCfWV/7szOv0hJpViOIzgG2HiGK3WpMpcqdM95Czh5bhZX3TmR4Qjxo8sFJL
         QFEg==
X-Gm-Message-State: AFqh2kpdeOQrrZlKeqUD/Eu/7jhpqEDxeLj7r9KEzENs0ogSOtwrjVLA
        SEdE1bTrlA9RZbTS+G3y85OaFE6re7TZdFEWfhDWQlVQAPgvVXamKUd0QcidpNfxEYpftTtRD2P
        yoU2B5Zfb8ROVNGpT1tLqq0k=
X-Received: by 2002:a05:6000:718:b0:256:ce1b:74ac with SMTP id bs24-20020a056000071800b00256ce1b74acmr19147672wrb.29.1671529596404;
        Tue, 20 Dec 2022 01:46:36 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvJLK/eM71NU46wbs2aboKoDtpTCvPv8+GeJSh+yzufeE4NK5CbBNZkmGr9N2Pg6bIDfe3F3Q==
X-Received: by 2002:a05:6000:718:b0:256:ce1b:74ac with SMTP id bs24-20020a056000071800b00256ce1b74acmr19147664wrb.29.1671529596230;
        Tue, 20 Dec 2022 01:46:36 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id c16-20020adffb50000000b002365254ea42sm12325758wrs.1.2022.12.20.01.46.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 01:46:35 -0800 (PST)
Message-ID: <978cd907-65ce-2a89-e046-17a75c0ab832@redhat.com>
Date:   Tue, 20 Dec 2022 10:46:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 18/18] drm/fbdev: Remove aperture handling and
 FBINFO_MISC_FIRMWARE
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        airlied@gmail.com, deller@gmx.de
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org
References: <20221219160516.23436-1-tzimmermann@suse.de>
 <20221219160516.23436-19-tzimmermann@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221219160516.23436-19-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 12/19/22 17:05, Thomas Zimmermann wrote:
> There are no users left of struct fb_info.apertures and the flag
> FBINFO_MISC_FIRMWARE. Remove both and the aperture-ownership code
> in the fbdev core. All code for aperture ownership is now located
> in the fbdev drivers.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/video/fbdev/core/fbmem.c   | 33 ------------------------------
>  drivers/video/fbdev/core/fbsysfs.c |  1 -
>  include/linux/fb.h                 | 22 --------------------
>  3 files changed, 56 deletions(-)

Nice patch!

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

