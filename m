Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A8F0C433ED
	for <linux-fbdev@archiver.kernel.org>; Sun, 11 Apr 2021 22:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F284F6008E
	for <linux-fbdev@archiver.kernel.org>; Sun, 11 Apr 2021 22:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235819AbhDKWQN (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 11 Apr 2021 18:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235718AbhDKWQM (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sun, 11 Apr 2021 18:16:12 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67BDEC061574
        for <linux-fbdev@vger.kernel.org>; Sun, 11 Apr 2021 15:15:55 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 12so18165435lfq.13
        for <linux-fbdev@vger.kernel.org>; Sun, 11 Apr 2021 15:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=we0IPy7GkHXIWTEepGW7TLgrKnT+n2hTi8pOuKv6Tfg=;
        b=bMBOsx+IjgATxfVRDghj2rM1/YzPonOm1tzZeLG+5a54MJfIfaO/nZWtWht/TTfoyT
         CvjwlGxrg9yUQQv/VPXJ+Rq9opfuEJ0tz3NPnswOkwDjFd4CaeAQXYAhtf428HEx9T0/
         3wq3L5dGSr12c9RX5GXiaysDYCFWmelpOE5R4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=we0IPy7GkHXIWTEepGW7TLgrKnT+n2hTi8pOuKv6Tfg=;
        b=SxiKx/RMw/iqP7e/QXM4F93BDASSvcqhY0M7aJBwYqZ2wuylqj+pMC0aHg6HEkaK3c
         2SDLiaN9SWuB78j81mrmjGLOzp6bXBOry5TI9U+ovDRvB0m/EW1cdH35Ane0nd+944oG
         HIwsGa8i7Vy1/H8h4o5ZUfUF7gbETr+I/AZ1TlmRWvMrR4G+7+aaWNzuxuBRaz16vlAi
         gBbByteS8BXG0whs4ZaYLaSS1nIlxnHspIKgWOGtfGx3TpbuDgcFecq0aVujUdqdHnW9
         ykGpy8QvP6Gwrxe5n4jLb88Tw7Gq/h6HnOmDf916faBahwrIJA5Fn4N5CCn1df62zrzY
         tF9A==
X-Gm-Message-State: AOAM530Rwij32IH+kpujbJOXgbp9FoybltOEz84YwYteVrQLcL8tf9gz
        j8Xpn6jEwl32BSF4YY25gcFuFl+C6J2Dkd6C
X-Google-Smtp-Source: ABdhPJyDRIawxcWukmqrypGNNUxRh7Qyc8b8DeSz7v9GlGdp6/3OaAt2dDO58n7aYWKq5vdlI1KBJg==
X-Received: by 2002:a19:808f:: with SMTP id b137mr17279029lfd.162.1618179352898;
        Sun, 11 Apr 2021 15:15:52 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id c14sm1848101lfi.74.2021.04.11.15.15.51
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Apr 2021 15:15:51 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id g8so18243184lfv.12
        for <linux-fbdev@vger.kernel.org>; Sun, 11 Apr 2021 15:15:51 -0700 (PDT)
X-Received: by 2002:ac2:4947:: with SMTP id o7mr12254385lfi.253.1618179351232;
 Sun, 11 Apr 2021 15:15:51 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000226d3f05b02dd607@google.com> <bbcef674-4ac6-c933-b55d-8961ada97f4c@i-love.sakura.ne.jp>
 <47907f77-b14b-b433-45c6-a315193f0c1a@i-love.sakura.ne.jp>
 <494395bc-a7dd-fdb1-8196-a236a266ef54@i-love.sakura.ne.jp>
 <20200927092701.GA1037755@PWN> <4933b81b-9b1a-355b-df0e-9b31e8280ab9@i-love.sakura.ne.jp>
 <20200928175956.GF24673@neutronstar.dyndns.org> <100dfd3f-3415-80ae-a6cf-30d15f7ca49f@i-love.sakura.ne.jp>
 <20200929105203.GG24673@neutronstar.dyndns.org> <20200929165657.GS438822@phenom.ffwll.local>
 <20200929171040.GB1351851@kroah.com> <alpine.DEB.2.21.2104112250310.65251@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2104112250310.65251@angie.orcam.me.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 11 Apr 2021 15:15:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgF8e5i+9eeGu=CgWAagTPv-9UbkG7B6bR5jDe6kkkFZQ@mail.gmail.com>
Message-ID: <CAHk-=wgF8e5i+9eeGu=CgWAagTPv-9UbkG7B6bR5jDe6kkkFZQ@mail.gmail.com>
Subject: Re: [PATCH] vt_ioctl: make VT_RESIZEX behave like VT_RESIZE
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Martin Hostettler <textshell@uchuujin.de>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jiri Slaby <jirislaby@kernel.org>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        syzbot <syzbot+b308f5fd049fbbc6e74f@syzkaller.appspotmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Helge Deller <deller@gmx.de>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        George Kennedy <george.kennedy@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Sun, Apr 11, 2021 at 2:43 PM Maciej W. Rozycki <macro@orcam.me.uk> wrote:
>
>  So it does trigger with vgacon and my old server, which I have started
> experimenting with and for a start I have switched to a new kernel for an
> unrelated purpose (now that I have relieved it from all its usual tasks
> except for the last remaining one for which I haven't got the required
> user software ported to the new system yet):
>
> "struct vt_consize"->v_vlin is ignored. Please report if you need this.
> "struct vt_consize"->v_clin is ignored. Please report if you need this.

Note that it's entirely possible that things continue to work well
despite this warning. It's unclear to me from your email if you
actually see any difference (and apparently you're not able to see it
right now due to not being close to the machine).

The fact that v_vlin/v_clin are ignored doesn't necessarily mean that
they are different from what they were before, so the warning may be a
non-issue.

> It continues using svgatextmode with its glass (CRT) VT to set my usual
> 80x37 text mode (720x576 pixel resolution) by manipulating the VGA clock
> chip and the CRT controller appropriately for a nice refresh rate of 85Hz:
>
> Chipset = `TVGA8900', Textmode clock = 44.90 MHz, 80x37 chars, CharCell = 9x16. Refresh = 52.51kHz/84.7Hz.

That doesn't seem necessarily wrong to me.

>  So what's the supposed impact of this change that prompted the inclusion
> of the messages?

There _may_ be no impact at all apart from the messages.

The code _used_ to set the scan lines (v_vlin) and font height
(v_clin) from those numbers if they were non-zero, and now it just
ignores them and warns instead.

The code now just sets the font height from the actual font size when
the font is set. Which is honestly the only thing that ever made
sense. Trying to set it with v_clin is ignored, but it's entirely
possible - maybe even likely - that your user of VT_RESIZEX sets it to
the same values it already has.

Exactly because setting a font line number to anything else than the
font size isn't exactly sensible.

But if your screen looks different than it used to, that is obviously
interesting and says something actually changed (outside of the
message itself).

           Linus
