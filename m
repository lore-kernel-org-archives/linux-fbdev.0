Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F826C43334
	for <linux-fbdev@archiver.kernel.org>; Thu, 30 Jun 2022 19:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233070AbiF3TVu (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 30 Jun 2022 15:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236598AbiF3TVt (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 30 Jun 2022 15:21:49 -0400
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3392442EDA
        for <linux-fbdev@vger.kernel.org>; Thu, 30 Jun 2022 12:21:49 -0700 (PDT)
Received: by mail-qv1-f45.google.com with SMTP id c1so632713qvi.11
        for <linux-fbdev@vger.kernel.org>; Thu, 30 Jun 2022 12:21:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a3PYIklwKRbZib6lnKejKJfseVyL5UdoclVR+DLTM0c=;
        b=Uag+mTtL0JoUZRnEPTHKxMvfEyh8FbbgMHKbtxFz3bFOA8w8wi0vpvEiU6aECsbBCS
         G9hsJHxyLPK90A9gkMuCbWlOT4knoqWq1ARts2OClzO/oFPCJQ8bwfIvxBtaTV9qRPW+
         Boqkf+NOAXanLhOdOtikqrf1t3faquRM+dFBtcfX94Wk2j/k/90n+1UMkN4tdrgyp6lI
         /ujBDTPb6fYjzf1VZTXDnPH9BIKAYV1SsZmCLB7LGBnex/K1v3owCTMqfSY2H5FDjVah
         Uhpb87dyOhHeUGP9DOLbAnoO0cAd7W2mIPlJv1bD0F0l+wr1DYPcBvE3VjQ86Qqk/erT
         FdEQ==
X-Gm-Message-State: AJIora8L6hOUfsu6xB7LeLbl7ywfNHShtBSvc9bRqM34SKXANKMXo/uE
        MOQ1gXKNYRBe1bsmmXxHbZzlamzVh88PUA==
X-Google-Smtp-Source: AGRyM1tjXvdXO4MJa+YYzxjBxMOK1dse/8yX/cacSuugswu/GV04w3t/X87lquREXhRNnbB0VgUPyA==
X-Received: by 2002:a05:6214:5d88:b0:470:402d:a3fe with SMTP id mf8-20020a0562145d8800b00470402da3femr12754845qvb.6.1656616908078;
        Thu, 30 Jun 2022 12:21:48 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id bk2-20020a05620a1a0200b006b1490619cdsm3631261qkb.99.2022.06.30.12.21.47
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 12:21:47 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id l11so78248ybu.13
        for <linux-fbdev@vger.kernel.org>; Thu, 30 Jun 2022 12:21:47 -0700 (PDT)
X-Received: by 2002:a05:6902:a:b0:65c:b38e:6d9f with SMTP id
 l10-20020a056902000a00b0065cb38e6d9fmr11777905ybh.36.1656616907463; Thu, 30
 Jun 2022 12:21:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220629200024.187187-1-deller@gmx.de> <20220629200024.187187-6-deller@gmx.de>
In-Reply-To: <20220629200024.187187-6-deller@gmx.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 30 Jun 2022 21:21:36 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXs+m80hPjcbW6XfNrgQYyO8G5McyGSjY5bPqAxQjqk_g@mail.gmail.com>
Message-ID: <CAMuHMdXs+m80hPjcbW6XfNrgQYyO8G5McyGSjY5bPqAxQjqk_g@mail.gmail.com>
Subject: Re: [PATCH 5/5] fbcon: Use fbcon_info_from_console() in fbcon_modechange_possible()
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
> Use the fbcon_info_from_console() wrapper which was added to kernel
> v5.19 with commit 409d6c95f9c6 ("fbcon: Introduce wrapper for console->fb_info lookup").
>
> Signed-off-by: Helge Deller <deller@gmx.de>

Thanks for your patch!

I guess you kept this separate, to ease backporting?
This does mean that upstream will never really see if using
registered_fb[] directly may cause problems...

> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -2752,7 +2752,7 @@ int fbcon_modechange_possible(struct fb_info *info, struct fb_var_screeninfo *va
>         for (i = first_fb_vc; i <= last_fb_vc; i++) {
>                 vc = vc_cons[i].d;
>                 if (!vc || vc->vc_mode != KD_TEXT ||
> -                          registered_fb[con2fb_map[i]] != info)
> +                          fbcon_info_from_console(i) != info)
>                         continue;
>
>                 if (vc->vc_font.width  > FBCON_SWAP(var->rotate, var->xres, var->yres) ||

Anyway, LGTM, so
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
