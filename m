Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33855C433F5
	for <linux-fbdev@archiver.kernel.org>; Wed, 19 Jan 2022 14:34:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355146AbiASOeT (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 19 Jan 2022 09:34:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355142AbiASOeT (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 19 Jan 2022 09:34:19 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00182C06161C
        for <linux-fbdev@vger.kernel.org>; Wed, 19 Jan 2022 06:34:18 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id a12-20020a0568301dcc00b005919e149b4cso3311915otj.8
        for <linux-fbdev@vger.kernel.org>; Wed, 19 Jan 2022 06:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9kzQsP7xdcOo4/yHfvVfKqgcZoVNHB3M0EMVy+tuCNU=;
        b=MwwZUQEW+QtUVAq3466CCsAjvpvJ+cNXwRETxi+xwQ7hhpUwOhOatm4nTEbLEGotoB
         1TtUz25a044+zv7NdXKpBKYbkIe9pjHagzS4w7TB1YrlUpj02u78LXj10ZlkcabweW3t
         MGkz/WnNcQ137Dj9PLFhK8zwzqRGaCNqxSQUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9kzQsP7xdcOo4/yHfvVfKqgcZoVNHB3M0EMVy+tuCNU=;
        b=WDBOuX/NJaW6xodS6bgtjCFEuw01VQcaYkJGE4DuK/fYk7hu34BJKqYTjnNVW4ycpk
         VdP4Og6WueSxKdTe6ghTIdwbdf8YcT10Lllf9GlQ6Et0No1dhoDHeev/mffYr19f6IrB
         scT7Ky3mZT1eGOOvWo3U7vgtB+Q1SYj+nAzFDHnrGQZ6gBNbs9QKR5rMzznhDInWRg0S
         NCviwyP0wmjJ8sGx/e88mXgD1LOxi2FfNnI4fgOkWZrxwJQZy95W2FYd1M/zdFazcSMU
         C3rwqzMd9gkox3ASwt8XtzGYmNBxVmErkV0C6uBOjSsoAQvDN2FPW9m+siIxdz2Q/yAv
         8RmQ==
X-Gm-Message-State: AOAM533A78QEPOA2zTmzPyZhSjLb0FDat4UOhKkKCGk/+FmUDUbHpgZe
        9i1CBVRQLcqGhr6vlLajK+yhjQtrAbmFiaCfk3IMHQ==
X-Google-Smtp-Source: ABdhPJzsPoKUTRwcahcaLPyRU+wwxVRU/sDDpI8hVyibcKoclfqdsQi3ILaSD45Jj8A4q4A51AgWhTyQFQ3zYYEmCCc=
X-Received: by 2002:a9d:685a:: with SMTP id c26mr24282535oto.239.1642602858341;
 Wed, 19 Jan 2022 06:34:18 -0800 (PST)
MIME-Version: 1.0
References: <20220119110839.33187-1-deller@gmx.de> <20220119110839.33187-3-deller@gmx.de>
 <Yef0j8+DBbwC7Kjv@kroah.com> <Yef15k2GtC40aJEu@kroah.com> <CAMuHMdVWFJEDwjf-htZ_D1484efmuPnz_L-qhcTeUE-GVpvZXA@mail.gmail.com>
 <4d8950c7-5f51-ca2b-4c93-741c7805a214@gmx.de> <CAHk-=wikFKjwdUBWCLCu=iL3rFq4BDDF0aBGdXC6ay74yJb+5Q@mail.gmail.com>
In-Reply-To: <CAHk-=wikFKjwdUBWCLCu=iL3rFq4BDDF0aBGdXC6ay74yJb+5Q@mail.gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 19 Jan 2022 15:34:06 +0100
Message-ID: <CAKMK7uEb53iu_HxYSnFZ59j=vXQdMvTWT7xosEo85XkAwzDMnA@mail.gmail.com>
Subject: Re: [PATCH 2/2] Revert "fbcon: Disable accelerated scrolling"
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Helge Deller <deller@gmx.de>,
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
        Sven Schnelle <svens@stackframe.org>,
        Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, Jan 19, 2022 at 3:01 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, Jan 19, 2022 at 2:29 PM Helge Deller <deller@gmx.de> wrote:
> >
> > >>
> > >> Ah, no, that was just the soft scrollback code I was thinking of, which
> >
> > Right.
> > That was commit 973c096f6a85 and it was about vgacon, not fbcon.
>
> No, fbcon had some bug too, although I've paged out the details. See
> commit 50145474f6ef ("fbcon: remove soft scrollback code").

tbh I've paged it all out too.

> If I remember correctly (and it's entirely possible that I don't), the
> whole "softback_lines" logic had serious problems with resizing the
> console (or maybe changing the font size).

Yeah that pile of reverts was my motiviation to look into this and see
what else we could rip out most likely and still have an fbcon that
works as well as it does right now for almost all users (which is not
so great, but oh well).

> There may have been some other bad interaction with
> foreground/background consoles too, I forget.

Irrespective of this code being buggy or not buggy I think the bigger
pictures, and really the reason I want to see as much code ditched
from the fbdev/fbcon stack as we possible can, are very clear:

- it's full of bugs
- there's no test coverage/CI to speak of
- it's very arcane code which is damn hard to understand and fix issues within
- the locking is busted (largely thanks to console_lock, and the
effort to make that reasonable from -rt folks has been slowly creeping
forward for years).

Iow this subsystem is firmly stuck in the 90s, and I think it's best
to just leave it there. There's also not been anyone actually capable
and willing to put in the work to change this (pretty much all actual
changes/fixes have been done by drm folks anyway, like me having a
small pet project to make the fbdev vs fbcon locking slightly less
busted).

The other side is that being a maintainer is about collaboration, and
this entire fbdev maintainership takeover has been a demonstration of
anything but that. MAINTAINERS entry was a bit confusing since defacto
drm has been maintaining it for years, but for the above reasons we've
done that by just aggressively deleting stuff that isn't absolutely
needed - hence why I figured "orphaned" is a reasonable description of
the state of things. This entire affair of rushing in a maintainer
change over the w/e and then being greeted by a lot of wtf mails next
Monday does leave a rather sour aftertaste. Plus that thread shows a
lot of misunderstandings of what's all been going on and what drm can
and cannot do by Helge, which doesn't improve the entire "we need
fbdev back" argument.

But if the overall consensus is that that fbdev needs to be brought
back to it's full 90s glory then I think we need a copy of that code
for drm drivers (should work out if we intercept fb_open() and put our
own file_ops in there, maybe some more fun with fbcon), so that at
least for anything modern using drm driver we can keep on maintaining
that compat support code.

And with maintaining here I don't mean build a museum around it, but
actually try to keep/move the thing towards a state where we can still
tell distros that enabling it is an ok thing to do and not just a CVE
subscription (well it is that too right now, but at least we can fix a
lot of them by just deleting code).

I think until that mess is sorted out resurrecting code that's not
strictly needed is just not a bright idea.

Also wrt the issue at hand of "fbcon scrolling": The way to actually
do that with some speed is to render into a fully cached shadow buffer
and upload changed areas with a timer. Not with hw accelerated
scrolling, at least not if we just don't have full scale development
teams for each driver because creating 2d accel that doesn't suck is
really hard. drm fbdev compat helpers give you that shadow buffer for
free (well you got to set some options).

Unfortunately just ditching fbdev/fbcon compat is not an option for
many distros still, althought things are very slowly moving towards
that. Until we've arrived there I can't just pretend to not care about
what's going on in drivers/video.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
