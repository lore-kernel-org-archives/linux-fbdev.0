Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B3D2CCA488
	for <linux-fbdev@archiver.kernel.org>; Thu, 21 Jul 2022 14:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbiGUOqd (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 21 Jul 2022 10:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbiGUOqc (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 21 Jul 2022 10:46:32 -0400
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2F673910
        for <linux-fbdev@vger.kernel.org>; Thu, 21 Jul 2022 07:46:31 -0700 (PDT)
Received: by mail-qk1-f181.google.com with SMTP id b25so1417341qka.11
        for <linux-fbdev@vger.kernel.org>; Thu, 21 Jul 2022 07:46:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uRb/kpCM2Tp3RADIUm8HgY748KiyFCtoEV6JEoibXAk=;
        b=WifBijIqhJ7KR1LqAHDpkOESXoYS7B0b1XWqXhbixqMo7/UNQfmWwRbRWpI+ZFuMBJ
         Di9wa6ySAXTUvuMZB+EYjIcEcg6P/6ItuwuOjJeOBS/6jSBqDU317W9XE2mxwgH/oJqE
         d1Cz2e+w3BLsmogNtaO/d49IS0avhfyTOimFWTco7VNmHfi421etigqiP+edrhYRvzGt
         TsoulS2X/gc/kRXFyiZXWZj2Gwn9jeGN+huVkcR5sJVfVqT5Q2Joyt1bPhMk9xH95JzZ
         EeS+y7Ggn/UQb5RNlH6zMMKv2M3H3x/45u5Rn+O6f3W1NdGPcZnReuqGbieyPUtNr8ib
         UpkQ==
X-Gm-Message-State: AJIora8aCMHlNFMOzrcFOzaGlgrQFOoSEMOy8ZuyyfvjpYj0bX8abGXl
        uMonQ3h0EcO3OO222p4hQC4uEwe+1t8QfA==
X-Google-Smtp-Source: AGRyM1v1u1oHN1gUDnAG1sfupQl8KVxRhofRmZ8RLCO++bnlSP/NtwEcQ2FzrabvEAFASfZb/+zuMA==
X-Received: by 2002:a37:e31a:0:b0:6b5:c922:897d with SMTP id y26-20020a37e31a000000b006b5c922897dmr23018242qki.634.1658414790377;
        Thu, 21 Jul 2022 07:46:30 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id cb8-20020a05622a1f8800b0031ece8b6666sm1415919qtb.43.2022.07.21.07.46.29
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 07:46:30 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id i206so3140806ybc.5
        for <linux-fbdev@vger.kernel.org>; Thu, 21 Jul 2022 07:46:29 -0700 (PDT)
X-Received: by 2002:a05:6902:154f:b0:66e:e2d3:ce1 with SMTP id
 r15-20020a056902154f00b0066ee2d30ce1mr38429480ybu.365.1658414789102; Thu, 21
 Jul 2022 07:46:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220720142732.32041-1-tzimmermann@suse.de> <20220720142732.32041-5-tzimmermann@suse.de>
In-Reply-To: <20220720142732.32041-5-tzimmermann@suse.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 21 Jul 2022 16:46:17 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWEah62Ho4C8NQr-qwz62pKQiJiTi8Fa4KcXNRzo7ySJA@mail.gmail.com>
Message-ID: <CAMuHMdWEah62Ho4C8NQr-qwz62pKQiJiTi8Fa4KcXNRzo7ySJA@mail.gmail.com>
Subject: Re: [PATCH v2 04/10] drm/simpledrm: Compute framebuffer stride if not set
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
        Maxime Ripard <maxime@cerno.tech>,
        Sam Ravnborg <sam@ravnborg.org>,
        Michal Suchanek <msuchanek@suse.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        DRI Development <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Thomas,

On Wed, Jul 20, 2022 at 4:27 PM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Compute the framebuffer's scanline stride length if not given by
> the simplefb data.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Thanks for your patch!

> --- a/drivers/gpu/drm/tiny/simpledrm.c
> +++ b/drivers/gpu/drm/tiny/simpledrm.c
> @@ -743,6 +743,9 @@ static struct simpledrm_device *simpledrm_device_create(struct drm_driver *drv,
>                 drm_err(dev, "no simplefb configuration found\n");
>                 return ERR_PTR(-ENODEV);
>         }
> +       if (!stride)
> +               stride = format->cpp[0] * width;

DIV_ROUND_UP(drm_format_info_bpp(format) * width, 8)

> +
>         sdev->mode = simpledrm_mode(width, height);
>         sdev->format = format;
>         sdev->pitch = stride;

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
