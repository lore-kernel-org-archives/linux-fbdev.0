Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5524C433DB
	for <linux-fbdev@archiver.kernel.org>; Thu, 14 Jan 2021 15:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9240D238E7
	for <linux-fbdev@archiver.kernel.org>; Thu, 14 Jan 2021 15:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbhANP5r (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 14 Jan 2021 10:57:47 -0500
Received: from mail-oi1-f175.google.com ([209.85.167.175]:40305 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbhANP5r (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 14 Jan 2021 10:57:47 -0500
Received: by mail-oi1-f175.google.com with SMTP id p5so6364378oif.7;
        Thu, 14 Jan 2021 07:57:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y0MoCmIyBbiEovesbLQa2skQFcnP2H8/At5+Yu5mU8k=;
        b=YsKhjrLXwKErfBgaBy1BVhl0QW32+3Sl/dVWi+jSwMNiRtZtL7SnTq1gxmsMWj90mv
         ZTIGQGAEwL/PdF2c4E0siPS7o4g7xsTIy6zIShyP3FtPcWmJmtr8Ak0ssb7ORakkXiNq
         60Krg661CTBmieAq8r1v20T/4NmVwD8dbYT7UEj7DpYFU6c1deqfDNDw0/jZZ1bdwiqV
         B1tcFiDJV12B2cwMPA/PdvdbtQsEq0fyilkLzxYclvT7GSv58urrET3/NqSnTnTWXrFC
         EOIRNXHVUdKooZSLSucHKsp0Xen0cSwkveeLS5/axmYwtAYtq1tVOeGVhezoSPKftQzR
         V2DQ==
X-Gm-Message-State: AOAM532NHjdvC4aomEtudR4NEB6w+4H0RX0yF0TJoqy9nimLZKqrTGA9
        WDSJJJ1K96IZbnDaSyRXPM4St+UpUCJ45heNliM=
X-Google-Smtp-Source: ABdhPJz3tFPzEi+kqhb52Yw3+gOpoRqT4PX+G+XIAyHJZ4riIuUyvmmAAObS/i6xIg8FVvZgRnPMv5SNOvQoR8zuzzk=
X-Received: by 2002:aca:ec09:: with SMTP id k9mr2906604oih.153.1610639809807;
 Thu, 14 Jan 2021 07:56:49 -0800 (PST)
MIME-Version: 1.0
References: <20200916205434.GA10389@duo.ucw.cz> <87czyf5jjp.fsf@vps.thesusis.net>
 <CAHk-=wjsjC1h7fskwYaaRLykN1ms6ZtxGvucQgmL-zZTfxPdBA@mail.gmail.com> <CAKMK7uEGXOC_ci=Drm=Hz+xPGdcoxv8YZ-gcOckoPmu2XijiSA@mail.gmail.com>
In-Reply-To: <CAKMK7uEGXOC_ci=Drm=Hz+xPGdcoxv8YZ-gcOckoPmu2XijiSA@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 14 Jan 2021 16:56:38 +0100
Message-ID: <CAMuHMdVzCjVim4A3eAZzztqUyjb6a2bjmSkgxUnaugQFv42qag@mail.gmail.com>
Subject: Re: fbcon: remove soft scrollback code (missing Doc. patch)
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Phillip Susi <phill@thesusis.net>, Pavel Machek <pavel@ucw.cz>,
        Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Daniel,

CC linux-fbdev

On Tue, Jan 12, 2021 at 5:00 PM Daniel Vetter <daniel@ffwll.ch> wrote:
> On Sat, Jan 9, 2021 at 12:11 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> > On Fri, Jan 8, 2021 at 11:13 AM Phillip Susi <phill@thesusis.net> wrote:
> > > > Could we pause this madness? Scrollback is still useful. I needed it
> > > > today... it was too small, so command results I was looking for
> > > > already scrolled away, but... life will be really painful with 0
> > > > scrollback.
> > >
> > > > You'll need it, too... as soon as you get oops and will want to see
> > > > errors just prior to that oops.
> > >
> > > > If it means I get to maintain it... I'm not happy about it but that's
> > > > better than no scrollback.
> > >
> > > Amen!  What self respecting admin installs a gui on servers?  What do we
> > > have to do to get this back in?  What was so buggy with this code that
> > > it needed to be removed?  Why was it such a burden to just leave it be?
> >
> > It really was buggy, with security implications. And we have no maintainers.
> >
> > So the scroll-back code can't come back until we have a maintainer and
> > a cleaner and simpler implementation.
> >
> > And no, maintaining it really doesn't mean "just get it back to the
> > old broken state".
> >
> > So far I haven't actually seen any patches, which means that it's not
> > coming back.
> >
> > The good news? If you have an actual text VGA console, that should
> > still work just fine.

IIRC, all of this was written for systems lacking VGA text consoles
in the first place...

> Also on anything that is remotely modern (i.e. runs a drm kernel
> modesetting driver undearneath the fbdev/fbcon stack) there's a pile
> more issues on top of just the scrollback/fbcon code being a mess.

Would it help to remove DRM_FBDEV_EMULATION (instead)?

> Specifically the locking is somewhere between yolo and outright
> deadlocks. This holds even more so if the use case here is "I want
> scrollback for an oops". There's rough sketches for how it could be
> solved, but it's all very tricky work.

When an oops happens, all bets are off.  At that point, all information
you can extract from the system is valuable, and additional locking
issues are moot.

> Also adding dri-devel since defacto that's the only place where
> display people hang out nowadays.

Please keep on CCing linux-fbdev, especially for patches removing
fbdev features.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
