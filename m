Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0CE0C07E9B
	for <linux-fbdev@archiver.kernel.org>; Tue, 20 Jul 2021 09:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA2CB610F7
	for <linux-fbdev@archiver.kernel.org>; Tue, 20 Jul 2021 09:17:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233350AbhGTIgz (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 20 Jul 2021 04:36:55 -0400
Received: from mail-vs1-f48.google.com ([209.85.217.48]:42820 "EHLO
        mail-vs1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234809AbhGTIgB (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 20 Jul 2021 04:36:01 -0400
Received: by mail-vs1-f48.google.com with SMTP id u7so10867964vst.9;
        Tue, 20 Jul 2021 02:16:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pGK4Y9q1wNdkFd2qkEzt4SoJHeKZj51kb/6+Vc2cCrE=;
        b=HkD5FyjvnacsybfiyGgnoE3eHRIvRdfujN3HyK8qaCoRsGE3fv86T3BD3eGDe5EIPB
         aruLvK9JsDCSPxttsJj2L2PN8TQpIPIet8e3mJIjEPuFAX/B3HrTwa3sZ4oMgOmlRuNC
         mOAXdue1fcLLNF6haY5NvDMUw/GqFTFMlFP3r7NrtV0E/4oNY5Lv72+chzr2UiU4fKZm
         e/uLXITaAj4jSoQ03oCh+/lqWnhnJZ0tqu5oKelJivOMl1cyDG1G5sykd6vMfixR+LIK
         jAZjdUEpKfJCYIWk8TPPbmeB+apQ/ZwxdgmgZRcKWsfGZyO7aVFiz8T4lnL/LY26VO1b
         vuyg==
X-Gm-Message-State: AOAM530u1jWUVA32ugMUdtiDOoPBFsUQxqp+57ZWlOS80GatYk0A1kGV
        f9d5zjsp0BqkZoBosdWTliGCClC+iwdi3xPTsps=
X-Google-Smtp-Source: ABdhPJwoXV/bWgXqVc9IJcEEctt4YRmAEI9f2fx6tde3GwJo5sjH+AcIOE8BcMkUYIB6TTzpfyMnpZ0rvcI6B2cggsM=
X-Received: by 2002:a67:3c2:: with SMTP id 185mr27684696vsd.42.1626772598880;
 Tue, 20 Jul 2021 02:16:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210714145804.2530727-1-geert@linux-m68k.org>
 <20210714145804.2530727-5-geert@linux-m68k.org> <YPXQnlpWUa1QaZKd@ravnborg.org>
 <CAMuHMdVyuzQzXF0X3OA=PH4E4ifaT2TfHs76yGgRKk-XrEbwzw@mail.gmail.com>
In-Reply-To: <CAMuHMdVyuzQzXF0X3OA=PH4E4ifaT2TfHs76yGgRKk-XrEbwzw@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 20 Jul 2021 11:16:27 +0200
Message-ID: <CAMuHMdVpxVJx8=aGasrop6soO011gby8Xxotr+Yomi9oBOTrpA@mail.gmail.com>
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

On Tue, Jul 20, 2021 at 9:56 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Mon, Jul 19, 2021 at 9:21 PM Sam Ravnborg <sam@ravnborg.org> wrote:
> > On Wed, Jul 14, 2021 at 04:58:03PM +0200, Geert Uytterhoeven wrote:
> > > Currently, each screen update triggers an I2C transfer of all screen
> > > data, up to 1 KiB of data for a 128x64 display, which takes at least 20
> > > ms in Fast mode.
> > >
> > > Reduce the amount of transferred data by only updating the rectangle
> > > that changed.  Remove the call to ssd1307fb_set_address_range() during
> > > initialization, as ssd1307fb_update_rect() now takes care of that.
> > >
> > > Note that for now the optimized operation is only used for fillrect,
> > > copyarea, and imageblit, which are used by fbcon.
> > >
> > > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>
> > > --- a/drivers/video/fbdev/ssd1307fb.c
> > > +++ b/drivers/video/fbdev/ssd1307fb.c
> > > @@ -184,16 +184,18 @@ static int ssd1307fb_set_address_range(struct ssd1307fb_par *par, u8 col_start,
> > >       return ssd1307fb_write_cmd(par->client, page_end);
> > >  }
> > >
> > > -static int ssd1307fb_update_display(struct ssd1307fb_par *par)
> > > +static int ssd1307fb_update_rect(struct ssd1307fb_par *par, unsigned int x,
> > > +                              unsigned int y, unsigned int width,
> > > +                              unsigned int height)
> > >  {
> > >       struct ssd1307fb_array *array;
> > >       u8 *vmem = par->info->screen_buffer;
> > >       unsigned int line_length = par->info->fix.line_length;
> > > -     unsigned int pages = DIV_ROUND_UP(par->height, 8);
> > > +     unsigned int pages = DIV_ROUND_UP(height + y % 8, 8);
> >
> > Add () like this - at least it helps me:
> > > +     unsigned int pages = DIV_ROUND_UP((height + y) % 8, 8);
>
> Thanks, that's actually a genuine bug.

No it's not "(height + y) % 8" is wrong.

Better if I reorder the operands like below?

    unsigned int pages = DIV_ROUND_UP(y % 8 + height, 8);

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
