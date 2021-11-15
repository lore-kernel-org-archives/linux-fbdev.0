Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3DA8C433EF
	for <linux-fbdev@archiver.kernel.org>; Mon, 15 Nov 2021 16:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC90863212
	for <linux-fbdev@archiver.kernel.org>; Mon, 15 Nov 2021 16:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbhKOQYk (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 15 Nov 2021 11:24:40 -0500
Received: from mail-ua1-f45.google.com ([209.85.222.45]:36395 "EHLO
        mail-ua1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236739AbhKOQXo (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 15 Nov 2021 11:23:44 -0500
Received: by mail-ua1-f45.google.com with SMTP id r15so8825642uao.3;
        Mon, 15 Nov 2021 08:20:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GHbFsAYOPumvboD3uCH/py8mrfSZqewFYFUyg3SH2X4=;
        b=qlN3LYAmZH8lEu5bO8QTN50Pv9BnTXxYn764CKPvoQ/CKNoLfBaHht5vq9mck5NpHx
         n/EF1GpbtlKAMncRaLsuTRQ6GlMG+AqSJLnoMm8BQoeDMy5xA+cDDLb8BZKVQ93XxUeW
         iU7xmcdpgoGLnzXe5c7IgWymZcTPzuOLnU86j/xRoATSI7nU0Crg0D5g1+kVinKvIbHO
         +WAOZgbtoF9opHqQ5pygmEX2QKA0qInScWnQ74IcIb2C+7FxxLcvwPyO9DJSlQrwz0rI
         34gurzgGwIsPpyARt8VCZevUSu0SZhsmEYMqn1O84+i9/XWE1L1wOZxdNpA4vuA+p5zV
         v4fA==
X-Gm-Message-State: AOAM531+k0KwwCN0h0aWdUklimLwgu5AzMdDUA53OqbtVgxQ1bPUxWRZ
        tFXF7cRIMFKQWHPPTbvdMrYaNO9771iiqg==
X-Google-Smtp-Source: ABdhPJx3REMwZ4FDyZ58hQfijHw0mPsZk4NglnXGs6G7ZGpsnkG7ujsqnJ27fMjINjtciDCUKtYGcw==
X-Received: by 2002:a67:2446:: with SMTP id k67mr15844112vsk.38.1636993247999;
        Mon, 15 Nov 2021 08:20:47 -0800 (PST)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id y28sm8932084vkl.22.2021.11.15.08.20.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Nov 2021 08:20:47 -0800 (PST)
Received: by mail-ua1-f47.google.com with SMTP id n6so19464724uak.1;
        Mon, 15 Nov 2021 08:20:46 -0800 (PST)
X-Received: by 2002:a05:6102:e82:: with SMTP id l2mr44043532vst.37.1636993246647;
 Mon, 15 Nov 2021 08:20:46 -0800 (PST)
MIME-Version: 1.0
References: <20211111111120.1344613-1-javierm@redhat.com>
In-Reply-To: <20211111111120.1344613-1-javierm@redhat.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 15 Nov 2021 17:20:35 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWA2V_KDpcpMw3yRKmN+6YDjmysJoz6D-6JjJs-3+XYTQ@mail.gmail.com>
Message-ID: <CAMuHMdWA2V_KDpcpMw3yRKmN+6YDjmysJoz6D-6JjJs-3+XYTQ@mail.gmail.com>
Subject: Re: [PATCH v2] fbdev: Prevent probing generic drivers if a FB is
 already registered
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Peter Jones <pjones@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Ilya Trukhanov <lahvuun@gmail.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Borislav Petkov <bp@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Javier,

On Thu, Nov 11, 2021 at 12:13 PM Javier Martinez Canillas
<javierm@redhat.com> wrote:
> The efifb and simplefb drivers just render to a pre-allocated frame buffer
> and rely on the display hardware being initialized before the kernel boots.
>
> But if another driver already probed correctly and registered a fbdev, the
> generic drivers shouldn't be probed since an actual driver for the display
> hardware is already present.
>
> This is more likely to occur after commit d391c5827107 ("drivers/firmware:
> move x86 Generic System Framebuffers support") since the "efi-framebuffer"
> and "simple-framebuffer" platform devices are registered at a later time.
>
> Link: https://lore.kernel.org/r/20211110200253.rfudkt3edbd3nsyj@lahvuun/
> Fixes: d391c5827107 ("drivers/firmware: move x86 Generic System Framebuffers support")
> Reported-by: Ilya Trukhanov <lahvuun@gmail.com>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> ---
>
> Changes in v2:
> - Add a Link: tag with a reference to the bug report (Thorsten Leemhuis).
> - Add a comment explaining why the probe fails earlier (Daniel Vetter).
> - Add a Fixes: tag for stable to pick the fix (Daniel Vetter).
> - Add Daniel Vetter's Reviewed-by: tag.
> - Improve the commit message and mention the culprit commit
>
>  drivers/video/fbdev/efifb.c    | 11 +++++++++++
>  drivers/video/fbdev/simplefb.c | 11 +++++++++++
>  2 files changed, 22 insertions(+)
>
> diff --git drivers/video/fbdev/efifb.c drivers/video/fbdev/efifb.c
> index edca3703b964..ea42ba6445b2 100644
> --- drivers/video/fbdev/efifb.c
> +++ drivers/video/fbdev/efifb.c
> @@ -351,6 +351,17 @@ static int efifb_probe(struct platform_device *dev)
>         char *option = NULL;
>         efi_memory_desc_t md;
>
> +       /*
> +        * Generic drivers must not be registered if a framebuffer exists.
> +        * If a native driver was probed, the display hardware was already
> +        * taken and attempting to use the system framebuffer is dangerous.
> +        */
> +       if (num_registered_fb > 0) {

Who says this registered fbdev is driving the same hardware as efifb?
This might be e.g. a small external display connected to i2c or spi.

> +               dev_err(&dev->dev,
> +                       "efifb: a framebuffer is already registered\n");
> +               return -EINVAL;
> +       }
> +
>         if (screen_info.orig_video_isVGA != VIDEO_TYPE_EFI || pci_dev_disabled)
>                 return -ENODEV;
>
> diff --git drivers/video/fbdev/simplefb.c drivers/video/fbdev/simplefb.c
> index 62f0ded70681..b63074fd892e 100644
> --- drivers/video/fbdev/simplefb.c
> +++ drivers/video/fbdev/simplefb.c
> @@ -407,6 +407,17 @@ static int simplefb_probe(struct platform_device *pdev)
>         struct simplefb_par *par;
>         struct resource *mem;
>
> +       /*
> +        * Generic drivers must not be registered if a framebuffer exists.
> +        * If a native driver was probed, the display hardware was already
> +        * taken and attempting to use the system framebuffer is dangerous.
> +        */
> +       if (num_registered_fb > 0) {

Likewise.

> +               dev_err(&pdev->dev,
> +                       "simplefb: a framebuffer is already registered\n");
> +               return -EINVAL;
> +       }
> +
>         if (fb_get_options("simplefb", NULL))
>                 return -ENODEV;

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
