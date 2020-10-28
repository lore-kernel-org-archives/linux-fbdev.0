Return-Path: <SRS0=wnYw=ED=vger.kernel.org=linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FDAEC388F7
	for <linux-fbdev@archiver.kernel.org>; Wed, 28 Oct 2020 21:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07767246CD
	for <linux-fbdev@archiver.kernel.org>; Wed, 28 Oct 2020 21:55:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728780AbgJ1Vyf (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 28 Oct 2020 17:54:35 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41555 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728764AbgJ1VyZ (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 28 Oct 2020 17:54:25 -0400
Received: by mail-oi1-f196.google.com with SMTP id k65so1137934oih.8;
        Wed, 28 Oct 2020 14:54:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JaUb44Rael9RollufcGjxryeAFDxCaJy8yyWeBf3MYE=;
        b=Ke0ylEFry4wyB8ur4pyJbFpduGcFUyRQNzyq09O1XvIvjrfovi0/T6TpH+7bmyfFei
         UfK20LYKoRIuOGX5z5D+Xu2mEv1YjmrQ5jnna3BdJisSFje7Gzgw62htOEh9SmWlJXiC
         M51skvLyC2l3SE0rYGmf8G4oYJt+JfYbZcpHp+JgC2OiTB1xCELl88docT8JIf+YQxLz
         hFVeoppYLroBE3NSpElVnLa3l6a7V8IU//m+wKc3CVdFAglYBF9n/FthoV9NoI76I6yq
         ArDd3mPeqjHFVRAl6eWZsSdNdJfdS+A+BRun4EHTD7vrpsBXLu8OZjn+m2HdbAnNRd3O
         eaUg==
X-Gm-Message-State: AOAM530DgM05Vsn8KOQtA3nTBI2r93raD/9ohvV+pecXtM9g7VBIxodt
        6qPOi8iqUoOSuIyN34TYjSxkWOwoMq6/JFJwh0zkSETTR6M=
X-Google-Smtp-Source: ABdhPJzePWTrTQrFoo0k2/Wped76/eKJoLwdjYRZVWJjY0cwBi5OOjzzJxM0qO7UsqY6ipkAu536zeF2iEbbw19JnUI=
X-Received: by 2002:aca:f40c:: with SMTP id s12mr4365389oih.153.1603879193186;
 Wed, 28 Oct 2020 02:59:53 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1603788511.git.yepeilin.cs@gmail.com> <cb5bb49a33ff54fef41e719ee9d301a6a73c5f9c.1603788512.git.yepeilin.cs@gmail.com>
In-Reply-To: <cb5bb49a33ff54fef41e719ee9d301a6a73c5f9c.1603788512.git.yepeilin.cs@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 28 Oct 2020 10:59:42 +0100
Message-ID: <CAMuHMdXJef0O9YTh9+kaOuanGJ9WiCXKQs1CUd6DhyWVjfi7MA@mail.gmail.com>
Subject: Re: [PATCH 1/5] fbdev/atafb: Remove unused extern variables
To:     Peilin Ye <yepeilin.cs@gmail.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Tue, Oct 27, 2020 at 6:12 PM Peilin Ye <yepeilin.cs@gmail.com> wrote:
> Remove 6 unused extern variables to reduce confusion. It is worth
> mentioning that lib/fonts/font_8x8.c and lib/fonts/font_8x16.c also
> declare `fontdata_8x8` and `fontdata_8x16` respectively, and this file
> has nothing to do with them.
>
> Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
