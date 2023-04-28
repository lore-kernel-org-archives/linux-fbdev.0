Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 946A3C77B61
	for <linux-fbdev@archiver.kernel.org>; Fri, 28 Apr 2023 14:37:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjD1Ohb (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 28 Apr 2023 10:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjD1Oh3 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 28 Apr 2023 10:37:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0462696
        for <linux-fbdev@vger.kernel.org>; Fri, 28 Apr 2023 07:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682692602;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T6nMtf6Gzq3uJ6hYj+VP/gNrA7S63KDC0HhAUOQNVRE=;
        b=Beu0NBWFC2FSNEE9r/wl11LPiw6q2cWuahaUm3fh7UT+5oegazeNoLrcgBcipqle6XyTfw
        vulhwLbddnVBJmaThjjJCs0Cx0Chlm0IfVT6sXs6GHrWH6aF0vGN0x2B9OxBhcWZBfY8Kh
        JGoVuxo9RVTsQdSzVJO1wxJrXRMRVus=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-3JHEImXVPLaORzDqWXIlrw-1; Fri, 28 Apr 2023 10:36:37 -0400
X-MC-Unique: 3JHEImXVPLaORzDqWXIlrw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f08901fed3so62106965e9.1
        for <linux-fbdev@vger.kernel.org>; Fri, 28 Apr 2023 07:36:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682692596; x=1685284596;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T6nMtf6Gzq3uJ6hYj+VP/gNrA7S63KDC0HhAUOQNVRE=;
        b=YrnVvz4nLbcFaQ6NQwxQ5iP86SL8TGggzZcn8Hx8gcE5aFEgPQSrsWewJzZub2JT2J
         CP9Dl6AxHlNEfe0el24vWDaeUkxs3oxnDks4PQ3Jya9nDApz2kg4bkSWxkpjabqkNeD7
         D0v46sFLfIWXXN2QJHBDL5IJqJf5P/U10q1FCiAzfPqkLhPS1yOdPZNGtRXNXWG7LAcC
         jpfUcXI51tVGDo3fROd5wXyCSVkm4TJ0hy+jRSN+x1WP6tXzDSxscySvAi3v1ZZD0Q6H
         +ln0GQfF3XukKRP7oRG74AI62YR1OPaMipwatOUeV2WLcsOG8E1vVKOCEHSJv3+SvNBW
         g8rg==
X-Gm-Message-State: AC+VfDyN3YU3lvQo/kxv6NA3VdmzcUaMAdleT869RjfkQuBwIVUoab/+
        yzvzsVFuoQWI8JVAGrvQKPMf1KXS39mh8fQHmISDr5FBK4VVtFtUUr7hbt9wqlMCw5YU/nQRh5b
        gKpuWwoCjpzNKePK9kfYZSOk=
X-Received: by 2002:a1c:6a17:0:b0:3f1:9526:22da with SMTP id f23-20020a1c6a17000000b003f1952622damr4450146wmc.22.1682692596764;
        Fri, 28 Apr 2023 07:36:36 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4cjArnef9mZsKEH3jPnyFnZCmADiwtxf0nZtArDeKyxV2DJyORFUASBpraAxflr4enI4hCvQ==
X-Received: by 2002:a1c:6a17:0:b0:3f1:9526:22da with SMTP id f23-20020a1c6a17000000b003f1952622damr4450121wmc.22.1682692596395;
        Fri, 28 Apr 2023 07:36:36 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id u15-20020a5d468f000000b002f5fbc6ffb2sm21220121wrq.23.2023.04.28.07.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 07:36:36 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@gmail.com, daniel@ffwll.ch, deller@gmx.de,
        geert@linux-m68k.org, sudipm.mukherjee@gmail.com,
        teddy.wang@siliconmotion.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v2 08/19] fbdev/metronomefb: Use struct
 fb_info.screen_buffer
In-Reply-To: <20230428122452.4856-9-tzimmermann@suse.de>
References: <20230428122452.4856-1-tzimmermann@suse.de>
 <20230428122452.4856-9-tzimmermann@suse.de>
Date:   Fri, 28 Apr 2023 16:36:34 +0200
Message-ID: <87y1mcf4zx.fsf@minerva.mail-host-address-is-not-set>
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

