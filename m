Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A180BC43381
	for <linux-fbdev@archiver.kernel.org>; Tue,  2 Feb 2021 15:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6891364F5C
	for <linux-fbdev@archiver.kernel.org>; Tue,  2 Feb 2021 15:24:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235292AbhBBPYp (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 2 Feb 2021 10:24:45 -0500
Received: from vps.thesusis.net ([34.202.238.73]:60524 "EHLO vps.thesusis.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235161AbhBBPQt (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 2 Feb 2021 10:16:49 -0500
Received: from localhost (localhost [127.0.0.1])
        by vps.thesusis.net (Postfix) with ESMTP id DFE99243CA;
        Tue,  2 Feb 2021 10:15:55 -0500 (EST)
Received: from vps.thesusis.net ([127.0.0.1])
        by localhost (vps.thesusis.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id F7YuhNWjVJSq; Tue,  2 Feb 2021 10:15:55 -0500 (EST)
Received: by vps.thesusis.net (Postfix, from userid 1000)
        id A3BDC243C7; Tue,  2 Feb 2021 10:15:55 -0500 (EST)
References: <20200916205434.GA10389@duo.ucw.cz> <87czyf5jjp.fsf@vps.thesusis.net> <CAHk-=wjsjC1h7fskwYaaRLykN1ms6ZtxGvucQgmL-zZTfxPdBA@mail.gmail.com> <CAKMK7uEGXOC_ci=Drm=Hz+xPGdcoxv8YZ-gcOckoPmu2XijiSA@mail.gmail.com> <CAMuHMdVzCjVim4A3eAZzztqUyjb6a2bjmSkgxUnaugQFv42qag@mail.gmail.com> <87k0s4ai33.fsf@vps.thesusis.net> <YBlfKgQ1laQLFqpW@phenom.ffwll.local>
User-agent: mu4e 1.5.7; emacs 26.3
From:   Phillip Susi <phill@thesusis.net>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Pavel Machek <pavel@ucw.cz>,
        Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-doc\@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>
Subject: Re: fbcon: remove soft scrollback code (missing Doc. patch)
Date:   Tue, 02 Feb 2021 10:13:14 -0500
In-reply-to: <YBlfKgQ1laQLFqpW@phenom.ffwll.local>
Message-ID: <87wnvqts9g.fsf@vps.thesusis.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org


Daniel Vetter writes:

> Just a quick comment on this: Since most framebuffers are write-combining,
> and reads from that tend to be ~3 orders of magnitude slower than writes
> (at least on the pile of machines I looked at here, there's big
> differences, and some special streaming cpu instructions to make the
> reading side not so slow).
>
> So scrolling by copying tends to be significantly slower than just
> redrawing everything.

I know this was the case years ago with AGP as iirc, it doubled ( 4x, 8x
) the PCI clock rate but only for writes wasn't it?  I thought this was
no longer an issue with PCIe, but if it is, then I guess I'll go ahead
with cleaning up the dead code and having it re-render with the larger
text buffer.
