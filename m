Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23629C433EF
	for <linux-fbdev@archiver.kernel.org>; Thu, 30 Jun 2022 20:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236431AbiF3UA2 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 30 Jun 2022 16:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231747AbiF3UA1 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 30 Jun 2022 16:00:27 -0400
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3150942A17
        for <linux-fbdev@vger.kernel.org>; Thu, 30 Jun 2022 13:00:26 -0700 (PDT)
Received: by mail-qv1-f54.google.com with SMTP id cs6so838250qvb.6
        for <linux-fbdev@vger.kernel.org>; Thu, 30 Jun 2022 13:00:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y/Z/fowSl/l3Fs0mK7uiWWNdhRxBZYpUZvpWJxYSlOo=;
        b=F5qO9KmaieK70RYNCUgiGXoHU5DJvByApr2JdZ00hEz9l02XRz/0U690o8R8LFs8P1
         +gYGTVCxVeFcCdsB/DCGgn+dxiRC2K5uvxRJ9dLz8FNGviB6kjXLt+TDi0CJg/bGAoc6
         eA/csYD5CAfnhvoaFmMAe0RH/F0XKfiqXRsnAOSAyaXBLXjf2s1cBFdFJRraLukrRmOA
         KgGkQ9jpNrXp5bOJHNf07LL5npbYEOvFcUtJbW0Bjnt3cVgDdra5BoTVBPE4k/+3tvOv
         s3WiYCdWCpSNv75ihWBqmr1U0qUI5z5xkCuN/ft0GXIghCsqV+4FgkvXWDs0qU3YKUiP
         NnAQ==
X-Gm-Message-State: AJIora/Iw3oxtXc4ryucE4bdZAuS6F1tSxjP12J2REoBjlSgMvFCmEm3
        1oEOKd0SOgpAYrHJODpql7a8w2UgtY91dw==
X-Google-Smtp-Source: AGRyM1tm98jDtoS+ZMaM75cLVdjXTcXQR7Jgvbsq3L6l3QYFrcb+O26GKX8xki6VG6/P5/UKeapDNA==
X-Received: by 2002:a05:622a:40f:b0:317:c556:21d0 with SMTP id n15-20020a05622a040f00b00317c55621d0mr9445054qtx.302.1656619225077;
        Thu, 30 Jun 2022 13:00:25 -0700 (PDT)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id d23-20020ac851d7000000b0031661fc023esm13150882qtn.30.2022.06.30.13.00.24
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 13:00:24 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-31780ad7535so3866337b3.8
        for <linux-fbdev@vger.kernel.org>; Thu, 30 Jun 2022 13:00:24 -0700 (PDT)
X-Received: by 2002:a0d:c787:0:b0:31b:a963:e1de with SMTP id
 j129-20020a0dc787000000b0031ba963e1demr12479126ywd.283.1656619224368; Thu, 30
 Jun 2022 13:00:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220629200024.187187-1-deller@gmx.de> <20220629200024.187187-3-deller@gmx.de>
 <CAMuHMdXJRBywf+h_u1jgA6X7hLSByDDwSkskff47a0BHfd93iA@mail.gmail.com>
 <0c418b7d-474a-3f93-a1fb-2f13c4d19941@gmx.de> <CAMuHMdUoMJ6CmiKDh4MW_b-7uoxEF+H6QimsA7SfcE5kjo17vw@mail.gmail.com>
 <d57655b2-44d1-4083-c4e9-ef4f004f2b64@gmx.de>
In-Reply-To: <d57655b2-44d1-4083-c4e9-ef4f004f2b64@gmx.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 30 Jun 2022 22:00:12 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXk9Kz4-pv7-M9tufj-pruhOZWw_b51fegkr2JSqzL65g@mail.gmail.com>
Message-ID: <CAMuHMdXk9Kz4-pv7-M9tufj-pruhOZWw_b51fegkr2JSqzL65g@mail.gmail.com>
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

On Thu, Jun 30, 2022 at 9:46 PM Helge Deller <deller@gmx.de> wrote:
> On 6/30/22 21:36, Geert Uytterhoeven wrote:
> > On Thu, Jun 30, 2022 at 9:31 PM Helge Deller <deller@gmx.de> wrote:
> >> On 6/30/22 21:00, Geert Uytterhoeven wrote:
> >>> On Wed, Jun 29, 2022 at 10:00 PM Helge Deller <deller@gmx.de> wrote:
> >>>> The virtual screen size can't be smaller than the physical screen size.
> >>>> Based on the general rule that we round up user-provided input if
> >>>> neccessary, adjust the virtual screen size as well if needed.
> >>>>
> >>>> Signed-off-by: Helge Deller <deller@gmx.de>
> >>>> Cc: stable@vger.kernel.org # v5.4+
> >>>
> >>> Thanks for your patch!
> >>>
> >>>> --- a/drivers/video/fbdev/core/fbmem.c
> >>>> +++ b/drivers/video/fbdev/core/fbmem.c
> >>>> @@ -1106,6 +1106,11 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
> >>>>                         return -EFAULT;
> >>>>                 console_lock();
> >>>>                 lock_fb_info(info);
> >>>> +               /* adjust virtual screen size if user missed it */
> >>>> +               if (var.xres_virtual < var.xres)
> >>>> +                       var.xres_virtual = var.xres;
> >>>> +               if (var.yres_virtual < var.yres)
> >>>> +                       var.yres_virtual = var.yres;
> >>>>                 ret = fb_set_var(info, &var);
> >>>>                 if (!ret)
> >>>>                         fbcon_update_vcs(info, var.activate & FB_ACTIVATE_ALL);
> >>>
> >>> Given "[PATCH 4/5] fbmem: Prevent invalid virtual screen sizes in
> >>> fb_set_var", I don't think we need this patch.
> >>
> >> We do.
> >
> > Why? It will be caught by [PATCH 4/5].
>
> Right, it will be caught by patch #4.
> But if you drop this part, then everytime a user runs
>         fbset -xres 800 -yres 600 -xvres 200
> users will get the KERNEL BUG WARNING (from patch #4) including
> a kernel backtrace in their syslogs.

No, they will only see that warning if they are using a broken fbdev
driver that implements .fb_check_var(), but fails to validate or
update the passed geometry.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
