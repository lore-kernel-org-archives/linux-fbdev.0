Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C30E0C77B61
	for <linux-fbdev@archiver.kernel.org>; Fri, 28 Apr 2023 13:35:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346320AbjD1Nft (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 28 Apr 2023 09:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346241AbjD1Nfq (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 28 Apr 2023 09:35:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD662713
        for <linux-fbdev@vger.kernel.org>; Fri, 28 Apr 2023 06:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682688898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T6nMtf6Gzq3uJ6hYj+VP/gNrA7S63KDC0HhAUOQNVRE=;
        b=gevouImo8gMcBuXtWLTQDYtlKd0yJIPyAreB0avSANPV5aJsvkp1cB2+JnuVVMF1+iM1l4
        G9BmMyOxnMOwqDWmh7PG2Isiv+wrhISWkz8RlDOi48IQkvHCOMNWs2SSWEnDjspPCi8VvL
        QQU1KBMUl2KKVkXS9mp4w+LJ5r68WNs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-xZpOOxb9OFKBbHZlMWnBuw-1; Fri, 28 Apr 2023 09:34:55 -0400
X-MC-Unique: xZpOOxb9OFKBbHZlMWnBuw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-2f8b5e23d23so5983583f8f.0
        for <linux-fbdev@vger.kernel.org>; Fri, 28 Apr 2023 06:34:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682688894; x=1685280894;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T6nMtf6Gzq3uJ6hYj+VP/gNrA7S63KDC0HhAUOQNVRE=;
        b=d6vCbrNEuGUzsnTnol013MRMTloj7Z5SmGtMCi1EtrJwkEN6el68UMX/IHr/+3xcne
         eVfRQ5PRILdwQDhkUZHCQgq3Qsphk5I74VE5gantRKimjwBG4U3mgVNrheMBgUzCvK6Y
         XDbxcBRE509ixMIhF+ji/rD86I9/BYhZIZaqXvBCIaazpwiHyytdOxWAfobkXQFhSsw5
         z581ZMd+KPYhuy5p39HMceAcIbJMZfVpma/qHq4UasD4AIhjJ2xXwYLQpTWrlOQ1Q+Zm
         kI3lIt37go8N5TosfkEOp1Ug0WjGZ27gdkrSas43sKZVCWBtfN6E/SjgEWct15EEs69G
         lKpA==
X-Gm-Message-State: AC+VfDwiUtT3ji4htat9lF5z2cH/IPI+I/GnrMMosrz/8L8Cd/IPBglx
        4/+HAJWVkCkjfYNeQLyU00QzLdMBJNjkbs3hoVnLMvQSACpWl73Ub15qVxQ9CQQkogXZItkTYxO
        5R632445zo7UvyxaC0aQ36sI=
X-Received: by 2002:adf:f083:0:b0:2f9:9231:b214 with SMTP id n3-20020adff083000000b002f99231b214mr3957981wro.37.1682688894258;
        Fri, 28 Apr 2023 06:34:54 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5htILUCvMFPMWXFrSmDExwQIMCD2yiZsehHOE5PUQRmEVz2mgVOtPbubjCmOAAGZURFPcYyQ==
X-Received: by 2002:adf:f083:0:b0:2f9:9231:b214 with SMTP id n3-20020adff083000000b002f99231b214mr3957969wro.37.1682688893951;
        Fri, 28 Apr 2023 06:34:53 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id c7-20020a5d4cc7000000b002fa5a73bf9bsm21125421wrt.89.2023.04.28.06.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 06:34:53 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@gmail.com, daniel@ffwll.ch, deller@gmx.de,
        geert@linux-m68k.org, sudipm.mukherjee@gmail.com,
        teddy.wang@siliconmotion.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v2 03/19] hid/hid-picolcd_fb: Use struct
 fb_info.screen_buffer
In-Reply-To: <20230428122452.4856-4-tzimmermann@suse.de>
References: <20230428122452.4856-1-tzimmermann@suse.de>
 <20230428122452.4856-4-tzimmermann@suse.de>
Date:   Fri, 28 Apr 2023 15:34:52 +0200
Message-ID: <87cz3ogmf7.fsf@minerva.mail-host-address-is-not-set>
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

