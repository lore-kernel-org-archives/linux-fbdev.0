Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E252CC433DB
	for <linux-fbdev@archiver.kernel.org>; Wed, 24 Feb 2021 11:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96DFF60C3E
	for <linux-fbdev@archiver.kernel.org>; Wed, 24 Feb 2021 11:36:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234425AbhBXLgb (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 24 Feb 2021 06:36:31 -0500
Received: from mail-oi1-f177.google.com ([209.85.167.177]:34401 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232545AbhBXLga (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 24 Feb 2021 06:36:30 -0500
Received: by mail-oi1-f177.google.com with SMTP id w69so2098290oif.1;
        Wed, 24 Feb 2021 03:36:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V7g4KDGkN4bTV6Y86WxSYXBrPiMRP6Icmxr97tcDgIM=;
        b=EgwRhjOgHFg0j72uBBfZLyOPW4R5XP0jRtrVGgnp0EJ/HlQ8CtKX4It7JnEolzAluH
         HiQ6td+kZGT3zCw6bXHf0cCbUjYjSgn7+7MkMNCyrLTwgkQpYGHalQv+PeYDEcCdvbkr
         EXkQ4UWpDRy+wvbaGiGKYwOfjJOby2mAKjl8ODFrJ56WV3DB3IAWTglykEGCrndpOo6i
         ugylpOA0tas4ADjGAI2Mi25IIP0zBYccdkGwWjNmiucGEc4Mw51vAxgOUnjt5L5UiqAr
         SDuhAQgEwCT5IOqu0TLp3qAdk7nRV1rvw/1BfG5XPsSdaRo973Dw0HegvuqQlsykKc3q
         PSzA==
X-Gm-Message-State: AOAM531y2sniSo+SfFfPGHum01iO7l85ZDlr6PLBwecdmAl0Y0xgqKTm
        YXPvFg2NheWNktJY1M3vuViEiJqadF6n9UZfaOHRo7gPrlY=
X-Google-Smtp-Source: ABdhPJyyC3OgPRc8t7eL+A4bFMUBKjhhxC28ihqPvnbBLD0NPyTb8VvBUkXvZsvXDHxGs0xnf2E2wchLYsmgbSu4vZ0=
X-Received: by 2002:aca:d8c6:: with SMTP id p189mr2430015oig.54.1614166549412;
 Wed, 24 Feb 2021 03:35:49 -0800 (PST)
MIME-Version: 1.0
References: <20210220230248.320870-1-ztong0001@gmail.com> <ea1c5ff3-0b24-71c9-7a44-08b184c4854d@infradead.org>
 <CAA5qM4D0y9-gL7AAMQvtwrfJC_UvSTB5_S5PX3qkYSxHRUS-Qw@mail.gmail.com>
In-Reply-To: <CAA5qM4D0y9-gL7AAMQvtwrfJC_UvSTB5_S5PX3qkYSxHRUS-Qw@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 24 Feb 2021 12:35:37 +0100
Message-ID: <CAMuHMdWM5z-vKRwhCgJHjU-S_L0WR=avmDN-b8dN87b=rgi08w@mail.gmail.com>
Subject: Re: [PATCH] video: fbdev: pm2fb: avoid stall on fb_sync
To:     Tong Zhang <ztong0001@gmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Tong,

On Sun, Feb 21, 2021 at 1:05 AM Tong Zhang <ztong0001@gmail.com> wrote:
> On Sat, Feb 20, 2021 at 6:33 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> > On 2/20/21 3:02 PM, Tong Zhang wrote:
> > > pm2fb_sync is called when doing /dev/fb read or write.
> > > The original pm2fb_sync wait indefinitely on hardware flags which can
> > > possibly stall kernel and make everything unresponsive.
> > > Instead of waiting indefinitely, we can timeout to give user a chance to
> > > get back control.
> >
> > Is this a real problem or theoretical?
> > Does someone still use this driver?
>
> I currently have this problem on my machine.
> I have submitted a revised patch -- which includes the console log.

Your machine is "QEMU Standard"?
Can this happen on real hardware, too, or is this a deficiency in QEMU,
which should be fixed there?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
