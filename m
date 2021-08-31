Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51574C432BE
	for <linux-fbdev@archiver.kernel.org>; Tue, 31 Aug 2021 18:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 230E061056
	for <linux-fbdev@archiver.kernel.org>; Tue, 31 Aug 2021 18:56:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236193AbhHaS5f (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 31 Aug 2021 14:57:35 -0400
Received: from mail-vs1-f53.google.com ([209.85.217.53]:36407 "EHLO
        mail-vs1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbhHaS5f (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 31 Aug 2021 14:57:35 -0400
Received: by mail-vs1-f53.google.com with SMTP id f6so402275vsr.3;
        Tue, 31 Aug 2021 11:56:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0hrVR/Pp4bY5ExwU3CuX6SzlhALUUdWlYKXEp50Y348=;
        b=E4t68AklQrX2lq5RL1ENJVvNyuhvJtS3PzlCMQi1hXmCI74aBIeGTykQ1GvAjoct6w
         d7I+w6aADQDe7brIe8p8WvFC6YqEsisd3Kwm4zcddOQBIMYCE3E2Kvd3cUftYOrCS0kl
         LNOvN0r+65222zmakGtqzUtXBRSdAbShWYOJzC6E/Xzs2WQGjKPaPL1QkJJ7C4Kv+LUg
         zoZqb6Z/URehsv6iW9XItS/VH17h/u5pl8S9YugnA7afDjawhDLtr+hv+ex/5ZtFYCoS
         z+MXIbtPgeaJPAg6p7Dme7Ijc2b2lwAzGgaPZi3zJNLaBT44BkoxBG4fh/Sa1xs+6zs8
         aoYw==
X-Gm-Message-State: AOAM532nGSK0wbQZKkgVM7YQd8aBWQYpfeTTuLgC4Geomc/OCETYNkv+
        FyB+el6R+N5qDRHES+NnxAy64PwsB8JVV7x3S77cH6VU
X-Google-Smtp-Source: ABdhPJz9v59KKZoqK9rLnaHapES3XW5DBPdu8VPOELGOeHWSav0EGFF40rmu9oSffgZtAtzQvdPp23duhz+ykWeWZKU=
X-Received: by 2002:a67:cb0a:: with SMTP id b10mr20702000vsl.9.1630436198992;
 Tue, 31 Aug 2021 11:56:38 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000815b9605c70e74f8@google.com> <131b24e5-ee31-6f7b-42b4-c34583711913@infradead.org>
 <2fccb5d3-191c-924e-159f-1c9d423e282f@i-love.sakura.ne.jp>
 <339bfb21-8e80-c7d9-46dd-c416f87c50c0@infradead.org> <535e404d-03bf-8e7a-b296-132a2a98c599@i-love.sakura.ne.jp>
 <CAMuHMdWX7s63X_zR9329canbQkPGBVxZNG4O+_=jUut60aGR9g@mail.gmail.com>
 <5c6d2b95-31d7-0d59-5e62-2593d9a0e1fe@i-love.sakura.ne.jp>
 <CAMuHMdWbSUGRGAVi-17C3hyDBZnGLAsmbAs+wXPHiCNWWLbMpA@mail.gmail.com> <CAKMK7uF1cnen2UVWeOL164z1CCqOuRMC5SmM+5GvRvi7C-UOTw@mail.gmail.com>
In-Reply-To: <CAKMK7uF1cnen2UVWeOL164z1CCqOuRMC5SmM+5GvRvi7C-UOTw@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 31 Aug 2021 20:56:27 +0200
Message-ID: <CAMuHMdWNYaZxZB0Td4PFb76rrtQMumKu6cJgLi2aNnW-9NmG8A@mail.gmail.com>
Subject: Re: [PATCH] fbmem: don't allow too huge resolutions
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzbot <syzbot+04168c8063cfdde1db5e@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Colin King <colin.king@canonical.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Daniel,

On Tue, Aug 31, 2021 at 8:53 PM Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
> On Tue, Aug 31, 2021 at 7:19 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Tue, Aug 31, 2021 at 5:24 PM Tetsuo Handa
> > <penguin-kernel@i-love.sakura.ne.jp> wrote:
> > > On 2021/08/31 15:48, Geert Uytterhoeven wrote:
> > > > Furthermore, this restricts the virtual frame buffer size on 64-bit,
> > > > too, while graphics cards can have much more than 4 GiB of RAM.
> > >
> > > Excuse me, but do you mean that some hardware allows allocating more than
> > > UINT_MAX bytes of memory for kernel frame buffer drivers?
> >
> > While smem_len is u32 (there have been complaints about such
> > limitations on 64-bit platforms as far as 10 years ago), I see no
> > reason why a graphics card with more than 4 GiB of RAM would not be
> > able to provide a very large virtual screen.
> >
> > Of course e.g. vga16fb cannot, as it is limited to 64 KiB.
>
> The first gpus with 4GB or more memory started shipping in 2012. We're
> not going to have fbdev drivers for these, so let's not invent code
> for use-cases that aren't please.

This code path is used with fbdev emulation for drm drivers, too,
right?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
