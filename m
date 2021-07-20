Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B5C9C07E95
	for <linux-fbdev@archiver.kernel.org>; Tue, 20 Jul 2021 07:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5961761165
	for <linux-fbdev@archiver.kernel.org>; Tue, 20 Jul 2021 07:57:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbhGTHQ4 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 20 Jul 2021 03:16:56 -0400
Received: from mail-vs1-f47.google.com ([209.85.217.47]:37434 "EHLO
        mail-vs1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbhGTHQg (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 20 Jul 2021 03:16:36 -0400
Received: by mail-vs1-f47.google.com with SMTP id r18so10775710vsa.4;
        Tue, 20 Jul 2021 00:57:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u76ZFso6QMLrbaHGGcoA+mUtQA4GgwHmW+WhPdmK3Xk=;
        b=si8yWWuvczpElJ+G4rTB5WQJO+gU1lcYFw1gtgWMJ+Drh7TYfseI+Xkew4FV5Ehy9D
         GMCB3y7WncJJyfgRQOhWvmZHfauvvcpwF9Su6lr1pc8q1+tjiwcC1t6e/eRxXw7AiuCh
         A0891A9YsuxghB6azd8Id6BzZnvM5XzfJ0DGc/XDmcQjmjhsnbPSsLN20WZTvneSJniL
         UIw++2QXYgbr1PSNcrPWA47GnL81NDd1zhLrH/NOusan/sFNDBFfr/37prOqGrsMD6ki
         +m8cyuimOBAg270fDGbhh6hcW87UsRpDEoxhPL87gFDMIY3fGiK+UUhO8ORqf+brGo0q
         QSbg==
X-Gm-Message-State: AOAM530gWw6sAKFeKoTGU02MAWgCC5GignrqcEt/G6YkPLTrEss8dHgN
        2ZUb+KI4djRf3g+PV2j9rMC2t3F9/UobgGvWwsQ=
X-Google-Smtp-Source: ABdhPJyraCkn1488rWpkxZYL7ZH8R1r3G5CQ45R3Arx+9chg4x8zFL4cnxbqoC1QMarh/xMlberMMdgRC4Gq/ndBVro=
X-Received: by 2002:a05:6102:2828:: with SMTP id ba8mr28144523vsb.18.1626767823268;
 Tue, 20 Jul 2021 00:57:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210714145804.2530727-1-geert@linux-m68k.org>
 <20210714145804.2530727-5-geert@linux-m68k.org> <YPXQnlpWUa1QaZKd@ravnborg.org>
In-Reply-To: <YPXQnlpWUa1QaZKd@ravnborg.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 20 Jul 2021 09:56:52 +0200
Message-ID: <CAMuHMdVyuzQzXF0X3OA=PH4E4ifaT2TfHs76yGgRKk-XrEbwzw@mail.gmail.com>
Subject: Re: [PATCH resend 4/5] video: fbdev: ssd1307fb: Optimize screen updates
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

On Mon, Jul 19, 2021 at 9:21 PM Sam Ravnborg <sam@ravnborg.org> wrote:
> On Wed, Jul 14, 2021 at 04:58:03PM +0200, Geert Uytterhoeven wrote:
> > Currently, each screen update triggers an I2C transfer of all screen
> > data, up to 1 KiB of data for a 128x64 display, which takes at least 20
> > ms in Fast mode.
> >
> > Reduce the amount of transferred data by only updating the rectangle
> > that changed.  Remove the call to ssd1307fb_set_address_range() during
> > initialization, as ssd1307fb_update_rect() now takes care of that.
> >
> > Note that for now the optimized operation is only used for fillrect,
> > copyarea, and imageblit, which are used by fbcon.
> >
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

> > --- a/drivers/video/fbdev/ssd1307fb.c
> > +++ b/drivers/video/fbdev/ssd1307fb.c
> > @@ -184,16 +184,18 @@ static int ssd1307fb_set_address_range(struct ssd1307fb_par *par, u8 col_start,
> >       return ssd1307fb_write_cmd(par->client, page_end);
> >  }
> >
> > -static int ssd1307fb_update_display(struct ssd1307fb_par *par)
> > +static int ssd1307fb_update_rect(struct ssd1307fb_par *par, unsigned int x,
> > +                              unsigned int y, unsigned int width,
> > +                              unsigned int height)
> >  {
> >       struct ssd1307fb_array *array;
> >       u8 *vmem = par->info->screen_buffer;
> >       unsigned int line_length = par->info->fix.line_length;
> > -     unsigned int pages = DIV_ROUND_UP(par->height, 8);
> > +     unsigned int pages = DIV_ROUND_UP(height + y % 8, 8);
>
> Add () like this - at least it helps me:
> > +     unsigned int pages = DIV_ROUND_UP((height + y) % 8, 8);

Thanks, that's actually a genuine bug.

> > @@ -226,13 +228,18 @@ static int ssd1307fb_update_display(struct ssd1307fb_par *par)
> >        *  (5) A4 B4 C4 D4 E4 F4 G4 H4
> >        */
> >
> > -     for (i = 0; i < pages; i++) {
> > +     ret = ssd1307fb_set_address_range(par, par->col_offset + x, width,
> > +                                       par->page_offset + y / 8, pages);
> > +     if (ret < 0)
> > +             goto out_free;
> > +
> > +     for (i = y / 8; i < y / 8 + pages; i++) {
> >               int m = 8;
> >
> >               /* Last page may be partial */
> > -             if (i + 1 == pages && par->height % 8)
> > +             if (8 * (i + 1) > par->height)
> >                       m = par->height % 8;
> As before, this looks wrong to me.

Let's sort that out in the other thread...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
