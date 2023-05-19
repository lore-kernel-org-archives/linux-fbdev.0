Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62215C77B7F
	for <linux-fbdev@archiver.kernel.org>; Fri, 19 May 2023 14:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbjESOp2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 19 May 2023 10:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232026AbjESOpE (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 19 May 2023 10:45:04 -0400
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C533110D2
        for <linux-fbdev@vger.kernel.org>; Fri, 19 May 2023 07:44:41 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-561a33b6d63so44933937b3.1
        for <linux-fbdev@vger.kernel.org>; Fri, 19 May 2023 07:44:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684507480; x=1687099480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jmkRRs7o/GrPNRsnjEmMyXFmswNShBvbUzfAdFFg2lA=;
        b=AGbrIIff8XmJKEEISUr0FKLXBw1dkBbpB9uH6ryDXnyNx2tcTdGKQ9G/sxKxAVmHSU
         olm5BIhRQuL7j7Cz6T5OP+PxneooozN/vzpxmDT6L4owfc0T5mwI2GHVoaoqbvlb5NIU
         vYBiJfvxbNEBYHZJr95zbk/kcko0c3S1RprPRAqVCP4tNCQiViScbNPo6kuKic2+aQmo
         R+zGztns5Tp3gQ3EBcPzPCWg0v3nzoIAws1Cix0XaZbSJBkVZvdqHlF6yvSqzCSKAUw9
         C8wUSiRK7oWgaNwLLRNjSKweN3/uXLCeRnrIwqQNB++6JAWMlA6hl4ZGenUmxzaGZqMV
         AxYQ==
X-Gm-Message-State: AC+VfDxR21/9Rk9asFuH24YjaKpQNZJt3jSzgAqltyjg+MXNvNrypEp8
        TNNLtZcO/mhFSPmv7VDJHr+MCmA2ABq94g==
X-Google-Smtp-Source: ACHHUZ6FqjjFuyh7AYCl7u0qG3A/yhoPfK1hwV/qA31eK1pIasWrrJ8zImJMsigw8KdFprzrPNJkOw==
X-Received: by 2002:a0d:d550:0:b0:561:a3e6:bfc7 with SMTP id x77-20020a0dd550000000b00561a3e6bfc7mr1925634ywd.52.1684507480619;
        Fri, 19 May 2023 07:44:40 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id o65-20020a815a44000000b0054f8b1f21e5sm1200908ywb.85.2023.05.19.07.44.39
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 07:44:39 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-56204ac465fso24911617b3.2
        for <linux-fbdev@vger.kernel.org>; Fri, 19 May 2023 07:44:39 -0700 (PDT)
X-Received: by 2002:a0d:c043:0:b0:562:7f3:bee6 with SMTP id
 b64-20020a0dc043000000b0056207f3bee6mr2059739ywd.45.1684507479276; Fri, 19
 May 2023 07:44:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230516202257.559952-1-arnd@kernel.org> <CAMuHMdWgVsY8Ur7s9Xy1xMGxOW0WFXWq934aAE9Z884tGuWG_A@mail.gmail.com>
 <ZGeJsYmPU/7CHJRV@ls3530>
In-Reply-To: <ZGeJsYmPU/7CHJRV@ls3530>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 19 May 2023 16:44:26 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVTGcVoNh3EUK-K--=X5kf+c5Un6aDms-gP3QhgEKZUwg@mail.gmail.com>
Message-ID: <CAMuHMdVTGcVoNh3EUK-K--=X5kf+c5Un6aDms-gP3QhgEKZUwg@mail.gmail.com>
Subject: Re: [PATCH] fbdev: fbmem: mark get_fb_unmapped_area() static
To:     Helge Deller <deller@gmx.de>
Cc:     Arnd Bergmann <arnd@kernel.org>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Helge,

On Fri, May 19, 2023 at 4:37 PM Helge Deller <deller@gmx.de> wrote:
> * Geert Uytterhoeven <geert@linux-m68k.org>:
> > On Tue, May 16, 2023 at 10:23 PM Arnd Bergmann <arnd@kernel.org> wrote:
> > > From: Arnd Bergmann <arnd@arndb.de>
> > >
> > > There is a global function with this name on sparc, but no
> > > global declaration:
> > >
> > > drivers/video/fbdev/core/fbmem.c:1469:15: error: no previous prototype for 'get_fb_unmapped_area'
> > >
> > > Make the generic definition static to avoid this warning. On
> > > sparc, this is never seen.
> > >
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >
> > > --- a/drivers/video/fbdev/core/fbmem.c
> > > +++ b/drivers/video/fbdev/core/fbmem.c
> > > @@ -1468,7 +1468,7 @@ __releases(&info->lock)
> > >  }
> > >
> > >  #if defined(CONFIG_FB_PROVIDE_GET_FB_UNMAPPED_AREA) && !defined(CONFIG_MMU)
> > > -unsigned long get_fb_unmapped_area(struct file *filp,
> > > +static unsigned long get_fb_unmapped_area(struct file *filp,
> > >                                    unsigned long addr, unsigned long len,
> > >                                    unsigned long pgoff, unsigned long flags)
> > >  {
> >
> > LGTM, as this is unrelated to the SPARC function, and SPARC does
> > not support nommu (yet? ;-)
> >
> > drivers/video/fbdev/Kconfig:config FB_PROVIDE_GET_FB_UNMAPPED_AREA
> > drivers/video/fbdev/Kconfig-    bool
> > drivers/video/fbdev/Kconfig-    depends on FB
> > drivers/video/fbdev/Kconfig-    help
> > drivers/video/fbdev/Kconfig-      Allow generic frame-buffer to
> > provide get_fb_unmapped_area
> > drivers/video/fbdev/Kconfig-      function.
> >
> > Probably you want to update this help text, too. E.g.
> > "to provide shareable character device support on nommu"?
>
> I've added Geerts suggestions and made it dependend on !MMU.
>
> Applied to fbdev git tree as below.
>
> Thanks!
> Helge
>
>
> From 9adfa68ca0ddd63007cdce60a8ffcb493bb30d97 Mon Sep 17 00:00:00 2001
> From: Arnd Bergmann <arnd@arndb.de>
> Subject: [PATCH] fbdev: fbmem: mark get_fb_unmapped_area() static
>
> There is a global function with this name on sparc, but no
> global declaration:
>
> drivers/video/fbdev/core/fbmem.c:1469:15: error: no previous prototype for 'get_fb_unmapped_area'
>
> Make the generic definition static to avoid this warning. On
> sparc, this is never seen.
>
> Edit by Helge:
> Update Kconfig text as suggested by Geert Uytterhoeven and make it dependend on
> !MMU.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Helge Deller <deller@gmx.de>
>
> diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
> index 96e91570cdd3..1688875a07de 100644
> --- a/drivers/video/fbdev/Kconfig
> +++ b/drivers/video/fbdev/Kconfig
> @@ -121,10 +121,10 @@ config FB_SYS_IMAGEBLIT
>
>  config FB_PROVIDE_GET_FB_UNMAPPED_AREA
>         bool
> -       depends on FB
> +       depends on FB && !MMU

I expect this to cause a Kconfig warning when enabling DRM_STM
with MMU=y (e.g. multi_v7_defconfig).
ARCH_STM32 seems to support both MMU=y and MMU=n.

>         help
>           Allow generic frame-buffer to provide get_fb_unmapped_area
> -         function.
> +         function to provide shareable character device support on nommu.
>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
