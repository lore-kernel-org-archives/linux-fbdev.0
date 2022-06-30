Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E0A2C433EF
	for <linux-fbdev@archiver.kernel.org>; Thu, 30 Jun 2022 19:09:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235955AbiF3TJp (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 30 Jun 2022 15:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232971AbiF3TJo (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 30 Jun 2022 15:09:44 -0400
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ECE828E30
        for <linux-fbdev@vger.kernel.org>; Thu, 30 Jun 2022 12:09:43 -0700 (PDT)
Received: by mail-qv1-f41.google.com with SMTP id q4so612477qvq.8
        for <linux-fbdev@vger.kernel.org>; Thu, 30 Jun 2022 12:09:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=McFecsdmSkzrr5h/aM2httNZHnRBnCTdkFuqJ0CF+EA=;
        b=lEgpmY84H6ZEbMTzz3do7mjHSLDAOKA/3VGiBObCRPz8H7HEe+N3U3J9gQjrKii2yB
         wIKO7R1m20WjIYvImb0zpTCfxpqwPY3AExJsxxfWzfdrzNCEIwSUG7dcMPTdYCC8HzXv
         87B6ycWBp5ecPVZAJ95ncMEwwGGtugpL/9hZeXaZ7clkzQK08mVddl6gaHE8VDuh8MQV
         T2vX3qLNefvf8aL5tO5fw6BqHtZZpQIonrAOoyy9OK6jUhrdnqWExYTQVtVjxo0dqBEb
         p8zyTm7u0eUT1cNw7jNFV7HNs+6g62hnUUd1sP1JtAKh7Ss5G02uvYdOW5gD46a4kCpN
         9S2Q==
X-Gm-Message-State: AJIora/EhwVrumLE5O5FAKjTvG15WRQgb9qWlBsmbszbWw1uIMPq90vF
        oN3QUY/g/FlydO3La0U8NNnZQcW9AYd2fw==
X-Google-Smtp-Source: AGRyM1uoac/NdUXFEZ7S4rj2/lCnkYLP3TqNyiQ5tRkv5emABUvU/v/GsVH0+PeGq4Y8zZhl0B6DWQ==
X-Received: by 2002:ac8:5e4e:0:b0:31d:312d:3a33 with SMTP id i14-20020ac85e4e000000b0031d312d3a33mr3533006qtx.407.1656616182588;
        Thu, 30 Jun 2022 12:09:42 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id h21-20020ac87155000000b0031903373904sm10214035qtp.43.2022.06.30.12.09.42
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 12:09:42 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id x184so35295ybg.12
        for <linux-fbdev@vger.kernel.org>; Thu, 30 Jun 2022 12:09:42 -0700 (PDT)
X-Received: by 2002:a25:2b48:0:b0:668:3b7d:326c with SMTP id
 r69-20020a252b48000000b006683b7d326cmr10820211ybr.380.1656616181876; Thu, 30
 Jun 2022 12:09:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220629200024.187187-1-deller@gmx.de> <20220629200024.187187-4-deller@gmx.de>
In-Reply-To: <20220629200024.187187-4-deller@gmx.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 30 Jun 2022 21:09:30 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWVe3TPCpEiNks2p1AAc-7KXx8fnEa8J=Qsvc0d+WTL+w@mail.gmail.com>
Message-ID: <CAMuHMdWVe3TPCpEiNks2p1AAc-7KXx8fnEa8J=Qsvc0d+WTL+w@mail.gmail.com>
Subject: Re: [PATCH 3/5] fbcon: Prevent that screen size is smaller than font size
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
> We need to prevent that users configure a screen size which is smaller than the
> currently selected font size. Otherwise rendering chars on the screen will
> access memory outside the graphics memory region.
> This patch adds a new function fbcon_modechange_possible() which
> implements this check and which later may be extended with other checks
> if necessary.  The new function is called from the FBIOPUT_VSCREENINFO
> ioctl handler in fbmem.c, which will return -EINVAL if userspace asked
> for a too small screen size.
>
> Signed-off-by: Helge Deller <deller@gmx.de>
> Cc: stable@vger.kernel.org # v5.4+

Thanks for your patch!

> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -2736,6 +2736,34 @@ void fbcon_update_vcs(struct fb_info *info, bool all)
>  }
>  EXPORT_SYMBOL(fbcon_update_vcs);
>
> +/* let fbcon check if it supports a new screen resolution */
> +int fbcon_modechange_possible(struct fb_info *info, struct fb_var_screeninfo *var)
> +{
> +       struct fbcon_ops *ops = info->fbcon_par;
> +       struct vc_data *vc;
> +       int i;
> +
> +       WARN_CONSOLE_UNLOCKED();
> +
> +       if (!ops || ops->currcon < 0)
> +               return -EINVAL;

So if the virtual console is _not_ used as a text console, we refuse
mode changes?

> +
> +       /* prevent setting a screen size which is smaller than font size */
> +       for (i = first_fb_vc; i <= last_fb_vc; i++) {
> +               vc = vc_cons[i].d;
> +               if (!vc || vc->vc_mode != KD_TEXT ||
> +                          registered_fb[con2fb_map[i]] != info)
> +                       continue;
> +
> +               if (vc->vc_font.width  > FBCON_SWAP(var->rotate, var->xres, var->yres) ||
> +                   vc->vc_font.height > FBCON_SWAP(var->rotate, var->yres, var->xres))
> +                       return -EINVAL;
> +       }

IMHO this looks way too fragile, and we should fix the rendering code
to handle cols == 0 || rows == 0 instead...

> +
> +       return 0;
> +}
> +EXPORT_SYMBOL(fbcon_modechange_possible);
> +
>  int fbcon_mode_deleted(struct fb_info *info,
>                        struct fb_videomode *mode)
>  {
> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> index e645b96d2700..324f726739c4 100644
> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -1111,7 +1111,9 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
>                         var.xres_virtual = var.xres;
>                 if (var.yres_virtual < var.yres)
>                         var.yres_virtual = var.yres;
> -               ret = fb_set_var(info, &var);
> +               ret = fbcon_modechange_possible(info, &var);
> +               if (!ret)
> +                       ret = fb_set_var(info, &var);
>                 if (!ret)
>                         fbcon_update_vcs(info, var.activate & FB_ACTIVATE_ALL);
>                 unlock_fb_info(info);

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
