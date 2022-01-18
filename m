Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E3DDC433F5
	for <linux-fbdev@archiver.kernel.org>; Tue, 18 Jan 2022 11:14:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239015AbiARLO3 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 18 Jan 2022 06:14:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234277AbiARLO2 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 18 Jan 2022 06:14:28 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5183EC061574
        for <linux-fbdev@vger.kernel.org>; Tue, 18 Jan 2022 03:14:28 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id 60-20020a9d0142000000b0059103eb18d4so23623844otu.2
        for <linux-fbdev@vger.kernel.org>; Tue, 18 Jan 2022 03:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IE2Bi6BX71GxVQQunYcWXmzILspUK92Ha2RwuVxfI6g=;
        b=LhkdNE7Wa26DngF4QUM7KSJu6ffhXhV5rJMzNxMrt1cOP43VQAYu3S47MmjB6Tokyu
         g+i+uC7VE/qqn2eyLWNhPtarxTba/7Rt8z1VALemM5KSN00/UOLhnIKU9xtl0pFEv+3h
         4yH4xyvyE6otKaXhN2fXWk3QwgUS3V76OsszQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IE2Bi6BX71GxVQQunYcWXmzILspUK92Ha2RwuVxfI6g=;
        b=3M3+s2Knw8qmpLrv80Ui98hU6nzChGGJXsLAI4d1yAbUpiIiTMgJPwB6EJmxqr37LY
         0J8OyLemp9iJlAYKkL8xduW1gPDMYnKfNJJ0jc4nDwcsYEjRyJ3IYjH7lkE/i3Ne3jTc
         XEvushcI5ixaEyVN5DWttiHQNjuDg2UCQ7AYoJ+w0tqQEcQ1V3bBUMHGJu/fei6pl5bc
         KIZIQ8RxT9HjRbsrXgTTkq9jFultXvU18qttqPC2g/jWl1YyNJOjnkHNQKLP2q0KxDyZ
         IbJ8pRHgLNkTHnJqeMIGa2If8nP/2t8Lr/a9+U8rwo9mrdH5H7r63MYN5iGvBQm1N4uV
         9LBA==
X-Gm-Message-State: AOAM530WgZ5/dqcmIknaXH599LYjtbR0DAyz6MY7V37+A9rzs5OSpG7X
        3ZY5ObUrIvtt/RClRduLX3tD93nXso6usFrV9KO4bw==
X-Google-Smtp-Source: ABdhPJz/h9I5sASIC1KgAr2w0o6g5bvtKYeaZaU2ifc/uG9A1tp3zEkGuLQZ79GYR8K7qHRcO4txTn0Lx+0OAr5LxfE=
X-Received: by 2002:a9d:685a:: with SMTP id c26mr19640268oto.239.1642504467576;
 Tue, 18 Jan 2022 03:14:27 -0800 (PST)
MIME-Version: 1.0
References: <YeG8ydoJNWWkGrTb@ls3530> <CAKMK7uGdJckdM+fg+576iJXsqzCOUg20etPBMwRLB9U7GcG01Q@mail.gmail.com>
 <c80ed72c-2eb4-16dd-a7ad-57e9dde59ba1@gmx.de> <CAKMK7uHVHn9apB6YYbLSwu+adEB2Fqp4FM0z582zf4F-v3_GnQ@mail.gmail.com>
 <cf21018b-f231-7538-169e-2ad450643cbf@gmx.de> <97d49bca-f5f7-dba4-b62d-b6fcdd4276ac@suse.de>
 <e19563aa-21a3-e13c-4143-847bd77a38c7@gmx.de> <e4242fe9-13b1-91b5-d254-992f48115589@gmx.de>
 <CAKb7UvgXaeX7FRUK_Q35N=2zBms8WgCe=ZBKr3dHrixoJWtvqw@mail.gmail.com>
In-Reply-To: <CAKb7UvgXaeX7FRUK_Q35N=2zBms8WgCe=ZBKr3dHrixoJWtvqw@mail.gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 18 Jan 2022 12:14:16 +0100
Message-ID: <CAKMK7uH+88f6_NANd1F3ux7+j3iXg+AYWsNrVktuZOAAfc9Ngg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add Helge as fbdev maintainer
To:     Ilia Mirkin <imirkin@alum.mit.edu>
Cc:     Helge Deller <deller@gmx.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-fbdev <linux-fbdev@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Mon, Jan 17, 2022 at 10:55 PM Ilia Mirkin <imirkin@alum.mit.edu> wrote:
>
> On Mon, Jan 17, 2022 at 2:47 PM Helge Deller <deller@gmx.de> wrote:
> >
> > On 1/17/22 17:21, Helge Deller wrote:
> > > On 1/17/22 16:58, Thomas Zimmermann wrote:
> > >> Hi
> > >>
> > >> Am 17.01.22 um 16:42 schrieb Helge Deller:
> > >>> [...]
> > >>>>> c) reintroduce the state where fbcon is fast on fbdev. This is important for non-DRM machines,
> > >>>>>     either when run on native hardware or in an emulator.
> > >>>>> d) not break DRM development
> > >>>>>
> > >>>>> Especially regarding c) I complained in [1] and got no feedback. I really would like to
> > >>>>> understand where the actual problems were and what's necessary to fix them.
> > >>>>>
> > >>>>> Helge
> > >>>>>
> > >>>>> [1] https://lore.kernel.org/r/feea8303-2b83-fc36-972c-4fc8ad723bde@gmx.de
> > >>
> > >> Seems like few people read linux-fbdev these days.
> > >> I suggest to partly revert the patch to the point were performance
> > >> gets better again.
> > > Yes, *please*!
> > > That would solve my biggest concern.
> > >
> > > As far as I can see that's only 2 commits to be reverted:
> > > b3ec8cdf457e - "fbdev: Garbage collect fbdev scrolling acceleration, part 1 (from TODO list)"
> > > 39aead8373b3 - "fbcon: Disable accelerated scrolling"for-next-next
> > >
> > > I think both were not related to any 0-day bug reports (but again, I might be wrong).
> >
> > I did some more checking...
> >
> > Both patches are not related to DRM, since no DRM driver sets the
> > FBINFO_HWACCEL_COPYAREA or FBINFO_HWACCEL_FILLRECT flags.
>
> These used to be set by, at least, nouveau (which is a drm driver).
> And yeah, console responsiveness is _way_ worse without that. People
> keep pushing the messaging that it's the same speed to do it as
> memcpy, but that's just not the case in my experience, on a pretty
> bog-standard x86 desktop. The support got dumped, and it felt pretty
> clear from the messaging at the time, "too bad". Would love to see it
> come back.

You need to add in a shadow buffer and it's fast. The problem is that
the default fbcon sw code just replaces a hw blitter, and so does a
_lot_ of memmoves reading from wc/uc memory. Which is an absolute
disaster and results in a slideshow.

Once you stop doing that the thing is pretty reasonable, which would
also be what all the userspace sw compositors are doing. Fact that no
one bothers to roll this out for most drivers just shows how little
people care about accelerated fbcon.
-Daniel


>
> Cheers,
>
>   -ilia



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
