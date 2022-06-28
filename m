Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB80C43334
	for <linux-fbdev@archiver.kernel.org>; Tue, 28 Jun 2022 08:36:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241877AbiF1Igh (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 28 Jun 2022 04:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiF1Igf (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 28 Jun 2022 04:36:35 -0400
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D15B2D1DF
        for <linux-fbdev@vger.kernel.org>; Tue, 28 Jun 2022 01:36:34 -0700 (PDT)
Received: by mail-qk1-f177.google.com with SMTP id k10so9060612qke.9
        for <linux-fbdev@vger.kernel.org>; Tue, 28 Jun 2022 01:36:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TYku9rjKrdtonQ7P4m2anxgeztiebT4+0Jpg1WxM5fM=;
        b=1Ria7/mfEE3NmgsGsxXqs3nDFJNJC0gS0mErTes92Rz9IMIW3/nlSUfG1+EvlzUpYs
         RmaqCWEMAYKA8dXD+84iPvUb8KxDO7+ryJLc7Yac+2uhjszBSixk/tftJQdarN+w2nX2
         Vc05i+FOHKA3zzu8NjN2MCWWxcX8Oo8XtZxQGetUXWIJE5aeNpzLV4LykmxYa23tGY0R
         9IVdmyM/5X+wj+8TXTnSc3Q+eseV7qAkHP75H2TsL93QW5cUrxwZpgzg6P1muACh5EMR
         nF4sbf4a0eGkQY1iVMZ4Ak58GSW8qX1qv55Z/MQfYRT7wdnPhxVT7uaS8TsinRZnPu4x
         I/Tw==
X-Gm-Message-State: AJIora8AV6HfKUtScgsvgB4irj2jOKscC7suWPAesO6ynKeCn5pp+15x
        +1RKHAYpkL85bT5sY6GkWcWUNFbG2ovvOA==
X-Google-Smtp-Source: AGRyM1tvJf1o4G/YV7n47Hv+mNcH4xNtwMLtTRcgPULbqH6AoLVHZXFnJEYCN61jeIqAocm+ENfhnQ==
X-Received: by 2002:a37:c86:0:b0:6ae:ded5:2002 with SMTP id 128-20020a370c86000000b006aeded52002mr10516076qkm.594.1656405392336;
        Tue, 28 Jun 2022 01:36:32 -0700 (PDT)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id w18-20020a05620a445200b006af16f1b4adsm7221512qkp.35.2022.06.28.01.36.31
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 01:36:31 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-3137316bb69so108890767b3.10
        for <linux-fbdev@vger.kernel.org>; Tue, 28 Jun 2022 01:36:31 -0700 (PDT)
X-Received: by 2002:a81:9bcc:0:b0:317:9ff1:5a39 with SMTP id
 s195-20020a819bcc000000b003179ff15a39mr20769784ywg.384.1656405391417; Tue, 28
 Jun 2022 01:36:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220626102853.124108-1-deller@gmx.de> <20220626102853.124108-3-deller@gmx.de>
In-Reply-To: <20220626102853.124108-3-deller@gmx.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 28 Jun 2022 10:36:19 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV9atrvjFamenRY8UOVZSS2a+Gxsxxo+WfuCpBfuV+n2A@mail.gmail.com>
Message-ID: <CAMuHMdV9atrvjFamenRY8UOVZSS2a+Gxsxxo+WfuCpBfuV+n2A@mail.gmail.com>
Subject: Re: [PATCH v6 2/4] fbmem: Prevent invalid virtual screen sizes
To:     Helge Deller <deller@gmx.de>
Cc:     Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Helge,

On Sun, Jun 26, 2022 at 12:32 PM Helge Deller <deller@gmx.de> wrote:
> Prevent that drivers or the user sets the virtual screen resolution
> smaller than the physical screen resolution.  This is important, because
> otherwise we may access memory outside of the graphics memory area.
>
> Signed-off-by: Helge Deller <deller@gmx.de>
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: stable@vger.kernel.org # v5.4+

Thanks for your patch, which is now commit fe04405ce5de13a5 ("fbmem:
Prevent invalid virtual screen sizes") in fbdev/for-next.

> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -1006,6 +1006,12 @@ fb_set_var(struct fb_info *info, struct fb_var_screeninfo *var)
>         if (var->xres < 8 || var->yres < 8)
>                 return -EINVAL;
>
> +       /* make sure virtual resolution >= physical resolution */
> +       if (var->xres_virtual < var->xres)
> +               return -EINVAL;
> +       if (var->yres_virtual < var->yres)
> +               return -EINVAL;

This breaks valid use cases (e.g. "fbset -xres <larger-value-than-before>") ,
as the FBIOPUT_VSCREENINFO rule is to round up invalid values,
if possible.

Individual drivers may not follow that rule, so you could indeed end up
with a virtual resolution here if such a driver fails to sanitize var.
So either you have to move this after the call to fbops.fb_check_var()
below, and/or change the code to enlarge virtual resolution to match
physical resolution (at the risk of introducing another regression
with an obscure driver?).

So I'd go for moving it below.  And perhaps add a WARN(), as this
is a driver bug?

> +
>         /* Too huge resolution causes multiplication overflow. */
>         if (check_mul_overflow(var->xres, var->yres, &unused) ||
>             check_mul_overflow(var->xres_virtual, var->yres_virtual, &unused))

Note that doing the multiplication overflow check before calling
fbops.fb_check_var() is fine, as too large values can never be
rounded up to a valid value.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
