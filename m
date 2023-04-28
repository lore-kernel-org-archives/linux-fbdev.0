Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA16C77B61
	for <linux-fbdev@archiver.kernel.org>; Fri, 28 Apr 2023 14:32:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjD1OcX (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 28 Apr 2023 10:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjD1OcX (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 28 Apr 2023 10:32:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D1B3C20
        for <linux-fbdev@vger.kernel.org>; Fri, 28 Apr 2023 07:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682692295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T6nMtf6Gzq3uJ6hYj+VP/gNrA7S63KDC0HhAUOQNVRE=;
        b=avHzSlayKi9IllRZx3NuUeE2fL+ihfarAaYX0ez6dVxgnXhv7KuSW27BnHpNGJ3iNerbPH
        tHhDjNzeQxfcuc5WpdIv/vyS69n8qskh+iOKoedUn2T5V8XaZW3J4HtIYBnLPiUpgB97j8
        6wasYyQrUseOWOhDw5b4DSnWZ2+E7+Y=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-Stu1u_zCMxGdBP7zoETCYw-1; Fri, 28 Apr 2023 10:31:33 -0400
X-MC-Unique: Stu1u_zCMxGdBP7zoETCYw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f315735edeso41805665e9.1
        for <linux-fbdev@vger.kernel.org>; Fri, 28 Apr 2023 07:31:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682692292; x=1685284292;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T6nMtf6Gzq3uJ6hYj+VP/gNrA7S63KDC0HhAUOQNVRE=;
        b=CBBSuVpoQuuhniM9Ea41fB7O0MSUm0YyRxjy3jK4fNHKAOgU7is0uYMNFxu6swNz5z
         +7xnGl+P9c52/HxsyJUR6W5NB0vWwwj8brpYMkKmLfUuywMQg3J1Vrhyl9YEAQqvcycF
         AkV7N2srAtstI9dpUIYd1vIe/lLjToldVA9i/LbPrrK+60o/l7+oYX8DpuwGKgXB1sPs
         HdncF9THqo+KxbP9kQrYbtAnvE32TozMpm5azq1tJDBWkpI6nwcQxKgfIi/+wKXiOOZK
         exjWIcjsVbk/Tg4x25jMpYhqtUBEsYT8ENYXc2/KKhzrNg47/gCXM1kwSVP2TBi9EctB
         w1EA==
X-Gm-Message-State: AC+VfDwdqhzdTF8w/hllILV3MB9/i5z/D7saja2FBHjbrHgosFirtaeY
        XVJnPKcFv/Ak2lRX3uEJQxZLSup9svFBZ7mVy5Ijb/uC7LoP9NR1lSUdOOQlR84iic0yTKlPPPp
        vOsr3heIQxPN5+AlI67Eyu5o=
X-Received: by 2002:a05:600c:378e:b0:3f1:65cb:8156 with SMTP id o14-20020a05600c378e00b003f165cb8156mr3964487wmr.0.1682692292496;
        Fri, 28 Apr 2023 07:31:32 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4muiSR8Tdhi6QJG9j+lv9oeqIiugsfDwxBycG/oNh6nECXC9yJkPiL5Ke6E4x/Ylci6N3S/w==
X-Received: by 2002:a05:600c:378e:b0:3f1:65cb:8156 with SMTP id o14-20020a05600c378e00b003f165cb8156mr3964469wmr.0.1682692292241;
        Fri, 28 Apr 2023 07:31:32 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id u3-20020a7bcb03000000b003f16f3cc9fcsm24600054wmj.9.2023.04.28.07.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 07:31:31 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@gmail.com, daniel@ffwll.ch, deller@gmx.de,
        geert@linux-m68k.org, sudipm.mukherjee@gmail.com,
        teddy.wang@siliconmotion.com
Cc:     linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 06/19] fbdev/broadsheetfb: Use struct
 fb_info.screen_buffer
In-Reply-To: <20230428122452.4856-7-tzimmermann@suse.de>
References: <20230428122452.4856-1-tzimmermann@suse.de>
 <20230428122452.4856-7-tzimmermann@suse.de>
Date:   Fri, 28 Apr 2023 16:31:31 +0200
Message-ID: <874jp0gjss.fsf@minerva.mail-host-address-is-not-set>
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

