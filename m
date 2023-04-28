Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE55C77B60
	for <linux-fbdev@archiver.kernel.org>; Fri, 28 Apr 2023 15:15:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjD1PPH (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 28 Apr 2023 11:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjD1PPG (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 28 Apr 2023 11:15:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF41859DC
        for <linux-fbdev@vger.kernel.org>; Fri, 28 Apr 2023 08:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682694857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CtuyV//oUjSwLm+8sbTRXQA1ElJkX8KhmdItyI9uBhU=;
        b=c1AQXJx8T+QcBneRhZDnW28tTg6fH8YuI7WM4DXSaafKM6fb2M//bYfxwPP3VeiLkjuQgZ
        rmbYuEpN4CJ/BxkECyhmook8j9c5lQkgmgiWfWk1GrDqDWVltgE3n8V7HNwvSSF88mHVZm
        Niexd6qQpQGs1XLngd6Owh1fEj4XVzc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519--AHKaxO4M66OU4TdrurS0Q-1; Fri, 28 Apr 2023 11:13:50 -0400
X-MC-Unique: -AHKaxO4M66OU4TdrurS0Q-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-2f446161e5aso6064189f8f.1
        for <linux-fbdev@vger.kernel.org>; Fri, 28 Apr 2023 08:13:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682694810; x=1685286810;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CtuyV//oUjSwLm+8sbTRXQA1ElJkX8KhmdItyI9uBhU=;
        b=PYd4mEBNqc2p29UfepdKZRsNw8cEy+K48OMlN05iZukVpwy/RV0jA7zhyaEumuW5wR
         ABSyfSP4Zw+zGfxgl0jayNPsfEA3tARbWuDzyHNHOMZ4UwACt+S/HB+wF4zAf0GDoWSl
         5gmIUmDwHi4U4vpjz4duknga3d0xc8nUsJFjOG0dSadu9aQjGUQEmFVs4xGZuVqEZzhU
         nBR2rRGxEpGSq2sVZH2hP5vxWPpMa6csPR2Tj3tO+4tu9LlohPWdBnVyC+Gg9ESZVDKJ
         2w7VW22NN+iNQGzW0ST4fU142cGUMuKVhpIZn7lPesckF2PXiXCtnAcUWpV82JJkL3np
         wt2g==
X-Gm-Message-State: AC+VfDx4ogyXxqzo7UAJReOwXoR66ZShDUIoXaHwXgDd0CX7ePqQguNB
        +krtU4IV3PdIyTsrlVZL2LTxWWTpE4BKynuA2yUMR9upgfiMvIrZgmiiK0MNj052AToQMG5X7jx
        qgrjqrkJSfPx0JxtV5P04eik=
X-Received: by 2002:adf:ead0:0:b0:2f8:24f7:cc4a with SMTP id o16-20020adfead0000000b002f824f7cc4amr4133292wrn.57.1682694810231;
        Fri, 28 Apr 2023 08:13:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ67wwp6HF/HWcvyhUopIWNpcf97IrzpNeWwcGIERxbIXZRLrRielx1u31rlCkwTnYtHxiDZOA==
X-Received: by 2002:adf:ead0:0:b0:2f8:24f7:cc4a with SMTP id o16-20020adfead0000000b002f824f7cc4amr4133269wrn.57.1682694809932;
        Fri, 28 Apr 2023 08:13:29 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id p10-20020a1c544a000000b003f03d483966sm28021876wmi.44.2023.04.28.08.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 08:13:29 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@gmail.com, daniel@ffwll.ch, deller@gmx.de,
        geert@linux-m68k.org, sudipm.mukherjee@gmail.com,
        teddy.wang@siliconmotion.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v2 13/19] fbdev/xen-fbfront: Use struct
 fb_info.screen_buffer
In-Reply-To: <20230428122452.4856-14-tzimmermann@suse.de>
References: <20230428122452.4856-1-tzimmermann@suse.de>
 <20230428122452.4856-14-tzimmermann@suse.de>
Date:   Fri, 28 Apr 2023 17:13:28 +0200
Message-ID: <87ildgf3af.fsf@minerva.mail-host-address-is-not-set>
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
> .screen_base and .screen_buffer must be used instead.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

