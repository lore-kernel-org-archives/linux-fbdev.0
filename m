Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E14C43334
	for <linux-fbdev@archiver.kernel.org>; Fri,  1 Jul 2022 07:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbiGAH2h (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 1 Jul 2022 03:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbiGAH2f (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Fri, 1 Jul 2022 03:28:35 -0400
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26AB528E0F
        for <linux-fbdev@vger.kernel.org>; Fri,  1 Jul 2022 00:28:34 -0700 (PDT)
Received: by mail-qv1-f49.google.com with SMTP id g6so1087979qvt.5
        for <linux-fbdev@vger.kernel.org>; Fri, 01 Jul 2022 00:28:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ItiQX8JxxOqPGnMxDgw8fRBl9Ocf7hYz3g9osOjYopM=;
        b=iCrzaerGJM9zJBhJTS2TQEZtEFQ3RBUZ2xBq0gGDF2xkJoFHK8Xa01pqh8CT+HhyXU
         XJv4A5hkv0mckCBFaVKsBIrKhNvnjnLb+H0WJcMD/x8+puwBAX7Dkm8gdmEfQ3UU6FCn
         OLIFov0JwdH/zDRn2jI1y5ybAWMpdWyQJMSh56LmSbfY6cjmYGdv7AKWsG++Mp9EXx3Z
         pGNofUk64lr7wPiV1vDtJTgcK7vVvoZZsOzbytvp4l6Msf0smH5q8sdnaIbHSmq+IPnV
         79giZ5kBJzEa4/xLjBERGMnpfGLby6vrEQ9Y04w7s4ySGaKotk7141hX1BG9L9DmGIb6
         1NMA==
X-Gm-Message-State: AJIora+OhUtueH7M+LrvTVVnrdLcWGDUZy1lD3DpP+xuUQuGxn4qBZOf
        Fhs/4F98JMZXzOhHV06z6n+uISb64rhSLQ==
X-Google-Smtp-Source: AGRyM1tkgszaTt//IuTYDjIooA9ZTu1Ow9WyPubaznESUBu4sim+zmXBqyvw/3Y4i2kKtyXmj+ajYQ==
X-Received: by 2002:ac8:5953:0:b0:317:cfd0:1a72 with SMTP id 19-20020ac85953000000b00317cfd01a72mr11352601qtz.483.1656660513075;
        Fri, 01 Jul 2022 00:28:33 -0700 (PDT)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id c3-20020ac84e03000000b00304f55e56e4sm14071006qtw.40.2022.07.01.00.28.32
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Jul 2022 00:28:32 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-3176b6ed923so15012197b3.11
        for <linux-fbdev@vger.kernel.org>; Fri, 01 Jul 2022 00:28:32 -0700 (PDT)
X-Received: by 2002:a81:74c5:0:b0:31b:ca4b:4bc4 with SMTP id
 p188-20020a8174c5000000b0031bca4b4bc4mr15131919ywc.358.1656660512246; Fri, 01
 Jul 2022 00:28:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220629200024.187187-1-deller@gmx.de> <20220629200024.187187-3-deller@gmx.de>
 <CAMuHMdXJRBywf+h_u1jgA6X7hLSByDDwSkskff47a0BHfd93iA@mail.gmail.com>
 <0c418b7d-474a-3f93-a1fb-2f13c4d19941@gmx.de> <CAMuHMdUoMJ6CmiKDh4MW_b-7uoxEF+H6QimsA7SfcE5kjo17vw@mail.gmail.com>
 <d57655b2-44d1-4083-c4e9-ef4f004f2b64@gmx.de> <CAMuHMdXk9Kz4-pv7-M9tufj-pruhOZWw_b51fegkr2JSqzL65g@mail.gmail.com>
 <cae3dc86-8156-eef5-1af4-b16cb2a42849@gmx.de>
In-Reply-To: <cae3dc86-8156-eef5-1af4-b16cb2a42849@gmx.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 1 Jul 2022 09:28:20 +0200
X-Gmail-Original-Message-ID: <CAMuHMdViqMgpiB2a-cLt1viVMgGbBz_Q=youNsWdLPYxcXxFpA@mail.gmail.com>
Message-ID: <CAMuHMdViqMgpiB2a-cLt1viVMgGbBz_Q=youNsWdLPYxcXxFpA@mail.gmail.com>
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

On Thu, Jun 30, 2022 at 10:10 PM Helge Deller <deller@gmx.de> wrote:
> On 6/30/22 22:00, Geert Uytterhoeven wrote:
> > On Thu, Jun 30, 2022 at 9:46 PM Helge Deller <deller@gmx.de> wrote:
> >> On 6/30/22 21:36, Geert Uytterhoeven wrote:
> >>> On Thu, Jun 30, 2022 at 9:31 PM Helge Deller <deller@gmx.de> wrote:
> >>>> On 6/30/22 21:00, Geert Uytterhoeven wrote:
> >>>>> On Wed, Jun 29, 2022 at 10:00 PM Helge Deller <deller@gmx.de> wrote:
> >>>>>> The virtual screen size can't be smaller than the physical screen size.
> >>>>>> Based on the general rule that we round up user-provided input if
> >>>>>> neccessary, adjust the virtual screen size as well if needed.
> >>>>>>
> >>>>>> Signed-off-by: Helge Deller <deller@gmx.de>
> >>>>>> Cc: stable@vger.kernel.org # v5.4+
> >>>>>
> >>>>> Thanks for your patch!
> >>>>>
> >>>>>> --- a/drivers/video/fbdev/core/fbmem.c
> >>>>>> +++ b/drivers/video/fbdev/core/fbmem.c
> >>>>>> @@ -1106,6 +1106,11 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
> >>>>>>                         return -EFAULT;
> >>>>>>                 console_lock();
> >>>>>>                 lock_fb_info(info);
> >>>>>> +               /* adjust virtual screen size if user missed it */
> >>>>>> +               if (var.xres_virtual < var.xres)
> >>>>>> +                       var.xres_virtual = var.xres;
> >>>>>> +               if (var.yres_virtual < var.yres)
> >>>>>> +                       var.yres_virtual = var.yres;
> >>>>>>                 ret = fb_set_var(info, &var);
> >>>>>>                 if (!ret)
> >>>>>>                         fbcon_update_vcs(info, var.activate & FB_ACTIVATE_ALL);
> >>>>>
> >>>>> Given "[PATCH 4/5] fbmem: Prevent invalid virtual screen sizes in
> >>>>> fb_set_var", I don't think we need this patch.
> >>>>
> >>>> We do.
> >>>
> >>> Why? It will be caught by [PATCH 4/5].
> >>
> >> Right, it will be caught by patch #4.
> >> But if you drop this part, then everytime a user runs
> >>         fbset -xres 800 -yres 600 -xvres 200
> >> users will get the KERNEL BUG WARNING (from patch #4) including
> >> a kernel backtrace in their syslogs.
> >
> > No, they will only see that warning if they are using a broken fbdev
> > driver that implements .fb_check_var(), but fails to validate or
> > update the passed geometry.
>
> IMHO this argument is mood.
> That way you put pressure on and need such simple code in
> each single driver to fix it up, instead of cleaning it up at a central
> place.

Most hardware has restrictions on resolution (e.g. xres must be a
multiple of N), so the driver has to round up the resolution to make
it fit.  And after that the driver has to validate and update the
virtual resolution again anyway...

If a driver does not support changing the video mode, it can leave
out the .fb_check_var() and .fb_set_par() callbacks, so the fbdev
core will ignore the userspace-supplied parameters, and reinstate
the single supported mode. See e.g. "[PATCH] drm/fb-helper:
Remove helpers to change frame buffer config"
(https://lore.kernel.org/all/20220629105658.1373770-1-geert@linux-m68k.org).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
