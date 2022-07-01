Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83802C433EF
	for <linux-fbdev@archiver.kernel.org>; Fri,  1 Jul 2022 14:52:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbiGAOwe (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 1 Jul 2022 10:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233798AbiGAOwR (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Fri, 1 Jul 2022 10:52:17 -0400
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129E437A31
        for <linux-fbdev@vger.kernel.org>; Fri,  1 Jul 2022 07:52:14 -0700 (PDT)
Received: by mail-qk1-f176.google.com with SMTP id n10so1969967qkn.10
        for <linux-fbdev@vger.kernel.org>; Fri, 01 Jul 2022 07:52:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7hEuYzOoTmg7yPcz0VJpLuuzVEe9N67BOF/CjxNnnUk=;
        b=BESHW+6bZ2MpMweQe0X/xEjjYIs2lpqoDvTMiIWtROHiKazGo1DrIUldD8P26m2Yel
         yfAbm0sgfnjc9e3IOZ4m7KtgOqDiRLS1AiT80d88QXrQRhnu8zcjCveyTO28539OOMzm
         0E2Ncsql8WxhCKA/5qSmTtWfV7ObIFU8FNrzEOlcyspQ9XzH0RZXHiRaJPFsUMpRXS6p
         dW+uvEQ5LwG4ZLFIEaJvRahV0n6iKLnTJ5emx3OLOFWcVYPIpcguNimjyaG9a39/kQ9+
         EPGjvrNjDLi9bQL4wlA3Mrt+GKz5fJMliXVrpMObiwJGnhNbWc9YocjA1yzSx5CgTWr4
         zIoA==
X-Gm-Message-State: AJIora8W/+8AgpNCV/hLuWDzmvcdvPsp0OIM28Z4zkY9XXZ5bjAPD1+B
        yDEr1bw6+HR0RPrSMfPeHveDcvnqk+I4eA==
X-Google-Smtp-Source: AGRyM1uQVDMtY6uE1nqe5tU4IMLkaEFHjcbfg9iAAEQkJ9exHMzO/ZXsVwrt1wmpqK5Ewi28kawvkA==
X-Received: by 2002:a37:9b48:0:b0:6ae:ea5f:ab5f with SMTP id d69-20020a379b48000000b006aeea5fab5fmr10369401qke.761.1656687132877;
        Fri, 01 Jul 2022 07:52:12 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id az16-20020a05620a171000b006af4a816963sm10336175qkb.133.2022.07.01.07.52.12
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Jul 2022 07:52:12 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id l11so4405452ybu.13
        for <linux-fbdev@vger.kernel.org>; Fri, 01 Jul 2022 07:52:12 -0700 (PDT)
X-Received: by 2002:a25:be49:0:b0:64a:2089:f487 with SMTP id
 d9-20020a25be49000000b0064a2089f487mr1473340ybm.202.1656687131970; Fri, 01
 Jul 2022 07:52:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220629200024.187187-1-deller@gmx.de> <20220629200024.187187-3-deller@gmx.de>
 <CAMuHMdXJRBywf+h_u1jgA6X7hLSByDDwSkskff47a0BHfd93iA@mail.gmail.com>
 <0c418b7d-474a-3f93-a1fb-2f13c4d19941@gmx.de> <CAMuHMdUoMJ6CmiKDh4MW_b-7uoxEF+H6QimsA7SfcE5kjo17vw@mail.gmail.com>
 <d57655b2-44d1-4083-c4e9-ef4f004f2b64@gmx.de> <CAMuHMdXk9Kz4-pv7-M9tufj-pruhOZWw_b51fegkr2JSqzL65g@mail.gmail.com>
 <cae3dc86-8156-eef5-1af4-b16cb2a42849@gmx.de> <CAMuHMdViqMgpiB2a-cLt1viVMgGbBz_Q=youNsWdLPYxcXxFpA@mail.gmail.com>
 <4580aa35-5a34-0d81-56d1-1f10218375d2@gmx.de>
In-Reply-To: <4580aa35-5a34-0d81-56d1-1f10218375d2@gmx.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 1 Jul 2022 16:52:00 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV_8+Cp=BCWhADQ-2B9o3sk6GSdmxxVLLiAnWV-Nwncug@mail.gmail.com>
Message-ID: <CAMuHMdV_8+Cp=BCWhADQ-2B9o3sk6GSdmxxVLLiAnWV-Nwncug@mail.gmail.com>
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

On Fri, Jul 1, 2022 at 11:30 AM Helge Deller <deller@gmx.de> wrote:
> On 7/1/22 09:28, Geert Uytterhoeven wrote:
> > On Thu, Jun 30, 2022 at 10:10 PM Helge Deller <deller@gmx.de> wrote:
> >> On 6/30/22 22:00, Geert Uytterhoeven wrote:
> >>> On Thu, Jun 30, 2022 at 9:46 PM Helge Deller <deller@gmx.de> wrote:
> >>>> On 6/30/22 21:36, Geert Uytterhoeven wrote:
> >>>>> On Thu, Jun 30, 2022 at 9:31 PM Helge Deller <deller@gmx.de> wrote:
> >>>>>> On 6/30/22 21:00, Geert Uytterhoeven wrote:
> >>>>>>> On Wed, Jun 29, 2022 at 10:00 PM Helge Deller <deller@gmx.de> wrote:
> >>>>>>>> The virtual screen size can't be smaller than the physical screen size.
> >>>>>>>> Based on the general rule that we round up user-provided input if
> >>>>>>>> neccessary, adjust the virtual screen size as well if needed.
> >>>>>>>>
> >>>>>>>> Signed-off-by: Helge Deller <deller@gmx.de>
> >>>>>>>> Cc: stable@vger.kernel.org # v5.4+
> >>>>>>>
> >>>>>>> Thanks for your patch!
> >>>>>>>
> >>>>>>>> --- a/drivers/video/fbdev/core/fbmem.c
> >>>>>>>> +++ b/drivers/video/fbdev/core/fbmem.c
> >>>>>>>> @@ -1106,6 +1106,11 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
> >>>>>>>>                         return -EFAULT;
> >>>>>>>>                 console_lock();
> >>>>>>>>                 lock_fb_info(info);
> >>>>>>>> +               /* adjust virtual screen size if user missed it */
> >>>>>>>> +               if (var.xres_virtual < var.xres)
> >>>>>>>> +                       var.xres_virtual = var.xres;
> >>>>>>>> +               if (var.yres_virtual < var.yres)
> >>>>>>>> +                       var.yres_virtual = var.yres;
> >>>>>>>>                 ret = fb_set_var(info, &var);
> >>>>>>>>                 if (!ret)
> >>>>>>>>                         fbcon_update_vcs(info, var.activate & FB_ACTIVATE_ALL);
> >>>>>>>
> >>>>>>> Given "[PATCH 4/5] fbmem: Prevent invalid virtual screen sizes in
> >>>>>>> fb_set_var", I don't think we need this patch.
> >>>>>>
> >>>>>> We do.
> >>>>>
> >>>>> Why? It will be caught by [PATCH 4/5].
> >>>>
> >>>> Right, it will be caught by patch #4.
> >>>> But if you drop this part, then everytime a user runs
> >>>>         fbset -xres 800 -yres 600 -xvres 200
> >>>> users will get the KERNEL BUG WARNING (from patch #4) including
> >>>> a kernel backtrace in their syslogs.
> >>>
> >>> No, they will only see that warning if they are using a broken fbdev
> >>> driver that implements .fb_check_var(), but fails to validate or
> >>> update the passed geometry.
> >>
> >> IMHO this argument is mood.
> >> That way you put pressure on and need such simple code in
> >> each single driver to fix it up, instead of cleaning it up at a central
> >> place.
> >
> > Most hardware has restrictions on resolution (e.g. xres must be a
> > multiple of N), so the driver has to round up the resolution to make
> > it fit.  And after that the driver has to validate and update the
> > virtual resolution again anyway...
> >
> > If a driver does not support changing the video mode, it can leave
> > out the .fb_check_var() and .fb_set_par() callbacks, so the fbdev
> > core will ignore the userspace-supplied parameters, and reinstate
> > the single supported mode. See e.g. "[PATCH] drm/fb-helper:
> > Remove helpers to change frame buffer config"
> > (https://lore.kernel.org/all/20220629105658.1373770-1-geert@linux-m68k.org).
>
> I implemented all of your suggested changes - from this mail and the others.
> I've committed a new testing tree to the fbcon-fix-testing branch at:
> https://github.com/hdeller/linux/tree/fbcon-fix-testing
> The diff is here:
> https://github.com/torvalds/linux/compare/master...hdeller:linux:fbcon-fix-testing
>
> Although your idea is good since we now would find issues in the drivers,
> I don't think we want to commit it, since the testcase from
> the bug report then immediately crashes the kernel - see below.

That is expected behavior with panic_on_warn?
The right fix is to fix the broken .fb_check_var() implementation.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
