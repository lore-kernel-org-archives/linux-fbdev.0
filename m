Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50797C433DB
	for <linux-fbdev@archiver.kernel.org>; Wed, 27 Jan 2021 08:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0217520727
	for <linux-fbdev@archiver.kernel.org>; Wed, 27 Jan 2021 08:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbhA0IrI (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 27 Jan 2021 03:47:08 -0500
Received: from mail-oi1-f171.google.com ([209.85.167.171]:46408 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbhA0Io7 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 27 Jan 2021 03:44:59 -0500
Received: by mail-oi1-f171.google.com with SMTP id k25so1346232oik.13;
        Wed, 27 Jan 2021 00:44:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mutFHLc1gkkZrR4Fer8oAQQ0VCNtXv8me5nxm8JFG6o=;
        b=DnOA1IGmjQYbY4KLzonEeZkIja7LjirV7YHOmwmHDUGLetyAeWN0fFNbm78SfD7wNx
         PJ4dvjIU0x2UgJ2DtDpXzUJ+8x9lwIZR7619AjdskX+ywN20rMm+OoDx6ITAB+canVcN
         W5DpEI//d0luRFxn5WX967QDKNQhrmEOoX7+yDAy3wNsI3qQMzLeiagbKdTEDerXe2a7
         vjnNegZjmzAwlJGaZta5Rm7ci5sOWMm6dYNjwIKOHZKQ7q5mNsj+Br1cWTVtfnI2+YTo
         U6Ityr3DdKz86xPqWDnA/tAZoJxY14f2aBlr7EQFwbjVwTIg3U1c2B4XmKrenxtSjX9d
         bi8g==
X-Gm-Message-State: AOAM533tMZ1OoROfyCDdheIyKMK1mhzBjQhYinA12IggeZa6uv8Z1WhE
        C4j2eUEa3++cDXNfvei+ovxF+G5rtI8MA9DeDVI=
X-Google-Smtp-Source: ABdhPJyRilKemvCJEv7600MUD7rrw3Vm6t3WWaVeIyKZk2WvWyk7vpQeeMYS1vDHeon2cuMn7KqlF1medC/JKjRyBlE=
X-Received: by 2002:a54:4e88:: with SMTP id c8mr2448439oiy.148.1611737056266;
 Wed, 27 Jan 2021 00:44:16 -0800 (PST)
MIME-Version: 1.0
References: <20210126182113.19892-1-david@redhat.com> <20210126182113.19892-2-david@redhat.com>
In-Reply-To: <20210126182113.19892-2-david@redhat.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 27 Jan 2021 09:44:05 +0100
Message-ID: <CAMuHMdVp=K6UpR_BfrJjiFEJgQt4nC7n35M8O+Wr2kSqfeERxQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] video: fbdev: acornfb: remove free_unused_pages()
To:     David Hildenbrand <david@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Tue, Jan 26, 2021 at 11:54 PM David Hildenbrand <david@redhat.com> wrote:
> This function is never used and it is one of the last remaining user of
> __free_reserved_page(). Let's just drop it.
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Fixes: ffd29195ed720188 ("drivers/video/acornfb.c: remove dead code")

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
