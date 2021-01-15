Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C0DC433DB
	for <linux-fbdev@archiver.kernel.org>; Fri, 15 Jan 2021 08:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C57C221E9
	for <linux-fbdev@archiver.kernel.org>; Fri, 15 Jan 2021 08:07:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbhAOIH0 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 15 Jan 2021 03:07:26 -0500
Received: from mail-oi1-f179.google.com ([209.85.167.179]:46130 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbhAOIHZ (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 15 Jan 2021 03:07:25 -0500
Received: by mail-oi1-f179.google.com with SMTP id q205so8686432oig.13;
        Fri, 15 Jan 2021 00:07:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KHJ4LFBTeySXrAB0B3j8k7W0q4a43BLWpsk73jsTU8I=;
        b=NoLkyZsN+ZgPjDcb6PrXIWaPgVLiEBhFVaC15tvTWzZTUId5jh5K/2zcATLH8Dbged
         jJRqx2FNWthMvuf3+4DHWomQZJp6WEMEXaxq+Sg988OYZV+tDGMeA2IjcgvTgRIzlRgO
         0v733gm7fvpLvEQbsyRl3nhjFq04gtt3iK89wbJB03+KcE8Fj84HZRjdrOn7Tpt2RXmu
         OeoD0Yidw6DVRPpNyPfvph1PwfPUNKQ/jeQwIxOXXXeca3w5RqhNKRr+Oj/Ah/hiPgQ/
         Ridhjq0vALzeGpzpJLZRZ2P/7f4BzGAey7zbzepgoZEi+XKgzbm3GmFp0DECLawgBnJY
         p2Pg==
X-Gm-Message-State: AOAM531HPJYd5jpuHhRtnXxQY+jzgj6JX1uWIC5QKGQWGDjISXe4WT0G
        4WNMY9Q1e/3YC9I2a02aiqiqxR7Lj8IV0XZNtQU=
X-Google-Smtp-Source: ABdhPJxGZI0PFSd8/9cz6QQtwsEnLh5GsODfVqU6ivhGty9KZLXuVxw9DoF5rLCTCgOv7jS7bGnrUuqWBkh8Mye41/s=
X-Received: by 2002:aca:4b16:: with SMTP id y22mr4929340oia.148.1610698004707;
 Fri, 15 Jan 2021 00:06:44 -0800 (PST)
MIME-Version: 1.0
References: <20200916205434.GA10389@duo.ucw.cz> <87czyf5jjp.fsf@vps.thesusis.net>
 <CAHk-=wjsjC1h7fskwYaaRLykN1ms6ZtxGvucQgmL-zZTfxPdBA@mail.gmail.com>
 <CAKMK7uEGXOC_ci=Drm=Hz+xPGdcoxv8YZ-gcOckoPmu2XijiSA@mail.gmail.com>
 <CAMuHMdVzCjVim4A3eAZzztqUyjb6a2bjmSkgxUnaugQFv42qag@mail.gmail.com> <CAKMK7uEwHu5GLF16wn83PLZUjoJWgF0dcLXwsGkt_aBpOgLt+w@mail.gmail.com>
In-Reply-To: <CAKMK7uEwHu5GLF16wn83PLZUjoJWgF0dcLXwsGkt_aBpOgLt+w@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 15 Jan 2021 09:06:33 +0100
Message-ID: <CAMuHMdUf3eeK=Fr_pasUdXkk_zuicFBqNY+jSnH6EgUgmG+3hA@mail.gmail.com>
Subject: Re: fbcon: remove soft scrollback code (missing Doc. patch)
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Phillip Susi <phill@thesusis.net>, Pavel Machek <pavel@ucw.cz>,
        Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Daniel,

On Thu, Jan 14, 2021 at 5:11 PM Daniel Vetter <daniel@ffwll.ch> wrote:
> On Thu, Jan 14, 2021 at 4:56 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Tue, Jan 12, 2021 at 5:00 PM Daniel Vetter <daniel@ffwll.ch> wrote:
> > > On Sat, Jan 9, 2021 at 12:11 AM Linus Torvalds
> > > <torvalds@linux-foundation.org> wrote:
> > > > On Fri, Jan 8, 2021 at 11:13 AM Phillip Susi <phill@thesusis.net> wrote:
> > > > > > Could we pause this madness? Scrollback is still useful. I needed it
> > > > > > today... it was too small, so command results I was looking for
> > > > > > already scrolled away, but... life will be really painful with 0
> > > > > > scrollback.
> > > > >
> > > > > > You'll need it, too... as soon as you get oops and will want to see
> > > > > > errors just prior to that oops.
> > > > >
> > > > > > If it means I get to maintain it... I'm not happy about it but that's
> > > > > > better than no scrollback.
> > > > >
> > > > > Amen!  What self respecting admin installs a gui on servers?  What do we
> > > > > have to do to get this back in?  What was so buggy with this code that
> > > > > it needed to be removed?  Why was it such a burden to just leave it be?
> > > >
> > > > It really was buggy, with security implications. And we have no maintainers.
> > > >
> > > > So the scroll-back code can't come back until we have a maintainer and
> > > > a cleaner and simpler implementation.
> > > >
> > > > And no, maintaining it really doesn't mean "just get it back to the
> > > > old broken state".
> > > >
> > > > So far I haven't actually seen any patches, which means that it's not
> > > > coming back.
> > > >
> > > > The good news? If you have an actual text VGA console, that should
> > > > still work just fine.
> >
> > IIRC, all of this was written for systems lacking VGA text consoles
> > in the first place...
> >
> > > Also on anything that is remotely modern (i.e. runs a drm kernel
> > > modesetting driver undearneath the fbdev/fbcon stack) there's a pile
> > > more issues on top of just the scrollback/fbcon code being a mess.
> >
> > Would it help to remove DRM_FBDEV_EMULATION (instead)?
>
> It's a problem with the hardware. "Write some registers and done"
> isn't how display blocks work nowadays. So your proposal amounts to
> "no fbdev/fbcon for anything modern-ish".

With "modern-ish" actually meaning: "desktop/gaming/mobile-style
3D-accelerated wide-color display hardware".  There's plenty of display
hardware that doesn't fall into that class, and is served by fbdev (also
out-of-tree due to the moratorium) because of that.

> Also I said "a pile more", most of the issues in fbcon/fbdev code
> apply for all drivers.
>
> > > Specifically the locking is somewhere between yolo and outright
> > > deadlocks. This holds even more so if the use case here is "I want
> > > scrollback for an oops". There's rough sketches for how it could be
> > > solved, but it's all very tricky work.
> >
> > When an oops happens, all bets are off.  At that point, all information
> > you can extract from the system is valuable, and additional locking
> > issues are moot.
>
> Except the first oops then scrolls aways because it's getting buried
> under further fail. Your locking needs to be minimally good enough to
> not make the situation worse.

When an oops happens, all bets are off...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
