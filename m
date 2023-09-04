Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B30C83F2C
	for <linux-fbdev@archiver.kernel.org>; Mon,  4 Sep 2023 13:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbjIDNGC (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 4 Sep 2023 09:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbjIDNGB (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 4 Sep 2023 09:06:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040661AD
        for <linux-fbdev@vger.kernel.org>; Mon,  4 Sep 2023 06:05:12 -0700 (PDT)
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-hHKF_KZWPOOoOjTM4khcCA-1; Mon, 04 Sep 2023 09:05:11 -0400
X-MC-Unique: hHKF_KZWPOOoOjTM4khcCA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3172a94b274so813543f8f.0
        for <linux-fbdev@vger.kernel.org>; Mon, 04 Sep 2023 06:05:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693832710; x=1694437510;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JGDuo0fidzIyb7lQTlkFMMjSr0JbZNOTrueOM/c6sEY=;
        b=Fp01bE4+6jc0EGEeEYpXteehE4acpAGwKxKI93dr4xkJZWtEfqa+DaPBFPqQhwu4nR
         dOxBzL6AGcwGNU09KJoOCuF9mYq+L8Bg4365l8nk4FjTgkm7Q8XVv7kH7Z8N4qkhqVOm
         zMmmDoKyrC6O8Y7hUgpaEnblS0S9F+JlY8EW9FMOJonLyLtzInpbVGSFGbHiptSq8L1D
         RlRWCz9MSKWlKgXzHWsNJtz23rMgyv3yQMUiG3UHPr/q/Ow4BPhoGXIx7XWaZAJUvDZS
         bLkyuz4qVdL4gpE9FCGXmBAXrvM0sZJbVFPcn5CstYu3t5dYwsqAx0O8yZsOCzDkrSOo
         0gPw==
X-Gm-Message-State: AOJu0YyPeBUnC0VWynIqGhCLm6q7F0hyuz6+kB1jOImcYM/p/J/YmDTo
        A+5jiJe0E2NqmSojdk/FPEFnzQq/ZSToH32NkYBii396GTgJWhVWQoNXVq+Ykv3bPNtPfTLfdFI
        0Du3o3qRtP0pFalO7YGsisFM=
X-Received: by 2002:a05:6000:1cd:b0:317:5de3:86fb with SMTP id t13-20020a05600001cd00b003175de386fbmr7162727wrx.10.1693832709956;
        Mon, 04 Sep 2023 06:05:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXjVWzCt7e02jUxRGN8dZzdROG6Y6I7k2Dqt3rSE/+w+cQmE9Wq23/UuCwnni8eIyMrEIxCA==
X-Received: by 2002:a05:6000:1cd:b0:317:5de3:86fb with SMTP id t13-20020a05600001cd00b003175de386fbmr7162714wrx.10.1693832709657;
        Mon, 04 Sep 2023 06:05:09 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f7-20020adffcc7000000b0031c7682607asm14485436wrs.111.2023.09.04.06.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 06:05:09 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de,
        daniel@ffwll.ch, sam@ravnborg.org
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-staging@lists.linux.dev, linux-hyperv@vger.kernel.org,
        linux-input@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Bernie Thompson <bernie@plugable.com>
Subject: Re: [PATCH 2/8] fbdev/udlfb: Use fb_ops helpers for deferred I/O
In-Reply-To: <20230828132131.29295-3-tzimmermann@suse.de>
References: <20230828132131.29295-1-tzimmermann@suse.de>
 <20230828132131.29295-3-tzimmermann@suse.de>
Date:   Mon, 04 Sep 2023 15:05:08 +0200
Message-ID: <874jka6qd7.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Generate callback functions for struct fb_ops with the fbdev macro
> FB_GEN_DEFAULT_DEFERRED_SYSMEM_OPS(). Initialize struct fb_ops to
> the generated functions with fbdev initializer macros.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Bernie Thompson <bernie@plugable.com>
> ---

Acked-by: Javier Martinez Canillas <javierm@redhat.com>

[...]

> +static void dlfb_ops_damage_range(struct fb_info *info, off_t off, size_t len)
> +{
> +	struct dlfb_data *dlfb = info->par;
> +	int start = max((int)(off / info->fix.line_length), 0);
> +	int lines = min((u32)((len / info->fix.line_length) + 1), (u32)info->var.yres);
> +
> +	dlfb_handle_damage(dlfb, 0, start, info->var.xres, lines);
> +}
> +
> +static void dlfb_ops_damage_area(struct fb_info *info, u32 x, u32 y, u32 width, u32 height)
> +{
> +	struct dlfb_data *dlfb = info->par;
> +
> +	dlfb_offload_damage(dlfb, x, y, width, height);
> +}
> +

These two are very similar to the helpers you added for the smscufx driver
in patch #1. I guess there's room for further consolidation as follow-up ?

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

