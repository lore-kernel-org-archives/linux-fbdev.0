Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2CB1C0015E
	for <linux-fbdev@archiver.kernel.org>; Wed,  5 Jul 2023 09:06:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbjGEJGZ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 5 Jul 2023 05:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbjGEJGY (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 5 Jul 2023 05:06:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44AB1700
        for <linux-fbdev@vger.kernel.org>; Wed,  5 Jul 2023 02:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688547939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FkUdoB9ukiXu+GwQPoh7yLjinOj86HTx0mJIEOcNqHk=;
        b=XF2Ty5+4s9gCoV8n7LHDoERopxwpo86Ru71klVOgsVxem42AWvqjL4FWU5cuNfpp4ZcgGJ
        +Gj+zebDnCrm9a2VVpf9BShSfLHI0tEDWaK9b0Hnl350HBR197RlLimghqxXqI77MDnhtg
        eUCJ2C7y9G03mXz01L0MP9koQZrdso8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-_lrl8eQdNIiHU8lVK9Xamw-1; Wed, 05 Jul 2023 05:05:37 -0400
X-MC-Unique: _lrl8eQdNIiHU8lVK9Xamw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3fbb0c01e71so37825045e9.0
        for <linux-fbdev@vger.kernel.org>; Wed, 05 Jul 2023 02:05:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688547936; x=1691139936;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FkUdoB9ukiXu+GwQPoh7yLjinOj86HTx0mJIEOcNqHk=;
        b=X5yfVBrvDwn39V2mYtpYbVbWrPMH1ubPl403mPi+S7UlIr/Si9Og0v6MZuQp0w8ok9
         MEYV34ry77Shoad8E/Kbj6BtFkJeM4hPmlceDzfql/EgWSWXb3hxSlY5lngfKG4dbMoX
         vf7fzsdk24J3VXHZFWT9aMVfLolC2AKn5JOQ4PzIS6pJ+wgxNgy083fJ3rTMCEoYBiqf
         0b6Gg4Px/7hTwkxMiBz+KdojemcaVN+3DME95A7vblYamObL/JdVwMEUYjZ9CXzv1PHL
         lhVYoXbwmrlrZ4WUPHz17u4CXfIx0f+32aMojZ8WTFQwUhss3o17tyfco4fix0+pLl3F
         9n+Q==
X-Gm-Message-State: ABy/qLZUyVPCNa7Ycgo9BUiAT1KcGR9P01isDdxKyqGnp1fwTDqCoOZE
        7AL/1wWlA5lttonNG/Ypi5W0oeqOVso9E8B2N6DZA1T+i7akcBoAE7kP7f7001EB2vT8BVHdAME
        L36war0AjnKDsyH/cvLnoQQQ=
X-Received: by 2002:a1c:f712:0:b0:3fb:dbd0:a7ea with SMTP id v18-20020a1cf712000000b003fbdbd0a7eamr6291383wmh.37.1688547936822;
        Wed, 05 Jul 2023 02:05:36 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFea/9ghtylfsKDHnVQCxTc0bPKyrA8WH7Zc8b8ay9vM+p1C9BZYAjxS62tSMn7FBeqBkEyEw==
X-Received: by 2002:a1c:f712:0:b0:3fb:dbd0:a7ea with SMTP id v18-20020a1cf712000000b003fbdbd0a7eamr6291366wmh.37.1688547936580;
        Wed, 05 Jul 2023 02:05:36 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id k7-20020a05600c0b4700b003f9b155b148sm1517462wmr.34.2023.07.05.02.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 02:05:36 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: Re: [PATCH 08/10] drm/omapdrm: Use GEM mmap for fbdev emulation
In-Reply-To: <20230704160133.20261-9-tzimmermann@suse.de>
References: <20230704160133.20261-1-tzimmermann@suse.de>
 <20230704160133.20261-9-tzimmermann@suse.de>
Date:   Wed, 05 Jul 2023 11:05:35 +0200
Message-ID: <87lefuran4.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> The fbdev emulation currently uses fbdev's default mmap code, which
> has been written for I/O memory. Provide an mmap that uses GEM's mmap
> infrastructure.
>
> Utilize fine-grained fbdev macros to initialize struct fb_ops. The
> macros set the read/write and the draw callbacks for DMA memory. Set
> the fb_mmap callback to omapdrm's new mmap helper. Also select the
> correct Kconfig token for fbdev's DMA helpers. Note that the DMA
> helpers are the same as for system memory.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

