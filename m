Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E170DC12002
	for <linux-fbdev@archiver.kernel.org>; Mon, 19 Jul 2021 07:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C72FE61164
	for <linux-fbdev@archiver.kernel.org>; Mon, 19 Jul 2021 07:53:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234778AbhGSH4t (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 19 Jul 2021 03:56:49 -0400
Received: from mail-ua1-f54.google.com ([209.85.222.54]:35698 "EHLO
        mail-ua1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235180AbhGSH4q (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 19 Jul 2021 03:56:46 -0400
Received: by mail-ua1-f54.google.com with SMTP id n61so6493301uan.2;
        Mon, 19 Jul 2021 00:53:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UFrHGkePZup1taj30Rt41mFp0n9XCiwOIs/xt1tbnaw=;
        b=ILbqZWvTJ4tnouXLPQmgYQhcoUF9/+cAIYgUjJbF0zcCAcWJcwAEcIRXWs/zvynuzZ
         HJx2hYBqI8YtidL3XlaDBILFYUzzS+p2boNhgF2Hr3xaav2OLSLq/PWdHkUWTD1ULZW8
         2YxcM1NZJzJDLarp7S1Ut2q5RqcOD8N3U6RK+5ZB61eY2cPwTPy5zlY9iPgc7zXmh/Y9
         rtRBw15hG5TrG2S2zHOF/F5tr7hMyX/u94wN8ZIPS50+TXgiJ3dthcDb12FoV7Dh4I2n
         RWoDy0eP0qZ/8keeFIwwhl4jYxPuaktVxl0UZ8WDJzWztYImUUEn1HcU4GUlw5LaIyYn
         y7AQ==
X-Gm-Message-State: AOAM5324RULE5Dm+9m9/N9mPwofzWP5ZBnCsVaaIMBVP0r7c8zV4IPSc
        si+ocUseyrm5QXSZNrLWNXIcIE7Op5C5mk4AVYw=
X-Google-Smtp-Source: ABdhPJzXmKaiICvApSnCr48W0kVIIhAe0HClSDvRY/+X8t7EqH9YSmdjsOer92Kdg8iWZJTvPkJd3JyN+8IpVFrQ92Y=
X-Received: by 2002:a9f:3f0d:: with SMTP id h13mr24866271uaj.100.1626681220672;
 Mon, 19 Jul 2021 00:53:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210718133920.15825-1-len.baker@gmx.com> <CAHp75VeEA0=KFsfdjCnBm-b9+F+NnFWJ38nkh+qtb85XdXVWog@mail.gmail.com>
In-Reply-To: <CAHp75VeEA0=KFsfdjCnBm-b9+F+NnFWJ38nkh+qtb85XdXVWog@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 19 Jul 2021 09:53:29 +0200
Message-ID: <CAMuHMdXnhzumSrr=MAkv5nwY2o8xCa4s5zKa9meJTuo0r9yABw@mail.gmail.com>
Subject: Re: [PATCH] staging/fbtft: Remove all strcpy() uses
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Len Baker <len.baker@gmx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Phil Reid <preid@electromag.com.au>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Sun, Jul 18, 2021 at 9:43 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Sun, Jul 18, 2021 at 4:43 PM Len Baker <len.baker@gmx.com> wrote:
> > strcpy() performs no bounds checking on the destination buffer. This
> > could result in linear overflows beyond the end of the buffer, leading
> > to all kinds of misbehaviors. The safe replacement is strscpy() but in
> > this case it is simpler to add NULL to the first position since we want

"NULL" is a pointer value, "NUL" is the character with value zero.

> > to empty the string.
>
> > This is a previous step in the path to remove the strcpy() function.
>
> Any document behind this (something to read on the site(s) more or
> less affiliated with what is going to happen in the kernel) to read
> background?
>
> ...
>
> >                 case -1:
> >                         i++;
> >                         /* make debug message */
> > -                       strcpy(msg, "");

While this strcpy() is provably safe at compile-time, and will probably
be replaced by an assignment to zero by the compiler...

> > +                       msg[0] = 0;
>
> Strictly speaking it should be '\0'.
>
> >                         j = i + 1;
> >                         while (par->init_sequence[j] >= 0) {
> >                                 sprintf(str, "0x%02X ", par->init_sequence[j]);

... the real danger is the

        strcat(msg, str);

on the next line.
Fortunately this whole debug printing block (including the strcpy)
can (and should) be rewritten to just use "%*ph".

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
