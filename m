Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 229BCC77B61
	for <linux-fbdev@archiver.kernel.org>; Fri, 28 Apr 2023 12:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjD1MUk convert rfc822-to-8bit (ORCPT
        <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 28 Apr 2023 08:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346055AbjD1MUg (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 28 Apr 2023 08:20:36 -0400
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783F85FD0
        for <linux-fbdev@vger.kernel.org>; Fri, 28 Apr 2023 05:20:20 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-54fc1824f0bso113187437b3.0
        for <linux-fbdev@vger.kernel.org>; Fri, 28 Apr 2023 05:20:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682684419; x=1685276419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7o32H4PTL3mzxqBzaVY0LbmteAecqwupnN7CxCbojaQ=;
        b=NJVXG1YEct+w15MNlyCPFT1p0Km7Jgiqs/hjkjohK3c6KUVFkG5NMCqUj1RaQB7ixE
         EK/ry00SS8lrHWifuCO5yAn7fiygta0WVfTupElsalNXd4qxTwvwX2ulWkfownkG2Fad
         GsLqCqwdfvdkNnpEwemfnGdhckPUiXN6xv/46IUhbR/vuBRTXxARwkBDI3FR5Go3UqMF
         Hc0y8vt1NHSKAVHsSLoYkK/cS2rA0yTqVWtszOMmNPU/CcZMP0KSDNGvjeamc9+bIhvW
         Xgf50SHEfIrGSYQMpcNuj0g1YxHUErNtwYKAXzU5OH1fB6MAfSR1IzNqgY63mwtBLzGN
         W47w==
X-Gm-Message-State: AC+VfDzsH/KNT9cEhziW78aTvAOHTvJUJyvKhVUAoTnvDuc9kkqSkgw+
        N2INH9/tNoSxyp7mvtoQ6jEXRBgfxlA7pg==
X-Google-Smtp-Source: ACHHUZ7WZAwnuo9qhG7p6+Pvz/Gx932Ml6UZPMjpGP2Zqd4kW4kFka+dcIIf3XxuYEiuMErOKzsMrA==
X-Received: by 2002:a81:8782:0:b0:54f:e1ac:96a with SMTP id x124-20020a818782000000b0054fe1ac096amr3811757ywf.7.1682684419356;
        Fri, 28 Apr 2023 05:20:19 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id w202-20020a0dd4d3000000b00545a081848bsm5401422ywd.27.2023.04.28.05.20.18
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Apr 2023 05:20:18 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-b8f5121503eso14625888276.1
        for <linux-fbdev@vger.kernel.org>; Fri, 28 Apr 2023 05:20:18 -0700 (PDT)
X-Received: by 2002:a25:782:0:b0:b97:1e2e:a4e5 with SMTP id
 124-20020a250782000000b00b971e2ea4e5mr3739275ybh.40.1682684417838; Fri, 28
 Apr 2023 05:20:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230425142846.730-1-tzimmermann@suse.de> <20230425142846.730-6-tzimmermann@suse.de>
 <CAMuHMdU-_w9yQHYhOCD3cz4CEY6ag-dTXjuHSLnzty0hAMBbXw@mail.gmail.com>
 <1d81e4cc-5079-12a7-4cf5-c31879396e56@suse.de> <CAMuHMdWDyabYxtRHtvuNZy8BjoukRdycAMK2jX+qmgc51HU5Xw@mail.gmail.com>
 <b7c09aa8-ce41-9c9a-062f-e652ea92f8a8@suse.de>
In-Reply-To: <b7c09aa8-ce41-9c9a-062f-e652ea92f8a8@suse.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 28 Apr 2023 14:20:03 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUq_bkCWQJfe=j+RAC8s6Ce9KPROy7RxaoPGpUX70+EXw@mail.gmail.com>
Message-ID: <CAMuHMdUq_bkCWQJfe=j+RAC8s6Ce9KPROy7RxaoPGpUX70+EXw@mail.gmail.com>
Subject: Re: [PATCH 5/6] fbdev: Move CFB read and write code into helper functions
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@gmail.com, daniel@ffwll.ch, javierm@redhat.com,
        deller@gmx.de, sudipm.mukherjee@gmail.com,
        teddy.wang@siliconmotion.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Thomas,

On Fri, Apr 28, 2023 at 1:20 PM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Am 26.04.23 um 17:21 schrieb Geert Uytterhoeven:
> > On Wed, Apr 26, 2023 at 5:06 PM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> >> Am 26.04.23 um 17:01 schrieb Geert Uytterhoeven:
> >>> On Tue, Apr 25, 2023 at 4:28 PM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> >>>> Move the existing CFB read and write code for I/O memory into
> >>>> the new helpers fb_cfb_read() and fb_cfb_write(). Make them the
> >>>> default fp_ops. No functional changes.
> >>>>
> >>>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> >>>> ---
> >>>>    drivers/video/fbdev/core/Makefile      |   2 +-
> >>>>    drivers/video/fbdev/core/fb_cfb_fops.c | 126 +++++++++++++++++++++++++
> >>>>    drivers/video/fbdev/core/fbmem.c       | 113 +---------------------
> >>>>    include/linux/fb.h                     |  10 ++
> >>>>    4 files changed, 139 insertions(+), 112 deletions(-)
> >>>>    create mode 100644 drivers/video/fbdev/core/fb_cfb_fops.c
> >>>
> >>> While the general idea is fine, please do not call any of this "cfb",
> >>> as it is not related to chunky color frame buffer formats.
> >>> All of these operate on the raw frame buffer contents.
> >>
> >> Shall I call it fb_raw_() or fb_io_()?
> >
> > Given fb_memcpy_fromfb() is mapped to memcpy_fromio() on
> > most architectures, I'd go for fb_io_*().
>
> Ok, makes sense.
>
> >> CFB is used by the drawing helpers, which are usually used together with
> >> this code. Hence the current naming.
> >
> > That's because your drawing helpers operate (only) on chunky color
> > frame buffer formats ;-)
>
> Should we rename the CFB drawing functions to fb_io_ then? AFAICT they
> are the same algorithms as in the fb_sys_ functions; just with I/O memory.

I don't know if that's worth the churn.
Historically, the frame buffer was usually located in dedicated memory,
hence the drawing operations operated on I/O memory.
With the advent of unified memory architectures, the fb_sys_*()
functions were introduced.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
