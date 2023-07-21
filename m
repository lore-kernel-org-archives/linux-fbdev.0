Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF66EEB64DD
	for <linux-fbdev@archiver.kernel.org>; Fri, 21 Jul 2023 22:47:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjGUWrD (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 21 Jul 2023 18:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjGUWrD (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 21 Jul 2023 18:47:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B213A87
        for <linux-fbdev@vger.kernel.org>; Fri, 21 Jul 2023 15:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689979581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yE0bLtRIMwP7QfCtqHUeTr/4KJnDlp9DaWfvJbs40ac=;
        b=BqBnZNisgVbOBZQRdS6p5vwh42Hps3h6wUStE6SeSWX3nUKOhhCSgG+3ynMBZIqJX36pVt
        ySGqyowbxRFD9JFiNq4TFa/z5h9ds8KzW04ik2wzWIb/wjN6ahUltHXvvcdGbbFnlIW2i9
        WyDhoADX1LCIYz8gC02B4dabx/KWeeQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-502-FC2g5FZsMmesTb__BYQzug-1; Fri, 21 Jul 2023 18:46:19 -0400
X-MC-Unique: FC2g5FZsMmesTb__BYQzug-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f41a04a297so12439185e9.3
        for <linux-fbdev@vger.kernel.org>; Fri, 21 Jul 2023 15:46:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689979578; x=1690584378;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yE0bLtRIMwP7QfCtqHUeTr/4KJnDlp9DaWfvJbs40ac=;
        b=bv2UPQ6Yxcv2CTL1IPsPesRm7W1GI6OK1t/h47clUDN0W+gfyrAxw6bKypQVbeU+lm
         GcycxEnlCIn5rI3sqwtkr9d0JQJxGUjIwX1SQL52AEpmROxLRQChM42xajeJoNVKiQnp
         MNBJPnOA/sIKSuYnOnsmr1MLFa4B8yjrplByGxE20/3O4km2iqhNoBwpPI4N87gGGlV4
         VVrELCrjBYCyN7i2RAs/Mv86Ow9KyedhWZvNqCKLRQDAa40weIbq9Xe5ecdMU1nGYUMB
         jkawP50vG/2HuNmYBGy9Up6nK2qwk3glwIFqbSkteexvXoJb9H4AdRIIJxgoWNg9g4fb
         42rg==
X-Gm-Message-State: ABy/qLa72BihoHE8IKa6viBQZBdoks5C1D76l4Er0cP1f4uTfv3gnKp0
        Lr5BkuSYBVggB1NYqW6Y7dL9GmjdJ9i6j8Ygh+faoA+CKrPV3Q5AQ8e8H5U0767UYuzCihOvNZK
        X4+omfKwTNoUk+qj9clAhyUQ=
X-Received: by 2002:a05:600c:224b:b0:3fb:b34f:6cd4 with SMTP id a11-20020a05600c224b00b003fbb34f6cd4mr2241627wmm.36.1689979578510;
        Fri, 21 Jul 2023 15:46:18 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG4o1OxvRmpHFoaNAuc4QqPQ+HeK/yygxg+TEil6F/L2at/FUadRCLQ5fAQrswO0An7WjzHsw==
X-Received: by 2002:a05:600c:224b:b0:3fb:b34f:6cd4 with SMTP id a11-20020a05600c224b00b003fbb34f6cd4mr2241612wmm.36.1689979578118;
        Fri, 21 Jul 2023 15:46:18 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id s19-20020a1cf213000000b003fbaade072dsm4099955wmc.23.2023.07.21.15.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 15:46:17 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Nipun Gupta <nipun.gupta@amd.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v6 1/4] video: Add auxiliary display drivers to Graphics
 support menu
In-Reply-To: <20230719081544.741051-2-javierm@redhat.com>
References: <20230719081544.741051-1-javierm@redhat.com>
 <20230719081544.741051-2-javierm@redhat.com>
Date:   Sat, 22 Jul 2023 00:46:16 +0200
Message-ID: <87sf9gublz.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Javier Martinez Canillas <javierm@redhat.com> writes:

[adding Miguel Ojeda who was not in the Cc list]

Hello Miguel, could you please ack this patch so that I can take the whole
patch-set through the drm-misc tree?

> The drivers in this subsystem are for character-based LCD displays, which
> can fall into the same category of the DRM/KMS and fbdev drivers that are
> located under the "Graphics support" menu. Add auxdisplay there as well.
>
> Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> Tested-by: Arnd Bergmann <arnd@arndb.de>
> ---
>
> (no changes since v5)
>
> Changes in v5:
> - Take the auxdisplay/Kconfig source out of "if HAS_IOMEM" (Geert Uytterhoeven).
>
>  drivers/Kconfig       | 2 --
>  drivers/video/Kconfig | 2 ++
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/Kconfig b/drivers/Kconfig
> index 514ae6b24cb2..496ca02ee18f 100644
> --- a/drivers/Kconfig
> +++ b/drivers/Kconfig
> @@ -129,8 +129,6 @@ source "drivers/dma-buf/Kconfig"
>  
>  source "drivers/dca/Kconfig"
>  
> -source "drivers/auxdisplay/Kconfig"
> -
>  source "drivers/uio/Kconfig"
>  
>  source "drivers/vfio/Kconfig"
> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index 8b2b9ac37c3d..e5b1cc54cafa 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -25,6 +25,8 @@ config VIDEO_NOMODESET
>  	bool
>  	default n
>  
> +source "drivers/auxdisplay/Kconfig"
> +
>  if HAS_IOMEM
>  
>  config HAVE_FB_ATMEL
> -- 
> 2.41.0
>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

