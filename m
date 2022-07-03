Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C6CC43334
	for <linux-fbdev@archiver.kernel.org>; Sun,  3 Jul 2022 14:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbiGCOmK (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 3 Jul 2022 10:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiGCOmJ (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Sun, 3 Jul 2022 10:42:09 -0400
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506266353
        for <linux-fbdev@vger.kernel.org>; Sun,  3 Jul 2022 07:42:08 -0700 (PDT)
Received: by mail-qk1-f172.google.com with SMTP id b24so5174160qkn.4
        for <linux-fbdev@vger.kernel.org>; Sun, 03 Jul 2022 07:42:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UMzCVrrwT3NphyyJJjToVfwqHb66h1iNReM+vSAJnLg=;
        b=zkO6bDsWsjtKUizHzWlfmcgMrcqwlr6q+RaawaXMWQ7kY8NwvPXi65wAOaegPRsRir
         B2nFjT9S6DK9q3OqpOm1F+SLYnZXBnj847SZGngZWTLX1YoYHkjoZgTu/U/dDux1TzPi
         DZeabGp1ngcQDhNIhg+XLZYmXaR8TD7aN23yYxJM113l+9VI7OvKtqCBdiyyOZDIYZBL
         y0iLtNppSgGJwYM355P4zVU+D/4jhUTW3WU2QfJEQCYQMwbYzf9iWKVRJp9pWuMjvOlf
         QQkjGNDyk1ckMDFAXIhp9iIftAZza1MLBIUZnkhhKpqvBG8HG8qikF94tVDIGnbLVDyT
         fQFA==
X-Gm-Message-State: AJIora/bhnBRqO0jAIsFgGOarvVwLUmgYlHI7STUfaLAr+gToFuz+WlP
        1T56Y/sh5hs6/zjZiLU+hIvhEz0dqTjkag==
X-Google-Smtp-Source: AGRyM1t4PdMbtJdcVnKSHnTeFGSu39Q/BJCyiNzEVmkr5tpFyE++qEBZ3PmzBYievTZ0bmU3ruJJGw==
X-Received: by 2002:a05:620a:2912:b0:6b2:4a02:feae with SMTP id m18-20020a05620a291200b006b24a02feaemr12056686qkp.265.1656859326965;
        Sun, 03 Jul 2022 07:42:06 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id do56-20020a05620a2b3800b006a684c87f4bsm7210285qkb.68.2022.07.03.07.42.06
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Jul 2022 07:42:06 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-317a66d62dfso61426697b3.7
        for <linux-fbdev@vger.kernel.org>; Sun, 03 Jul 2022 07:42:06 -0700 (PDT)
X-Received: by 2002:a81:98d:0:b0:31c:921c:9783 with SMTP id
 135-20020a81098d000000b0031c921c9783mr1929402ywj.316.1656859326344; Sun, 03
 Jul 2022 07:42:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220701202352.559808-1-deller@gmx.de> <20220701202352.559808-4-deller@gmx.de>
 <CAMuHMdUTwM+y+yi5ASY9hQLgJD-4pjtStGA9m82853LmbdywOA@mail.gmail.com> <YsGfdEO4lU+y2004@p100>
In-Reply-To: <YsGfdEO4lU+y2004@p100>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 3 Jul 2022 16:41:54 +0200
X-Gmail-Original-Message-ID: <CAMuHMdULPGmK_K3QeyEpBbO5Dr9_WEszHXDGLzvdv7f3Y2O7vw@mail.gmail.com>
Message-ID: <CAMuHMdULPGmK_K3QeyEpBbO5Dr9_WEszHXDGLzvdv7f3Y2O7vw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] fbmem: Prevent invalid virtual screen sizes in fb_set_var()
To:     Helge Deller <deller@gmx.de>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Helge,

On Sun, Jul 3, 2022 at 3:54 PM Helge Deller <deller@gmx.de> wrote:
> * Geert Uytterhoeven <geert@linux-m68k.org>:
> > > --- a/drivers/video/fbdev/core/fbmem.c
> > > +++ b/drivers/video/fbdev/core/fbmem.c
> > > @@ -1016,6 +1016,18 @@ fb_set_var(struct fb_info *info, struct fb_var_screeninfo *var)
> > >         if (ret)
> > >                 return ret;
> > >
> > > +       /* make sure virtual resolution >= physical resolution */
> > > +       if (WARN_ON(var->xres_virtual < var->xres)) {
> >
> > WARN_ON_ONCE()?
> > This does mean we would miss two or more buggy drivers in a single system.
> >
> > > +               pr_warn("fbcon: Fix up invalid xres %d for %s\n",
> >
> > xres_virtual?
> >
> > > +                       var->xres_virtual, info->fix.id);
> > > +               var->xres_virtual = var->xres;
> >
> > I think it's better to not fix this up, but return -EINVAL instead.
> > After all if we get here, we have a buggy driver that needs to be fixed.
> >
> > > +       }
> > > +       if (WARN_ON(var->yres_virtual < var->yres)) {
> > > +               pr_warn("fbcon: Fix up invalid yres %d for %s\n",
> > > +                       var->yres_virtual, info->fix.id);
> > > +               var->yres_virtual = var->yres;
> > > +       }
> >
> > Same for yres.
>
> Geert, thanks for your valuable feedback!
>
> In general I don't like for this case any of the WARN_ON* functions.
> They don't provide any useful info for us, dumps unneccessarily the
> stack backtrace and would annoy existing users.

Without the stack trace, most people won't notice...

> We know, that DRM drivers can't change the resolution. If we would leave
> in any kind of warning, all DRM users will ask back - and we don't have
> a solution for them. It's also no regression, because it didn't worked
> before either.

The warning will only be triggered when the requested virtual
resolution is smaller than the requested physical resolution.  As
long as the requested virtual and physical resolution match what
was returned by FBIOGET_VSCREENINFO before, the warning won't
be triggered.  So in normal use cases, the user won't be impacted.
Fuzzers will see the warning, but the kernel will no longer crash
on invalid values.

> But we want to detect fbdev drivers which behave badly - so we should
> print that info with the driver name.
>
> Below is a new patch which addresses this. The search for drm drivers
> looks somewhat hackish - maybe someone can propose a better approach?
>
> Thoughts?
>
> Helge
>
>
> From 0f33e2a3730342ab85df372f80b4f61762fb1130 Mon Sep 17 00:00:00 2001
> From: Helge Deller <deller@gmx.de>
> Date: Wed, 29 Jun 2022 15:53:55 +0200
> Subject: [PATCH] fbmem: Check virtual screen sizes in fb_set_var()
>
> Verify that the fbdev or drm driver correctly adjusted the virtual screen
> sizes. On failure report (in case of fbdev drivers) the failing driver.
>
> Signed-off-by: Helge Deller <deller@gmx.de>
> Cc: stable@vger.kernel.org # v5.4+
>
> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> index 160389365a36..9b75aa4405ee 100644
> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -1016,6 +1016,21 @@ fb_set_var(struct fb_info *info, struct fb_var_screeninfo *var)
>         if (ret)
>                 return ret;
>
> +       /* verify that virtual resolution >= physical resolution */
> +       if (var->xres_virtual < var->xres ||
> +           var->yres_virtual < var->yres) {
> +               /* drm drivers don't support mode changes yet. Do not report. */
> +               if (strstr(info->fix.id, "drm"))
> +                       return -ENOTSUPP;
> +
> +               pr_warn("WARNING: fbcon: Driver %s missed to adjust virtual"
> +                       " screen size (%dx%d vs. %dx%d)\n",
> +                       info->fix.id,
> +                       var->xres_virtual, var->yres_virtual,
> +                       var->xres, var->yres);
> +               return -EINVAL;
> +       }
> +
>         if ((var->activate & FB_ACTIVATE_MASK) != FB_ACTIVATE_NOW)
>                 return 0;

Hence I think there is no need for ignoring drm.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
