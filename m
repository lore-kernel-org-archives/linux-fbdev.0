Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5451C0015E
	for <linux-fbdev@archiver.kernel.org>; Tue, 25 Jul 2023 16:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbjGYQHo (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 25 Jul 2023 12:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjGYQHn (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 25 Jul 2023 12:07:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8616D10CC
        for <linux-fbdev@vger.kernel.org>; Tue, 25 Jul 2023 09:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690301214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n8WDoL0557ijucVnvFFhXFlCk91a1heL5kHgluQGr74=;
        b=g5K9ZBTXdPpSrOjhbguXGKvYj07frR4WI0v4xtPNlDVs1KL7NnjFL3MDJkgXHqdf14kXvP
        8y2vzBImDn+YZ32B611BJhSsq9nWOQWdHaR92SubW9dYbV+3DqleVrzJ7skFx5Zp1Lywra
        bU5JEY4L1xgLmWfjJoPrR9pfNMgXYGQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-mIOtdKMwNVicbagLFzhEPg-1; Tue, 25 Jul 2023 12:06:52 -0400
X-MC-Unique: mIOtdKMwNVicbagLFzhEPg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f5df65fa35so30265135e9.3
        for <linux-fbdev@vger.kernel.org>; Tue, 25 Jul 2023 09:06:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690301211; x=1690906011;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n8WDoL0557ijucVnvFFhXFlCk91a1heL5kHgluQGr74=;
        b=jtY8nhTIkfHrxKVaXQfAn2zYnNgiuZ+b0diESEvYS/s8YgtBAzIDwRC6Bm3lNZVvDi
         wkpgZm5BMd3WnEEGF69fae6rgMMjdfmTbUWOmXubs9Cs2yTvCCOAhaielTBa9XtQcF86
         9/e8DO0mDcu7wm3PK0kMxpFnlIyjtpodrjn+L+jUCPDUitLgSv+nc+Yl6jU6a2yAchnN
         yagRF/Dx5lYV0ouibrBIbpqO/kk4JIIPH3qzsqnbMYTyulKOBgZXP1KfQOPIgB7m2Jeg
         0O8AuG673zziB9Zp0r9Q4gXC+9WwoHymhca5AFD1Gl/E54bfsKE8nmjDWnTlM8aTV0U0
         NqdA==
X-Gm-Message-State: ABy/qLbtxqwc+efbUN+lzhIhpD+SS53Y2xYpoS7mMBT3mJ4zcjv0/dww
        6ovHhgiRI65iUslMi4q1ium8im2cl+Nx+6ruahtF9rWgrD92SgZhHt8Ebx+qb3X7RsWAdu90dfG
        hvBCFVs/AfE9pCFc87Tn6DUFzCWiRcRw=
X-Received: by 2002:a05:600c:2043:b0:3fa:934c:8350 with SMTP id p3-20020a05600c204300b003fa934c8350mr10062661wmg.27.1690301211266;
        Tue, 25 Jul 2023 09:06:51 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHhB4b1r6/9EKYpbymuXJFkp9iRDrryPS4kRN5/XpdtSoEVtQGo358UOoZiWwF6PdI9lwFdRA==
X-Received: by 2002:a05:600c:2043:b0:3fa:934c:8350 with SMTP id p3-20020a05600c204300b003fa934c8350mr10062636wmg.27.1690301210864;
        Tue, 25 Jul 2023 09:06:50 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id a17-20020adffad1000000b003143cdc5949sm16909129wrs.9.2023.07.25.09.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 09:06:50 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Helge Deller <deller@gmx.de>, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH] video: logo: LOGO should depend on FB_CORE i.s.o. FB
In-Reply-To: <5ab3d1fe7b67ab10e4bc1bdbc0fa7731f7960965.1690300189.git.geert+renesas@glider.be>
References: <5ab3d1fe7b67ab10e4bc1bdbc0fa7731f7960965.1690300189.git.geert+renesas@glider.be>
Date:   Tue, 25 Jul 2023 18:06:49 +0200
Message-ID: <87a5vkj7qe.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Geert Uytterhoeven <geert+renesas@glider.be> writes:

Hello Geert,

Thanks a lot for your patch!

> If CONFIG_FB_CORE=y but CONFIG_FB=n, the frame buffer bootup logos can
> no longer be enabled.  Fix this by making CONFIG_LOGO depend on
> CONFIG_FB_CORE instead of CONFIG_FB, as there is no good reason for the
> logo code to depend on the presence of real frame buffer device drivers.
>

Indeed.

> Fixes: 55bffc8170bb5813 ("fbdev: Split frame buffer support in FB and FB_CORE symbols")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/video/Kconfig      | 2 +-
>  drivers/video/logo/Kconfig | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index e5b1cc54cafa10d5..b694d7669d3200b1 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -63,7 +63,7 @@ if VT
>  	source "drivers/video/console/Kconfig"
>  endif
>  
> -if FB || SGI_NEWPORT_CONSOLE
> +if FB_CORE || SGI_NEWPORT_CONSOLE
>  	source "drivers/video/logo/Kconfig"
>  
>  endif
> diff --git a/drivers/video/logo/Kconfig b/drivers/video/logo/Kconfig
> index 6d6f8c08792dc897..b7d94d1dd1585a84 100644
> --- a/drivers/video/logo/Kconfig
> +++ b/drivers/video/logo/Kconfig
> @@ -5,7 +5,7 @@
>  
>  menuconfig LOGO
>  	bool "Bootup logo"
> -	depends on FB || SGI_NEWPORT_CONSOLE
> +	depends on FB_CORE || SGI_NEWPORT_CONSOLE
>  	help
>  	  Enable and select frame buffer bootup logos.

Should then move this option to drivers/video/fbdev/core/Kconfig ?

Regardless, could be done as a follow-up and the fix looks good to me.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

