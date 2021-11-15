Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F06C433FE
	for <linux-fbdev@archiver.kernel.org>; Mon, 15 Nov 2021 08:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26FB661B1B
	for <linux-fbdev@archiver.kernel.org>; Mon, 15 Nov 2021 08:35:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbhKOIiV (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 15 Nov 2021 03:38:21 -0500
Received: from mail-ua1-f54.google.com ([209.85.222.54]:41537 "EHLO
        mail-ua1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbhKOIiR (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 15 Nov 2021 03:38:17 -0500
Received: by mail-ua1-f54.google.com with SMTP id p37so31535743uae.8;
        Mon, 15 Nov 2021 00:35:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PmBiLQLwGk4BtQ4xIuEDuY7kvhhjd5riXXU4uoLcz30=;
        b=x5aZuBvbKqgxMPwAaLHVwbTi77f3Aih+N5tMsJQhx2kyBR6CPBq3OPJHmb/EW+VmGO
         Fd308p3wF3Kgd6AajIIvy0uf5yldrZ7xpdsP9FVRwlRd1UK8xo7oYjKmXGWBZKFmv2Nk
         1REBBl5cjDwKNX+rBOE8gUVQ0Q9JPzSMyXPPG7yxkUcZusphhCAWLBDju8vRZSCncFIF
         Xu2YPvipIHR54keJux/OknS3ixgeVDh9AOQ/iCJ8yiRByMh3iR1VVO6/GtPw/Xb2f2uz
         18yxMPPKnoy01QGOj4WEkWwb7baumU5HAuMQxuv5zsG4u8qi38eir1DKj6cSgtbpDq7r
         SR2w==
X-Gm-Message-State: AOAM532ZPnjA6jV0FT7DtPLYrhBEEme5b+f9QGz2tA0GvxzMTqvT302x
        1xjjT811kRCpzkCTZtj+OZ3yTz4L7Kujng==
X-Google-Smtp-Source: ABdhPJwFf0yvJR5yS8aPuDBVD1M1j470FPAX9fQVLpTAoC+n4wAXgRvVycsRvye+1FTgk7+5tW8P2g==
X-Received: by 2002:a05:6102:3232:: with SMTP id x18mr34870771vsf.38.1636965321726;
        Mon, 15 Nov 2021 00:35:21 -0800 (PST)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com. [209.85.222.51])
        by smtp.gmail.com with ESMTPSA id f11sm8316621vkk.50.2021.11.15.00.35.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Nov 2021 00:35:21 -0800 (PST)
Received: by mail-ua1-f51.google.com with SMTP id w23so10259066uao.5;
        Mon, 15 Nov 2021 00:35:21 -0800 (PST)
X-Received: by 2002:a9f:248b:: with SMTP id 11mr52047394uar.14.1636965320871;
 Mon, 15 Nov 2021 00:35:20 -0800 (PST)
MIME-Version: 1.0
References: <20211115063257.14369-1-rdunlap@infradead.org>
In-Reply-To: <20211115063257.14369-1-rdunlap@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 15 Nov 2021 09:35:09 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWerZGYz_i8oBK4-ZC+AHZm8c0VW7CXDRX=2PxboWFZ-w@mail.gmail.com>
Message-ID: <CAMuHMdWerZGYz_i8oBK4-ZC+AHZm8c0VW7CXDRX=2PxboWFZ-w@mail.gmail.com>
Subject: Re: [PATCH] fbdev: sh7760fb: document fallthrough cases
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>,
        Manuel Lauss <mano@roarinelk.homelinux.net>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Mon, Nov 15, 2021 at 7:33 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> Fix fallthrough warnings in sh776fb.c:
>
> ../drivers/video/fbdev/sh7760fb.c: In function 'sh7760fb_get_color_info':
> ../drivers/video/fbdev/sh7760fb.c:138:23: warning: this statement may fall through [-Wimplicit-fallthrough=]
>   138 |                 lgray = 1;
> ../drivers/video/fbdev/sh7760fb.c:143:23: warning: this statement may fall through [-Wimplicit-fallthrough=]
>   143 |                 lgray = 1;
>
> Just document the current state of code execution/flow.
>
> Fixes: 4a25e41831ee ("video: sh7760fb: SH7760/SH7763 LCDC framebuffer driver")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Section 30.4.4 ("Data Format") of the SH7760 Group Hardware
Manual confirms fall-through is appropriate here (especially for
the odd 6 bpp mode).

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
