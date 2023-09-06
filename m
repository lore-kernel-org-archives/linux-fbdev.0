Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D27EB8FA5
	for <linux-fbdev@archiver.kernel.org>; Wed,  6 Sep 2023 10:11:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbjIFKLr (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 6 Sep 2023 06:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjIFKLq (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 6 Sep 2023 06:11:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F5110F5
        for <linux-fbdev@vger.kernel.org>; Wed,  6 Sep 2023 03:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693995057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Hv8DYu7MTr4kuGV37i9sTqxH6eTvGFMuruIX7/nBGWo=;
        b=U1rYxNNqA1GVa7ONzUK+dwD5sLYyVxrBr1rLaA03BpRQ8tO0jKbPOBCxUYZ8Y12t/rgung
        KD92p0p7hNt++IiG5RcToPVg4RV6dAJ+SXAcRQ4GQvYN8lIJUNLJtsnzLe5nXZpsW5giPH
        MidWd52WHiWmECbtCAJUWWQy0T1OC6s=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-08kp9h3cOx2M-kNmUucr6g-1; Wed, 06 Sep 2023 06:10:56 -0400
X-MC-Unique: 08kp9h3cOx2M-kNmUucr6g-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2bcc1e0dfe5so36257101fa.1
        for <linux-fbdev@vger.kernel.org>; Wed, 06 Sep 2023 03:10:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693995055; x=1694599855;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hv8DYu7MTr4kuGV37i9sTqxH6eTvGFMuruIX7/nBGWo=;
        b=I2d52a3uGcU7znuQyY2CcBSQwdMvaej3RpeI0/qne1F8SOOkdLe1rpfYHlHg4uvunT
         T0eiv2vbwtSEKlOb1EXBJSGDXLDvjhjtMfORQUs38oWOwNVNFmJ/g7K3yKQigodfsBMK
         V0vRJarSo4ipKnoCiM7BqheY+MMgywW6Q4wN+fqrn2OkeJfiUSAMs2P/aFBG5PkUjdCW
         i/bYhrHR8X3KLKD4LMx9a0g1v2CBQonV0sls/UDF484L/YipgYTvI0yRLHioihncq9k2
         0y5rNPuyOBAQz3QKUHbDgWOrnPLmRoKV5/Dye5L37mhjIUGa6/+mZTcIAgOYJDMs1UUT
         kWdA==
X-Gm-Message-State: AOJu0YxcWoeWe/EfhsTbbGJX70RIAFGLCRtAP9eRAqjkhvGuFbd5H8+9
        QwEWCtOIbR2+iZMRgPLIhg8sphumsZJhAIbaJLk9oLP2EWLYLaGWHViibRRoU3zPHGUNRDEMeOF
        RAyLlgQsEUWatwKWSk54UXGE=
X-Received: by 2002:a2e:870d:0:b0:2bc:b9c7:7ba8 with SMTP id m13-20020a2e870d000000b002bcb9c77ba8mr1821980lji.43.1693995054992;
        Wed, 06 Sep 2023 03:10:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlEOBg4YUUo+ApwkDK41eZQoOWRKWT9hoI43BTnkb2886b1jJOEBUZMQKvCBA2uq3yLQagdg==
X-Received: by 2002:a2e:870d:0:b0:2bc:b9c7:7ba8 with SMTP id m13-20020a2e870d000000b002bcb9c77ba8mr1821960lji.43.1693995054655;
        Wed, 06 Sep 2023 03:10:54 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id n17-20020a7bcbd1000000b003fee777fd84sm19425278wmi.41.2023.09.06.03.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 03:10:54 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de,
        daniel@ffwll.ch, sam@ravnborg.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 4/7] fbdev/core: Move logo functions into separate
 source file
In-Reply-To: <20230829142109.4521-5-tzimmermann@suse.de>
References: <20230829142109.4521-1-tzimmermann@suse.de>
 <20230829142109.4521-5-tzimmermann@suse.de>
Date:   Wed, 06 Sep 2023 12:10:53 +0200
Message-ID: <87fs3r4no2.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Move the fbdev function for displaying boot-up logos into their
> own file fb_logo.c. The file can later be build depending on the
> state of CONFIG_LOGO. No functional changes.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/video/fbdev/core/Makefile      |   1 +
>  drivers/video/fbdev/core/fb_internal.h |   6 +
>  drivers/video/fbdev/core/fb_logo.c     | 533 +++++++++++++++++++++++++
>  drivers/video/fbdev/core/fbmem.c       | 524 ------------------------
>  include/linux/fb.h                     |   5 -
>  5 files changed, 540 insertions(+), 529 deletions(-)
>  create mode 100644 drivers/video/fbdev/core/fb_logo.c
>
> diff --git a/drivers/video/fbdev/core/Makefile b/drivers/video/fbdev/core/Makefile
> index edfde2948e5c..adce31155e92 100644
> --- a/drivers/video/fbdev/core/Makefile
> +++ b/drivers/video/fbdev/core/Makefile
> @@ -2,6 +2,7 @@
>  obj-$(CONFIG_FB_NOTIFY)           += fb_notify.o
>  obj-$(CONFIG_FB_CORE)             += fb.o
>  fb-y                              := fb_info.o \
> +                                     fb_logo.o \

Maybe instead of adding this unconditionally you could only add it when
CONFIG_LOGO is enabled ?

[...]

> diff --git a/drivers/video/fbdev/core/fb_logo.c b/drivers/video/fbdev/core/fb_logo.c
> new file mode 100644
> index 000000000000..76ba5a2bebae
> --- /dev/null
> +++ b/drivers/video/fbdev/core/fb_logo.c
> @@ -0,0 +1,533 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/export.h>
> +#include <linux/fb.h>
> +#include <linux/linux_logo.h>
> +
> +bool fb_center_logo __read_mostly;
> +int fb_logo_count __read_mostly = -1;
> +
> +#ifdef CONFIG_LOGO

[...]

> +#else
> +int fb_prepare_logo(struct fb_info *info, int rotate)
> +{
> +	return 0;
> +}
> +EXPORT_SYMBOL(fb_prepare_logo);
> +
> +int fb_show_logo(struct fb_info *info, int rotate)
> +{
> +	return 0;
> +}
> +EXPORT_SYMBOL(fb_show_logo);

I would move the CONFIG_LOGO #ifdefery to the header file and make these a
static inline function, instead of having the stubs here and exporting
symbols for functions that are a no-op.

I think that will also fix the issues that the robot complained about.

Other than that, the patch looks good to me.

Acked-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

