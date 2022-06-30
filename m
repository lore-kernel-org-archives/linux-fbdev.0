Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F3FC43334
	for <linux-fbdev@archiver.kernel.org>; Thu, 30 Jun 2022 19:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235373AbiF3TL4 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 30 Jun 2022 15:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232971AbiF3TLz (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 30 Jun 2022 15:11:55 -0400
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C26338B7
        for <linux-fbdev@vger.kernel.org>; Thu, 30 Jun 2022 12:11:53 -0700 (PDT)
Received: by mail-qk1-f175.google.com with SMTP id v6so15203594qkh.2
        for <linux-fbdev@vger.kernel.org>; Thu, 30 Jun 2022 12:11:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=USQBZQ6SgoV5Ne4yk1LghTNS4+/aHcnJLY2+ToZRaBI=;
        b=GVULxFmpFkXKbg1RhZ6mGXMSPqDwv+Vv9eisDOx5HslvY3Tw8QX16Z48ckRKUyXJ1K
         HpUMsfD23nRpv45EYnyyzn+4tXTP+ApRj87fNDw/OBJE1mJj+dZDG8O4STbUkcANLu6j
         xKy5SW+sKIbi3lGRCpbApVvxmjwt6iOgA5ryqVI6qui+lp16ual5qVLiZszyMGBDpXf1
         rXh2jbVHVFDqnEfZN2lTrWaJTTuBpPYxu9bQLpwcdZM95YW4uLH2n0a3GSXV1qWBaeVJ
         LmLAx/gpKwkiBUX/0GipIdEmIgbDcpbPUt/SUGVebDx4byvPEeMlCU+4JDzA80J4Mb0/
         BgfA==
X-Gm-Message-State: AJIora+9z1twRnftEhyVvD+AzLxgQ8CV6LsUt/dHJc7+w+iJ5A8MNmsz
        XNG43dnK8ZNSqeKyqva8ofOOFsyhOiK07Q==
X-Google-Smtp-Source: AGRyM1u3R4sWOB5yN1GHEmB49/lDSLKcy4cBmNThYUaF8FSwet+j000eEpv1+tymwu2A/POtEUxFfg==
X-Received: by 2002:a37:355:0:b0:6ae:e5a7:bb5c with SMTP id 82-20020a370355000000b006aee5a7bb5cmr7743016qkd.758.1656616312032;
        Thu, 30 Jun 2022 12:11:52 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id bq9-20020a05620a468900b006af6f0893c6sm5182416qkb.91.2022.06.30.12.11.51
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 12:11:51 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-31bf327d4b5so2407897b3.13
        for <linux-fbdev@vger.kernel.org>; Thu, 30 Jun 2022 12:11:51 -0700 (PDT)
X-Received: by 2002:a81:4fc9:0:b0:318:b0ca:4b13 with SMTP id
 d192-20020a814fc9000000b00318b0ca4b13mr12621013ywb.502.1656616310970; Thu, 30
 Jun 2022 12:11:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220629200024.187187-1-deller@gmx.de> <20220629200024.187187-5-deller@gmx.de>
In-Reply-To: <20220629200024.187187-5-deller@gmx.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 30 Jun 2022 21:11:39 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVJ0PsDyTdGoOHPOKdaR7AffG2FpFmw6fxoNdXx9y-J4A@mail.gmail.com>
Message-ID: <CAMuHMdVJ0PsDyTdGoOHPOKdaR7AffG2FpFmw6fxoNdXx9y-J4A@mail.gmail.com>
Subject: Re: [PATCH 4/5] fbmem: Prevent invalid virtual screen sizes in fb_set_var()
To:     Helge Deller <deller@gmx.de>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Helge,

On Wed, Jun 29, 2022 at 10:00 PM Helge Deller <deller@gmx.de> wrote:
> Prevent that drivers configure a virtual screen resolution smaller than
> the physical screen resolution.  This is important, because otherwise we
> may access memory outside of the graphics memory area.
>
> Signed-off-by: Helge Deller <deller@gmx.de>
> Cc: stable@vger.kernel.org # v5.4+

Thanks for your patch!

> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -1006,6 +1006,12 @@ fb_set_var(struct fb_info *info, struct fb_var_screeninfo *var)
>         if (var->xres < 8 || var->yres < 8)
>                 return -EINVAL;
>
> +       /* make sure virtual resolution >= physical resolution */
> +       if (WARN_ON(var->xres_virtual < var->xres))
> +               var->xres_virtual = var->xres;
> +       if (WARN_ON(var->yres_virtual < var->yres))
> +               var->yres_virtual = var->yres;

This should be moved below the call to info->fbops->fb_check_var(),
so the WARN_ON() catches buggy fbdev drivers, not userspace fuzzers.

> +
>         /* Too huge resolution causes multiplication overflow. */
>         if (check_mul_overflow(var->xres, var->yres, &unused) ||
>             check_mul_overflow(var->xres_virtual, var->yres_virtual, &unused))

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
