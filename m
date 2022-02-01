Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 822B8C4332F
	for <linux-fbdev@archiver.kernel.org>; Tue,  1 Feb 2022 16:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241090AbiBAQat (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 1 Feb 2022 11:30:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241089AbiBAQas (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 1 Feb 2022 11:30:48 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55423C06173D
        for <linux-fbdev@vger.kernel.org>; Tue,  1 Feb 2022 08:30:48 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id e81so34328684oia.6
        for <linux-fbdev@vger.kernel.org>; Tue, 01 Feb 2022 08:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SmoAfGUcv3WuX5MTMsQtLDuakLAcJhTCCEdC4MKfCJU=;
        b=hE0dHoYE2FXofMs4e1RcU8c6vfA8rv8R3XWFaQ0os1A+wPd9bM/1RxDIdOUGSJs44C
         IbvTPs4DM04VagcMezxMBUFH8mDLy9QtjjQblNkO/XUP+kEMmcvVuSs6Ghbzv6BTRJkJ
         xLtV9OHhTOddvn0QXAX7viusKmGqEOG1wVJo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SmoAfGUcv3WuX5MTMsQtLDuakLAcJhTCCEdC4MKfCJU=;
        b=TF5xLYzGrSpThmkUp/NfUrLwC7RSIO8btS/6ZVSrIb5QXhZlGKNCvUYhundTy9Tb7N
         9PxZJvKOjg6N+xjDyCZsn178BNv5G9G9ZmmVVZAxING+nzJrYkbzfJBfjTid1lKBtApR
         kdtSj2V7dKewMaUmTiYxga6eyJC8YlPWQtxWf31Mo0dGhJSOgnVsbMi0M1MbxMJwKDNe
         P19zLn73cFYdP3igIStRK5jv20jrCBw6BSc/BuPgL+JjPx95lNCUvEUy0sGtBDVi3EUb
         GQ47OZu84JGefYMuMA9B1KD98OJybijkgRcqnZ+HN/G/lq5kj4kG1ZdIbwDkNOt3CgnM
         wcsw==
X-Gm-Message-State: AOAM531FtLMGbiUckGPDoKku9dS3v9fvzLGIIflwTIF8w2yCnVgFBXdg
        PouzY4yyTwDOeqP3hRSOkqTi0t5WtCt5qZa75PoZEqfwJVw=
X-Google-Smtp-Source: ABdhPJz3JayTHVyC51m4kdAPGDzLvlPbnDnx2e6c/T0JZ7beOtPGbdiv2N+Jc7yrinJz0jrqaKDfzGNAZgBoR3v4+Ao=
X-Received: by 2002:a54:4803:: with SMTP id j3mr1774572oij.279.1643733047225;
 Tue, 01 Feb 2022 08:30:47 -0800 (PST)
MIME-Version: 1.0
References: <20220131210552.482606-1-daniel.vetter@ffwll.ch>
 <20220131210552.482606-4-daniel.vetter@ffwll.ch> <9c22b709-cbcf-6a29-a45e-5a57ba0b9c14@gmx.de>
 <CAKMK7uGvOVe8kkJCTkQBEFw+3i2iAMANsyG9vGqZkcROZ9he4A@mail.gmail.com>
 <63018892-68e8-01b6-1e8f-853892e15c97@gmx.de> <CAKMK7uHPn77GA12fFjmvkRUDQXSBkbYK5X=rJp8sfO_xarys_g@mail.gmail.com>
 <313c4c72-364b-1d61-09c1-e4a83cbefe6a@gmx.de>
In-Reply-To: <313c4c72-364b-1d61-09c1-e4a83cbefe6a@gmx.de>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Tue, 1 Feb 2022 17:30:36 +0100
Message-ID: <CAKMK7uE5A6+s6=yaCUsKN0XrMAESLKNwz2_bJR9YL3S7YeDzMw@mail.gmail.com>
Subject: Re: [PATCH 03/21] fbcon: Restore fbcon scrolling acceleration
To:     Helge Deller <deller@gmx.de>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org, Claudio Suarez <cssk@net-c.es>,
        Dave Airlie <airlied@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Pavel Machek <pavel@ucw.cz>, Sam Ravnborg <sam@ravnborg.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Sven Schnelle <svens@stackframe.org>,
        Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Tue, Feb 1, 2022 at 3:52 PM Helge Deller <deller@gmx.de> wrote:
>
> On 2/1/22 14:45, Daniel Vetter wrote:
> > On Tue, Feb 1, 2022 at 12:01 PM Helge Deller <deller@gmx.de> wrote:
> >> On 2/1/22 11:36, Daniel Vetter wrote:
> >>> On Tue, Feb 1, 2022 at 11:16 AM Helge Deller <deller@gmx.de> wrote:
> >>>>
> >>>> On 1/31/22 22:05, Daniel Vetter wrote:
> >>>>> This functionally undoes 39aead8373b3 ("fbcon: Disable accelerated
> >>>>> scrolling"), but behind the FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION
> >>>>> option.
> >>>>
> >>>> you have two trivial copy-n-paste errors in this patch which still prevent the
> >>>> console acceleration.
> >>>
> >>> Duh :-(
> >>>
> >>> But before we dig into details I think the big picture would be
> >>> better. I honestly don't like the #ifdef pile here that much.
> >>
> >> Me neither.
> >> The ifdefs give a better separation, but prevents that the compiler
> >> checks the various paths when building.
> >>
> >>> I wonder whether your approach, also with GETVX/YRES adjusted
> >>> somehow, wouldn't look cleaner?
> >> I think so.
> >> You wouldn't even need to touch GETVX/YRES because the compiler
> >> will optimize/reduce it from
> >>
> >> #define GETVYRES(s,i) ({                           \
> >>         (s == SCROLL_REDRAW || s == SCROLL_MOVE) ? \
> >>         (i)->var.yres : (i)->var.yres_virtual; })
> >>
> >> to just become:
> >>
> >> #define GETVYRES(s,i) ((i)->var.yres)
> >
> > Yeah, but you need to roll out your helper to all the callsites. But
> > since you #ifdef out info->scrollmode we should catch them all I
> > guess.
>
> Right. That was the only reason why I ifdef'ed it out.
> Technically we don't need that ifdef.
>
> >>> Like I said in the cover letter I got mostly distracted with fbcon
> >>> locking last week, not really with this one here at all, so maybe
> >>> going with your 4 (or 2 if we squash them like I did here) patches is
> >>> neater?
> >>
> >> The benefit of my patch series was, that it could be easily backported first,
> >> and then cleaned up afterwards. Even a small additional backport patch to disable
> >> the fbcon acceleration for DRM in the old releases would be easy.
> >> But I'm not insisting on backporting the patches, if we find good way forward.
> >>
> >> So, either with the 4 (or 2) patches would be OK for me (or even your approach).
> >
> > The idea behind the squash was that it's then impossible to backport
> > without the Kconfig,
>
> Yes, my proposal was to simply revert the 2 patches and immediatly send
> the Kconfig patch to disable it again.
>
> > and so we'll only enable this code when people
> > intentionally want it. Maybe I'm too paranoid?
>
> I think you are too paranoid :-)
> If all patches incl. the Kconfig patch are backported then people shouldn't
> do it wrong.
>
> > Anyway, you feel like finishing off your approach? Or should I send
> > out v2 of this with the issues fixed you spotted? Like I said either
> > is fine with me.
>
> Ok, then let me try to finish my approach until tomorrow, and then you
> check if you can and want to add your locking and other patches on top of it.
> In the end I leave the decision which approach to take to you.
> Ok?

Sounds good, and yeah rough idea is that the maintainers + revert +
Kconfig should go in for rc3 or rc4 if we hit another bump, and the
locking stuff then in for -next (since it needs a backmerge and is
defo tricky stuff).

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
