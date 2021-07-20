Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63621C07E95
	for <linux-fbdev@archiver.kernel.org>; Tue, 20 Jul 2021 07:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4718961165
	for <linux-fbdev@archiver.kernel.org>; Tue, 20 Jul 2021 07:53:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbhGTHMs (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 20 Jul 2021 03:12:48 -0400
Received: from mail-vs1-f49.google.com ([209.85.217.49]:44581 "EHLO
        mail-vs1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbhGTHLN (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 20 Jul 2021 03:11:13 -0400
Received: by mail-vs1-f49.google.com with SMTP id f4so10782311vsh.11;
        Tue, 20 Jul 2021 00:51:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DZMv92PNWEyH/QL4ILLkJC90/ugfFVFAmOpTreas0WA=;
        b=jLhuOLYicrbYys3/wGtixRHB2Vx+VIY5ZwJuI5izpKmLg4hSs3Fl6LON+W2xV2U/bL
         Dk7o9KEjkdBJyIcgEP6GyGL4BBwtG+lJH0QqPXhH5929H0yYxnqFWCIiQHRzHjYm8bv0
         CWUVGM595WhCTuttTHfgxoa3nTKgUQd9m3nx0q+V3Rh2g/qSjEfAFB9XKT45D4LD0ixO
         mXMHTwlfmNbwL2UZ14uuabD5h8gndtt/XMZZ1TbULxHzLJnEGLk2eDIw/+eAyCeff6m7
         lQZxzoNakN2n8du/RybkQklTJMborBrh1BCZV+QyRBQpoV8nWTpNdX0685o/Agoxs8Z9
         a8kw==
X-Gm-Message-State: AOAM533uFELZR95PY0oOl5crv6hmlOpKnihTUIhuzD9HCeZLyKbPf8bR
        5vTpgs1pqnQpmvARSVtG5Kf8iPQo/2rJuoEsgvE=
X-Google-Smtp-Source: ABdhPJy5ykCKOa7GH2xtwasEaNh2q+NOLASUypUGJI2+3KRHExc/ycIzEpJaXbEHJmfx54Z9yxO7Ae8R7oW52MzL2T8=
X-Received: by 2002:a05:6102:321c:: with SMTP id r28mr28150910vsf.40.1626767503947;
 Tue, 20 Jul 2021 00:51:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210714145804.2530727-1-geert@linux-m68k.org>
 <20210714145804.2530727-4-geert@linux-m68k.org> <YPXNdJNpYoPSpxSb@ravnborg.org>
In-Reply-To: <YPXNdJNpYoPSpxSb@ravnborg.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 20 Jul 2021 09:51:32 +0200
Message-ID: <CAMuHMdUJsLMErGYkr8M3y+yGtVd1YhHAmir2_FEOC7n3=9-yfA@mail.gmail.com>
Subject: Re: [PATCH resend 3/5] video: fbdev: ssd1307fb: Extract ssd1307fb_set_address_range()
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

On Mon, Jul 19, 2021 at 9:07 PM Sam Ravnborg <sam@ravnborg.org> wrote:
> On Wed, Jul 14, 2021 at 04:58:02PM +0200, Geert Uytterhoeven wrote:
> > Extract the code to set the column and page ranges into a helper
> > function.
> >
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > ---
> >  drivers/video/fbdev/ssd1307fb.c | 61 +++++++++++++++++++--------------
> >  1 file changed, 36 insertions(+), 25 deletions(-)
> >
> > diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
> > index 6d7bd025bca1a175..cfa27ea0feab4f01 100644
> > --- a/drivers/video/fbdev/ssd1307fb.c
> > +++ b/drivers/video/fbdev/ssd1307fb.c
> > @@ -152,6 +152,38 @@ static inline int ssd1307fb_write_cmd(struct i2c_client *client, u8 cmd)
> >       return ret;
> >  }
> >
> > +static int ssd1307fb_set_address_range(struct ssd1307fb_par *par, u8 col_start,
> > +                                    u8 cols, u8 page_start, u8 pages)
> > +{
> Bikeshedding, but I think a dedicated function for col_range and another
> for page_range had been simpler to read.

I agree.
Originally, before I removed the call during initialization, there were
two calls to this function, so it made sense to have a single function.

> With or wihout this change:
> Acked-by: Sam Ravnborg <sam@ravnborg.org>

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
