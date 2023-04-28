Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C89DFC77B60
	for <linux-fbdev@archiver.kernel.org>; Fri, 28 Apr 2023 15:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346154AbjD1PKn (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 28 Apr 2023 11:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346338AbjD1PKm (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 28 Apr 2023 11:10:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60D5527E
        for <linux-fbdev@vger.kernel.org>; Fri, 28 Apr 2023 08:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682694574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CtuyV//oUjSwLm+8sbTRXQA1ElJkX8KhmdItyI9uBhU=;
        b=Shj4BF+1slyKSMfxntolouHZAe2uiI8Y/KShDTfzoYxjp0NsYWrBOCxf9s4+gO4L4dzCNM
        wNqI2f02b0er7XW5oCfXL64Xb1m5hMBPWnxjmtOoahdn/CI756jHmWQ0ErLlZmgmswaGN/
        YBNRJWvssaGNCY+M9ubhsI3ouSCI9cA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-7QccIgdZMVWAo3ZVBiPaJA-1; Fri, 28 Apr 2023 11:08:47 -0400
X-MC-Unique: 7QccIgdZMVWAo3ZVBiPaJA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-2f8b5e23d23so6055695f8f.0
        for <linux-fbdev@vger.kernel.org>; Fri, 28 Apr 2023 08:08:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682694516; x=1685286516;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CtuyV//oUjSwLm+8sbTRXQA1ElJkX8KhmdItyI9uBhU=;
        b=SzDGWDQD69aUi5+4a9L1N/DRfSZ/+9EGJUIdfbfdjh+Bmb1LmdRl9svO2kvAN1De8v
         uEo+i+rcu1Qe3lKllatkE/5mJU21fkOzdofU8DdoDWL6VPTbUmj2LqQZVYosU7B6rUWp
         00yNzin1/fMu6ZrLkJW7ftwgt0unCki4hoO2XQxPFjB8H2ovbCv9svBuUks3LtP1/55C
         4Rs4mlbUKUwQ5I3U9WqrPo4pqcRhOIV6NVH4KOAxKtzya+FoLvW9htpA6SvnH0jiiMDb
         nET6s9xTH+1uI+7R5T8v1YY4hJfiJh7TdvHNTxp8ebR768LzpotJfRV3fwKcoBr6GP+m
         FaAg==
X-Gm-Message-State: AC+VfDw+pJ6TvHJ4mf2N2BBpMRs9QmYDJuuBYFWHh+dpOxuIiuIWbFfc
        WQsgncIzTZ25xAB9ym6mK93rFOWbkIbjCGnVH75Mk+m7F1zEOLN37wDjv8NI2gy3Es4zXtucbrw
        jorag4ZdNElmUPeEVeSwqI9U=
X-Received: by 2002:adf:f9cd:0:b0:300:cb8c:fd8f with SMTP id w13-20020adff9cd000000b00300cb8cfd8fmr4303850wrr.54.1682694516516;
        Fri, 28 Apr 2023 08:08:36 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5FgJceQYz2SY41hmwVKRoPDdwpglz9z+P8bHRPnmCN2iLhJTTykty1Ty35JpjNffWOYwatQA==
X-Received: by 2002:adf:f9cd:0:b0:300:cb8c:fd8f with SMTP id w13-20020adff9cd000000b00300cb8cfd8fmr4303836wrr.54.1682694516221;
        Fri, 28 Apr 2023 08:08:36 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id k5-20020adff5c5000000b002f103ca90cdsm21275148wrp.101.2023.04.28.08.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 08:08:35 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@gmail.com, daniel@ffwll.ch, deller@gmx.de,
        geert@linux-m68k.org, sudipm.mukherjee@gmail.com,
        teddy.wang@siliconmotion.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v2 10/19] fbdev/smscufx: Use struct fb_info.screen_buffer
In-Reply-To: <20230428122452.4856-11-tzimmermann@suse.de>
References: <20230428122452.4856-1-tzimmermann@suse.de>
 <20230428122452.4856-11-tzimmermann@suse.de>
Date:   Fri, 28 Apr 2023 17:08:34 +0200
Message-ID: <87r0s4f3il.fsf@minerva.mail-host-address-is-not-set>
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

