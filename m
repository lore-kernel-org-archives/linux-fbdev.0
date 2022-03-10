Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3884CC433EF
	for <linux-fbdev@archiver.kernel.org>; Thu, 10 Mar 2022 19:23:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243269AbiCJTYm (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 10 Mar 2022 14:24:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238741AbiCJTYl (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 10 Mar 2022 14:24:41 -0500
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A19012B768
        for <linux-fbdev@vger.kernel.org>; Thu, 10 Mar 2022 11:23:39 -0800 (PST)
Received: by mail-qt1-f173.google.com with SMTP id 10so3002010qtz.11
        for <linux-fbdev@vger.kernel.org>; Thu, 10 Mar 2022 11:23:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HoHIIrMg0k/ZFTGcfgryylR1kLXwE+5bLslGVm788tY=;
        b=D0cDYvaEaGjXovLydlOUe+3AT+ljCBJpYXPIJ6g/uhv9qor9sKICzZnPovHnbMK5AS
         Ls83UhZhhcbKMrZzq4ehJF24Am1LCL6OGpqCC6fP7w8E7fUFgbAK/omoEPT516bd6bR0
         mVbCnuko1EKNY6H/gU/bA6OD7u5s8YeV74yqgA1pp9skjivEWo9ZqT/6E/iVEbPdiOpm
         ccHtoJFDID4pfQV1yxOVfRsxmLamWxpwvDIs7mTDtrzGkC7TZoE8Vz8c1DGtKOYLc579
         Q5uDVwQPG/F8OWb2QFb0AnMJuca6yWvpoLRHnHUY8HqyWvwk9R9T0BW4oNNtkjh1Deeh
         14zg==
X-Gm-Message-State: AOAM531RGxBYzLTBugkIROBIriHjWv0pBOspZbWzZDeL8rIgqs1qGFwh
        M2hgNcufYs2tPWVXg/xgZI1Rl5fkHu5gTg==
X-Google-Smtp-Source: ABdhPJy9gutMT2J2Z09Nrxd4oLVMcW0977tPhQ3yrVxZc43CGHCZ9xP9zF2Mdy26NrsPnCcCF1sInQ==
X-Received: by 2002:a05:622a:1825:b0:2e0:64e4:5a93 with SMTP id t37-20020a05622a182500b002e064e45a93mr5364590qtc.400.1646940217107;
        Thu, 10 Mar 2022 11:23:37 -0800 (PST)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id j10-20020ac85f8a000000b002dde6288fa7sm3924747qta.83.2022.03.10.11.23.35
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 11:23:35 -0800 (PST)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-2dbfe58670cso69948927b3.3
        for <linux-fbdev@vger.kernel.org>; Thu, 10 Mar 2022 11:23:35 -0800 (PST)
X-Received: by 2002:a81:49d0:0:b0:2db:dc6d:445d with SMTP id
 w199-20020a8149d0000000b002dbdc6d445dmr5497712ywa.512.1646940215076; Thu, 10
 Mar 2022 11:23:35 -0800 (PST)
MIME-Version: 1.0
References: <20220223193804.18636-5-tzimmermann@suse.de> <CGME20220308225225eucas1p12fcdd6e5dc83308b19d51ad7b2a13141@eucas1p1.samsung.com>
 <21110de8-d52a-e55e-8853-1f073c4ab969@samsung.com> <a7c8ee6c-185e-916c-c92a-d3b3f4fd9135@suse.de>
 <f318d57d-ef9e-295a-6865-eb0377a9bd07@samsung.com> <CAMuHMdU4w-68-V2QXqbJqorL3iQFyBSRkGTrz5ePFRRUC8mRzw@mail.gmail.com>
 <d8726a6e-d0a9-1471-c113-a7bf567aa994@suse.de>
In-Reply-To: <d8726a6e-d0a9-1471-c113-a7bf567aa994@suse.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 10 Mar 2022 20:23:23 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVO0-q8CU7CAf-5O1CQ3e-8eeg73KgbS8uDAVY+vnd6nw@mail.gmail.com>
Message-ID: <CAMuHMdVO0-q8CU7CAf-5O1CQ3e-8eeg73KgbS8uDAVY+vnd6nw@mail.gmail.com>
Subject: Re: [v3,4/5] fbdev: Improve performance of cfb_imageblit()
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Thomas,

On Thu, Mar 10, 2022 at 8:22 PM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Am 09.03.22 um 11:39 schrieb Geert Uytterhoeven:
> > On Wed, Mar 9, 2022 at 10:22 AM Marek Szyprowski
> > <m.szyprowski@samsung.com> wrote:
> >> On 09.03.2022 09:22, Thomas Zimmermann wrote:
> >>> Am 08.03.22 um 23:52 schrieb Marek Szyprowski:
> >>>> On 23.02.2022 20:38, Thomas Zimmermann wrote:
> >>>>> Improve the performance of cfb_imageblit() by manually unrolling
> >>>>> the inner blitting loop and moving some invariants out. The compiler
> >>>>> failed to do this automatically. This change keeps cfb_imageblit()
> >>>>> in sync with sys_imagebit().
> >>>>>
> >>>>> A microbenchmark measures the average number of CPU cycles
> >>>>> for cfb_imageblit() after a stabilizing period of a few minutes
> >>>>> (i7-4790, FullHD, simpledrm, kernel with debugging).
> >>>>>
> >>>>> cfb_imageblit(), new: 15724 cycles
> >>>>> cfb_imageblit(): old: 30566 cycles
> >>>>>
> >>>>> In the optimized case, cfb_imageblit() is now ~2x faster than before.
> >>>>>
> >>>>> v3:
> >>>>>      * fix commit description (Pekka)
> >>>>>
> >>>>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> >>>>> Acked-by: Sam Ravnborg <sam@ravnborg.org>
> >>>>> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> >>>> This patch landed recently in linux next-20220308 as commit 0d03011894d2
> >>>> ("fbdev: Improve performance of cfb_imageblit()"). Sadly it causes a
> >>>> freeze after DRM and emulated fbdev initialization on various Samsung
> >>>> Exynos ARM 32bit based boards. This happens when kernel is compiled from
> >>>> exynos_defconfig. Surprisingly when kernel is compiled from
> >>>> multi_v7_defconfig all those boards boot fine, so this is a matter of
> >>>> one of the debugging options enabled in the exynos_defconfig. I will try
> >>>> to analyze this further and share the results. Reverting $subject on top
> >>>> of next-20220308 fixes the boot issue.
> >>>
> >>> Thanks for reporting. I don't have the hardware to reproduce it and
> >>> there's no obvious difference to the original version. It's supposed
> >>> to be the same algorithm with a different implementation. Unless you
> >>> can figure out the issue, we can also revert the patch easily.
> >>
> >> I've played a bit with .config options and found that the issue is
> >> caused by the compiled-in fonts used for the framebuffer. For some
> >> reasons (so far unknown to me), exynos_defconfig has the following odd
> >> setup:
> >>
> >> CONFIG_FONT_SUPPORT=y
> >> CONFIG_FONTS=y
> >> # CONFIG_FONT_8x8 is not set
> >> # CONFIG_FONT_8x16 is not set
> >> # CONFIG_FONT_6x11 is not set
> >> CONFIG_FONT_7x14=y
> >> # CONFIG_FONT_PEARL_8x8 is not set
> >> # CONFIG_FONT_ACORN_8x8 is not set
> >> # CONFIG_FONT_MINI_4x6 is not set
> >> # CONFIG_FONT_6x10 is not set
> >> # CONFIG_FONT_10x18 is not set
> >> # CONFIG_FONT_SUN8x16 is not set
> >> # CONFIG_FONT_SUN12x22 is not set
> >> # CONFIG_FONT_TER16x32 is not set
> >> # CONFIG_FONT_6x8 is not set
> >>
> >> Such setup causes a freeze during framebuffer initialization (or just
> >> after it got registered). I've reproduced this even on Raspberry Pi 3B
> >> with multi_v7_defconfig and changed fonts configuration (this also
> >> required to disable vivid driver, which forces 8x16 font), where I got
> >> the following panic:
> >>
> >> simple-framebuffer 3eace000.framebuffer: framebuffer at 0x3eace000,
> >> 0x12c000 bytes
> >> simple-framebuffer 3eace000.framebuffer: format=a8r8g8b8,
> >> mode=640x480x32, linelength=2560
> >> 8<--- cut here ---
> >> Unable to handle kernel paging request at virtual address f0aac000
> >
> > So support for images with offsets or widths that are not a multiple
> > of 8 got broken in cfb_imageblit(). Oops...
> >
> > BTW, the various drawing routines used to set a bitmask indicating
> > which alignments were supported (see blit_x), but most of them no
> > longer do, presumably because all alignments are now supported
> > (since ca. 20 years?).
> > So you can (temporarily) work around this by filling in blit_x,
> > preventing the use of the 7x14 font.
>
> How do I activate the 7x14 font? It's compiled into the kernel already
> (CONFIG_FONT_7x14=y).

Documentation/fb/fbcon.rst:1. fbcon=font:<name>

Or just disable all other fonts.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
