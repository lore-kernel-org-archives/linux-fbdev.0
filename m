Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62CF4C433DB
	for <linux-fbdev@archiver.kernel.org>; Thu, 14 Jan 2021 16:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36DBD23B2F
	for <linux-fbdev@archiver.kernel.org>; Thu, 14 Jan 2021 16:12:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbhANQMA (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 14 Jan 2021 11:12:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbhANQMA (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 14 Jan 2021 11:12:00 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92ECC061574
        for <linux-fbdev@vger.kernel.org>; Thu, 14 Jan 2021 08:11:19 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id b24so5669019otj.0
        for <linux-fbdev@vger.kernel.org>; Thu, 14 Jan 2021 08:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lI7DNB9PJvzlL1ZP9cY7fdOx2/ptLeVjeZhhrDDi7c4=;
        b=Zi8S4ocJOhLeZPI7DA82w2n/RGNymWj4EnipZ421KIVCN3q+pn6FHQlQjVv4fbVCTq
         Arl+l+jzarPBMM/Q4vO6TR9DcPVhQMO9VvuyqHQXyLCv+FfsVMoypWDiVtBzddb+YuxA
         K1x1YV7KyaUREwbkOGl2QJAf+Oot3y9DhjTh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lI7DNB9PJvzlL1ZP9cY7fdOx2/ptLeVjeZhhrDDi7c4=;
        b=FwJsd0AcmmiCsQ8xUwvlzJdPF8AP2OxYCYI0yBoq97qRX6EoulUKn/ekpHY8xd1VtP
         Rl9oOaL/wbb3MjKCYQstVl7+K+D1kBqRVhYTlfZPe53FoSq+QSaEmI8IT32slGdm3oV7
         DsEQv7JKbJeGdT0AHHmWCwlzSc0KEcdesXF7tjdZQALvtgdoLqoe5vM1UbMsr4dmyVt4
         niYNz4zxIulE3ahn44x1q/QQW5/j4PBOK0QcxfsTbKMnPewyLD/HJ02BBR4aiVZG3EtA
         4dWMj2HMyJt2ZcCHgryWwaqdE0yqD4c65Q+9fnArPMs+u/lzV8GhH8BR/pwqzun0UCKa
         L9xQ==
X-Gm-Message-State: AOAM532Bvti/mzXB2T2dErX6TaC2N3LfjukjhA+g1qz1sMlgqciTqBHN
        PX2ReKFK4lc4jV8mX+RfZpS7qQCctDRClmXZKZVwoA==
X-Google-Smtp-Source: ABdhPJzzz22o9OQD7ab1kI0cLaSVhXvWLJ9AS4BVjPKCWnUBdp3at3x0E09pBUvROlXehDbVAiUAp+GHsISnTag0oIg=
X-Received: by 2002:a05:6830:1bef:: with SMTP id k15mr4945559otb.303.1610640679142;
 Thu, 14 Jan 2021 08:11:19 -0800 (PST)
MIME-Version: 1.0
References: <20200916205434.GA10389@duo.ucw.cz> <87czyf5jjp.fsf@vps.thesusis.net>
 <CAHk-=wjsjC1h7fskwYaaRLykN1ms6ZtxGvucQgmL-zZTfxPdBA@mail.gmail.com>
 <CAKMK7uEGXOC_ci=Drm=Hz+xPGdcoxv8YZ-gcOckoPmu2XijiSA@mail.gmail.com> <CAMuHMdVzCjVim4A3eAZzztqUyjb6a2bjmSkgxUnaugQFv42qag@mail.gmail.com>
In-Reply-To: <CAMuHMdVzCjVim4A3eAZzztqUyjb6a2bjmSkgxUnaugQFv42qag@mail.gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Thu, 14 Jan 2021 17:11:07 +0100
Message-ID: <CAKMK7uEwHu5GLF16wn83PLZUjoJWgF0dcLXwsGkt_aBpOgLt+w@mail.gmail.com>
Subject: Re: fbcon: remove soft scrollback code (missing Doc. patch)
To:     Geert Uytterhoeven <geert@linux-m68k.org>
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

On Thu, Jan 14, 2021 at 4:56 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Daniel,
>
> CC linux-fbdev
>
> On Tue, Jan 12, 2021 at 5:00 PM Daniel Vetter <daniel@ffwll.ch> wrote:
> > On Sat, Jan 9, 2021 at 12:11 AM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > > On Fri, Jan 8, 2021 at 11:13 AM Phillip Susi <phill@thesusis.net> wrote:
> > > > > Could we pause this madness? Scrollback is still useful. I needed it
> > > > > today... it was too small, so command results I was looking for
> > > > > already scrolled away, but... life will be really painful with 0
> > > > > scrollback.
> > > >
> > > > > You'll need it, too... as soon as you get oops and will want to see
> > > > > errors just prior to that oops.
> > > >
> > > > > If it means I get to maintain it... I'm not happy about it but that's
> > > > > better than no scrollback.
> > > >
> > > > Amen!  What self respecting admin installs a gui on servers?  What do we
> > > > have to do to get this back in?  What was so buggy with this code that
> > > > it needed to be removed?  Why was it such a burden to just leave it be?
> > >
> > > It really was buggy, with security implications. And we have no maintainers.
> > >
> > > So the scroll-back code can't come back until we have a maintainer and
> > > a cleaner and simpler implementation.
> > >
> > > And no, maintaining it really doesn't mean "just get it back to the
> > > old broken state".
> > >
> > > So far I haven't actually seen any patches, which means that it's not
> > > coming back.
> > >
> > > The good news? If you have an actual text VGA console, that should
> > > still work just fine.
>
> IIRC, all of this was written for systems lacking VGA text consoles
> in the first place...
>
> > Also on anything that is remotely modern (i.e. runs a drm kernel
> > modesetting driver undearneath the fbdev/fbcon stack) there's a pile
> > more issues on top of just the scrollback/fbcon code being a mess.
>
> Would it help to remove DRM_FBDEV_EMULATION (instead)?

It's a problem with the hardware. "Write some registers and done"
isn't how display blocks work nowadays. So your proposal amounts to
"no fbdev/fbcon for anything modern-ish".

Also I said "a pile more", most of the issues in fbcon/fbdev code
apply for all drivers.

> > Specifically the locking is somewhere between yolo and outright
> > deadlocks. This holds even more so if the use case here is "I want
> > scrollback for an oops". There's rough sketches for how it could be
> > solved, but it's all very tricky work.
>
> When an oops happens, all bets are off.  At that point, all information
> you can extract from the system is valuable, and additional locking
> issues are moot.

Except the first oops then scrolls aways because it's getting buried
under further fail. Your locking needs to be minimally good enough to
not make the situation worse.
-Daniel

> > Also adding dri-devel since defacto that's the only place where
> > display people hang out nowadays.
>
> Please keep on CCing linux-fbdev, especially for patches removing
> fbdev features.
>
> Thanks!
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
