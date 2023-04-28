Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F174C77B60
	for <linux-fbdev@archiver.kernel.org>; Fri, 28 Apr 2023 13:34:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346300AbjD1Ne2 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 28 Apr 2023 09:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346247AbjD1Ne2 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 28 Apr 2023 09:34:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C141F210B
        for <linux-fbdev@vger.kernel.org>; Fri, 28 Apr 2023 06:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682688821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T6nMtf6Gzq3uJ6hYj+VP/gNrA7S63KDC0HhAUOQNVRE=;
        b=YiRvuylMP4szzd0TVhNqNQ7nYMerMd1mUkjDIthTtSfj3VI9Q90zomKysdudIindgRbCLd
        bkbBDxW3tbcm6tlXL/QKySmim14hmYA3KIEPBFuFn5Xd0PPkcVona/9r9qJEMZpKEY1Fup
        Tn+uaLlKCMkS4KyXlsFhpGmqO74m9bA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-AH2XKY4VMFaQmJXaGiVrtQ-1; Fri, 28 Apr 2023 09:33:39 -0400
X-MC-Unique: AH2XKY4VMFaQmJXaGiVrtQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f187a7a626so35560845e9.0
        for <linux-fbdev@vger.kernel.org>; Fri, 28 Apr 2023 06:33:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682688817; x=1685280817;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T6nMtf6Gzq3uJ6hYj+VP/gNrA7S63KDC0HhAUOQNVRE=;
        b=NK3q2ZRhRSW50EuEsmN+Tc+CiA4FBjpUkT3stX1XKI+8E6Mz6BuJeBa51+DpdgGYu2
         jptQXkuMSg1h2rwS4VJ06kVcuioZWzZfx2vXz7apr+LJPq/WuhhkhM8kQtpG8de5Chqo
         /ufUhSUylVuqwAR455+te8QaEvVPb7g97p752YgwUg9hhXP1Q9Qqa2DxuaupoLizs3Eq
         /bF7vYIaO384KG8nuJwkg7QZD+1K29+S5q60vyUelETJ2gPs6oqetETdYkXMc3Y4W6sR
         Xpv9MqsbqV1XEhyVS1e1WSduRItD4cKHhzLIwsBQrAV90xQvAGJWwS42d2y1LbTcnaCX
         QjWg==
X-Gm-Message-State: AC+VfDyRh4943RiUIM2O2+arIFnO1BV6JS4tP5Eyvm3Mlryhu38CcKS/
        AoKGhp+Q3qpT5vrI1uDA4B71KiPCSyPaM7rpJ2RUVYP7If5fzluY9wk0DHTAVSEJDtzejGW5zFm
        wic6t8phVpFkZJ1F/sVdzLIU=
X-Received: by 2002:a5d:54cb:0:b0:2f4:f727:14b9 with SMTP id x11-20020a5d54cb000000b002f4f72714b9mr3754762wrv.43.1682688817682;
        Fri, 28 Apr 2023 06:33:37 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4aoS11M0VcXzkzoTNNDPlJ9yq5eLNx4vXdbKR1p77ehBhl3fOopeYeVOMj3at8BjlbnCOB3Q==
X-Received: by 2002:a5d:54cb:0:b0:2f4:f727:14b9 with SMTP id x11-20020a5d54cb000000b002f4f72714b9mr3754743wrv.43.1682688817385;
        Fri, 28 Apr 2023 06:33:37 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l18-20020a05600012d200b002ceacff44c7sm21198449wrx.83.2023.04.28.06.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 06:33:37 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@gmail.com, daniel@ffwll.ch, deller@gmx.de,
        geert@linux-m68k.org, sudipm.mukherjee@gmail.com,
        teddy.wang@siliconmotion.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v2 01/19] auxdisplay/cfag12864bfb: Use struct
 fb_info.screen_buffer
In-Reply-To: <20230428122452.4856-2-tzimmermann@suse.de>
References: <20230428122452.4856-1-tzimmermann@suse.de>
 <20230428122452.4856-2-tzimmermann@suse.de>
Date:   Fri, 28 Apr 2023 15:33:36 +0200
Message-ID: <87ildggmhb.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Use info->screen_buffer when reading and writing framebuffers in
> system memory. It's the correct pointer for this address space.
>
> The struct fb_info has a union to store the framebuffer memory. This can
> either be info->screen_base if the framebuffer is stored in I/O memory,
> or info->screen_buffer if the framebuffer is stored in system memory.
>
> As the driver operates on the latter address space, it is wrong to use
> .screen_base and .screen_buffer must be used instead. This also gets
> rid of casting needed due to not using the correct data type.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

