Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE57C433EF
	for <linux-fbdev@archiver.kernel.org>; Fri,  1 Jul 2022 14:50:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233586AbiGAOuI (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 1 Jul 2022 10:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233544AbiGAOuH (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Fri, 1 Jul 2022 10:50:07 -0400
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6107EE74
        for <linux-fbdev@vger.kernel.org>; Fri,  1 Jul 2022 07:50:06 -0700 (PDT)
Received: by mail-qk1-f169.google.com with SMTP id z7so1971337qko.8
        for <linux-fbdev@vger.kernel.org>; Fri, 01 Jul 2022 07:50:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gNmMPejZxFSddU5yd/bVeRCt+NvlGBtVWJ+UptuK+EM=;
        b=hDyJpu9g1Bb3cOo5lhOXXV7BF5a4kBhZHYVl1hkkUp2v/dOfWgt9C20aVtLkssR16M
         9kWIeeuPmMDbR5+i44EC/2azewdMVB6gKJMAksBi3zqYYg3+tX/SP4sPU3/E/7DIWPxO
         z7oTaqRIJ8PJzPGj1/79KXsRKYzuRGjr9MLcaWgEjbhfhRkR6pw7AufDx8mlL+J0AHX0
         SeH2NEBLFneTgEUWiHuqNs4qkgrpulGApag0N8erQl4feUsPptogVtEOFqLVEaR6Ze4T
         VmpRGD62W16nzafqie9jinQdrPjB9wlemTYH6jnRng7rbyrPaCZKQQrYMYK5DW1g1Epk
         QHkw==
X-Gm-Message-State: AJIora/pAyNI+aSCxfjIXjGav6GtTuVrrTqSFtYQa27JQevWBxusbRMw
        pM4FUFnoKg3Doe5lAfWtjN1L/ByLP/lkTw==
X-Google-Smtp-Source: AGRyM1sxPZRRKp7ZDN8u3S4kJjDpqXN0qRk6sLSi0LdUKkhivl72UoCPZNBCl4MRIdorKK4d14150g==
X-Received: by 2002:a05:620a:1787:b0:6af:451a:282 with SMTP id ay7-20020a05620a178700b006af451a0282mr10042448qkb.682.1656687005364;
        Fri, 01 Jul 2022 07:50:05 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id o19-20020a05622a045300b00304ecf35b50sm15935603qtx.97.2022.07.01.07.50.04
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Jul 2022 07:50:05 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-317741c86fdso26211687b3.2
        for <linux-fbdev@vger.kernel.org>; Fri, 01 Jul 2022 07:50:04 -0700 (PDT)
X-Received: by 2002:a81:a092:0:b0:318:5c89:a935 with SMTP id
 x140-20020a81a092000000b003185c89a935mr17867481ywg.383.1656687004729; Fri, 01
 Jul 2022 07:50:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220629200024.187187-1-deller@gmx.de> <20220629200024.187187-5-deller@gmx.de>
 <CAMuHMdVJ0PsDyTdGoOHPOKdaR7AffG2FpFmw6fxoNdXx9y-J4A@mail.gmail.com>
 <1ba5f6d6-1c31-a8fb-867b-e2a7fda7da56@gmx.de> <CAMuHMdVMp-ywWmDevdZTwHHhdiHnsFhze376guTEMd1T=tb-Pg@mail.gmail.com>
In-Reply-To: <CAMuHMdVMp-ywWmDevdZTwHHhdiHnsFhze376guTEMd1T=tb-Pg@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 1 Jul 2022 16:49:53 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVs1J0kvA2Kinx121vF=35dUEY+1Jrx3sjF3NHoD=wMfQ@mail.gmail.com>
Message-ID: <CAMuHMdVs1J0kvA2Kinx121vF=35dUEY+1Jrx3sjF3NHoD=wMfQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] fbmem: Prevent invalid virtual screen sizes in fb_set_var()
To:     Helge Deller <deller@gmx.de>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Helge,

On Thu, Jun 30, 2022 at 9:38 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Thu, Jun 30, 2022 at 9:17 PM Helge Deller <deller@gmx.de> wrote:
> > On 6/30/22 21:11, Geert Uytterhoeven wrote:
> > > On Wed, Jun 29, 2022 at 10:00 PM Helge Deller <deller@gmx.de> wrote:
> > >> Prevent that drivers configure a virtual screen resolution smaller than
> > >> the physical screen resolution.  This is important, because otherwise we
> > >> may access memory outside of the graphics memory area.
> > >>
> > >> Signed-off-by: Helge Deller <deller@gmx.de>
> > >> Cc: stable@vger.kernel.org # v5.4+
> > >
> > > Thanks for your patch!
> > >
> > >> --- a/drivers/video/fbdev/core/fbmem.c
> > >> +++ b/drivers/video/fbdev/core/fbmem.c
> > >> @@ -1006,6 +1006,12 @@ fb_set_var(struct fb_info *info, struct fb_var_screeninfo *var)
> > >>         if (var->xres < 8 || var->yres < 8)
> > >>                 return -EINVAL;
> > >>
> > >> +       /* make sure virtual resolution >= physical resolution */
> > >> +       if (WARN_ON(var->xres_virtual < var->xres))
> > >> +               var->xres_virtual = var->xres;
> > >> +       if (WARN_ON(var->yres_virtual < var->yres))
> > >> +               var->yres_virtual = var->yres;
> > >
> > > This should be moved below the call to info->fbops->fb_check_var(),
> > > so the WARN_ON() catches buggy fbdev drivers, not userspace fuzzers.
> >
> > Yes, makes sense.
>
> And print the name of the frame buffer device driver, so people know
> who to blame.

Or better, do not continue, but return with a failure:

    if (WARN(var->xres_virtual < var->xres || var->yres_virtual < var->yres,
        "%ps for %s is broken\n", info->fbops->fb_check_var, info->fix.id)
            return -EINVAL;

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
