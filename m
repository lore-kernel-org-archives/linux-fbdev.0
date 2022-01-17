Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B863C433EF
	for <linux-fbdev@archiver.kernel.org>; Mon, 17 Jan 2022 16:38:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241096AbiAQQii (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 17 Jan 2022 11:38:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237646AbiAQQih (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 17 Jan 2022 11:38:37 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6C6C06161C
        for <linux-fbdev@vger.kernel.org>; Mon, 17 Jan 2022 08:38:37 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id s22so24214378oie.10
        for <linux-fbdev@vger.kernel.org>; Mon, 17 Jan 2022 08:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TI+T6c0N7K3peD5+tx0Z05C/5JTL5JQSb7+Gvq9P/90=;
        b=HQGZtxqrdYuyGFZCoIvTbvoyDbXOEqvEXtal37kXs0fwaT8d5+UBqIyUt03jdv+LWO
         YTghMijy/JpjTAiDS1lH/dgiOJTG8ZqcJ/YNZ+hCWHG9ArTln0xRRiNFQnToVrr3UKbu
         cFRDl3Edik/s2Uzs5ZHZggDK4AJW0zTqhLH+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TI+T6c0N7K3peD5+tx0Z05C/5JTL5JQSb7+Gvq9P/90=;
        b=r+hwf9rJowo7NlR9aCX4AunoiWreDQCIzUZ5qZ4XbG3HdP2WrRZ/pdNB/XeyM1zdOQ
         TtV1fSEkgkiy3X9IANbYN0a4Nfc5d9+llLkIxxEh/J4N2KLGFTJpRDr03YSczHrpG5cI
         rBjeeBPe9QoqxcO0Ml5QRE67hUDbyF2F01PwiK7t1Ds2hOAI0VfSle739vY59wBv/Hp+
         dVr5bPQM6M8zwQ08rrUbqcKc4AVLY6vD3vSQb2BidUfEqovxEHCUVnebIzCsgyiODs0C
         o8R9T88PDdDQXeXtUBhTYQpZk1TenmSDTV4AA1H4pJKX9T6zktctUH5rj0ha0Jj77pV+
         IolA==
X-Gm-Message-State: AOAM5311v7Ur3hzviXhitieZCNKaMLbEym8vVsiMCg43YehnZtnrhicu
        6ZjdRtXUz26gtUHL6bI8Jnnh7A1/n6P2gK1ESzz1OQ==
X-Google-Smtp-Source: ABdhPJwtZw3vr6mz2n3FOqglwVtWUYAgk2YKpHpdVERnXV0uo5vcLRo2/BjpnL+iKV8aeXnIyLfjH1gWrAF+/H/EIvA=
X-Received: by 2002:a05:6808:3a3:: with SMTP id n3mr9217462oie.128.1642437516512;
 Mon, 17 Jan 2022 08:38:36 -0800 (PST)
MIME-Version: 1.0
References: <YeG8ydoJNWWkGrTb@ls3530> <CAKMK7uGdJckdM+fg+576iJXsqzCOUg20etPBMwRLB9U7GcG01Q@mail.gmail.com>
 <c80ed72c-2eb4-16dd-a7ad-57e9dde59ba1@gmx.de> <CAKMK7uHVHn9apB6YYbLSwu+adEB2Fqp4FM0z582zf4F-v3_GnQ@mail.gmail.com>
 <cf21018b-f231-7538-169e-2ad450643cbf@gmx.de> <97d49bca-f5f7-dba4-b62d-b6fcdd4276ac@suse.de>
 <e19563aa-21a3-e13c-4143-847bd77a38c7@gmx.de>
In-Reply-To: <e19563aa-21a3-e13c-4143-847bd77a38c7@gmx.de>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Mon, 17 Jan 2022 17:38:25 +0100
Message-ID: <CAKMK7uECQU2ALkLHuFfPCjDcH456R6yJ4N_yKbHJ6PiFZ6fiow@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add Helge as fbdev maintainer
To:     Helge Deller <deller@gmx.de>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "airlied@gmail.com" <airlied@gmail.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Mon, Jan 17, 2022 at 5:22 PM Helge Deller <deller@gmx.de> wrote:
>
> On 1/17/22 16:58, Thomas Zimmermann wrote:
> > Hi
> >
> > Am 17.01.22 um 16:42 schrieb Helge Deller:
> >> [...]
> >>>> c) reintroduce the state where fbcon is fast on fbdev. This is important for non-DRM machines,
> >>>>     either when run on native hardware or in an emulator.
> >>>> d) not break DRM development
> >>>>
> >>>> Especially regarding c) I complained in [1] and got no feedback. I really would like to
> >>>> understand where the actual problems were and what's necessary to fix them.
> >>>>
> >>>> Helge
> >>>>
> >>>> [1] https://lore.kernel.org/r/feea8303-2b83-fc36-972c-4fc8ad723bde@gmx.de
> >
> > Seems like few people read linux-fbdev these days.
> > I suggest to partly revert the patch to the point were performance
> > gets better again.
> Yes, *please*!
> That would solve my biggest concern.
>
> As far as I can see that's only 2 commits to be reverted:
> b3ec8cdf457e - "fbdev: Garbage collect fbdev scrolling acceleration, part 1 (from TODO list)"
> 39aead8373b3 - "fbcon: Disable accelerated scrolling"for-next-next
>
> I think both were not related to any 0-day bug reports (but again, I might be wrong).

syzbot, not 0day, and there's like a sea of them unfortunately.
There's all kinds of funny races going on when resizing consoles (due
to bad locking design) which then blow up, especially in less tested
code. For the sw rendering we've merged a bunch of patches, but you
pretty much have to assume that it's all fairly broken code until it's
rewritten and fully covered with tests. Shadowfb + memcpy is probably
much faster for restoring scrolling performance than anything else
really.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
