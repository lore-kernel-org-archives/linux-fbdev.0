Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21E4C77B60
	for <linux-fbdev@archiver.kernel.org>; Fri, 28 Apr 2023 13:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346108AbjD1Ne4 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 28 Apr 2023 09:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346213AbjD1Nez (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 28 Apr 2023 09:34:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7543AB2
        for <linux-fbdev@vger.kernel.org>; Fri, 28 Apr 2023 06:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682688847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T6nMtf6Gzq3uJ6hYj+VP/gNrA7S63KDC0HhAUOQNVRE=;
        b=dyjrnHwdHvgVpocIedEwhl4V2+DbB0WQM8RAYxRtJIWvnxQ4MULoAletM/QqLatNcn5XF9
        er+AIW/4QWb3drWRuBboao4rmeyOBcRRTqK3e6hfFIhbCtc/mDF5KkjE7JpoIz4PX8Y7V3
        oGsqN4WmBLe1PsLDb0fmUEzJgwv1rjQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-36-vFdFKR_mOmyIc5noKvvFdA-1; Fri, 28 Apr 2023 09:34:05 -0400
X-MC-Unique: vFdFKR_mOmyIc5noKvvFdA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f170a1fbe7so61425325e9.2
        for <linux-fbdev@vger.kernel.org>; Fri, 28 Apr 2023 06:34:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682688844; x=1685280844;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T6nMtf6Gzq3uJ6hYj+VP/gNrA7S63KDC0HhAUOQNVRE=;
        b=LwGSwwy2HuMB6sWApia+9SVB3NpcU3TnfUaCnh4+Z+s+Ism36mmyA9ghkj+oBOMrCz
         wOgugkrfJYJsscp6WInlveTsYNdh6wRzmojXhFK2Ip43mGZ/q1gycwPDy5mcDB+5Tu6W
         FUIoN6Y9/g7uBVxbG0rQWisaQITCsfduSxfUS6PYyEPLI0OrCh19ceOmu8VPmVNbXj+T
         IAluUx5drZAWOtoZoOk1kSiTd0Uo80KGQb6ptOhCNR0sf1D0PbSgC5GWPrZscLqHMD69
         nEQXZdUnASiJK/v7lX5Asy+DOcjxUX6N79xpGeVxDKP6HFBRLkOQqY6afQK5hrv8fPn8
         qbow==
X-Gm-Message-State: AC+VfDz1lDKhClC5Ft425XVZtebWFrKumZmlVwRSCk1aEW07pG7Pg+S4
        e8EhRA1vE7lBIQSIKgC3f9dlSZHBQxBUJIN/40WjpfsIW2pO5Y+TJY9SYcFUYwdjCJKgq9uGI68
        y9Vd8WaV+16LTuPAhvaQDV1M=
X-Received: by 2002:a05:600c:257:b0:3f1:6ead:e389 with SMTP id 23-20020a05600c025700b003f16eade389mr4088063wmj.30.1682688844480;
        Fri, 28 Apr 2023 06:34:04 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6APGvdtm/YP9mNCQTuu7xjUKb4lnkET42/qbhnzhp0iz8vor0r5uUclqXdzyG09R3eF09kYQ==
X-Received: by 2002:a05:600c:257:b0:3f1:6ead:e389 with SMTP id 23-20020a05600c025700b003f16eade389mr4088048wmj.30.1682688844182;
        Fri, 28 Apr 2023 06:34:04 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f25-20020a7bc8d9000000b003f0b1b8cd9bsm24470014wml.4.2023.04.28.06.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 06:34:03 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@gmail.com, daniel@ffwll.ch, deller@gmx.de,
        geert@linux-m68k.org, sudipm.mukherjee@gmail.com,
        teddy.wang@siliconmotion.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v2 02/19] auxdisplay/ht16k33: Use struct
 fb_info.screen_buffer
In-Reply-To: <20230428122452.4856-3-tzimmermann@suse.de>
References: <20230428122452.4856-1-tzimmermann@suse.de>
 <20230428122452.4856-3-tzimmermann@suse.de>
Date:   Fri, 28 Apr 2023 15:34:03 +0200
Message-ID: <87fs8kgmgk.fsf@minerva.mail-host-address-is-not-set>
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

