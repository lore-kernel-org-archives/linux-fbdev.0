Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96201C433ED
	for <linux-fbdev@archiver.kernel.org>; Mon, 17 May 2021 13:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E78061028
	for <linux-fbdev@archiver.kernel.org>; Mon, 17 May 2021 13:08:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237235AbhEQNJS (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 17 May 2021 09:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237205AbhEQNJO (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 17 May 2021 09:09:14 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4890EC061756
        for <linux-fbdev@vger.kernel.org>; Mon, 17 May 2021 06:07:47 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id j75so6385282oih.10
        for <linux-fbdev@vger.kernel.org>; Mon, 17 May 2021 06:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dZeinS6LE1NP88+BR+f1LcsUBMPUh7N3G4KpQRQogBk=;
        b=aGBMVprGuoTf9++f+DatDpeTnGL5ZmpmA0esmGNR7sOjh15bPnJ5xl4LQ5QM8p55SZ
         k0Gr9tasB7CXqw4F9//xhZFkDKTW8P+jDQg2ksKWGRr8PQl3uomjjBlkpx26Llf80vsO
         aqPf6OCmWnkSEJ6/iAg/YkwZbF/CzGgpR2sG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dZeinS6LE1NP88+BR+f1LcsUBMPUh7N3G4KpQRQogBk=;
        b=JCOByFk2NUyGdChtwnDLmbee+644TXjtF4pPM95j3pB0smlEvTEDPH7LHi5zvUJWBp
         MLc/wmdf88Hm01xTpw6duzzLRkUn/P3sDy0LlmQh1Jon7APYUmCNVbWTbBwAwx2137nC
         Ix/6ia+u+Y9KxjLNmTa1BVjQ+/+bo83wDCOA/yAaR+m8mWlpkHYfUU30IyxL2cKjDBtt
         DPUFzDhv3vmyj8epWniZ0sHoLjb/rOWlY0uIIMadrFMBUZCe/kn10msWcCURBY+AKNMb
         axBsQV2v2t13eg1WWX+vHcmJcJcewgESX7aRYOnDM90P1YXzs2STrKfYd7AJyiFdg+eY
         EVjA==
X-Gm-Message-State: AOAM530tnjqu0ISFzEkOZYZCUMriTldR35/HuGt5OvPBEzC1rHCKakE0
        vX43nzDEz4QzzPAUw2/ZhkYEQuWlgX7uM0zN1PZ2kQ==
X-Google-Smtp-Source: ABdhPJy7GTk1BfTS88fw/8gIr6/ZDBTUprv35YFaMITbfmvjl7jiiSuHvPGnKkFzht+U6iHn/HLP2JVzKLU+U28GVkY=
X-Received: by 2002:a54:4809:: with SMTP id j9mr15251365oij.14.1621256866371;
 Mon, 17 May 2021 06:07:46 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000006bbd0c05c14f1b09@google.com> <6e21483c-06f6-404b-4018-e00ee85c456c@i-love.sakura.ne.jp>
 <87d928e4-b2b9-ad30-f3f0-1dfb8e4e03ed@i-love.sakura.ne.jp>
 <05acdda8-dc1c-5119-4326-96eed24bea0c@i-love.sakura.ne.jp>
 <CAHk-=wguwhFpjhyMtDaH2hhjoV62gDgByC=aPyTrW9CkM5hqvA@mail.gmail.com>
 <alpine.DEB.2.21.2105142150460.3032@angie.orcam.me.uk> <CAHk-=wioOHwKNj8AmvXWV-oL60ae0jKswAHy9e6wCYYeA5EQXg@mail.gmail.com>
In-Reply-To: <CAHk-=wioOHwKNj8AmvXWV-oL60ae0jKswAHy9e6wCYYeA5EQXg@mail.gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Mon, 17 May 2021 15:07:35 +0200
Message-ID: <CAKMK7uGLP2zn7LX4ATExA4DLo16shVivSd_W58X-rBZNPSb3_w@mail.gmail.com>
Subject: Re: [PATCH] video: fbdev: vga16fb: fix OOB write in vga16fb_imageblit()
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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

On Fri, May 14, 2021 at 10:33 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, May 14, 2021 at 1:25 PM Maciej W. Rozycki <macro@orcam.me.uk> wrote:
> >
> >  Overall I think it does make sense to resize the text console at any
> > time, even if the visible console (VT) chosen is in the graphics mode,
>
> It might make sense, but only if we call the function to update the
> low-level data.
>
> Not calling it, and then starting to randomly use the (wrong)
> geometry, and just limiting it so that it's all within the buffer -
> THAT does not make sense.
>
> So I think your patch is fundamentally wrong. It basically says "let's
> use random stale incorrect data, but just make sure that the end
> result is still within the allocated buffer".
>
> My patch is at least conceptually sane.
>
> An alternative would be to just remove the "vcmode != KD_GRAPHICS"
> check entirely, and always call con_resize() to update the low-level
> data, but honestly, that seems very likelty to break something very
> fundamentally, since it's not how any of fbcon has ever been tested,

Just an aside: I think with fbdev drivers this would go boom, because
you'd have fbcon interferring with a direct /dev/fb/* user.

But if your fbdev driver is actually a drm modeset driver, then we
have additional limitations: If the userspace accesses the display
through /dev/dri/card0, then the kernel blocks all access through
/dev/fb/* (including fbcon) to the actual display (it only goes into
the buffer used for fbdev emulation). And everything would be fine.

Also generally you'd get away with this even in problematic cases,
since usually you resize your console when looking at it, not when X
or something else is using your fbdev direct access.

The one thing that's left out here a bit in the cold is userspace
modeset drivers in X. Those would get hosed. But also, we stopped
supporting those in at least i915/amd/radeon/nouveau drivers,
automatically falling back to the fbdev stuff in most cases (with or
without the drm drivers underneath that), and no one screamed. So
probably not many users left.

So I /think/ we could wager this, if it's the least intrusive fix from
the kernel pov. But it has some risks that we need to revert again if
we break some of the really old use-cases here.

Cheers, Daniel

> Another alternative would be to just delay the resize to when vcmode
> is put back to text mode again. That sounds somewhat reasonable to me,
> but it's a pretty big thing.
>
> But no, your patch to just "knowingly use entirely wrong values, then
> add a limit check because we know the values are possibly garbage and
> not consistent with reality" is simply not acceptable.
>
>               Linus



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
