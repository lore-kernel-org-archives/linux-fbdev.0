Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F4CC433DB
	for <linux-fbdev@archiver.kernel.org>; Tue, 26 Jan 2021 06:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94FA022A84
	for <linux-fbdev@archiver.kernel.org>; Tue, 26 Jan 2021 06:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbhAZGAf (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 26 Jan 2021 01:00:35 -0500
Received: from mail-oi1-f175.google.com ([209.85.167.175]:43333 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730147AbhAYPkC (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 25 Jan 2021 10:40:02 -0500
Received: by mail-oi1-f175.google.com with SMTP id i25so3757279oie.10;
        Mon, 25 Jan 2021 07:39:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xv2F8uEJDzNOELHmwTwNLPLNs8lRPkq+SnWZqNcKmSE=;
        b=l0RiaogzJdbwI3BYj1NXzN9PA0A5mun/+03eFzsjANhlnWfE+LejPPZ85bnWGm8GEt
         P8mwM89xcXvc3sOStSQsVTtRZ79DAVjUMUlAkEZrseS5/g6D6XBLED0tnaWoqFy8hhH6
         kZ5wIL8bHBN7gcWHltYxXuJI8PZQwZkGUQvlRamY4clk7/9Nx2pjldLHcBoVopr3Q1lV
         pB/dohKXuIPXa0TammoqpCckEiZuX66MChOceW0K0JJsh4qzvshOe+ASt8nKGRhHtEhx
         WIAaG0PDEJuqD40HCs+/Q/+mZREE6GoN6+XGH1AOsnGT4DTWQvDRsnx0FfkfE0MguhkL
         xiAg==
X-Gm-Message-State: AOAM532xYGwCZyicwI041k9wISSwXBB4v3lc1Fad+4ndO0W3rSlPLyjb
        rJox62RZq58+tphVi11bEtqA75vOzlRC9NnJQxQ=
X-Google-Smtp-Source: ABdhPJwZj9WDxzrkp5B5fBpFQxEJMl3itE2IsPYlaaZPJaGCbLO05CDNwOR5DGdC23BcrNbXL/hWQx20i4ztPmfvMHc=
X-Received: by 2002:aca:1219:: with SMTP id 25mr489984ois.54.1611589161153;
 Mon, 25 Jan 2021 07:39:21 -0800 (PST)
MIME-Version: 1.0
References: <20200916205434.GA10389@duo.ucw.cz> <87czyf5jjp.fsf@vps.thesusis.net>
 <CAHk-=wjsjC1h7fskwYaaRLykN1ms6ZtxGvucQgmL-zZTfxPdBA@mail.gmail.com>
 <CAKMK7uEGXOC_ci=Drm=Hz+xPGdcoxv8YZ-gcOckoPmu2XijiSA@mail.gmail.com>
 <CAMuHMdVzCjVim4A3eAZzztqUyjb6a2bjmSkgxUnaugQFv42qag@mail.gmail.com> <87k0s4ai33.fsf@vps.thesusis.net>
In-Reply-To: <87k0s4ai33.fsf@vps.thesusis.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 25 Jan 2021 16:39:09 +0100
Message-ID: <CAMuHMdVe-pS4wT++RDzF+EYd-_SC9naGJj8dzWbN6mt0yAnVxg@mail.gmail.com>
Subject: Re: fbcon: remove soft scrollback code (missing Doc. patch)
To:     Phillip Susi <phill@thesusis.net>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Pavel Machek <pavel@ucw.cz>,
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

Hi Phillip,

On Fri, Jan 22, 2021 at 8:26 PM Phillip Susi <phill@thesusis.net> wrote:
> Geert Uytterhoeven writes:
> Judging from some of the comments in the code, it looks like you were
> one of the original authors of fbcon?  I haven't been able to find any

Indeed, a looooong time ago... Before DRM existed.

> of these sczbot crash reports, and am not sure how fuzzing syscalls
> would really affect this code ( it's not really handling a buch of
> ioctls or otherwise taking arguments from user space ) , but I am a bit

AFAIU, most of these are triggered by VT ioctls.
There is an intimate relation between the VT and fbev subsystems: VT
changes impact fbdev, and vice versa.

Perhaps these should be decoupled, at the expense of worse user
experience (i.e. the user needing to change both screen resolution and
number of columns/rows of the text console)?

> confused as to why the softback was implemented the way that it was.
>
> vgacon simply copies the main buffer to vram in ->set_origin() and then
> changes the pointers to operate out of the much larger vram while that
> virtual terminal is active.  If I understand it correctly, it looks like
> fbcon instead opts to operate out of the main buffer but rescue lines as
> they are scrolled off and relocate them to the softback buffer.  This
> seems to be rather more convoluted.
>
> I'm thinking of re-implementing scrollback more like the way vgacon does
> it: allocate a big "vram" buffer and operate out of that.  Obviously
> ->scroll() and ->scrolldelta() have to actually repaint the screen rather
> than simply change the pointer register, but that should be about the
> only difference.

I'm not that intimate familiar anymore with the current state of the
code, but it used to be like this:
  - vgacon used a VRAM buffer for the current VC, and multiple shadow
    buffers to implement virtual consoles,
  - fbcon always used the shadow buffers, with each update triggering
    an update of the frame buffer (see below).

As the text console buffer handling should be the same for vgacon and
fbcon, I expect most scrollback bugs (if any) to be present in both.

> I have also noticed that there was some code to use hardware panning of
> the video buffer rather than having to do a block bitblt to scroll the
> contents of the screen, but that it was disabled because virtually no
> video drivers actually implemented it?  That seems like a shame, but if
> it is so, then there's no sense carrying the dead code so I think I'll
> clean that up now.
>
> Now that I look at it again, everything is simply always redrawn now
> instead of even doing a simple bitblt.  Daniel, you mentioned that
> almost nobody supports hardware acceleration, but even without any
> specific hardware support, surely even if bitblt() is implemented just
> as a memcpy(), it has to be faster than redrawing all of the characters
> doesn't it?  Getting rid of the panning if it isn't generally supported
> I can see, but I don't understand killing bitblt even if most devices
> don't accelerate it.

There are multiple ways to implement scrolling:
  1. If the hardware supports a larger virtual screen and panning, and
     the virtual screen is enabled, most scrolling can be implemented by
     panning, with a casual copy when reaching the bottom (or top) of
     the virtual screen.
     This mode is (was) available on most graphics hardware with
     dedicated graphics memory.
  2. If a 2D acceleration engine is available, copying (and
     clearing/filling) can be implemented by rectangle copy/fill
     operations.
  3. Rectangle copy/fill by the CPU is always available.
  4. Redrawing characters by the CPU is always available.

Which option was used depended on the hardware: not all options are
available everywhere, and some perform better than others.
E.g. on PCI graphics cards, reading graphics memory by the CPU is
usually very slow, so option 3 is much slower than option 4 (given a
sufficiently fast CPU).
AFAIU, option 2 is not suitable for modern systems with 3D acceleration.
On the older (slower) systems (lacking VGA text mode) for which fbcon
was originally written, option 4 is usually the slowest.

Support for 1-3 were removed in commit 39aead8373b3c20b ("fbcon: Disable
accelerated scrolling"), which claimed only 3 (DRM) drivers made use of
this, ignoring the other 32 (fbdev) drivers making use of it.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
