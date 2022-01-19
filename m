Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01422C433F5
	for <linux-fbdev@archiver.kernel.org>; Wed, 19 Jan 2022 15:42:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355845AbiASPmU (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 19 Jan 2022 10:42:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355850AbiASPmU (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 19 Jan 2022 10:42:20 -0500
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16DFC06161C
        for <linux-fbdev@vger.kernel.org>; Wed, 19 Jan 2022 07:42:19 -0800 (PST)
Received: by mail-oo1-xc30.google.com with SMTP id q16-20020a4a3010000000b002dde2463e66so839290oof.9
        for <linux-fbdev@vger.kernel.org>; Wed, 19 Jan 2022 07:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sV3+kDUL8DjXoSEoLC5sXb4a9dOfAi1JlkS/4ECjvmk=;
        b=evupy6jbU/zkHyiw80GH7FsGZa1tP7RHT2/12cO+4uKW5JeDTCmqIYtqol5Zre9096
         zea8POTzyFWE686ja34SKcLRPrrM8RovCstJr77m/tNTbDjX+hlEcc8BsUH5FvwNU5HD
         qsr4oXlbRiiNg3A0dp5ep0yYYVTkTW9BpZ5iQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sV3+kDUL8DjXoSEoLC5sXb4a9dOfAi1JlkS/4ECjvmk=;
        b=nI7xgyHAKQUyvnhfmOYY4o7FsD4LNCJ/ct/OWNZ7DEaSpOjsTRorPIrP/rkCT6agVo
         kxjlTrm3NcnaDrWJO3LSEj8r5aNaw70B6dUIzmhHOZGpk2NiGXNggZG7SmNZBTBPlAp7
         TB8xj6yWq/tGJe873nKmj8kpR+MGIdA61vDMdWk/197zBDkiLVnBFTXQx56ZGLeV32W6
         lAF2dXcByYjLwI81pSVpFt4/0NAvr/tfaL9KR3vFdNfWb2l/Bb0BPIuk5StcLo/JD0We
         rdvMC8ddoi9Cs74mIFGaqGJRkvQyB+Osyi4kXFr8XZCdjkNoarlfx7Mr/hynMBmDB0Ei
         y8LQ==
X-Gm-Message-State: AOAM533QZ+Kfi6NUOupJLYEdiC5jxZE/Td2kA6GALaIfPOdx75DcJI9v
        o73Ete0vQ+bLvods5kM/WPr+DyLohA40iWh7SGi5IQ==
X-Google-Smtp-Source: ABdhPJy1jF87ij4w/+5l4yF+BCVJUry1sfgh+1wGxiideA8/zbNw4kVCCpwr6CQ1DSKDi+tQ6WImdhmt0nLCEpnChJc=
X-Received: by 2002:a4a:db96:: with SMTP id s22mr20322036oou.66.1642606939245;
 Wed, 19 Jan 2022 07:42:19 -0800 (PST)
MIME-Version: 1.0
References: <20220119110839.33187-1-deller@gmx.de> <20220119110839.33187-3-deller@gmx.de>
 <Yef0j8+DBbwC7Kjv@kroah.com> <Yef15k2GtC40aJEu@kroah.com> <CAMuHMdVWFJEDwjf-htZ_D1484efmuPnz_L-qhcTeUE-GVpvZXA@mail.gmail.com>
 <4d8950c7-5f51-ca2b-4c93-741c7805a214@gmx.de> <CAHk-=wikFKjwdUBWCLCu=iL3rFq4BDDF0aBGdXC6ay74yJb+5Q@mail.gmail.com>
 <CAKMK7uEb53iu_HxYSnFZ59j=vXQdMvTWT7xosEo85XkAwzDMnA@mail.gmail.com> <8735ljkboo.fsf@x1.stackframe.org>
In-Reply-To: <8735ljkboo.fsf@x1.stackframe.org>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 19 Jan 2022 16:42:06 +0100
Message-ID: <CAKMK7uHHF22+MBz5D2kBv07X2BR76UDi2-JP7eO-f=nm-pymcw@mail.gmail.com>
Subject: Re: [PATCH 2/2] Revert "fbcon: Disable accelerated scrolling"
To:     Sven Schnelle <svens@stackframe.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Helge Deller <deller@gmx.de>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Sam Ravnborg <sam@ravnborg.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Claudio Suarez <cssk@net-c.es>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, Jan 19, 2022 at 4:06 PM Sven Schnelle <svens@stackframe.org> wrote:
>
> Daniel Vetter <daniel@ffwll.ch> writes:
>
> > On Wed, Jan 19, 2022 at 3:01 PM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > Irrespective of this code being buggy or not buggy I think the bigger
> > pictures, and really the reason I want to see as much code ditched
> > from the fbdev/fbcon stack as we possible can, are very clear:
> >
> > - it's full of bugs
> > - there's no test coverage/CI to speak of
> > - it's very arcane code which is damn hard to understand and fix issues within
> > - the locking is busted (largely thanks to console_lock, and the
> > effort to make that reasonable from -rt folks has been slowly creeping
> > forward for years).
> >
> > Iow this subsystem is firmly stuck in the 90s, and I think it's best
> > to just leave it there. There's also not been anyone actually capable
> > and willing to put in the work to change this (pretty much all actual
> > changes/fixes have been done by drm folks anyway, like me having a
> > small pet project to make the fbdev vs fbcon locking slightly less
> > busted).
>
> Saying it's stuck in the 90ies, and actively trying to prevent
> Helge from taking over maintainership at the same time looks odd.
> I think Helge should at least get a chance to fix the issues. If the
> state is still the same in a year or so it should be discussed again.

You don't need maintainership to fix issues. You need to submit patches.

If otoh you get the maintainership first to be able to cram in reverts
without discussions, then it's very backwards.

> > The other side is that being a maintainer is about collaboration, and
> > this entire fbdev maintainership takeover has been a demonstration of
> > anything but that. MAINTAINERS entry was a bit confusing since defacto
> > drm has been maintaining it for years.
>
> It was marked as 'Orphaned'. Anyone is free to send a Patch/PR to take
> over maintainership. If you have strong opinions about that code (And you
> obviously have reading your mail, set it to 'maintained' and care about
> it. Everything else is just wrong in my opinion.

I already added dri-devel so anything we drastically change can be
discussed first. If that's indeed not strong enough then yes I can
whack in full maintainer entry with a bugfix-only status.

But really I try to not create facts with just editing MAINTAINERS
first and ask questions later, that's just not a great way to
collaborate.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
