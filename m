Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 000CDC433B4
	for <linux-fbdev@archiver.kernel.org>; Fri, 14 May 2021 17:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D20DB61183
	for <linux-fbdev@archiver.kernel.org>; Fri, 14 May 2021 17:30:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbhENRbU (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 14 May 2021 13:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232164AbhENRbT (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 14 May 2021 13:31:19 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8ECC061574
        for <linux-fbdev@vger.kernel.org>; Fri, 14 May 2021 10:30:05 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id z9so44078855lfu.8
        for <linux-fbdev@vger.kernel.org>; Fri, 14 May 2021 10:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1gCT3yFXN0nq6W0TvPfJDEC6ju7ngwBrbZ3V/R/ZJt4=;
        b=QrDM1vyn65+P14zzNE8NIxADOjzkXwgZ1OVSKlrR4yWXq5tE46/SGHEAy800t0p0KD
         09lTLzF24eD7OUZIM3qJyL3BYanjfr/ddscyzFIcuOxS77RMISzoNAQdTSU8ej9mIAeW
         QqV6REiHKfhF0o2ztdoumCpotG6fc5BTXat8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1gCT3yFXN0nq6W0TvPfJDEC6ju7ngwBrbZ3V/R/ZJt4=;
        b=EdRFrs+xOse1KYmedFjAJHG3yWcrvTfLFMvHod1SPoF2gdb36zn5t8/yul9vtgLWWI
         am26kKJSahYAig5zXhUiRLhdYMtyshI3gsVjHh0Td+OmWyLpD0/9eC+TX/Ysv+wcJV11
         WCvTPYTZyQNBNjYLrkxb/OczM8/blGHgbH7tEt3t2/VIlEJMbIyQENsKZRXw374WJ7Vm
         CS5TTnaM/aoQhX/ZBHAdbzEHnpzsd4wyJDIbCNH6LuriFsmZ0tLzQjXVxrPWCQxN+CQD
         FUuBxCMjTG9BE9LdFGqDyRklnYX8nHmxZu2/Ta+DSZvmU7Xh2rqNMf4OyA6SkUuem9DZ
         LYVQ==
X-Gm-Message-State: AOAM531VPr52aovVFsYvItmcu3enNHkh49feqWnvFIm+uxCPxDL0nh76
        09SR70udJmq1iBO7191lxY5zHB4q+vJEqaPw
X-Google-Smtp-Source: ABdhPJyQ/OlRoohpiCI3vOIeOu5opd5lYT3lV4fZwOnP8PrmX28nJXksWrAOSJ4Iy9vqyO5QJsitLg==
X-Received: by 2002:ac2:484f:: with SMTP id 15mr3925680lfy.519.1621013403988;
        Fri, 14 May 2021 10:30:03 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id p13sm846118lfr.141.2021.05.14.10.30.02
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 May 2021 10:30:03 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id z13so44115492lft.1
        for <linux-fbdev@vger.kernel.org>; Fri, 14 May 2021 10:30:02 -0700 (PDT)
X-Received: by 2002:ac2:4a9d:: with SMTP id l29mr270413lfp.201.1621013402775;
 Fri, 14 May 2021 10:30:02 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000006bbd0c05c14f1b09@google.com> <6e21483c-06f6-404b-4018-e00ee85c456c@i-love.sakura.ne.jp>
 <87d928e4-b2b9-ad30-f3f0-1dfb8e4e03ed@i-love.sakura.ne.jp> <05acdda8-dc1c-5119-4326-96eed24bea0c@i-love.sakura.ne.jp>
In-Reply-To: <05acdda8-dc1c-5119-4326-96eed24bea0c@i-love.sakura.ne.jp>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 14 May 2021 10:29:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wguwhFpjhyMtDaH2hhjoV62gDgByC=aPyTrW9CkM5hqvA@mail.gmail.com>
Message-ID: <CAHk-=wguwhFpjhyMtDaH2hhjoV62gDgByC=aPyTrW9CkM5hqvA@mail.gmail.com>
Subject: Re: [PATCH] video: fbdev: vga16fb: fix OOB write in vga16fb_imageblit()
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
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

On Fri, May 14, 2021 at 9:20 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> Currently it is impossible to control upper limit of rows/columns values
> based on amount of memory reserved for the graphical screen, for
> resize_screen() calls vc->vc_sw->con_resize() only if vc->vc_mode is not
> already KD_GRAPHICS

Honestly, the saner approach would seem to be to simply error out if
vc_mode is KD_GRAPHICS.

Doing VT_RESIZE while in KD_GRAPHICS mode seems _very_ questionable,
and is clearly currently very buggy.

So why not just say "that clearly already doesn't work, so make it
explicitly not permitted"?

              Linus
