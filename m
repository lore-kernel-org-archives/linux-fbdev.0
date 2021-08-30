Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F382C4320E
	for <linux-fbdev@archiver.kernel.org>; Mon, 30 Aug 2021 14:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61D3C6023E
	for <linux-fbdev@archiver.kernel.org>; Mon, 30 Aug 2021 14:30:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237195AbhH3Obp (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 30 Aug 2021 10:31:45 -0400
Received: from mail-vs1-f44.google.com ([209.85.217.44]:40615 "EHLO
        mail-vs1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237181AbhH3Obm (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 30 Aug 2021 10:31:42 -0400
Received: by mail-vs1-f44.google.com with SMTP id d6so4300973vsr.7;
        Mon, 30 Aug 2021 07:30:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VgKhHizq2L8dQZoQcxBfufERxFjnVK3q48k2GBzHxbg=;
        b=gHEekl3GLlnCmOd+FZFDoDl80NkQfMka975uFWQjgPFQ/lNnGYXkXtGwCXC+xGsnsf
         pJE5ClOj7MEyDLhYoiKDNwPd/IZJb0OQ9uRDsUhS1vEayYV5cKkNrUy8wh0xO4N4M3kg
         K3AKMSkO7mWf8JSNCqz/T7LyiWCgRair8f9pklBcm+1LNKsbhBMlBDfpJnzA3MJwlmaY
         2wSnWm6QxR+H0mWlKEZ6Jel8GV4/Su/saBWUpH/Y3wCzbNjSS0I2hiIEkEFaJ6ByibOo
         uWsY6zVEnYKpSsUYy5toRpnpaAs1f5/U+KOJZBKdxQ3RdFjuk4l0zVT6oTKcJS9ZmaOL
         YjGw==
X-Gm-Message-State: AOAM530ZRiWtKnVF1w4BQYd8QrFG/6FsJiAODizUFT9VD9KgiQlTajIp
        7nYKOUeICmS67fm92WSWsu40YRMjHRnzNHsDN/c=
X-Google-Smtp-Source: ABdhPJwXrGuINMzmLOeLoNvKrXr8kded9JMrOcZu3G8T8pbvFnWwxXU9kXJU7O9Mej5MH/LuttPsiK2qv0RDHBrX1gw=
X-Received: by 2002:a67:cb0a:: with SMTP id b10mr14980584vsl.9.1630333847661;
 Mon, 30 Aug 2021 07:30:47 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000815b9605c70e74f8@google.com> <131b24e5-ee31-6f7b-42b4-c34583711913@infradead.org>
 <2fccb5d3-191c-924e-159f-1c9d423e282f@i-love.sakura.ne.jp>
 <CAMuHMdV=xVhEHLEoYt3OF+kmGrLOr6t7SP1sghSmp9JqXD+3Og@mail.gmail.com>
 <20210830130000.GW7722@kadam> <8ed0ca59-226b-2d0e-b1ae-82305202558d@i-love.sakura.ne.jp>
 <20210830134719.GI12231@kadam> <03d0f549-9731-8b06-1393-60d4bef27884@i-love.sakura.ne.jp>
In-Reply-To: <03d0f549-9731-8b06-1393-60d4bef27884@i-love.sakura.ne.jp>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 30 Aug 2021 16:30:36 +0200
Message-ID: <CAMuHMdXp7D02Z_Hs4wT9y4WeNzqdxHMgExiOzVauvpfgf4Veig@mail.gmail.com>
Subject: Re: [syzbot] BUG: unable to handle kernel paging request in vga16fb_fillrect
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        syzbot <syzbot+04168c8063cfdde1db5e@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Colin King <colin.king@canonical.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Tetsuo,

On Mon, Aug 30, 2021 at 4:26 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2021/08/30 22:47, Dan Carpenter wrote:
> > On Mon, Aug 30, 2021 at 10:37:31PM +0900, Tetsuo Handa wrote:
> >> On 2021/08/30 22:00, Dan Carpenter wrote:
> >>>>> diff --git a/drivers/video/fbdev/vga16fb.c b/drivers/video/fbdev/vga16fb.c
> >>>>> index e2757ff1c23d..e483a3f5fd47 100644
> >>>>> --- a/drivers/video/fbdev/vga16fb.c
> >>>>> +++ b/drivers/video/fbdev/vga16fb.c
> >>>>> @@ -403,7 +403,7 @@ static int vga16fb_check_var(struct fb_var_screeninfo *var,
> >>>>>
> >>>>>         if (yres > vyres)
> >>>>>                 vyres = yres;
> >>>>> -       if (vxres * vyres > maxmem) {
> >>>>> +       if ((u64) vxres * vyres > (u64) maxmem) {
> >>>>
> >>>> Mindlessly changing the sizes is not the solution.
> >>>> Please use e.g. the array_size() helper from <linux/overflow.h>
> >>>> instead.
> >>>
> >>> On a 64bit system the array_size() macro is going to do the exact same
> >>> casts?  But I do think this code would be easier to understand if the
> >>> integer overflow check were pull out separately and done first:
> >>>
> >>>     if (array_size(vxres, vyres) >= UINT_MAX)
> >>>             return -EINVAL;
> >>
> >> This is wrong. array_size() returns ULONG_MAX on 64bits upon overflow and
> >> returns UINT_MAX on 32bits upon overflow. However, UINT_MAX is a valid
> >> value without overflow (e.g. vxres == UINT_MAX / 15 && vyres == 15).
> >
> > Huh...  I just assumed we didn't allow resolutions that high.
>
> Of course, we don't allow resolutions that high. ;-)
>
> Since I don't know possible max resolutions, I chose UINT_MAX + 1 as a common
> limit for returning -EINVAL. Unless overflow happens, vga16fb_check_var() will
> return -ENOMEM on such high resolutions.

The highest possible value of maxmem inside vga16fb_check_var()
is 65536.

So I believe

    if (array_size(vxres, vyres) > maxmem)

should work fine.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
