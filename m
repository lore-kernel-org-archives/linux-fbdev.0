Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C554C43334
	for <linux-fbdev@archiver.kernel.org>; Wed, 29 Jun 2022 07:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbiF2HGB (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 29 Jun 2022 03:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233001AbiF2HFr (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 29 Jun 2022 03:05:47 -0400
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E925C3D48A
        for <linux-fbdev@vger.kernel.org>; Wed, 29 Jun 2022 00:03:54 -0700 (PDT)
Received: by mail-qv1-f41.google.com with SMTP id u7so1089965qvm.4
        for <linux-fbdev@vger.kernel.org>; Wed, 29 Jun 2022 00:03:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eywFT5Cbr+VM4RLwzIkGWvtXZKRL8hfaceBA9KstOpo=;
        b=vlYFH1/zb8/iMHoC/VRHJwlu/KbP2FThBOCcVoYOVPzw98gixRn8y9ugjhc+n+jq8M
         XxPsTokqHi+5nAN79NiKy4z5iwNKVNytmfuOtDkJ+5AH8c3cX3AljExfs7cu/bo5AFzD
         Ll03BXOTa0zJDgEhiyj+4ceLV5Cwzf2JFS++zsIZNSFhZF79BI1AZy5hKOe3sOVS15zl
         Qlo0I5gSmIlH4YZwZhvDye0eBkCEGzB3796KR/O5pu7W+lLgkei8K99+sclZtSth0zq5
         x84PGCqDL9fylxpNTO+2Vr0snFvq+X3PIrwy+ewW/LfKSoasZTbtp0t6pO6OR3Pq0+of
         5Exg==
X-Gm-Message-State: AJIora8RwmXIvNHaW6JJsdlPQMj7tPAJiSid0FZeG6xmB3acL2tXVnB0
        /syB4MOYsvTh6goKkEWYaVOFJEteVGTAZQ==
X-Google-Smtp-Source: AGRyM1trYfQmglMrmvMoxBAFoPZsumk7vuK9IX2btJ9FnvqH9rJwJqjQdvS0WnnNuqdTAjIPY27DkQ==
X-Received: by 2002:a05:622a:287:b0:317:c7b8:478b with SMTP id z7-20020a05622a028700b00317c7b8478bmr1194591qtw.111.1656486233631;
        Wed, 29 Jun 2022 00:03:53 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id j17-20020ac84c91000000b002f39b99f6a4sm5416271qtv.62.2022.06.29.00.03.52
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 00:03:52 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-318889e6a2cso139038727b3.1
        for <linux-fbdev@vger.kernel.org>; Wed, 29 Jun 2022 00:03:52 -0700 (PDT)
X-Received: by 2002:a81:574c:0:b0:317:7c3a:45be with SMTP id
 l73-20020a81574c000000b003177c3a45bemr2177677ywb.316.1656486232303; Wed, 29
 Jun 2022 00:03:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220626102853.124108-1-deller@gmx.de> <20220626102853.124108-4-deller@gmx.de>
 <CAMuHMdV5zLoQWi2qd9HpP65WEvCw_q3VTsZ0MnBV1t8xM7KFUw@mail.gmail.com> <f3b01426-1cd4-40b9-7dd7-0965c4c0611c@gmx.de>
In-Reply-To: <f3b01426-1cd4-40b9-7dd7-0965c4c0611c@gmx.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 29 Jun 2022 09:03:39 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUz1OMe+opM2b=XyYpQc4ynCyamXGFTjkbnzMr3wFvb8g@mail.gmail.com>
Message-ID: <CAMuHMdUz1OMe+opM2b=XyYpQc4ynCyamXGFTjkbnzMr3wFvb8g@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] fbcon: Prevent that screen size is smaller than
 font size
To:     Helge Deller <deller@gmx.de>
Cc:     Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Helge,

On Tue, Jun 28, 2022 at 10:52 PM Helge Deller <deller@gmx.de> wrote:
> On 6/28/22 10:39, Geert Uytterhoeven wrote:
> > On Sun, Jun 26, 2022 at 12:33 PM Helge Deller <deller@gmx.de> wrote:
> >> We need to prevent that users configure a screen size which is smaller than the
> >> currently selected font size. Otherwise rendering chars on the screen will
> >> access memory outside the graphics memory region.
> >>
> >> This patch adds a new function fbcon_modechange_possible() which
> >> implements this check and which later may be extended with other checks
> >> if necessary.  The new function is called from the FBIOPUT_VSCREENINFO
> >> ioctl handler in fbmem.c, which will return -EINVAL if userspace asked
> >> for a too small screen size.
> >>
> >> Signed-off-by: Helge Deller <deller@gmx.de>
> >> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> >> Cc: stable@vger.kernel.org # v5.4+
> >
> > Thanks for your patch, which is now commit f0b6a66d33ca6e7e ("fbcon:
> > Prevent that screen size is smaller than font size") in fbdev/for-next

> >> --- a/drivers/video/fbdev/core/fbmem.c
> >> +++ b/drivers/video/fbdev/core/fbmem.c
> >> @@ -1112,7 +1112,9 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
> >>                         return -EFAULT;
> >>                 console_lock();
> >>                 lock_fb_info(info);
> >> -               ret = fb_set_var(info, &var);
> >> +               ret = fbcon_modechange_possible(info, &var);
> >
> > Again, this should be done (if done at all) after the call to
> > fb_ops.check_var(), as it breaks the FBIOPUT_VSCREENINFO rounding rule.
> >
> > What if the user just wants to display graphics, not text?
>
> Yes, I need to go back to an older version here too and check that
> the test is only run on text consoles.
> That check was dropped, due feedback that you could switch
> back from graphics (e.g. X11) to text console at any time....so the
> check for text-only is not correct.
>
> > Can't the text console be disabled instead?
>
> I think the solution is to return failure if switching back to text mode isn't possible if
> fonts are bigger than the screen resolution. That will be another patch.

Isn't the font a per-VC setting? Hence can't you change resolution,
switch to a different VC, and run into this?

I think the only real solution is to set the number of text columns
and/or rows to zero, and make sure that is handled correctly.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
