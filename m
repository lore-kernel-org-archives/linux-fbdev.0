Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF399C433ED
	for <linux-fbdev@archiver.kernel.org>; Thu,  1 Apr 2021 09:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 825A46108B
	for <linux-fbdev@archiver.kernel.org>; Thu,  1 Apr 2021 09:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233643AbhDAJ4b (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 1 Apr 2021 05:56:31 -0400
Received: from mail-ua1-f41.google.com ([209.85.222.41]:40952 "EHLO
        mail-ua1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234050AbhDAJ4C (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 1 Apr 2021 05:56:02 -0400
Received: by mail-ua1-f41.google.com with SMTP id 97so334769uav.7;
        Thu, 01 Apr 2021 02:56:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YDXS92zPEjCpL7MJMbrT73u8MWdqrI408SBop4OgNb4=;
        b=p3wsf09PEo0DhdTWyqVbbgdJZuyQzCTVqYw+m/nzzKvVHfSGm36YEtjCAdE8Uk981q
         YCmWDfbgbcUDOPzNGrEEAEMLnsqyIZ2tN32J+fQRBP21tM2bu7U+i0GWeA1fm9Bs5pf/
         xrwbgYFR7l2QyrM0yu0P7dBm7lv1mt+hl/VYV6mdWwBB56bg7WAGtDyZI1uBxbUElv7v
         2rtaLHBsRRk47tDLC7/S9BYeG9Fj27GczHd9On1p17R9ymJIlw+puo5aQBkEea8qU0Vg
         JmhzL/UXIe5Nl/UXcAAX+YsAEATiMlZluxt6/Eqog3urEnHH63nm/x3dCOS59N3mWSGg
         vSaA==
X-Gm-Message-State: AOAM531Kn3wi11IziBs0AoHXWdOST6T44vfhFIUdBTYZ/1c1h1q6Ck8Y
        itKimwdPZJz7hfyTqYTWhiOpjsRC6OSCvrc/Etc=
X-Google-Smtp-Source: ABdhPJw3OSt8aNIPams9lW+tkRGTYrTBk/EgfCRROi8DV35dH66P0/bkhTWTHwVhx5OAEX8diuwcRf3DQ40g2O2+BYM=
X-Received: by 2002:ab0:64cf:: with SMTP id j15mr4124910uaq.4.1617270962087;
 Thu, 01 Apr 2021 02:56:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210331220719.1499743-1-phil@philpotter.co.uk>
In-Reply-To: <20210331220719.1499743-1-phil@philpotter.co.uk>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 1 Apr 2021 11:55:50 +0200
Message-ID: <CAMuHMdVh9JPZKphSi5+KR+BMJL7cQpVifrPBzhR3ees8QBhBXw@mail.gmail.com>
Subject: Re: [PATCH] zero-fill colormap in drivers/video/fbdev/core/fbcmap.c
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Thu, Apr 1, 2021 at 12:09 AM Phillip Potter <phil@philpotter.co.uk> wrote:
> Use kzalloc() rather than kmalloc() for the dynamically allocated parts
> of the colormap in fb_alloc_cmap_gfp, to prevent a leak of random kernel
> data to userspace under certain circumstances.
>
> Fixes a KMSAN-found infoleak bug reported by syzbot at:
> https://syzkaller.appspot.com/bug?id=741578659feabd108ad9e06696f0c1f2e69c4b6e
>
> Reported-by: syzbot+47fa9c9c648b765305b9@syzkaller.appspotmail.com
> Signed-off-by: Phillip Potter <phil@philpotter.co.uk>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
