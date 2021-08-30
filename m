Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D9CC432BE
	for <linux-fbdev@archiver.kernel.org>; Mon, 30 Aug 2021 12:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D01A611BD
	for <linux-fbdev@archiver.kernel.org>; Mon, 30 Aug 2021 12:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236839AbhH3MBh (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 30 Aug 2021 08:01:37 -0400
Received: from mail-ua1-f52.google.com ([209.85.222.52]:46855 "EHLO
        mail-ua1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236728AbhH3MB0 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 30 Aug 2021 08:01:26 -0400
Received: by mail-ua1-f52.google.com with SMTP id 37so7636877uau.13;
        Mon, 30 Aug 2021 05:00:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=11pv2ckVVYJo0g4/dbYTk5+xKODOJ86Wt8N4FuAzkzw=;
        b=VCeFCXkpc19Fxput7VuqSZCbboy/tLCOETkgE/21mkZUWXGdS4858xwt8sQ0jC4qAA
         srxLPb8TTn6TO/P+Go61p6p265vifvqjK7LFapmumXGO5Zm2SmT+AbAz4aDdYL7VpGZT
         62Xw/Agena5GSVxnx42Cc5KutdSRXU5nBo6RmYmcn+NOmmyWQE2USS7trvjgQOLznPjC
         MnCXts2GcU3ve+vJKAqb8a7MWSlOoVzpcU3Rei2guTLDFUsh5O8R4qH+yZkpKtgFKvHC
         Xd1kfxCbqVNlgpk9TGD+7Hnmco8CrkT+QKIJ8lCTD7J9ms+1NUciRzbEkFQr8dpAe+tk
         3nrQ==
X-Gm-Message-State: AOAM5329bkHhVuelYIQl7nzjufjXjBKlJdSq1cH9FJDfpBIE0uMwLHJP
        /vGuY8ksQHv3KPrvewE1ebJo55I3sjO7NTXymxM=
X-Google-Smtp-Source: ABdhPJx00PUliqMVjy2+H+sP6oRkhmzsJ7PVLxQZrrTPRL/WUVNKSBJfsgZ5OfJP//LA62PgPuSisoNK8onZSU+t6oM=
X-Received: by 2002:ab0:6887:: with SMTP id t7mr14100361uar.114.1630324832645;
 Mon, 30 Aug 2021 05:00:32 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000815b9605c70e74f8@google.com> <131b24e5-ee31-6f7b-42b4-c34583711913@infradead.org>
 <2fccb5d3-191c-924e-159f-1c9d423e282f@i-love.sakura.ne.jp>
In-Reply-To: <2fccb5d3-191c-924e-159f-1c9d423e282f@i-love.sakura.ne.jp>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 30 Aug 2021 14:00:21 +0200
Message-ID: <CAMuHMdV=xVhEHLEoYt3OF+kmGrLOr6t7SP1sghSmp9JqXD+3Og@mail.gmail.com>
Subject: Re: [syzbot] BUG: unable to handle kernel paging request in vga16fb_fillrect
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
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

Hi Testsuo,

On Mon, Aug 30, 2021 at 4:27 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2021/08/30 9:24, Randy Dunlap wrote:
> > Note that yres_virtual is set to 0x10000000. Is there no practical limit
> > (hence limit check) that can be used here?
> >
> > Also, in vga16fb_check_var(), beginning at line 404:
> >
> >   404        if (yres > vyres)
> >   405            vyres = yres;
> >   406        if (vxres * vyres > maxmem) {
> >   407            vyres = maxmem / vxres;
> >   408            if (vyres < yres)
> >   409                return -ENOMEM;
> >   410        }
> >
> > At line 406, the product of vxres * vyres overflows 32 bits (is 0 in this
> > case/example), so any protection from this block is lost.
>
> OK. Then, we can check overflow like below.
>
> diff --git a/drivers/video/fbdev/vga16fb.c b/drivers/video/fbdev/vga16fb.c
> index e2757ff1c23d..e483a3f5fd47 100644
> --- a/drivers/video/fbdev/vga16fb.c
> +++ b/drivers/video/fbdev/vga16fb.c
> @@ -403,7 +403,7 @@ static int vga16fb_check_var(struct fb_var_screeninfo *var,
>
>         if (yres > vyres)
>                 vyres = yres;
> -       if (vxres * vyres > maxmem) {
> +       if ((u64) vxres * vyres > (u64) maxmem) {

Mindlessly changing the sizes is not the solution.
Please use e.g. the array_size() helper from <linux/overflow.h>
instead.

>                 vyres = maxmem / vxres;
>                 if (vyres < yres)
>                         return -ENOMEM;
>
> But I think we can check overflow in the common code like below. (Both patch fixed the oops.)
>
> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> index 1c855145711b..8899679bbc46 100644
> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -1008,6 +1008,11 @@ fb_set_var(struct fb_info *info, struct fb_var_screeninfo *var)
>         if (var->xres < 8 || var->yres < 8)
>                 return -EINVAL;
>
> +       /* Don't allow u32 * u32 to overflow. */
> +       if ((u64) var->xres * var->yres > (u64) UINT_MAX ||
> +           (u64) var->xres_virtual * var->yres_virtual > (u64) UINT_MAX)
> +               return -EINVAL;
> +

Same comment here, of course.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
