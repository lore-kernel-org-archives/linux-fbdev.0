Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC4FC43334
	for <linux-fbdev@archiver.kernel.org>; Thu, 30 Jun 2022 18:51:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235833AbiF3Svq (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 30 Jun 2022 14:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233100AbiF3Svp (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 30 Jun 2022 14:51:45 -0400
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511792BB3A
        for <linux-fbdev@vger.kernel.org>; Thu, 30 Jun 2022 11:51:43 -0700 (PDT)
Received: by mail-qk1-f182.google.com with SMTP id z16so10278031qkj.7
        for <linux-fbdev@vger.kernel.org>; Thu, 30 Jun 2022 11:51:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OpYaioDW3jT2hu8uqTSIqgPPXpyurlp09tw76Zsm3gA=;
        b=5CMFlhC8MnP5xUECHKOKmOmpCO2fMGuLyDIia6I5lCeZMhoxsOpaOj/BkovGFeWvZ0
         YnRaHGrDWp/Vhh4FPCch8ZcBw1HDGPRV/1X291mPDHY6jCJWVz38gMJO3FIKf6e/lPFI
         xlJKZJ5BIDP8qR+bRy91W0nUepIBhQ3dxrkSeq4+74DiLHgU1RRuvqly0VprEjnNqrKM
         uJSUbzoJ6p7yfUKAQ21w7UH3jHMNtuo5KOydjce4od5Vfo01jb0KDBmjop4VNddju3Fl
         vkiBdb1Sv6DoycFg3HotUGcnFOJ555ZxH5YwTxHi4591meANWAe7UykNANOBR+oh5Nes
         MkPQ==
X-Gm-Message-State: AJIora8xrI+5bvRR5w+ceUnA4kXqSCESE5Jd4/E6s6Q/xXG5jZzeIknM
        C6JO3soRLpC8O1D/Le5TvJSaDrvjOI/qWQ==
X-Google-Smtp-Source: AGRyM1t5u8cC00THr03bZNdllqqN641JNWlNg1wh4XtepCXEdBdUnc8bWUyMA6SRHVqk3nB6T4+ePQ==
X-Received: by 2002:a05:620a:6008:b0:6af:5d81:870b with SMTP id dw8-20020a05620a600800b006af5d81870bmr7383877qkb.763.1656615102277;
        Thu, 30 Jun 2022 11:51:42 -0700 (PDT)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id 142-20020a370994000000b006a73cb957dasm14961195qkj.20.2022.06.30.11.51.41
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 11:51:41 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-317a66d62dfso2220507b3.7
        for <linux-fbdev@vger.kernel.org>; Thu, 30 Jun 2022 11:51:41 -0700 (PDT)
X-Received: by 2002:a81:9bcc:0:b0:317:9ff1:5a39 with SMTP id
 s195-20020a819bcc000000b003179ff15a39mr12759976ywg.384.1656615100904; Thu, 30
 Jun 2022 11:51:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220629200024.187187-1-deller@gmx.de> <20220629200024.187187-2-deller@gmx.de>
In-Reply-To: <20220629200024.187187-2-deller@gmx.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 30 Jun 2022 20:51:29 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWW-oh_q7zE6riS8o+tgRmcOxxO_93-FVy9CVCcAOakhg@mail.gmail.com>
Message-ID: <CAMuHMdWW-oh_q7zE6riS8o+tgRmcOxxO_93-FVy9CVCcAOakhg@mail.gmail.com>
Subject: Re: [PATCH 1/5] fbcon: Disallow setting font bigger than screen size
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
> Prevent that users set a font size which is bigger than the physical screen.
> It's unlikely this may happen (because screens are usually much larger than the
> fonts and each font char is limited to 32x32 pixels), but it may happen on
> smaller screens/LCD displays.
>
> Signed-off-by: Helge Deller <deller@gmx.de>
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Thanks for your patch!

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -2469,6 +2469,11 @@ static int fbcon_set_font(struct vc_data *vc, struct console_font *font,
>         if (charcount != 256 && charcount != 512)
>                 return -EINVAL;
>
> +       /* font bigger than screen resolution ? */
> +       if (font->width  > FBCON_SWAP(info->var.rotate, info->var.xres, info->var.yres) ||
> +           font->height > FBCON_SWAP(info->var.rotate, info->var.yres, info->var.xres))

Note that we already have local vars w and h, albeit with the wrong
signedness.

> +               return -EINVAL;
> +
>         /* Make sure drawing engine can handle the font */
>         if (!(info->pixmap.blit_x & (1 << (font->width - 1))) ||
>             !(info->pixmap.blit_y & (1 << (font->height - 1))))

There were already more opportunities for using w and h before...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
