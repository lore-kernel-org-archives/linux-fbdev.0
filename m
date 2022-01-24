Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA76C433F5
	for <linux-fbdev@archiver.kernel.org>; Mon, 24 Jan 2022 21:12:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376734AbiAXVJU (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 24 Jan 2022 16:09:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392292AbiAXUvB (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 24 Jan 2022 15:51:01 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D552C054308
        for <linux-fbdev@vger.kernel.org>; Mon, 24 Jan 2022 11:58:14 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id j38-20020a9d1926000000b0059fa6de6c71so4019168ota.10
        for <linux-fbdev@vger.kernel.org>; Mon, 24 Jan 2022 11:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T2gDbuL9fMv2rl269QnqyXxLamH6Z2QbvH+WQ3k8mrg=;
        b=S6T6+fQYKJd2lvAA2I5oWA8UZplvZIJ/P3ivaU7HOkoWIHPFDNyYJIwGmCm+sZpo+G
         FyrOqGSwcjZXeOfBGe1nMuCMKv+cVnxYYWLF6aJd4VYpfc06NjX8KKCXhUHPbnFS6nxh
         nkXnT/qOflzhO0QObJxKdvbDWFz++9Iuvl5YA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T2gDbuL9fMv2rl269QnqyXxLamH6Z2QbvH+WQ3k8mrg=;
        b=bLeHOJbUrI5iXaHDS++eIFCJSkCaQr6phSlgTO4DH9xQqpoeA3jVXWw99dO2J30uaW
         OM7UdnJm0c8vwalPh3CZhQDsLKBPyqZI6f+fWyEDL+UtMUdM6hjtwsPJYvG9ZbWevyfl
         uqPbDztPgTWOpQX4is5IMwTYosLDvG7EVdans7KeBWe6I4GLGlSodOcRID/ANLzkxJ4E
         ixtnYgPb1Qp0gqkUIiQJZsd9fEyL5fUkmsyorpWreV04MAnhXhc9IY4vss5Ntafrhsx8
         Qf2sBx/YDZjPSjEI/a8xLBjXzKmwtlHh2fxY3oqHt+AJA62uEa9axHLtthBFU1iGUM2D
         w/qQ==
X-Gm-Message-State: AOAM532XZB7/tjWPN537frvvn90T0IFeFjcMbGsowIIoXu1gbGf4HNu7
        BbgvI2C0qHmGLl8/ucEfmZ7r7uj19wCL9I3gDFovig==
X-Google-Smtp-Source: ABdhPJyUUM/IIey5d4pq9ejNsaUDjZqTQVDk+w+6dfEsVTOAABJxU6UfFTMho4QBvDpTtANKviwZ2bSXix8WqmhS5ow=
X-Received: by 2002:a05:6830:1e76:: with SMTP id m22mr7775943otr.75.1643054293385;
 Mon, 24 Jan 2022 11:58:13 -0800 (PST)
MIME-Version: 1.0
References: <feea8303-2b83-fc36-972c-4fc8ad723bde@gmx.de> <87zgnz71ic.fsf@x1.stackframe.org>
 <Yegwl/rwRhjROxcy@phenom.ffwll.local> <CAMuHMdVBFgo6ryq=h8e6mZZmnxnChZVP924yeX+C-KwghKx3tA@mail.gmail.com>
In-Reply-To: <CAMuHMdVBFgo6ryq=h8e6mZZmnxnChZVP924yeX+C-KwghKx3tA@mail.gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Mon, 24 Jan 2022 20:58:01 +0100
Message-ID: <CAKMK7uHCtm3NSGBi=k5+RGtrmURG3-WJ6PLByZxDj0uaMBGOPA@mail.gmail.com>
Subject: Re: fbdev: Garbage collect fbdev scrolling acceleration
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Sven Schnelle <svens@stackframe.org>, Helge Deller <deller@gmx.de>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Hamza Mahfooz <someguy@effective-light.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Mon, Jan 24, 2022 at 7:27 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Daniel et al,
>
> On Wed, Jan 19, 2022 at 4:39 PM Daniel Vetter <daniel@ffwll.ch> wrote:
> > On Thu, Jan 13, 2022 at 10:46:03PM +0100, Sven Schnelle wrote:
> > > Helge Deller <deller@gmx.de> writes:
> > > > I may have missed some discussions, but I'm objecting against this patch:
> > > >
> > > >     b3ec8cdf457e5 ("fbdev: Garbage collect fbdev scrolling acceleration, part 1 (from TODO list)")
> > > >
> > > > Can we please (partly) revert it and restore the scrolling behaviour,
> > > > where fbcon uses fb_copyarea() to copy the screen contents instead of
> > > > redrawing the whole screen?
> > > >
> > > > I'm fine with dropping the ypan-functionality.
> > > >
> > > > Maybe on fast new x86 boxes the performance difference isn't huge,
> > > > but for all old systems, or when emulated in qemu, this makes
> > > > a big difference.
> > > >
> > > > Helge
> > >
> > > I second that. For most people, the framebuffer isn't important as
> > > they're mostly interested in getting to X11/wayland as fast as possible.
> > > But for systems like servers without X11 it's nice to have a fast
> > > console.
> >
> > Fast console howto:
> > - shadow buffer in cached memory
> > - timer based upload of changed areas to the real framebuffer
> >
> > This one is actually fast, instead of trying to use hw bltcopy and having
> > the most terrible fallback path if that's gone. Yes drm fbdev helpers has
> > this (but not enabled on most drivers because very, very few people care).
>
> That depends on the hardware, and the balance between CPU-to-RAM,
> CPU-to-VRAM, and GPU-to-VRAM bandwidths, and CPU and GPU performance.
>
> When scrolling, the fastest copy is the copy that doesn't need to copy
> much.  So that's why fbcon supports (or supported :-( many strategies:
> scrolling by wrapping, panning, copying (either by CPU or by (simple)
> GPU), re-rendering (useful for a GPU with bitmap expansion).  So forcing
> everybody to render into a fully cached shadow buffer and upload changed
> areas is not the silver bullet.
>
> Whether text output is rendered immediately or not is completely
> orthogonal to this.  While timer-based updates would speed up printing
> of large hunks of text (where no one actually reads what was printed at
> the top), that would have almost no impact on actual interactive console
> work: it may still take 0.5s to scroll the screen if you press "enter"
> when your cursor is positioned on the last line.
> BTW, implementing timer-based updates would make measuring real-world
> performance more difficult, as we would have to use a different
> benchmark than "time dmesg" ;-)
>
> Both Daniel and Thomas said: fbdev is not suitable for modern hardware.
> Fine, we do not debate that, and do not want to prevent you from using
> DRM for modern hardware.  Then please accept us saying that DRM (in its
> current form) is not suitable for other types of graphics hardware.
> Still, even modern (embedded) hardware may have small low-color
> displays.
>
> For the last +5 years, we've been pointed to the tinydrm drivers, to
> serve as examples for converting existing fbdev drivers to drm drivers.
> All but one of them are drivers for hi-color or better hardware, thus
> surpassing the capabilities of lots of hardware driven by fbdev drivers.
> The other one is an e-ink driver that exposes an XRGB8888 shadow frame
> buffer, and converts that in a two-step process, first to 8-bit
> grayscale, second to 1-bit monochrome.  If that is considered a good
> example, should I be impressed?
> Compare that to other subsystems boasting about zero-copy...

tiny drivers are the state of the art for small neat drivers. As you
pointed out multiple times now there's not Rx or Cx support for x < 8
in drm or fbdev yet, so that would need to be added. If someone cares
enough for that. Some of the fbtft drivers have gone down
substantially when ported to tiny, which is really the claim we've put
down. Not that you'll find the perfect C4 pixel format example in
there, at most you find C8 support in some of the really old drivers
like i915/radeon/nouveau for old platforms. But that's very well
burried.

I guess in practice (as you point out below) the repaper display is so
glacially slow anyway and connected to machines with enough ram that
generally the only case that mattered was convenience and hence
supporting what every drm userspace can cope with minimally. Which is
xrgb8888. So yeah don't look at a driver which updates at roughly
0.5fps for efficient upload code :-) The space wasting is a bit more
important and should be trivial to add if someone cares enough to do
that.
-Daniel

> Furthermore, for a contemporary e-ink device like[1], the shadow buffer
> would consume 10 MiB.  Of course this device has 4 GiB of RAM, and quad
> Cortex-A55 CPU cores, but not all systems have 10 MiB to spare...
>
> [1] https://linuxgizmos.com/rk3566-based-pinenote-e-ink-tablet-ships-at-399/
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
