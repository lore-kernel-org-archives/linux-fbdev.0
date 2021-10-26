Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 662E9C433F5
	for <linux-fbdev@archiver.kernel.org>; Tue, 26 Oct 2021 14:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 497D160C4B
	for <linux-fbdev@archiver.kernel.org>; Tue, 26 Oct 2021 14:12:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236434AbhJZOO1 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 26 Oct 2021 10:14:27 -0400
Received: from mail-vk1-f169.google.com ([209.85.221.169]:41963 "EHLO
        mail-vk1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236432AbhJZOOZ (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 26 Oct 2021 10:14:25 -0400
Received: by mail-vk1-f169.google.com with SMTP id 20so4403097vkc.8;
        Tue, 26 Oct 2021 07:12:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CRfQV5P44DJIIjFOVODNH7vxAWsLcKoctro6Rd4M6L0=;
        b=JhMD9WqBBDNoS5sxFMKvFw+hlp08fIm1aVe6StXjPCPgahqyFFexrsK9u9Dxh0frbv
         nOHFv9h1lKBMNuYceWS1rfxNDaV7era6ukWMJMGJGKqdZ1rOsnRB5wV26H88UyZxPNJO
         NZ+QOiCjgqXxQ5TAM9R+d/dSPanpcKblx1SX8RcXzRPz0BKfC/8gKOL8y+PMDYklvZOS
         pa56UVoDVNkkmj7fE40FwRUq6K3mtW3EL5mrHTKRdp1E2PC1YAfsL2ytZb5pz8L3K2dW
         OhDt3+JQhMRDS10+P3fdd8Qvqxrrgjo8QJxcKNy66dm8CQFxKBjBVPb5ej0QFCa86DgC
         Jwig==
X-Gm-Message-State: AOAM530vZYQ1zjIHBK2G5ejU8o/UYCcSVr+V+ug7kQdVmNQ3xQ82uFxZ
        CoxVMtkfVtAeYasI3HTP+qFoOfbV7LZBSw==
X-Google-Smtp-Source: ABdhPJyVPVJuFctm/b0earWTs2EGfmwgb0+E1r5spWPoT3GmPEA2cWxiGb2SnxjM+ZtFbV3JSPLI+g==
X-Received: by 2002:a1f:5c46:: with SMTP id q67mr23295370vkb.24.1635257521000;
        Tue, 26 Oct 2021 07:12:01 -0700 (PDT)
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com. [209.85.221.181])
        by smtp.gmail.com with ESMTPSA id s23sm3115777vss.33.2021.10.26.07.12.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Oct 2021 07:12:00 -0700 (PDT)
Received: by mail-vk1-f181.google.com with SMTP id n201so6967349vkn.12;
        Tue, 26 Oct 2021 07:12:00 -0700 (PDT)
X-Received: by 2002:a1f:1604:: with SMTP id 4mr22564190vkw.11.1635257520204;
 Tue, 26 Oct 2021 07:12:00 -0700 (PDT)
MIME-Version: 1.0
References: <1635188490-15082-1-git-send-email-george.kennedy@oracle.com>
 <YXcAbXJfg/jKCo5h@kroah.com> <0ddb1c19-64b0-4117-7a92-c3d2fcddfdcf@oracle.com>
 <CAMuHMdWcU7wy1dxa_MXuHoUTWebvq6ShP820Bn_v+8tx7-TEdg@mail.gmail.com> <c73402dd-ec3f-4df7-6a16-36fb276a50f4@oracle.com>
In-Reply-To: <c73402dd-ec3f-4df7-6a16-36fb276a50f4@oracle.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 26 Oct 2021 16:11:48 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVHt=9N274SG+B7W83JbVVnbz_U5Nkejs_PR2HqvZvJgQ@mail.gmail.com>
Message-ID: <CAMuHMdVHt=9N274SG+B7W83JbVVnbz_U5Nkejs_PR2HqvZvJgQ@mail.gmail.com>
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

On Tue, Oct 26, 2021 at 3:38 PM George Kennedy
<george.kennedy@oracle.com> wrote:
> On 10/26/2021 4:30 AM, Geert Uytterhoeven wrote:
> > On Mon, Oct 25, 2021 at 9:37 PM George Kennedy
> > <george.kennedy@oracle.com> wrote:
> >> On 10/25/2021 3:07 PM, Greg KH wrote:
> >>> On Mon, Oct 25, 2021 at 02:01:30PM -0500, George Kennedy wrote:
> >>>> Do a sanity check on pixclock value before using it as a divisor.
> >>>>
> >>>> Syzkaller reported a divide error in cirrusfb_check_pixclock.
> >>>>
> >>>> divide error: 0000 [#1] SMP KASAN PTI
> >>>> CPU: 0 PID: 14938 Comm: cirrusfb_test Not tainted 5.15.0-rc6 #1
> >>>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.0-2
> >>>> RIP: 0010:cirrusfb_check_var+0x6f1/0x1260
> >>>>
> >>>> Call Trace:
> >>>>    fb_set_var+0x398/0xf90
> >>>>    do_fb_ioctl+0x4b8/0x6f0
> >>>>    fb_ioctl+0xeb/0x130
> >>>>    __x64_sys_ioctl+0x19d/0x220
> >>>>    do_syscall_64+0x3a/0x80
> >>>>    entry_SYSCALL_64_after_hwframe+0x44/0xae
> >>>>
> >>>> Signed-off-by: George Kennedy <george.kennedy@oracle.com>

> >>>> --- a/drivers/video/fbdev/cirrusfb.c
> >>>> +++ b/drivers/video/fbdev/cirrusfb.c
> >>>> @@ -477,6 +477,9 @@ static int cirrusfb_check_pixclock(const struct fb_var_screeninfo *var,
> >>>>       struct cirrusfb_info *cinfo = info->par;
> >>>>       unsigned maxclockidx = var->bits_per_pixel >> 3;
> >>>>
> >>>> +    if (!var->pixclock)
> >>>> +            return -EINVAL;
> > This is not correct: fbdev drivers should round up invalid values,
> > and only return an error if rounding up cannot yield a valid value.
>
> What default value would you recommend? Here are examples of some of the
> possible cirrusfb pixclock values:
> 40000: 25MHz
> 20000: 50Mhz
> 12500: 80Mhz

You should pick the lowest supported value.

> We can plug in a default value, but I believe it is just covering up the
> fact that an incorrect value has been copied in.

Passing zero is not incorrect.  The driver is supposed to round it
up to a valid value.

> I would think we would want to keep this driver consistent with the
> other fb drivers that return failure with the incorrect value.

I disagree: non-conformant behavior should be fixed, not copied.

> >>> Shouldn't you be checking further up the call chain where this got set
> >>> to 0?
> >> The same pixclock check is done in these fb drivers:
> >>
> >> arch/arm/mach-rpc/include/mach/acornfb.h:    if (!var->pixclock)
> >> drivers/video/fbdev/asiliantfb.c:    if (!var->pixclock)
> >> drivers/video/fbdev/clps711x-fb.c:    if (!var->pixclock)
> >> drivers/video/fbdev/core/fbmon.c:    if (!var->pixclock)
> >> drivers/video/fbdev/core/modedb.c:    if (!var->pixclock)
> >> drivers/video/fbdev/cirrusfb.c:    if (!var->pixclock)
> >> drivers/video/fbdev/kyro/fbdev.c:    if (!var->pixclock)
> >> drivers/video/fbdev/riva/fbdev.c:    if (!var->pixclock)
> >> drivers/video/fbdev/uvesafb.c:    if (!var->pixclock)
> >>
> >>> What logic allows this to be a valid value?  What about all other fb
> >>> drivers?
> >> The "check_var" function, which is set into the ".fb_check_var" element
> >> of the fb_ops struct, should do the check, but in the case of cirrusfb,
> >> that is not being done.
> >>
> >> All this patch does is add the same pixclock check that the other above
> >> fb drivers do.
> > Indeed, several drivers are not following the rounding rules.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
