Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BBF2C43460
	for <linux-fbdev@archiver.kernel.org>; Fri, 14 May 2021 21:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EE8D61285
	for <linux-fbdev@archiver.kernel.org>; Fri, 14 May 2021 21:11:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbhENVMQ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 14 May 2021 17:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbhENVMP (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 14 May 2021 17:12:15 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0697C061574
        for <linux-fbdev@vger.kernel.org>; Fri, 14 May 2021 14:11:02 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id s25so38051ljo.11
        for <linux-fbdev@vger.kernel.org>; Fri, 14 May 2021 14:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qmD8bOtABF5XD+YzylZZ0F+UXv+l/cf1tAlHtz2MQKI=;
        b=E7NGDr8baMYrNmyWjoI5iqN4uwMNaqda9XZ6KgibagBhs7q01o3AiUnWU21oLy+K+p
         05yfVvaCeBxwJ+GRX7lNtGVBy1um0kIwp/pOYG3jAYfNG7rU+EMqRTrceEygaNGT81+E
         I6Kf4BqE1SyN58yvSQudkP2u9VbbGuJjaYF7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qmD8bOtABF5XD+YzylZZ0F+UXv+l/cf1tAlHtz2MQKI=;
        b=lBPQwDoFeRA4mSDgDkZXXvpZ5vy/ePWpnA/bEGmDmRSxI7C19+XyHC+bP/2DdWDZPT
         vhASfBXXAV5isAjjXffDZuqd4gBz5l8h4kvZ9SZvbSBiYvIrLn+sVcdvZrMkIGI6Wayt
         KnChOWLVmhCpG/WcJ734Zl8AQOmGaq7UUzc5esJlWdHkplzTpFUAW3gA64lERfLmWwDB
         C8ooUfbc3neqEdeZvmr/YrWIX73zuVq0McmN6orOJHvt8l55no1sfODRJDf2bCNVa1g5
         v+t5q0UJkbYI9ClQnGPRe3aC/1hMi5LBz2P5/fE2E039K509x4WKoWuY+LRh8r1dA7uW
         2ZyQ==
X-Gm-Message-State: AOAM531/rRoScMcQiHUuQYGm1yCloFYUO0lYJZVH9GxBfuOxIWmLGu8G
        eXiQmRpV1oC56MRlH7SFokQsCHDqnEM0DDrQ2zc=
X-Google-Smtp-Source: ABdhPJz7H33CgzyvepENBrOA9F/4imKH6twoavAkm3FNjZ360w2NrANKD/3lZ2Slb7VQd7dp25Dbrw==
X-Received: by 2002:a2e:814d:: with SMTP id t13mr37852802ljg.467.1621026661207;
        Fri, 14 May 2021 14:11:01 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id b8sm238597lfs.282.2021.05.14.14.11.00
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 May 2021 14:11:01 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id p20so54284ljj.8
        for <linux-fbdev@vger.kernel.org>; Fri, 14 May 2021 14:11:00 -0700 (PDT)
X-Received: by 2002:a2e:22c4:: with SMTP id i187mr38530598lji.465.1621026660520;
 Fri, 14 May 2021 14:11:00 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000006bbd0c05c14f1b09@google.com> <6e21483c-06f6-404b-4018-e00ee85c456c@i-love.sakura.ne.jp>
 <87d928e4-b2b9-ad30-f3f0-1dfb8e4e03ed@i-love.sakura.ne.jp>
 <05acdda8-dc1c-5119-4326-96eed24bea0c@i-love.sakura.ne.jp>
 <CAHk-=wguwhFpjhyMtDaH2hhjoV62gDgByC=aPyTrW9CkM5hqvA@mail.gmail.com>
 <alpine.DEB.2.21.2105142150460.3032@angie.orcam.me.uk> <CAHk-=wioOHwKNj8AmvXWV-oL60ae0jKswAHy9e6wCYYeA5EQXg@mail.gmail.com>
In-Reply-To: <CAHk-=wioOHwKNj8AmvXWV-oL60ae0jKswAHy9e6wCYYeA5EQXg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 14 May 2021 14:10:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjkVAjfWrmmJnJe1_MriK9gezWCew_MU=MbQNzHbGopsQ@mail.gmail.com>
Message-ID: <CAHk-=wjkVAjfWrmmJnJe1_MriK9gezWCew_MU=MbQNzHbGopsQ@mail.gmail.com>
Subject: Re: [PATCH] video: fbdev: vga16fb: fix OOB write in vga16fb_imageblit()
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        syzbot <syzbot+1f29e126cf461c4de3b3@syzkaller.appspotmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Colin King <colin.king@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jani Nikula <jani.nikula@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        "Antonino A. Daplas" <adaplas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Fri, May 14, 2021 at 1:32 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Another alternative would be to just delay the resize to when vcmode
> is put back to text mode again. That sounds somewhat reasonable to me,
> but it's a pretty big thing.

Actually thinking more about that option, it sounds horrible. It would
mean that we'd continue to use the old geometry for the actual VC
buffers for a random time, and then change it to the new geometry at
some arbitrary point.

So I think the only reasonable approach (apart from just my "don't do
that then") might be to just always call ->con_resize().

There are only actually three cases of "->con_resize()", so it might
not be too bad.

Looking at it, both sisusbcon_resize() and vgacon_resize() seem to be
trivially fine in KD_GRAPHICS mode.

vgacon already seems to have that "!vga_is_gfx" test, and does
vgacon_doresize() at vgacon_switch(). It might need to add a
vgacon_doresize() to the vgacon_blank() case 0 code so that it
actually does the right thing when going back to KD_TEXT mode.

And fbcon_resize() looks like it might be mostly ok with it too.
Again, there is a con_is_visible() test, and I suspect that might need
to be changed to

        if (con_is_visible(vc) && vc->vc_mode == KD_TEXT)

instead,  but it doesn't look _too_ bad.

So I think just removing the "vc->vc_mode != KD_GRAPHICS" test from
resize_screen() might be the way to go. That way, the low-level data
structures actually are in sync with the resize, and the "out of
bounds" bug should never happen.

Would you mind testing that?

               Linus
