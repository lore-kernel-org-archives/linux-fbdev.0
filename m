Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5E5C432BE
	for <linux-fbdev@archiver.kernel.org>; Mon, 30 Aug 2021 15:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B066460C40
	for <linux-fbdev@archiver.kernel.org>; Mon, 30 Aug 2021 15:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233162AbhH3PB4 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 30 Aug 2021 11:01:56 -0400
Received: from mail-vs1-f48.google.com ([209.85.217.48]:33330 "EHLO
        mail-vs1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237123AbhH3PB4 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 30 Aug 2021 11:01:56 -0400
Received: by mail-vs1-f48.google.com with SMTP id bf15so7486565vsb.0;
        Mon, 30 Aug 2021 08:01:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u13jY3wSZM31fcmpr4GBs3113ESNVPQ9w7zIuFDRtqA=;
        b=S26MupTMB9lNp+e5CmUl21PLpFTAmE0SKz2wgO6NHFMjhxkQYKALAhKAv0IFFt9U5S
         bObtw7oPJiQxRQCxz/jg0p3gidQP8VsVmiIrJ99iEoeW2fNdhO/WONT7/IosJ9ZTqf3u
         ZTx3vk2tyuWs5pJ3mwrn/7ssMs9DxXrn8F5BiACPqU7ji2Srw5FYv3ozQhGJvnqoON3O
         8aE6ZCytDW9tX/aoQfApzaa4qfpKS65ll++ppM/mCee8gzhlnREp/sgMnD0EMaC/vqMB
         3yRW8oyebOVZMIRoavNBlDICwOZJLdzDnCN0eTT38fhAlvugREM/KbVXtWIjYmzR885q
         vkuw==
X-Gm-Message-State: AOAM533yF3lMvv23mYatvcdpRVN5B5kMy23Gm4Xjr8BzNXKv+zYt3Wma
        OlVLTLDmWc1FLlAkLGiBAYTLoebQ8/HIuyBFxL4=
X-Google-Smtp-Source: ABdhPJycXkCL/LhUbLlVUIVrKZgwucuUJ5aj2ffNWq+81tLkWAXOEw1KSPDM3UaKy+3i0pGmd6eAWJNnwA27a2ky+cc=
X-Received: by 2002:a67:c789:: with SMTP id t9mr15437109vsk.60.1630335661896;
 Mon, 30 Aug 2021 08:01:01 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000815b9605c70e74f8@google.com> <131b24e5-ee31-6f7b-42b4-c34583711913@infradead.org>
 <2fccb5d3-191c-924e-159f-1c9d423e282f@i-love.sakura.ne.jp>
 <CAMuHMdV=xVhEHLEoYt3OF+kmGrLOr6t7SP1sghSmp9JqXD+3Og@mail.gmail.com>
 <20210830130000.GW7722@kadam> <8ed0ca59-226b-2d0e-b1ae-82305202558d@i-love.sakura.ne.jp>
 <20210830134719.GI12231@kadam> <03d0f549-9731-8b06-1393-60d4bef27884@i-love.sakura.ne.jp>
 <CAMuHMdXp7D02Z_Hs4wT9y4WeNzqdxHMgExiOzVauvpfgf4Veig@mail.gmail.com>
 <ba78b9a5-08a5-36d3-7c6f-e26ee239d92f@i-love.sakura.ne.jp> <CAMuHMdWLTPBatefOgdVpfcqQoBw-D1F-_+-+23WdoQfwBcrz6A@mail.gmail.com>
In-Reply-To: <CAMuHMdWLTPBatefOgdVpfcqQoBw-D1F-_+-+23WdoQfwBcrz6A@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 30 Aug 2021 17:00:49 +0200
Message-ID: <CAMuHMdUtjd7Uf9VPEEztL+raasLdRqfMN55S8B8Nqoh0vxuk1g@mail.gmail.com>
Subject: Re: [syzbot] BUG: unable to handle kernel paging request in vga16fb_fillrect
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        syzbot <syzbot+04168c8063cfdde1db5e@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Colin King <colin.king@canonical.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Tetsuo,

On Mon, Aug 30, 2021 at 4:53 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Mon, Aug 30, 2021 at 4:38 PM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
> > On 2021/08/30 23:30, Geert Uytterhoeven wrote:
> > > The highest possible value of maxmem inside vga16fb_check_var()
> > > is 65536.
> >
> > Yes.
> >
> > >
> > > So I believe
> > >
> > >     if (array_size(vxres, vyres) > maxmem)
> > >
> > > should work fine.
> >
> > My intent is to check at common path than individual module so that we don't
> > need to add same check to every module. Same approach is proposed at
> > https://lkml.kernel.org/r/1630294223-7225-1-git-send-email-tcs_kernel@tencent.com .
>
> Which I believe is wrong.
> Thanks for the pointer, I will reply to the actual patch...

Upon second look, that patch is not really wrong, as the check happens
after calling into info->fbops->fb_check_var().

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
