Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42378C433EF
	for <linux-fbdev@archiver.kernel.org>; Tue, 18 Jan 2022 11:41:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236763AbiARLlb (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 18 Jan 2022 06:41:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236823AbiARLlb (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 18 Jan 2022 06:41:31 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BAD3C06161C
        for <linux-fbdev@vger.kernel.org>; Tue, 18 Jan 2022 03:41:31 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id s127so27975954oig.2
        for <linux-fbdev@vger.kernel.org>; Tue, 18 Jan 2022 03:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x78/TbYfX5QsnYZyr52VgAAejiGos9kR5zRjc4vUcCI=;
        b=BHIqFD6eJovLYxKCszVQrtc4G+FVdv6Af3+lRJEtvGKcldsEv7St9cpQiHsu8HtM0U
         NVcEdyoH7nAWqEdWzcNUGjIgads4GWtLnBxoviCJOps7kYsK27aZW2mZEhBLUqWgzRPE
         VN+r7kLysZOMORWrbBThHM57uYpD/YgJdfDHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x78/TbYfX5QsnYZyr52VgAAejiGos9kR5zRjc4vUcCI=;
        b=UiMi+67kRGWMv4duradLvzfx0FaxBR48D97b4BQPyD8sOKU8NvC8iMTwfr4lKy9Mzb
         NUxB7zJcJLg7CaP33TEcKyTtjIOvK/vzwudOPafmVDMEzYE2EYbVJ1H4MEc8mQl5W190
         IqTs3kCZdBmJ1TlJ8QfmO+3y3XhuaH/IXwzEpURDLriwNEPjTn8/fWCbV/2C6l+lrBqo
         P0mD7sKzK3QRan+BNmX0palxGMqyoyTGD/0VcIp+B+1OR4vFrDlfoWvYBe5ETA73vfRV
         7loK5mrynNd947AsnchRK5QbVNt1nxkB1wblMmc9w3DhBusXI6tDyTfeO2ui5t8Uumtq
         Yc9A==
X-Gm-Message-State: AOAM532ZpqAZYnHjMU0LEXoXdzHSvVNQodLXtXwNHNg/Khci/PLBcj7Y
        QfPGqg+PjSqKv2SrIyVKqfswb9U8ZKmmnO0m3pqnSA==
X-Google-Smtp-Source: ABdhPJy5bFsGvTTo9Rj+B1mnhsO4OFpJd/bnRdu8kgbMxvhGzvZK0wJseXPAtmukitDgS+zCuzX4XwI2yFZBlgTFLbQ=
X-Received: by 2002:a05:6808:3a3:: with SMTP id n3mr12476341oie.128.1642506089204;
 Tue, 18 Jan 2022 03:41:29 -0800 (PST)
MIME-Version: 1.0
References: <YeG8ydoJNWWkGrTb@ls3530> <CAKMK7uGdJckdM+fg+576iJXsqzCOUg20etPBMwRLB9U7GcG01Q@mail.gmail.com>
 <c80ed72c-2eb4-16dd-a7ad-57e9dde59ba1@gmx.de> <CAKMK7uHVHn9apB6YYbLSwu+adEB2Fqp4FM0z582zf4F-v3_GnQ@mail.gmail.com>
 <cf21018b-f231-7538-169e-2ad450643cbf@gmx.de> <97d49bca-f5f7-dba4-b62d-b6fcdd4276ac@suse.de>
 <87ee5659dt.fsf@intel.com> <4f1d6018-d74e-8e62-ea4d-0ca79c6bbbc5@gmx.de>
 <87a6ft5thv.fsf@intel.com> <CAMuHMdVE6OY29qB+F-QPgQt2q5xAYfyuPhKqSDrh_HhD9PPw9g@mail.gmail.com>
In-Reply-To: <CAMuHMdVE6OY29qB+F-QPgQt2q5xAYfyuPhKqSDrh_HhD9PPw9g@mail.gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 18 Jan 2022 12:41:17 +0100
Message-ID: <CAKMK7uHtdjyeasnJw2ZVwJJjuCn1KGT05kJu-x5jdmEmnBB-dA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add Helge as fbdev maintainer
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Helge Deller <deller@gmx.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Javier Martinez Canillas <javierm@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Tue, Jan 18, 2022 at 9:41 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Jani,
>
> On Tue, Jan 18, 2022 at 9:38 AM Jani Nikula <jani.nikula@linux.intel.com> wrote:
> > On Mon, 17 Jan 2022, Helge Deller <deller@gmx.de> wrote:
> > > On 1/17/22 22:40, Jani Nikula wrote:
> > >> On Mon, 17 Jan 2022, Thomas Zimmermann <tzimmermann@suse.de> wrote:
> > >>> Seems like few people read linux-fbdev these days.
> > >>
> > >> How much traffic is there to linux-fbdev that is *not* Cc'd to dri-devel
> > >> also?
> > >
> > > Doesn't seem like much traffic - which IMHO is OK for such a tree with
> > > mostly just maintenance patches.
> > >
> > >> Do we still need a separate linux-fbdev mailing list at all?
> > >
> > > Yes. I want to have it seperate of dri-devel.
> > > Actually I'd prefer to drop dri-devel from the list where patches
> > > for fbdev are sent...
> >
> > Disagreed. If anything, this thread shows we can't have fbdev and drm in
> > silos of their own.
>
> Unless DRM drops fbdev support. Isn't that the long-term plan anyway?

No. There's way too much old stuff still using the fbdev interface to
do that. We've even done things like standardize the vblank wait
ioctl, because people need that.

There's some effort to make fbdev drivers like efifb obsolete, and
there's been discussions to have a drm-native fbcon. But none of these
are going to make fbdev on top of drm obsolete and something we can
remove. Pretty sure at least not this decade.
-Daniel

>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
