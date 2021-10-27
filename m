Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DAD0C433F5
	for <linux-fbdev@archiver.kernel.org>; Wed, 27 Oct 2021 06:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19BC2600CC
	for <linux-fbdev@archiver.kernel.org>; Wed, 27 Oct 2021 06:54:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236188AbhJ0G4b (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 27 Oct 2021 02:56:31 -0400
Received: from mail-ua1-f41.google.com ([209.85.222.41]:44851 "EHLO
        mail-ua1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbhJ0G4a (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 27 Oct 2021 02:56:30 -0400
Received: by mail-ua1-f41.google.com with SMTP id e5so2976752uam.11;
        Tue, 26 Oct 2021 23:54:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uHeQsCzj+NuIoaUijS+BqVs1TYH9sOv+TDs8LySkQvc=;
        b=m7vXgr+jgGuHrDKqzGF9AKOmvSaw+8jt1pSGe/+LpQDCbUK7SPdtku8gvHD4LtEUfK
         RgpreFDTlVHmk3hrk9M6MkSMbVUOL0yMtmAV6DfW7Vl3B6vnjpfEtStwSgeWGM0yATTm
         4MKMmrGIx3S4bGMJK+sPOklXzClM36w/gAlxjVA+bMiN/TzAmBzUOEJsDNqYXKE9aWli
         jye8wuEZ8sXk/nSHBOEafpzNoUsV9H4XaszGnGW5sh1RQ6iMg5KAU+TxZ7NHFAKoTJog
         z/hJDolUeOyyTDJg5OlGxjh3nGVhP5q/2A+4nr9eqSEqBUDuQwNcFLtO9+m6PZeCgJgn
         z8bw==
X-Gm-Message-State: AOAM53346ZIv/MXLwXh2no8bg54ndz/kqTfGUBmkeBFI4KR458Jn0mcB
        E0++w6eAtOHl88lx9XR45dR4lWAZLTG1XA==
X-Google-Smtp-Source: ABdhPJzTdk0nQVLJvERT3qsUiM5rO1tfFcej6c4uFrsdarZyP9KKaVl3zhqNPkBSoaVMRLKBLTHyhg==
X-Received: by 2002:ab0:720f:: with SMTP id u15mr27966737uao.54.1635317644908;
        Tue, 26 Oct 2021 23:54:04 -0700 (PDT)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id a126sm1956027vsc.27.2021.10.26.23.54.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Oct 2021 23:54:04 -0700 (PDT)
Received: by mail-ua1-f45.google.com with SMTP id v20so3000276uaj.9;
        Tue, 26 Oct 2021 23:54:04 -0700 (PDT)
X-Received: by 2002:ab0:2bd2:: with SMTP id s18mr28311148uar.78.1635317644217;
 Tue, 26 Oct 2021 23:54:04 -0700 (PDT)
MIME-Version: 1.0
References: <1635188490-15082-1-git-send-email-george.kennedy@oracle.com>
 <YXcAbXJfg/jKCo5h@kroah.com> <0ddb1c19-64b0-4117-7a92-c3d2fcddfdcf@oracle.com>
 <CAMuHMdWcU7wy1dxa_MXuHoUTWebvq6ShP820Bn_v+8tx7-TEdg@mail.gmail.com>
 <c73402dd-ec3f-4df7-6a16-36fb276a50f4@oracle.com> <CAMuHMdVHt=9N274SG+B7W83JbVVnbz_U5Nkejs_PR2HqvZvJgQ@mail.gmail.com>
 <d2119d59-89e4-34aa-86df-38fee2a0c6ef@oracle.com> <CAMuHMdUZq00r7QYeAKGm36UKpGwH_uEGMvwHBzRi9_nxV-dRhg@mail.gmail.com>
 <4cf6a155-85b7-649b-066d-e56da87dc8fd@oracle.com>
In-Reply-To: <4cf6a155-85b7-649b-066d-e56da87dc8fd@oracle.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 27 Oct 2021 08:53:53 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVJ=92S9Ds66cYZO+96THsOkz-jjYPWUgsJ6oRibEMoCA@mail.gmail.com>
Message-ID: <CAMuHMdVJ=92S9Ds66cYZO+96THsOkz-jjYPWUgsJ6oRibEMoCA@mail.gmail.com>
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

On Wed, Oct 27, 2021 at 3:13 AM George Kennedy
<george.kennedy@oracle.com> wrote:
> On 10/26/2021 1:12 PM, Geert Uytterhoeven wrote:
> > On Tue, Oct 26, 2021 at 5:48 PM George Kennedy
> > <george.kennedy@oracle.com> wrote:
> >> On 10/26/2021 10:11 AM, Geert Uytterhoeven wrote:
> >>> On Tue, Oct 26, 2021 at 3:38 PM George Kennedy
> >>> <george.kennedy@oracle.com> wrote:
> >>>> On 10/26/2021 4:30 AM, Geert Uytterhoeven wrote:
> >>>>> On Mon, Oct 25, 2021 at 9:37 PM George Kennedy
> >>>>> <george.kennedy@oracle.com> wrote:
> >>>>>> On 10/25/2021 3:07 PM, Greg KH wrote:
> >>>>>>> On Mon, Oct 25, 2021 at 02:01:30PM -0500, George Kennedy wrote:
> >>>>>>>> Do a sanity check on pixclock value before using it as a divisor.
> >>>>>>>>
> >>>>>>>> Syzkaller reported a divide error in cirrusfb_check_pixclock.
> >>>>>>>>
> >>>>>>>> divide error: 0000 [#1] SMP KASAN PTI
> >>>>>>>> CPU: 0 PID: 14938 Comm: cirrusfb_test Not tainted 5.15.0-rc6 #1
> >>>>>>>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.0-2
> >>>>>>>> RIP: 0010:cirrusfb_check_var+0x6f1/0x1260
> >>>>>>>>
> >>>>>>>> Call Trace:
> >>>>>>>>      fb_set_var+0x398/0xf90
> >>>>>>>>      do_fb_ioctl+0x4b8/0x6f0
> >>>>>>>>      fb_ioctl+0xeb/0x130
> >>>>>>>>      __x64_sys_ioctl+0x19d/0x220
> >>>>>>>>      do_syscall_64+0x3a/0x80
> >>>>>>>>      entry_SYSCALL_64_after_hwframe+0x44/0xae
> >>>>>>>>
> >>>>>>>> Signed-off-by: George Kennedy <george.kennedy@oracle.com>
> >>>>>>>> --- a/drivers/video/fbdev/cirrusfb.c
> >>>>>>>> +++ b/drivers/video/fbdev/cirrusfb.c
> >>>>>>>> @@ -477,6 +477,9 @@ static int cirrusfb_check_pixclock(const struct fb_var_screeninfo *var,
> >>>>>>>>         struct cirrusfb_info *cinfo = info->par;
> >>>>>>>>         unsigned maxclockidx = var->bits_per_pixel >> 3;
> >>>>>>>>
> >>>>>>>> +    if (!var->pixclock)
> >>>>>>>> +            return -EINVAL;
> >>>>> This is not correct: fbdev drivers should round up invalid values,
> >>>>> and only return an error if rounding up cannot yield a valid value.
> >>>> What default value would you recommend? Here are examples of some of the
> >>>> possible cirrusfb pixclock values:
> >>>> 40000: 25MHz
> >>>> 20000: 50Mhz
> >>>> 12500: 80Mhz
> >>> You should pick the lowest supported value.
> >> In bestclock() the frequency value ("freq") is not allowed to go below 8000.
> >>
> >>           if (freq < 8000)
> >>                   freq = 8000;
> >>
> >> If pixclock is passed in as zero to cirrusfb_check_pixclock(), is it ok
> >> to then set the value of pixclock to 125000, which will result in "freq"
> >> being set to 8000 (or adjust the passed in pixclock value to make sure
> >> "freq" does not get below 8000)?
> > No, clock rate is the inverse of clock period.
> > So the smallest clock period (fb_var_screeninfo.pixclock) corresponds
> > to the largest clock rate (freq in bestclock()).
>
> How about this?
>
> This gets the frequency derived from pixclock to maxclock or rounds up
> pixclock to get the frequency as close to maxclock as possible.
>
> diff --git a/drivers/video/fbdev/cirrusfb.c b/drivers/video/fbdev/cirrusfb.c
> index 93802ab..2e8e620 100644
> --- a/drivers/video/fbdev/cirrusfb.c
> +++ b/drivers/video/fbdev/cirrusfb.c
> @@ -620,6 +620,18 @@ static int cirrusfb_check_var(struct
> fb_var_screeninfo *var,
>                  return -EINVAL;
>          }
>
> +       if (!var->pixclock) {
> +               long maxclock;
> +               unsigned maxclockidx = var->bits_per_pixel >> 3;
> +
> +               maxclock =
> cirrusfb_board_info[cinfo->btype].maxclock[maxclockidx];
> +
> +               var->pixclock = KHZ2PICOS(maxclock);
> +               while (PICOS2KHZ(var->pixclock) > maxclock) {
> +                       var->pixclock++;
> +               }
> +       }
> +
>          if (cirrusfb_check_pixclock(var, info))
>                  return -EINVAL;
>
> The work can't be done in cirrusfb_check_pixclock() as var->pixclock is
> read-only because "var" is "const struct fb_var_screeninfo *var".

Perhaps the const should be dropped from the var parameter, so the
rounding can be done in the function where it makes most sense,
and where most of the above operations are already done?

Then, you can simplify:

-        freq = PICOS2KHZ(var->pixclock);
+        freq = PICOS2KHZ(var->pixclock ? : 1);

and change the "if (freq > maxclock) return -EINVAL" to use maxclock
instead.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
