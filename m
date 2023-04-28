Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DAD7C77B60
	for <linux-fbdev@archiver.kernel.org>; Fri, 28 Apr 2023 14:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjD1O1x (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 28 Apr 2023 10:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjD1O1w (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 28 Apr 2023 10:27:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3251BEE
        for <linux-fbdev@vger.kernel.org>; Fri, 28 Apr 2023 07:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682692035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T6nMtf6Gzq3uJ6hYj+VP/gNrA7S63KDC0HhAUOQNVRE=;
        b=H4xyBHUJRsIIopL17r8q9oy2xLsFg7MVKTuBdeOmo+T5rQ/yCYW7orvlI+CeXGu29Kn1ea
        FelXlXLDs/CPyjPSj59at56Khvofx4VffAZImz6dWnXK8vtzCASQflQRP1Mh378JxgFZUJ
        NOo3DY3jnQrd+G/OB98UFwh/NfCUkAQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-248-b2E57tmzP2iUQJGu1X5O_w-1; Fri, 28 Apr 2023 10:27:12 -0400
X-MC-Unique: b2E57tmzP2iUQJGu1X5O_w-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-2f43679bcf5so5940316f8f.1
        for <linux-fbdev@vger.kernel.org>; Fri, 28 Apr 2023 07:27:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682692031; x=1685284031;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T6nMtf6Gzq3uJ6hYj+VP/gNrA7S63KDC0HhAUOQNVRE=;
        b=cr6ORmzZJQryDahxQlUbxe6T06LV10SFHrKDW+3raWv7iZpEcJwfm5682gOa8ybt/i
         56sPJAsqsjKxtiA30eSosIOaueUnTInpGodPWW9rPH3Y0PSZW+1qBpYrynDDSlkEdx0r
         3yqT9Z9R4uwgnzsGptOQGr836k/JtdlysWRDqTUVOIpMxrLSrVr0BVYv795WmPREFWKm
         VPTDNc/lfvB3KMHsF5ZnSqDVLKFeVXmpH832dejmXNVfy3I/SWmDYGcsdIyHP7+sMQK7
         ZOMsC0k3qXtJ2Q1iOkPZPSV9J9+R8YrRta1k1UjOCbnpU3jCqD/iBultMWU1oZBSnQiC
         DsUQ==
X-Gm-Message-State: AC+VfDwhuy7i6Mx+4tEM29E95zC4AvwOsYbiCUGUGcxIbEJNJ195hNce
        hgE4AC7cDZjDaer4zdVDg41GRaTtr9FJKyGWVKzwKxYHQ+kl66AjBhhD8wMoJ3+fBBvbHu18PjH
        LMOlDARAOo489sZwwejaysHU=
X-Received: by 2002:adf:f810:0:b0:2c5:5a65:79a0 with SMTP id s16-20020adff810000000b002c55a6579a0mr4391331wrp.53.1682692030863;
        Fri, 28 Apr 2023 07:27:10 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6SrnpwcaTYOywstWBue2E99v9XRtq5SQQKVfxAHqBZBI0YeI6o+i4KonyzhoKKhmbKGMmicw==
X-Received: by 2002:adf:f810:0:b0:2c5:5a65:79a0 with SMTP id s16-20020adff810000000b002c55a6579a0mr4391318wrp.53.1682692030550;
        Fri, 28 Apr 2023 07:27:10 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id i1-20020a05600011c100b002cff06039d7sm21148541wrx.39.2023.04.28.07.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 07:27:10 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@gmail.com, daniel@ffwll.ch, deller@gmx.de,
        geert@linux-m68k.org, sudipm.mukherjee@gmail.com,
        teddy.wang@siliconmotion.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v2 05/19] fbdev/au1200fb: Use struct fb_info.screen_buffer
In-Reply-To: <20230428122452.4856-6-tzimmermann@suse.de>
References: <20230428122452.4856-1-tzimmermann@suse.de>
 <20230428122452.4856-6-tzimmermann@suse.de>
Date:   Fri, 28 Apr 2023 16:27:08 +0200
Message-ID: <877ctwgk03.fsf@minerva.mail-host-address-is-not-set>
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

