Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C5F3C6FD18
	for <linux-fbdev@archiver.kernel.org>; Tue, 25 Apr 2023 16:17:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234299AbjDYQRE (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 25 Apr 2023 12:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234192AbjDYQRD (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 25 Apr 2023 12:17:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF7F17A06
        for <linux-fbdev@vger.kernel.org>; Tue, 25 Apr 2023 09:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682439356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=47bgQGNaAeyNGSWS0q1PeP54wI3Fkx9tJmtH4n0GuFg=;
        b=ZC/H8+8s7SR8gVGwFMTK7EpN4M2kfd3V+p9fAhG+TOVPlKs28BUASIHKXEICxt/Lbszd3X
        CHO9lVaBqjDMsvs4C3r3fkAmcoOdOnBPbG+I6wu7jFRgm0O8JtYlnEsdNX/92f4cOmdhxP
        f6xr2P5WGMR9Nah0cOavUg872jFCqo0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-2r5iB6viNLqzfUnrJpI_-Q-1; Tue, 25 Apr 2023 12:15:54 -0400
X-MC-Unique: 2r5iB6viNLqzfUnrJpI_-Q-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f080f46fb1so23042175e9.0
        for <linux-fbdev@vger.kernel.org>; Tue, 25 Apr 2023 09:15:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682439353; x=1685031353;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=47bgQGNaAeyNGSWS0q1PeP54wI3Fkx9tJmtH4n0GuFg=;
        b=eJSPsoxNg36HuGAOsMQu0rmlW7ipPxETSm9ubllc0PGNYOySs8VLl0kLyzm76v2zpR
         K74BR+ay6KCA3ivyM0H6bycDX/wufjrv/H+PrOvi8ge+FfkPiNYVoDK6lP2IIxjf/n6J
         F0T52C4P9SgcgI+tMVjFxecuwhnon6Rm8kjRSCSupcn/KAsvv3JVRFUv2FTo9bs+uLs6
         645PRdcLOcnE7cYoEUqNf82hbyVXv3vyv+JCbYxj/eQoDi407HWR9+WeaG9zrmEHvzqN
         2OiNXtf84HmUYtw2N1v0RgPR/fNmR7n8/O26nEXRY5ScVktladZE1Bl0JwusxYkQLD/c
         zzVA==
X-Gm-Message-State: AAQBX9e3fz8Nw3TMdCyqevE5e8ms2AeV3pGFcGNJuLIy73K0rpDglXFg
        lFf95p8YSC4RRziCBHfF8dtBllrezK4sVQoH/USQALZcpLkigvZGuHpFPJ+BPgzIavA3yBoIqXo
        dVVle3VAcE2IIJxKkGsoOZbo=
X-Received: by 2002:a7b:cbd9:0:b0:3f1:952c:3c70 with SMTP id n25-20020a7bcbd9000000b003f1952c3c70mr9182240wmi.40.1682439353130;
        Tue, 25 Apr 2023 09:15:53 -0700 (PDT)
X-Google-Smtp-Source: AKy350adQEgL49wdb4ewQxdOYjifakCtfNmKUN8mm6DOnvjtC92yIJd9uc8+68p+F4VuT8mXExb5Qg==
X-Received: by 2002:a7b:cbd9:0:b0:3f1:952c:3c70 with SMTP id n25-20020a7bcbd9000000b003f1952c3c70mr9182227wmi.40.1682439352792;
        Tue, 25 Apr 2023 09:15:52 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id r3-20020a05600c35c300b003f1836c98b7sm16560874wmq.48.2023.04.25.09.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 09:15:52 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@gmail.com, daniel@ffwll.ch, deller@gmx.de,
        geert@linux-m68k.org, sudipm.mukherjee@gmail.com,
        teddy.wang@siliconmotion.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 1/6] fbdev: Return number of bytes read or written
In-Reply-To: <20230425142846.730-2-tzimmermann@suse.de>
References: <20230425142846.730-1-tzimmermann@suse.de>
 <20230425142846.730-2-tzimmermann@suse.de>
Date:   Tue, 25 Apr 2023 18:15:51 +0200
Message-ID: <87cz3shr9k.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

Hello Thomas,

> Always return the number of bytes read or written within the
> framebuffer. Only return an errno code if framebuffer memory
> was not touched. This is the semantics required by POSIX and
> makes fb_read() and fb_write() compatible with IGT tests. [1]
>
> This bug has been fixed for fb_write() long ago by
> commit 6a2a88668e90 ("[PATCH] fbdev: Fix return error of
> fb_write"). The code in fb_read() and the corresponding fb_sys_()
> helpers was forgotten.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Link: https://gitlab.freedesktop.org/drm/igt-gpu-tools/-/blob/master/tests/fbdev.c # 1
> ---

The patch looks good to me and indeed the correct semantics AFAICT.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

