Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2CC1C433EF
	for <linux-fbdev@archiver.kernel.org>; Tue, 26 Oct 2021 08:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8F3460F92
	for <linux-fbdev@archiver.kernel.org>; Tue, 26 Oct 2021 08:30:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234095AbhJZIcw (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 26 Oct 2021 04:32:52 -0400
Received: from mail-ua1-f46.google.com ([209.85.222.46]:40566 "EHLO
        mail-ua1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233763AbhJZIcv (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 26 Oct 2021 04:32:51 -0400
Received: by mail-ua1-f46.google.com with SMTP id e2so27566593uax.7;
        Tue, 26 Oct 2021 01:30:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/ahLicdrMZ8Rl440uYSQXYfqc+SmHqq4WEC7k8rF9Ug=;
        b=nJQNBL8XEiQozrks0YYPNf652DyOmi04Pwuc5YJVahKKahNNfaTRccZ8IzzxIvwzzl
         eX5P0KlJifyScpGC6JaPqom9U+VxyjgD1I5v/oydqnw+A2Oo/1NTGXz4+ccrATOsyHsV
         F2+kWeOG2m8h95rtX6jYHSfjaKkFGhtCfvEaa0F/Nac7y2oohxdyBF5lj2SwQ/QE3EWM
         yfRf8ku6DmwsuEdAxezjnrhlsiHFHBfGUoLNmBV+lzGOLx8HmP485cHmoFTCjiSswEYC
         41s0J4MW8Gl2ANCIl/4kKfmSjt4sAuartvEFYD4LCY2fXyWpfYi78Nz/uWURacMp3GFK
         Zfvg==
X-Gm-Message-State: AOAM5329oSMu4xlvAf+XDf7mcskbw6dSYRWC8GurwanvqzRn1c9pYiqQ
        j5stRu1R0f4U8iSP5l8oDsPqa5lFq5rr/A==
X-Google-Smtp-Source: ABdhPJxsN9Xbw1PFLkB71bmKCObFKUYd4mmyOrHy9+H+tMsxRHsqF9uvjzeSzF/E5CTKxR4Nw1wF7Q==
X-Received: by 2002:a05:6102:38ce:: with SMTP id k14mr21833917vst.6.1635237027568;
        Tue, 26 Oct 2021 01:30:27 -0700 (PDT)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id v2sm5180563uao.3.2021.10.26.01.30.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Oct 2021 01:30:27 -0700 (PDT)
Received: by mail-ua1-f44.google.com with SMTP id f4so27587239uad.4;
        Tue, 26 Oct 2021 01:30:27 -0700 (PDT)
X-Received: by 2002:ab0:2bd2:: with SMTP id s18mr21259739uar.78.1635237026866;
 Tue, 26 Oct 2021 01:30:26 -0700 (PDT)
MIME-Version: 1.0
References: <1635188490-15082-1-git-send-email-george.kennedy@oracle.com>
 <YXcAbXJfg/jKCo5h@kroah.com> <0ddb1c19-64b0-4117-7a92-c3d2fcddfdcf@oracle.com>
In-Reply-To: <0ddb1c19-64b0-4117-7a92-c3d2fcddfdcf@oracle.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 26 Oct 2021 10:30:15 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWcU7wy1dxa_MXuHoUTWebvq6ShP820Bn_v+8tx7-TEdg@mail.gmail.com>
Message-ID: <CAMuHMdWcU7wy1dxa_MXuHoUTWebvq6ShP820Bn_v+8tx7-TEdg@mail.gmail.com>
Subject: Re: [PATCH] video: fbdev: cirrusfb: check pixclock to avoid divide by zero
To:     George Kennedy <george.kennedy@oracle.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi George,

On Mon, Oct 25, 2021 at 9:37 PM George Kennedy
<george.kennedy@oracle.com> wrote:
> On 10/25/2021 3:07 PM, Greg KH wrote:
> > On Mon, Oct 25, 2021 at 02:01:30PM -0500, George Kennedy wrote:
> >> Do a sanity check on pixclock value before using it as a divisor.
> >>
> >> Syzkaller reported a divide error in cirrusfb_check_pixclock.
> >>
> >> divide error: 0000 [#1] SMP KASAN PTI
> >> CPU: 0 PID: 14938 Comm: cirrusfb_test Not tainted 5.15.0-rc6 #1
> >> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.0-2
> >> RIP: 0010:cirrusfb_check_var+0x6f1/0x1260
> >>
> >> Call Trace:
> >>   fb_set_var+0x398/0xf90
> >>   do_fb_ioctl+0x4b8/0x6f0
> >>   fb_ioctl+0xeb/0x130
> >>   __x64_sys_ioctl+0x19d/0x220
> >>   do_syscall_64+0x3a/0x80
> >>   entry_SYSCALL_64_after_hwframe+0x44/0xae
> >>
> >> Signed-off-by: George Kennedy <george.kennedy@oracle.com>
> >> ---
> >>   drivers/video/fbdev/cirrusfb.c | 3 +++
> >>   1 file changed, 3 insertions(+)
> >>
> >> diff --git a/drivers/video/fbdev/cirrusfb.c b/drivers/video/fbdev/cirrusfb.c
> >> index 93802ab..099ddcb 100644
> >> --- a/drivers/video/fbdev/cirrusfb.c
> >> +++ b/drivers/video/fbdev/cirrusfb.c
> >> @@ -477,6 +477,9 @@ static int cirrusfb_check_pixclock(const struct fb_var_screeninfo *var,
> >>      struct cirrusfb_info *cinfo = info->par;
> >>      unsigned maxclockidx = var->bits_per_pixel >> 3;
> >>
> >> +    if (!var->pixclock)
> >> +            return -EINVAL;

This is not correct: fbdev drivers should round up invalid values,
and only return an error if rounding up cannot yield a valid value.

> > Shouldn't you be checking further up the call chain where this got set
> > to 0?
>
> The same pixclock check is done in these fb drivers:
>
> arch/arm/mach-rpc/include/mach/acornfb.h:    if (!var->pixclock)
> drivers/video/fbdev/asiliantfb.c:    if (!var->pixclock)
> drivers/video/fbdev/clps711x-fb.c:    if (!var->pixclock)
> drivers/video/fbdev/core/fbmon.c:    if (!var->pixclock)
> drivers/video/fbdev/core/modedb.c:    if (!var->pixclock)
> drivers/video/fbdev/cirrusfb.c:    if (!var->pixclock)
> drivers/video/fbdev/kyro/fbdev.c:    if (!var->pixclock)
> drivers/video/fbdev/riva/fbdev.c:    if (!var->pixclock)
> drivers/video/fbdev/uvesafb.c:    if (!var->pixclock)
>
> >
> > What logic allows this to be a valid value?  What about all other fb
> > drivers?
>
> The "check_var" function, which is set into the ".fb_check_var" element
> of the fb_ops struct, should do the check, but in the case of cirrusfb,
> that is not being done.
>
> All this patch does is add the same pixclock check that the other above
> fb drivers do.

Indeed, several drivers are not following the rounding rules.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
