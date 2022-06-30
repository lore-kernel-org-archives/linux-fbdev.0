Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E091AC433EF
	for <linux-fbdev@archiver.kernel.org>; Thu, 30 Jun 2022 19:39:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236405AbiF3TjB (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 30 Jun 2022 15:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236377AbiF3TjA (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 30 Jun 2022 15:39:00 -0400
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AFC23C4BF
        for <linux-fbdev@vger.kernel.org>; Thu, 30 Jun 2022 12:39:00 -0700 (PDT)
Received: by mail-qk1-f180.google.com with SMTP id r138so15147020qke.13
        for <linux-fbdev@vger.kernel.org>; Thu, 30 Jun 2022 12:39:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rkKYgFZp/qSKYESmXqwsAioaMLByN2eEJsgXebEsRR0=;
        b=xG7XpSSiGc4aAFh4ctNA0eH2W9jnM/qpF9NeKTkmKfxaTaUMof4S3hgUNbw+aA/hCZ
         pXoyewb36EvsJ9971iFyGQKvdqCu0S7x5zMrINU7TWWdzwlFSbCDNrKpWGDfADk3ebE8
         YGVIP0HbL5GiMKNPVkJ78FELyE/U17MmDVZkFruhADO8Ty+Cy5Lpin2tSK26p3k+Do6m
         ood9Z5l/tas9uKkpQB/1x6Ufm5k0B7kGHeIlP2LrnBl6wB9Ga/AWEga4im1TDaXwJi7G
         y6DkvFcTz7lmfu8l3UK42dux12uwRy9Bb7xyLr6JJ+nj9LEPo3B4I5T+4Zyo1+P4zc2K
         19Bw==
X-Gm-Message-State: AJIora9KCFlGbYNtI4KvfxHANlN4EfWale2BVPayo1HndhzZ6HWHtVV7
        bdGBGzryMAONSTNwWccPtIG6nO9zPMEmVg==
X-Google-Smtp-Source: AGRyM1t8cJe1ktaC9LphHsbdxIUgPfDz7UZHU3inj8tC/KqKY+S+JWV5s6Ru9KmSU0Tp7RHBrhgP1Q==
X-Received: by 2002:a05:620a:4412:b0:6b2:52d0:e3e2 with SMTP id v18-20020a05620a441200b006b252d0e3e2mr742936qkp.12.1656617939104;
        Thu, 30 Jun 2022 12:38:59 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id a186-20020a3766c3000000b006a37c908d33sm15608722qkc.28.2022.06.30.12.38.58
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 12:38:58 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-3178acf2a92so3456047b3.6
        for <linux-fbdev@vger.kernel.org>; Thu, 30 Jun 2022 12:38:58 -0700 (PDT)
X-Received: by 2002:a81:574c:0:b0:317:7c3a:45be with SMTP id
 l73-20020a81574c000000b003177c3a45bemr12091300ywb.316.1656617938226; Thu, 30
 Jun 2022 12:38:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220629200024.187187-1-deller@gmx.de> <20220629200024.187187-5-deller@gmx.de>
 <CAMuHMdVJ0PsDyTdGoOHPOKdaR7AffG2FpFmw6fxoNdXx9y-J4A@mail.gmail.com> <1ba5f6d6-1c31-a8fb-867b-e2a7fda7da56@gmx.de>
In-Reply-To: <1ba5f6d6-1c31-a8fb-867b-e2a7fda7da56@gmx.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 30 Jun 2022 21:38:47 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVMp-ywWmDevdZTwHHhdiHnsFhze376guTEMd1T=tb-Pg@mail.gmail.com>
Message-ID: <CAMuHMdVMp-ywWmDevdZTwHHhdiHnsFhze376guTEMd1T=tb-Pg@mail.gmail.com>
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

On Thu, Jun 30, 2022 at 9:17 PM Helge Deller <deller@gmx.de> wrote:
> On 6/30/22 21:11, Geert Uytterhoeven wrote:
> > On Wed, Jun 29, 2022 at 10:00 PM Helge Deller <deller@gmx.de> wrote:
> >> Prevent that drivers configure a virtual screen resolution smaller than
> >> the physical screen resolution.  This is important, because otherwise we
> >> may access memory outside of the graphics memory area.
> >>
> >> Signed-off-by: Helge Deller <deller@gmx.de>
> >> Cc: stable@vger.kernel.org # v5.4+
> >
> > Thanks for your patch!
> >
> >> --- a/drivers/video/fbdev/core/fbmem.c
> >> +++ b/drivers/video/fbdev/core/fbmem.c
> >> @@ -1006,6 +1006,12 @@ fb_set_var(struct fb_info *info, struct fb_var_screeninfo *var)
> >>         if (var->xres < 8 || var->yres < 8)
> >>                 return -EINVAL;
> >>
> >> +       /* make sure virtual resolution >= physical resolution */
> >> +       if (WARN_ON(var->xres_virtual < var->xres))
> >> +               var->xres_virtual = var->xres;
> >> +       if (WARN_ON(var->yres_virtual < var->yres))
> >> +               var->yres_virtual = var->yres;
> >
> > This should be moved below the call to info->fbops->fb_check_var(),
> > so the WARN_ON() catches buggy fbdev drivers, not userspace fuzzers.
>
> Yes, makes sense.

And print the name of the frame buffer device driver, so people know
who to blame.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
