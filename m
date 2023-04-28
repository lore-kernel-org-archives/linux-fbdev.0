Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BCEAC77B61
	for <linux-fbdev@archiver.kernel.org>; Fri, 28 Apr 2023 14:33:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjD1OdV (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 28 Apr 2023 10:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjD1OdU (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 28 Apr 2023 10:33:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617AF26A5
        for <linux-fbdev@vger.kernel.org>; Fri, 28 Apr 2023 07:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682692355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T6nMtf6Gzq3uJ6hYj+VP/gNrA7S63KDC0HhAUOQNVRE=;
        b=a2fkmK5spHeu6FU9oF8vLRJK6Vh9OgquhMeB2LULFjFzRcXytsns7ksYlftN/ZQlEUbBoR
        35XXmOjMsXP35NCJUFJRIh8+Bu/FedqOY1qDS6Bp/WvPzGlkEYBL4Mx6QBab8ekv2H+65g
        2yFE6r+/QeCAnb6GeR+hrGDG7LTaYMg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-_2UxYxVZMEGiTHz5IV7ggQ-1; Fri, 28 Apr 2023 10:32:10 -0400
X-MC-Unique: _2UxYxVZMEGiTHz5IV7ggQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f08900cad7so38491345e9.3
        for <linux-fbdev@vger.kernel.org>; Fri, 28 Apr 2023 07:32:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682692327; x=1685284327;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T6nMtf6Gzq3uJ6hYj+VP/gNrA7S63KDC0HhAUOQNVRE=;
        b=Y6By21oK9kYHbs/OCHLL/U8kwgwX6htrrLskwJFisEUhc9LAss2etV2y0gITiJFF3/
         8DRDNj4EfdGC7cLtxxRZHl9T2REw5esh6+xQLoYEq8Zhh81ue6WdBs2iSEU110AsHqkr
         va5/bB9Q5vtyLJuU+zzP/qqjSyOqKThMosZZjr74e8bK2x4mDjXgtRux3vY80+mK/oTX
         3QfYO+0BGeGLMGOi/dLMskywW9XNPsYZN61oiqZVwrR30cvRARzkvKv4bmk+UOVFRkU2
         Er44r0HFHG+LV1+o9c1iKZcrqGV3fScb3YDfH2X0zz3yTKLiyhm1oeiFrJdjbwT6b4na
         S3qg==
X-Gm-Message-State: AC+VfDzkNOIt188nSQMGlsM4Mg+YxMPt76cyzgOoQqwUjB4I8Vd0+PqJ
        pFD6Pi0Zc68DgXOuBccBP6RFQki0DnpVxwEPOFt7Z6IBGob83J0B4aNfVGn/0sCQ3EZTFJxCY2T
        TyUwx+dImOFFgs6iJqh/VDh4=
X-Received: by 2002:a1c:7502:0:b0:3ed:88f5:160a with SMTP id o2-20020a1c7502000000b003ed88f5160amr4234515wmc.11.1682692327543;
        Fri, 28 Apr 2023 07:32:07 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6QwXnjgMravkmyjGU380q1EMostTJ3ocVKQHTXqvI7txqSAd4DxPGTwQhDuUSXMyhPd4gnAQ==
X-Received: by 2002:a1c:7502:0:b0:3ed:88f5:160a with SMTP id o2-20020a1c7502000000b003ed88f5160amr4234490wmc.11.1682692327225;
        Fri, 28 Apr 2023 07:32:07 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f15-20020a7bcd0f000000b003f182cc55c4sm24510462wmj.12.2023.04.28.07.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 07:32:06 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@gmail.com, daniel@ffwll.ch, deller@gmx.de,
        geert@linux-m68k.org, sudipm.mukherjee@gmail.com,
        teddy.wang@siliconmotion.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v2 07/19] fbdev/hecubafb: Use struct fb_info.screen_buffer
In-Reply-To: <20230428122452.4856-8-tzimmermann@suse.de>
References: <20230428122452.4856-1-tzimmermann@suse.de>
 <20230428122452.4856-8-tzimmermann@suse.de>
Date:   Fri, 28 Apr 2023 16:32:06 +0200
Message-ID: <871qk4gjrt.fsf@minerva.mail-host-address-is-not-set>
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

