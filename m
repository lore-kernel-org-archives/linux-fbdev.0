Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D4FEC433F5
	for <linux-fbdev@archiver.kernel.org>; Thu, 20 Jan 2022 11:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbiATLdL (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 20 Jan 2022 06:33:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiATLdL (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 20 Jan 2022 06:33:11 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBFEC061574
        for <linux-fbdev@vger.kernel.org>; Thu, 20 Jan 2022 03:33:10 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id q13-20020a9d4b0d000000b0059b1209d708so7135152otf.10
        for <linux-fbdev@vger.kernel.org>; Thu, 20 Jan 2022 03:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f+OEkxn4NakLGLT2aLZNbBo/yxXriEj8f/NZ6PMsXkA=;
        b=D/cV3Z013jsfQfCjTfYLYoU/Nfvo04vCLc5JfdNQAJ9VK2jat1BKsNrsHhDt1GUC1U
         M8OmYvquL8tqRHYrTsKBwZPZZy66HZsWfc7kejODp1QyjJOrZCgdUTB7rMvmYMwSoYs3
         4pWI/2QQczbTgPQAGCQUu/N6YZ4xrMord2kec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f+OEkxn4NakLGLT2aLZNbBo/yxXriEj8f/NZ6PMsXkA=;
        b=Luhrzgw6VTtxoXrx3JBRerCPeOrbXJP+KgRoZEkXhwHOJLC2QuD8az09GGy1Kc4hWA
         ZSB7nhnGZL40gul/dbbbkgSEjyl5mQ2rmbdAAXVwm2SOV9z9pjuNrrlT/qekHuMvobc7
         /UF67WMHPObg5Ig8g3Hp1p26lzWWjm6NLV6khCAAWsWj1GkHY1pQvJmLe/rySg72q5Lz
         QXRmWnQjtO5uK0fjHq3ILkuUmS3iqzx/uQxJ5xqtKpq8uW31ttVv1STUGBkpXa5/t76c
         JTRwkDfW6U3fnvsroUx42iMpE38E4ef2Bj7p5qu+S8lo5akLsBBPmtCUCwUQgtZ7sJcz
         gbLA==
X-Gm-Message-State: AOAM531Yz9UUeUjxgIZYzpVtFFd3y6ttvutObsyIQvvpykB1sfy6cdWW
        jcgAyk8lKlTMJQ7UjGdh9HDjTV7+zohesrdxsB7VTYDXGpZvNA==
X-Google-Smtp-Source: ABdhPJwpgfUsa4H2B5o2SXGcAXjYQNL5392vttSDan+DK2TkQUL9WGK7eutH4BDga0De/2cHyXd07fHl7K0b/Ox99rY=
X-Received: by 2002:a05:6830:2704:: with SMTP id j4mr15756956otu.323.1642678390125;
 Thu, 20 Jan 2022 03:33:10 -0800 (PST)
MIME-Version: 1.0
References: <YeG8ydoJNWWkGrTb@ls3530> <c48ad8ae-aea5-43fa-882f-dccb90dde9a4@suse.de>
 <87bl0amc6s.fsf@x1.stackframe.org> <20220118103323.4bae3a7d@eldfell>
 <20220118095352.xsb6fqacw4p276c5@sirius.home.kraxel.org> <CAMuHMdWV+-+Jr7HggbfH_GEDcdep4pJLiMG+15jxBvQ91BCS0w@mail.gmail.com>
In-Reply-To: <CAMuHMdWV+-+Jr7HggbfH_GEDcdep4pJLiMG+15jxBvQ91BCS0w@mail.gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Thu, 20 Jan 2022 12:32:58 +0100
Message-ID: <CAKMK7uEOFg3z2btFERQ5XBQ7hqex6bXCb9X=SdwCjeLfX_SdFw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add Helge as fbdev maintainer
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Helge Deller <deller@gmx.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sven Schnelle <svens@stackframe.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Thu, Jan 20, 2022 at 10:06 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Hi Gerd,
>
> On Thu, Jan 20, 2022 at 4:29 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
> > On Tue, Jan 18, 2022 at 10:33:23AM +0200, Pekka Paalanen wrote:
> > > On Mon, 17 Jan 2022 19:47:39 +0100
> > > Sven Schnelle <svens@stackframe.org> wrote:
> > >
> > > > I also tested the speed on my Thinkpad X1 with Intel graphics, and there
> > > > a dmesg with 919 lines one the text console took about 2s to display. In
> > > > x11, i measure 22ms. This might be unfair because encoding might be
> > > > different, but i cannot confirm the 'memcpy' is faster than hardware
> > > > blitting' point. I think if that would be the case, no-one would care
> > > > about 2D acceleration.
> > >
> > > I think that is an extremely unfair comparison, because a graphical
> > > terminal app is not going to render every line of text streamed to it.
> > > It probably renders only the final view alone if you simply run
> > > 'dmesg', skipping the first 800-900 lines completely.
> >
> > Probably more like "render on every vblank", but yes, unlike fbcon it
> > surely wouldn't render every single character sent to the terminal.
> >
> > Also acceleration on modern hardware is more like "compose window
> > content using the 3d engine" than "use 2d blitter to scroll the window".
> >
> > > Maybe fbcon should do the same when presented with a flood of text,
> > > but I don't know how or why it works like it works.
> >
> > fbcon could do the same, i.e. render to fbdev in a 60Hz timer instead of
> > doing it synchronously.
>
> Hopefully only the parts of the screen which need a redraw?
>
> Not all displays can be updated that fast. For a "modern" example, see
> https://patchwork.freedesktop.org/series/93070/.

drm does damage tracking throughout the stack, e.g.

https://dri.freedesktop.org/docs/drm/gpu/drm-kms.html#damage-tracking-properties

And unlike fbdev, it's explicit (so less overhead since userspace
generally knows what it's drawn) and doesn't rely on page fault
intercepting and fun stuff like that.

Like do people actually know what drm can and cannot do, or would that
take out all the fun?
-Daniel

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
