Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CACCC432BE
	for <linux-fbdev@archiver.kernel.org>; Mon, 30 Aug 2021 14:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F75960E73
	for <linux-fbdev@archiver.kernel.org>; Mon, 30 Aug 2021 14:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233798AbhH3Oy3 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 30 Aug 2021 10:54:29 -0400
Received: from mail-ua1-f43.google.com ([209.85.222.43]:42905 "EHLO
        mail-ua1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233162AbhH3Oy2 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 30 Aug 2021 10:54:28 -0400
Received: by mail-ua1-f43.google.com with SMTP id m39so7954953uad.9;
        Mon, 30 Aug 2021 07:53:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oOeLbxt57qZfv/yH8g9lzPrCzif+fnGpjQ2ymjIQjIU=;
        b=fEwzRwfrXqJuIzVfDgMO6zU4BTor4bZ9k3/QcaB8ugT0p8eVn9eHsE9n7HhLW+u0P2
         EF5CZ9K1jD8v3rBTdHvSVcsBuo8v8PboTNfp+ch2pdJDipgLAY16wIcUo71WcLKWIgPj
         686GhOGHwz6SZLcuYYOhvBece7aQlo40BSyZBgLQUhQOhk01VM8+kCKKC3hDLCgD9plp
         Uawoe9yZ864rXUNfk868FHPZSJplEezpRtIM+nsxWXUsVlhzRd/wM5Zt8nlcyUD3wS9M
         RzB2/MPuNcFC9AOCRbc0ActXFXzAE7zdAgk7wkguxUXfCgAmhaAjOJEe7/krnTUfHPFj
         gknw==
X-Gm-Message-State: AOAM531Ck34x0TXjeqOTef8hGy8QoaUePTBk4zD6CApY1PjIyEWfhpo/
        b9fCNc940DpEok0dn5uQBtWEX6l2AyXc04PT7f8=
X-Google-Smtp-Source: ABdhPJwmIV0qCAzV0q/OlL0uB0+VpSyYfMSp3r7kqu0hk1TSfG7YyjO/GNRUbbaJH49YxcrYEA7rPFV89kbYrCQkZKU=
X-Received: by 2002:ab0:209a:: with SMTP id r26mr15004025uak.14.1630335214663;
 Mon, 30 Aug 2021 07:53:34 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000815b9605c70e74f8@google.com> <131b24e5-ee31-6f7b-42b4-c34583711913@infradead.org>
 <2fccb5d3-191c-924e-159f-1c9d423e282f@i-love.sakura.ne.jp>
 <CAMuHMdV=xVhEHLEoYt3OF+kmGrLOr6t7SP1sghSmp9JqXD+3Og@mail.gmail.com>
 <20210830130000.GW7722@kadam> <8ed0ca59-226b-2d0e-b1ae-82305202558d@i-love.sakura.ne.jp>
 <20210830134719.GI12231@kadam> <03d0f549-9731-8b06-1393-60d4bef27884@i-love.sakura.ne.jp>
 <CAMuHMdXp7D02Z_Hs4wT9y4WeNzqdxHMgExiOzVauvpfgf4Veig@mail.gmail.com> <ba78b9a5-08a5-36d3-7c6f-e26ee239d92f@i-love.sakura.ne.jp>
In-Reply-To: <ba78b9a5-08a5-36d3-7c6f-e26ee239d92f@i-love.sakura.ne.jp>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 30 Aug 2021 16:53:23 +0200
Message-ID: <CAMuHMdWLTPBatefOgdVpfcqQoBw-D1F-_+-+23WdoQfwBcrz6A@mail.gmail.com>
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

On Mon, Aug 30, 2021 at 4:38 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2021/08/30 23:30, Geert Uytterhoeven wrote:
> > The highest possible value of maxmem inside vga16fb_check_var()
> > is 65536.
>
> Yes.
>
> >
> > So I believe
> >
> >     if (array_size(vxres, vyres) > maxmem)
> >
> > should work fine.
>
> My intent is to check at common path than individual module so that we don't
> need to add same check to every module. Same approach is proposed at
> https://lkml.kernel.org/r/1630294223-7225-1-git-send-email-tcs_kernel@tencent.com .

Which I believe is wrong.
Thanks for the pointer, I will reply to the actual patch...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
