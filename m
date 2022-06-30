Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E58FC433EF
	for <linux-fbdev@archiver.kernel.org>; Thu, 30 Jun 2022 19:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236491AbiF3ThD (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 30 Jun 2022 15:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235686AbiF3ThD (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 30 Jun 2022 15:37:03 -0400
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A0443AED
        for <linux-fbdev@vger.kernel.org>; Thu, 30 Jun 2022 12:37:00 -0700 (PDT)
Received: by mail-qv1-f52.google.com with SMTP id i17so679732qvo.13
        for <linux-fbdev@vger.kernel.org>; Thu, 30 Jun 2022 12:37:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p6c5f2NCl92cN1Bu7KR0c/XkNY03WVgxoY3koBCNk38=;
        b=hnFvnt5auXbdDw4HDTPaP+fwOF8D7eYobaIw2p49FaDBO0loqjo1d8jUIT/X6SlEqx
         Ubu0qcJKguVIqAd3LcDo8iOJS5cI0XrkbWcg2valByz6XUOdg1ZK+d0ei+Iqr+6mWeAB
         9stUJJ68U7gYq8F34SyA5AXs/n3R/5hwrHqQaXfrjR8lQCJHlFY/G79GLwMRWOs/WoME
         ETeaTUurcKf53rgniMZjYzN7FNsg8sdGMSwowkuQl8QHBCYU3MlEpDIsBN2muXpRUY8W
         Kkcz4Tp6DQh3dCpuI8hXDHbcazplSE2vVndRPnuqE5lMDq8d0MmdF/mqhK+ya/ndV3BV
         PPtQ==
X-Gm-Message-State: AJIora/yxT91OoXEk6AgnFSnNBtHu4/vUp05vXupMk/JHnk4GL3NtpQO
        5cHW122NrKjtXs3QNm2elHcxBA2DT5VdQQ==
X-Google-Smtp-Source: AGRyM1uj+Jaq10bN+7GtW7RItfpj4USzuvBixdeod/haTSr8xi4uym8sDcB7V+j199oVHv2AYwQayA==
X-Received: by 2002:a05:622a:50d:b0:304:f438:c464 with SMTP id l13-20020a05622a050d00b00304f438c464mr9268347qtx.323.1656617818835;
        Thu, 30 Jun 2022 12:36:58 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id n65-20020a37a444000000b006aee8fa79adsm15494348qke.36.2022.06.30.12.36.58
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 12:36:58 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id d5so213701yba.5
        for <linux-fbdev@vger.kernel.org>; Thu, 30 Jun 2022 12:36:58 -0700 (PDT)
X-Received: by 2002:a05:6902:120e:b0:634:6f29:6b84 with SMTP id
 s14-20020a056902120e00b006346f296b84mr11068429ybu.604.1656617818106; Thu, 30
 Jun 2022 12:36:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220629200024.187187-1-deller@gmx.de> <20220629200024.187187-3-deller@gmx.de>
 <CAMuHMdXJRBywf+h_u1jgA6X7hLSByDDwSkskff47a0BHfd93iA@mail.gmail.com> <0c418b7d-474a-3f93-a1fb-2f13c4d19941@gmx.de>
In-Reply-To: <0c418b7d-474a-3f93-a1fb-2f13c4d19941@gmx.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 30 Jun 2022 21:36:46 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUoMJ6CmiKDh4MW_b-7uoxEF+H6QimsA7SfcE5kjo17vw@mail.gmail.com>
Message-ID: <CAMuHMdUoMJ6CmiKDh4MW_b-7uoxEF+H6QimsA7SfcE5kjo17vw@mail.gmail.com>
Subject: Re: [PATCH 2/5] fbcon: Fix up user-provided virtual screen size
To:     Helge Deller <deller@gmx.de>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Helge,

On Thu, Jun 30, 2022 at 9:31 PM Helge Deller <deller@gmx.de> wrote:
> On 6/30/22 21:00, Geert Uytterhoeven wrote:
> > On Wed, Jun 29, 2022 at 10:00 PM Helge Deller <deller@gmx.de> wrote:
> >> The virtual screen size can't be smaller than the physical screen size.
> >> Based on the general rule that we round up user-provided input if
> >> neccessary, adjust the virtual screen size as well if needed.
> >>
> >> Signed-off-by: Helge Deller <deller@gmx.de>
> >> Cc: stable@vger.kernel.org # v5.4+
> >
> > Thanks for your patch!
> >
> >> --- a/drivers/video/fbdev/core/fbmem.c
> >> +++ b/drivers/video/fbdev/core/fbmem.c
> >> @@ -1106,6 +1106,11 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
> >>                         return -EFAULT;
> >>                 console_lock();
> >>                 lock_fb_info(info);
> >> +               /* adjust virtual screen size if user missed it */
> >> +               if (var.xres_virtual < var.xres)
> >> +                       var.xres_virtual = var.xres;
> >> +               if (var.yres_virtual < var.yres)
> >> +                       var.yres_virtual = var.yres;
> >>                 ret = fb_set_var(info, &var);
> >>                 if (!ret)
> >>                         fbcon_update_vcs(info, var.activate & FB_ACTIVATE_ALL);
> >
> > Given "[PATCH 4/5] fbmem: Prevent invalid virtual screen sizes in
> > fb_set_var", I don't think we need this patch.
>
> We do.

Why? It will be caught by [PATCH 4/5].

> > Moreover, this
> > patch will prevent triggering the WARN_ON()s in [PATCH 4/5]
>
> Right.
>
> > in the most common buggy case of drivers plainly ignoring var.[xy]res_virtual.
>
> In summary:
> This patch #2 is fixing up user-space invalid input and is not
> allowed to trigger any WARN_ON().

It's the responsibility of the driver to at least look at its parameters.
What other invalid values might it let pass, that we cannot catch
at the generic level?

> We could drop patch #4, but then we wouldn't catch bad drivers.

I do want to keep patch #4.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
