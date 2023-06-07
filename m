Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC81C7EE29
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Jun 2023 07:36:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238673AbjFGHgN (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 7 Jun 2023 03:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234355AbjFGHfu (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 7 Jun 2023 03:35:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79FA3599
        for <linux-fbdev@vger.kernel.org>; Wed,  7 Jun 2023 00:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686123065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=86qJ/vtJ5+0COg+eCE9cC1XNW8WWzhrqJj3XV1HnHmU=;
        b=eutFc05yk/Z/4gcAr0HUljR5RGI9kWOtl1Ck3+WTfNmMhiobHeaGUAA25TO7fnxjYaMoA+
        F31ZDbPFgLrC0AaKv7ATxyv9+POuV8oe3O42MBun5l5RS31b9brehLh0peI4v9dbw8C7Ra
        Bd69eQDQmoHF5hIGiFIwWjT2OWWMTNs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-CpVtWrdJMQuiNg-xIXROSQ-1; Wed, 07 Jun 2023 03:31:02 -0400
X-MC-Unique: CpVtWrdJMQuiNg-xIXROSQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f5df65f9f4so33536305e9.2
        for <linux-fbdev@vger.kernel.org>; Wed, 07 Jun 2023 00:31:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686123061; x=1688715061;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=86qJ/vtJ5+0COg+eCE9cC1XNW8WWzhrqJj3XV1HnHmU=;
        b=PTQRvwsrFtm2XqupDQKJCBfvuHGbMHrnjmTKpIOH4UhkxEqjfgaKyIQIrsB9zObsXZ
         I+U2IcmuR1HcwPn3N8YyDnT7fEktd7JKj5lXj9oGAvzKawYAFw4WVX3bmkk2aiN+ZZ3A
         hRQOMnaJiD220tgUWjNSn8GhCn9BDMaG8KX7gyeTu00AnDMsthT2iEoeQM1RBQtsx7JS
         A3EPqOqaapqazbB3iUf6Fd/iFapMZKOqAKr8QBm7N1xS41Qg3NgwRjgNEFyevPecye8i
         AuppREWadGhV1Eod40k7ZG+IzTIda1AUPJliDqRPYOf6068yoU13hK3nVhlaURFTKxeJ
         SXRA==
X-Gm-Message-State: AC+VfDyM/EJeL1v3euiklHrpcJ1m5b8T1Gn//GSZL8vqgz7rz4e8zD6e
        w1KWaqH/QM4OIrRkJIAtUbhl0M2OB8kezouWpcAV8y9/BmaWfsxSZbDa5CWxKX/qWNPu4qLT7ck
        oEYP2+X6Uo6DwHHxQ2DA85Do=
X-Received: by 2002:a05:600c:2117:b0:3f4:2328:b5c2 with SMTP id u23-20020a05600c211700b003f42328b5c2mr3787346wml.35.1686123060796;
        Wed, 07 Jun 2023 00:31:00 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5uGo6zRkvpQ5estM3pdndUe5o7FAstx3xMsdIS0ZhyvoEoxkSKZkfhbKkJxPjpvFo09QUYlQ==
X-Received: by 2002:a05:600c:2117:b0:3f4:2328:b5c2 with SMTP id u23-20020a05600c211700b003f42328b5c2mr3787327wml.35.1686123060473;
        Wed, 07 Jun 2023 00:31:00 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id y6-20020a7bcd86000000b003f4ddde398csm1142560wmj.21.2023.06.07.00.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 00:31:00 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        sam@ravnborg.org, deller@gmx.de, geert+renesas@glider.be,
        lee@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sh@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-staging@lists.linux.dev,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 01/30] backlight/bd6107: Compare against struct
 fb_info.device
In-Reply-To: <20230605144812.15241-2-tzimmermann@suse.de>
References: <20230605144812.15241-1-tzimmermann@suse.de>
 <20230605144812.15241-2-tzimmermann@suse.de>
Date:   Wed, 07 Jun 2023 09:30:59 +0200
Message-ID: <87bkhrhgp8.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Struct bd6107_platform_data refers to a platform device within
> the Linux device hierarchy. The test in bd6107_backlight_check_fb()
> compares it against the fbdev device in struct fb_info.dev, which
> is different. Fix the test by comparing to struct fb_info.device.
>
> Fixes a bug in the backlight driver and prepares fbdev for making
> struct fb_info.dev optional.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Lee Jones <lee@kernel.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

