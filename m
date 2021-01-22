Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E9EC433E6
	for <linux-fbdev@archiver.kernel.org>; Fri, 22 Jan 2021 23:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FEAD23B00
	for <linux-fbdev@archiver.kernel.org>; Fri, 22 Jan 2021 23:17:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728568AbhAVXQn (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 22 Jan 2021 18:16:43 -0500
Received: from vps.thesusis.net ([34.202.238.73]:50602 "EHLO vps.thesusis.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729288AbhAVTgR (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 22 Jan 2021 14:36:17 -0500
X-Greylist: delayed 512 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Jan 2021 14:36:16 EST
Received: from localhost (localhost [127.0.0.1])
        by vps.thesusis.net (Postfix) with ESMTP id 8D16F29A9E;
        Fri, 22 Jan 2021 14:26:40 -0500 (EST)
Received: from vps.thesusis.net ([127.0.0.1])
        by localhost (vps.thesusis.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8wXz7EfBN6Kj; Fri, 22 Jan 2021 14:26:40 -0500 (EST)
Received: by vps.thesusis.net (Postfix, from userid 1000)
        id 387A529A9D; Fri, 22 Jan 2021 14:26:40 -0500 (EST)
References: <20200916205434.GA10389@duo.ucw.cz> <87czyf5jjp.fsf@vps.thesusis.net> <CAHk-=wjsjC1h7fskwYaaRLykN1ms6ZtxGvucQgmL-zZTfxPdBA@mail.gmail.com> <CAKMK7uEGXOC_ci=Drm=Hz+xPGdcoxv8YZ-gcOckoPmu2XijiSA@mail.gmail.com> <CAMuHMdVzCjVim4A3eAZzztqUyjb6a2bjmSkgxUnaugQFv42qag@mail.gmail.com>
User-agent: mu4e 1.5.7; emacs 26.3
From:   Phillip Susi <phill@thesusis.net>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Pavel Machek <pavel@ucw.cz>,
        Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-doc\@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>
Subject: Re: fbcon: remove soft scrollback code (missing Doc. patch)
Date:   Fri, 22 Jan 2021 13:55:04 -0500
In-reply-to: <CAMuHMdVzCjVim4A3eAZzztqUyjb6a2bjmSkgxUnaugQFv42qag@mail.gmail.com>
Message-ID: <87k0s4ai33.fsf@vps.thesusis.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org


Geert Uytterhoeven writes:

Judging from some of the comments in the code, it looks like you were
one of the original authors of fbcon?  I haven't been able to find any
of these sczbot crash reports, and am not sure how fuzzing syscalls
would really affect this code ( it's not really handling a buch of
ioctls or otherwise taking arguments from user space ) , but I am a bit
confused as to why the softback was implemented the way that it was.

vgacon simply copies the main buffer to vram in ->set_origin() and then
changes the pointers to operate out of the much larger vram while that
virtual terminal is active.  If I understand it correctly, it looks like
fbcon instead opts to operate out of the main buffer but rescue lines as
they are scrolled off and relocate them to the softback buffer.  This
seems to be rather more convoluted.

I'm thinking of re-implementing scrollback more like the way vgacon does
it: allocate a big "vram" buffer and operate out of that.  Obviously
->scroll() and ->scrolldelta() have to actually repaint the screen rather
than simply change the pointer register, but that should be about the
only difference.

I have also noticed that there was some code to use hardware panning of
the video buffer rather than having to do a block bitblt to scroll the
contents of the screen, but that it was disabled because virtually no
video drivers actually implemented it?  That seems like a shame, but if
it is so, then there's no sense carrying the dead code so I think I'll
clean that up now.

Now that I look at it again, everything is simply always redrawn now
instead of even doing a simple bitblt.  Daniel, you mentioned that
almost nobody supports hardware acceleration, but even without any
specific hardware support, surely even if bitblt() is implemented just
as a memcpy(), it has to be faster than redrawing all of the characters
doesn't it?  Getting rid of the panning if it isn't generally supported
I can see, but I don't understand killing bitblt even if most devices
don't accelerate it.

In addition, I noticed that ->screen_pos() was changed to just return
vc_origin+offset.  fbcon is the only console driver to implement
->screenpos() and if not implemented, vt defaults to using
vc_visible_origin+offset, so it looks like this function isn't needed at
all anymore and ->screen_pos() can be removed from struct consw.

Does this make sense or am I talking crazy?
