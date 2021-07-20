Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94AF0C07E95
	for <linux-fbdev@archiver.kernel.org>; Tue, 20 Jul 2021 07:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 709F761175
	for <linux-fbdev@archiver.kernel.org>; Tue, 20 Jul 2021 07:44:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234902AbhGTHDU (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 20 Jul 2021 03:03:20 -0400
Received: from mail-vs1-f54.google.com ([209.85.217.54]:35668 "EHLO
        mail-vs1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234353AbhGTHCz (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 20 Jul 2021 03:02:55 -0400
Received: by mail-vs1-f54.google.com with SMTP id r25so10839671vsk.2;
        Tue, 20 Jul 2021 00:43:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HkbFPSCh7E2GNVgDLGmZQaSXqDJjyX+benlbPIfM6pQ=;
        b=sOwwkhPpQgpEI1A/lLoowhm5e8t+j9cqWMiC1WMZ4xZtkjpJTPhC8aXvJ4iYPuvE1y
         4nwxGfiZj7hvFcxoUqPfdH4fJkCUds0IagEhluxLrboCMb6dQRO8sVpJVdKnMvVVy0x4
         GkVmL45tsd21oSJU6exDAJzN6CRLYB+lv9jvuM37gInqStN2LpwM95wSiLdd7aFOHAb7
         fzBPquQDh0pTKmamSyWjieShJLI+aU7mcnRfoaBxKIfKcWBFs88dMqAyU3Gz/oCOCaCt
         sVajZHeOUdtUJ9BvfHfl52GwFPVb0BfY3/WKoh3ITnjh7HZDd6V15hXER0FJwwrr9+Zy
         Xcjw==
X-Gm-Message-State: AOAM531b1RuRgsA7jzH71GdeBCiJWPxxUsbeT07ujNXyrgUjkh+6IDnN
        RQ2yNSjCnuKd1l8u44PVeFxJGyXYS9S37B7qZoA=
X-Google-Smtp-Source: ABdhPJyYlmc3X5ogaM2YCN+ZHjp31T159xYrBHR1iUCbkq8Cwh9HpbKTX06IJtME6LP+AGswyxAbmP74MJhqkDc7akg=
X-Received: by 2002:a05:6102:321c:: with SMTP id r28mr28139380vsf.40.1626767013827;
 Tue, 20 Jul 2021 00:43:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210714145804.2530727-1-geert@linux-m68k.org>
 <20210714145804.2530727-3-geert@linux-m68k.org> <YPXM8AXNje7GXf+i@ravnborg.org>
In-Reply-To: <YPXM8AXNje7GXf+i@ravnborg.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 20 Jul 2021 09:43:22 +0200
Message-ID: <CAMuHMdXgKkJeTstLdwh9h8ywe0a5=77izAW4eYyaOtk8ktSjWg@mail.gmail.com>
Subject: Re: [PATCH resend 2/5] video: fbdev: ssd1307fb: Simplify ssd1307fb_update_display()
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <mripard@kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Sam,

On Mon, Jul 19, 2021 at 9:05 PM Sam Ravnborg <sam@ravnborg.org> wrote:
> On Wed, Jul 14, 2021 at 04:58:01PM +0200, Geert Uytterhoeven wrote:
> > Simplify the nested loops to handle conversion from linear frame buffer
> > to ssd1307 page layout:
> >   1. Move last page handling one level up, as the value of "m" is the
> >      same inside a page,
> >   2. array->data[] is filled linearly, so there is no need to
> >      recalculate array_idx over and over again; a simple increment is
> >      sufficient.
> >
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > ---
> >  drivers/video/fbdev/ssd1307fb.c | 17 ++++++++++-------
> >  1 file changed, 10 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
> > index e6b6263e3bef847f..6d7bd025bca1a175 100644
> > --- a/drivers/video/fbdev/ssd1307fb.c
> > +++ b/drivers/video/fbdev/ssd1307fb.c
> > @@ -158,6 +158,7 @@ static int ssd1307fb_update_display(struct ssd1307fb_par *par)
> >       u8 *vmem = par->info->screen_buffer;
> >       unsigned int line_length = par->info->fix.line_length;
> >       unsigned int pages = DIV_ROUND_UP(par->height, 8);
> > +     u32 array_idx = 0;
> >       int ret, i, j, k;
> >
> >       array = ssd1307fb_alloc_array(par->width * pages, SSD1307FB_DATA);
> > @@ -194,19 +195,21 @@ static int ssd1307fb_update_display(struct ssd1307fb_par *par)
> >        */
> >
> >       for (i = 0; i < pages; i++) {
> > +             int m = 8;
> > +
> > +             /* Last page may be partial */
> > +             if (i + 1 == pages && par->height % 8)
> > +                     m = par->height % 8;
> >               for (j = 0; j < par->width; j++) {
> > -                     int m = 8;
> > -                     u32 array_idx = i * par->width + j;
> > -                     array->data[array_idx] = 0;
> > -                     /* Last page may be partial */
> > -                     if (i + 1 == pages && par->height % 8)
> > -                             m = par->height % 8;
> > +                     u8 data = 0;
> > +
> >                       for (k = 0; k < m; k++) {
> If the last page is partial then m will be less than 8 for all bytes in
> j = 0..par-width - but m should only be less than 8 for the last
> iteration of the loop.
>
> Do I miss something or is the code buggy?

"the loop" is the j-loop?
If m is less than 8 for the last page, it should be less than 8 for
all iterations of j, as all last bytes in each "line" (visible
row) are partial, cfr. the comments above the code, explaining the
representation of the screen.

> >                               u8 byte = vmem[(8 * i + k) * line_length +
> >                                              j / 8];
> >                               u8 bit = (byte >> (j % 8)) & 1;
> > -                             array->data[array_idx] |= bit << k;
> > +                             data |= bit << k;
> >                       }
> > +                     array->data[array_idx++] = data;
> >               }
> >       }

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
