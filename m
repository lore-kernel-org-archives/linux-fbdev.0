Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D18BEC433DB
	for <linux-fbdev@archiver.kernel.org>; Wed, 27 Jan 2021 08:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9064820754
	for <linux-fbdev@archiver.kernel.org>; Wed, 27 Jan 2021 08:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbhA0IwB (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 27 Jan 2021 03:52:01 -0500
Received: from mail-ot1-f43.google.com ([209.85.210.43]:39104 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbhA0ItA (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 27 Jan 2021 03:49:00 -0500
Received: by mail-ot1-f43.google.com with SMTP id i30so962577ota.6;
        Wed, 27 Jan 2021 00:48:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gAKk6Yt/rmV2RLudc2xk6PS0Y1a3qymlWcwiHDkjBr8=;
        b=m0f2FdGzYRFd9t1J4fdfTXTSeSpkoQmTJbZEaTWfATGjzqmGYGiD77CN5NxQaLvwHX
         iXXeD1I3TXUeXWUp3Ilkc+bFbryLbqXfwl22yPA8LVwUnwcizLJ/EQ8JHNxqJQJKd3VX
         QAAi73n47tA/oGr5cs4cv2wej7b+u1oE5aMlFgPIQt7bslDSfE4c6PDt8RUBOLzLy/u0
         n8X3epoaA+qv9pqCV7En0VE31OHulTnjUVT0oHCYD4F2OmWXnGicMyOAVSrn1wuu7wK8
         DW/hDrSvoVJG55QEJmZOdOeZw1hY7gbWQLpbegmRJ4kalwxaeceiXH9SUIKjnKUdxJYM
         QD9A==
X-Gm-Message-State: AOAM532SuEdMYWS7fapyyK8gVUO2GHAyZs8YJRTcrVDXtgHkGAchBReu
        D/yW2kV0sh/8mLJEpo+sqrWFpyuBeH4HIlqPK+Q=
X-Google-Smtp-Source: ABdhPJySkivwQpGFAZ+Grur9SYXrqqzDLD2UjmL030BacL3j7AyYhWe0zsuxjg9LQwAaq9rS0JKApCeVs56Z0mGYjzQ=
X-Received: by 2002:a05:6830:15cc:: with SMTP id j12mr6928590otr.145.1611737299392;
 Wed, 27 Jan 2021 00:48:19 -0800 (PST)
MIME-Version: 1.0
References: <1611711140-68260-1-git-send-email-zhangxuezhi3@gmail.com>
 <20210127054523.GA2696@kadam> <20210127141927.00004472@gmail.com> <20210127064916.GD2696@kadam>
In-Reply-To: <20210127064916.GD2696@kadam>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 27 Jan 2021 09:48:08 +0100
Message-ID: <CAMuHMdVHZWz-9eA9yocTrNfZ5T_j+x5Ymqt262tCjTwQUzMDVw@mail.gmail.com>
Subject: Re: [PATCH v5] fbtft: add tearing signal detect
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        carlis <zhangxuezhi3@gmail.com>
Cc:     driverdevel <devel@driverdev.osuosl.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        mh12gx2825@gmail.com, Greg KH <gregkh@linuxfoundation.org>,
        oliver.graute@kococonnector.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Stefano Brivio <sbrivio@redhat.com>,
        Colin King <colin.king@canonical.com>, zhangxuezhi1@yulong.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Dan, Carlis,

On Wed, Jan 27, 2021 at 9:32 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> On Wed, Jan 27, 2021 at 02:19:27PM +0800, carlis wrote:
> > hi,i will fix it like below:
> >       par->gpio.te = devm_gpiod_get_index_optional(dev, "te", 0,
> > GPIOD_IN); if (IS_ERR(par->gpio.te)) {
> >               rc = PTR_ERR(par->gpio.te);
> >               pr_err("Failed to request  te gpio: %d\n", rc);
> >               par->gpio.te = NULL;
> >       }
>
> I wish you would just copy and paste the code that I sent you instead,
> but this also fixes the crash...

While this fixes the crash, it does not propagate the error condition
(which may be -EPROBE_DEFER) upstream.
Same for devm_request_irq().

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
