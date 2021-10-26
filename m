Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F38AC433EF
	for <linux-fbdev@archiver.kernel.org>; Tue, 26 Oct 2021 17:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46D2260F90
	for <linux-fbdev@archiver.kernel.org>; Tue, 26 Oct 2021 17:12:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234147AbhJZROh (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 26 Oct 2021 13:14:37 -0400
Received: from mail-ua1-f41.google.com ([209.85.222.41]:33561 "EHLO
        mail-ua1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbhJZROh (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 26 Oct 2021 13:14:37 -0400
Received: by mail-ua1-f41.google.com with SMTP id s4so6302055uaq.0;
        Tue, 26 Oct 2021 10:12:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AXHONT95KJvkaHI1jvYYaUxOJPvtYl1iFSyJcrCpH7A=;
        b=722szwjXRC5/3fbyuPDDNMf8huFBx7byBrPMkIQDV2Shb0BDx9ejpAetH6cZ9mxc/J
         h8/8KTTejjP2PcJjujvZxxkD40eczZRxcRlW8xQYFDCh9/I9lN7EYHKuS9sxw4WtnmnG
         cm4w3WwIW0ALBT/7/Kw6++m6ULFvMG0OZq47+k7o2wdSXdMS81lZb5wM5Gc/BsHSQQKZ
         xKIvLRD0wWub4PPShsiWZ84WfvkuFExthobvH6kaG8QzJxRv9yq/TKfS0VBXn6yJ1SyE
         rqNOWHb61OvWzT6tD1Z8DCEInKMbd7/vxJOlHKCxdi9ylN5bH39cTJmJDRnhiYQpC50v
         LsOA==
X-Gm-Message-State: AOAM531plzoe4amZz3dtmJZBLyNDg/iKMPP6bY+SxejiZWLH6UdrBwBC
        OXjFnY1avS9iRGbdcjemAmav/7SxfUljMg==
X-Google-Smtp-Source: ABdhPJwHc2vueFIikZdo+UcIckNn/U0rbWZyiWNiqg8BlDCaTihtUY8IDg8Fw7Ksld8MojKvUiIRng==
X-Received: by 2002:a05:6102:3122:: with SMTP id f2mr12859196vsh.58.1635268332395;
        Tue, 26 Oct 2021 10:12:12 -0700 (PDT)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id h6sm844725vsc.16.2021.10.26.10.12.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Oct 2021 10:12:12 -0700 (PDT)
Received: by mail-ua1-f52.google.com with SMTP id e10so30592030uab.3;
        Tue, 26 Oct 2021 10:12:11 -0700 (PDT)
X-Received: by 2002:a67:f4c9:: with SMTP id s9mr14009160vsn.35.1635268331701;
 Tue, 26 Oct 2021 10:12:11 -0700 (PDT)
MIME-Version: 1.0
References: <1635188490-15082-1-git-send-email-george.kennedy@oracle.com>
 <YXcAbXJfg/jKCo5h@kroah.com> <0ddb1c19-64b0-4117-7a92-c3d2fcddfdcf@oracle.com>
 <CAMuHMdWcU7wy1dxa_MXuHoUTWebvq6ShP820Bn_v+8tx7-TEdg@mail.gmail.com>
 <c73402dd-ec3f-4df7-6a16-36fb276a50f4@oracle.com> <CAMuHMdVHt=9N274SG+B7W83JbVVnbz_U5Nkejs_PR2HqvZvJgQ@mail.gmail.com>
 <d2119d59-89e4-34aa-86df-38fee2a0c6ef@oracle.com>
In-Reply-To: <d2119d59-89e4-34aa-86df-38fee2a0c6ef@oracle.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 26 Oct 2021 19:12:00 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUZq00r7QYeAKGm36UKpGwH_uEGMvwHBzRi9_nxV-dRhg@mail.gmail.com>
Message-ID: <CAMuHMdUZq00r7QYeAKGm36UKpGwH_uEGMvwHBzRi9_nxV-dRhg@mail.gmail.com>
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

On Tue, Oct 26, 2021 at 5:48 PM George Kennedy
<george.kennedy@oracle.com> wrote:
> On 10/26/2021 10:11 AM, Geert Uytterhoeven wrote:
> > On Tue, Oct 26, 2021 at 3:38 PM George Kennedy
> > <george.kennedy@oracle.com> wrote:
> >> On 10/26/2021 4:30 AM, Geert Uytterhoeven wrote:
> >>> On Mon, Oct 25, 2021 at 9:37 PM George Kennedy
> >>> <george.kennedy@oracle.com> wrote:
> >>>> On 10/25/2021 3:07 PM, Greg KH wrote:
> >>>>> On Mon, Oct 25, 2021 at 02:01:30PM -0500, George Kennedy wrote:
> >>>>>> Do a sanity check on pixclock value before using it as a divisor.
> >>>>>>
> >>>>>> Syzkaller reported a divide error in cirrusfb_check_pixclock.
> >>>>>>
> >>>>>> divide error: 0000 [#1] SMP KASAN PTI
> >>>>>> CPU: 0 PID: 14938 Comm: cirrusfb_test Not tainted 5.15.0-rc6 #1
> >>>>>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.0-2
> >>>>>> RIP: 0010:cirrusfb_check_var+0x6f1/0x1260
> >>>>>>
> >>>>>> Call Trace:
> >>>>>>     fb_set_var+0x398/0xf90
> >>>>>>     do_fb_ioctl+0x4b8/0x6f0
> >>>>>>     fb_ioctl+0xeb/0x130
> >>>>>>     __x64_sys_ioctl+0x19d/0x220
> >>>>>>     do_syscall_64+0x3a/0x80
> >>>>>>     entry_SYSCALL_64_after_hwframe+0x44/0xae
> >>>>>>
> >>>>>> Signed-off-by: George Kennedy <george.kennedy@oracle.com>
> >>>>>> --- a/drivers/video/fbdev/cirrusfb.c
> >>>>>> +++ b/drivers/video/fbdev/cirrusfb.c
> >>>>>> @@ -477,6 +477,9 @@ static int cirrusfb_check_pixclock(const struct fb_var_screeninfo *var,
> >>>>>>        struct cirrusfb_info *cinfo = info->par;
> >>>>>>        unsigned maxclockidx = var->bits_per_pixel >> 3;
> >>>>>>
> >>>>>> +    if (!var->pixclock)
> >>>>>> +            return -EINVAL;
> >>> This is not correct: fbdev drivers should round up invalid values,
> >>> and only return an error if rounding up cannot yield a valid value.
> >> What default value would you recommend? Here are examples of some of the
> >> possible cirrusfb pixclock values:
> >> 40000: 25MHz
> >> 20000: 50Mhz
> >> 12500: 80Mhz
> > You should pick the lowest supported value.
>
> In bestclock() the frequency value ("freq") is not allowed to go below 8000.
>
>          if (freq < 8000)
>                  freq = 8000;
>
> If pixclock is passed in as zero to cirrusfb_check_pixclock(), is it ok
> to then set the value of pixclock to 125000, which will result in "freq"
> being set to 8000 (or adjust the passed in pixclock value to make sure
> "freq" does not get below 8000)?

No, clock rate is the inverse of clock period.
So the smallest clock period (fb_var_screeninfo.pixclock) corresponds
to the largest clock rate (freq in bestclock()).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
