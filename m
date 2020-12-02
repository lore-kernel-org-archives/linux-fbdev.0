Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE36C64E7C
	for <linux-fbdev@archiver.kernel.org>; Wed,  2 Dec 2020 17:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC5F8221FA
	for <linux-fbdev@archiver.kernel.org>; Wed,  2 Dec 2020 17:52:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbgLBRw4 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 2 Dec 2020 12:52:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbgLBRw4 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 2 Dec 2020 12:52:56 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3521DC0613D4
        for <linux-fbdev@vger.kernel.org>; Wed,  2 Dec 2020 09:52:16 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id b62so2445430otc.5
        for <linux-fbdev@vger.kernel.org>; Wed, 02 Dec 2020 09:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ub8cvY3qgnScNwJepLWbSZHUuE+KWCIwpEaiHVULiDk=;
        b=YYhhOq5rM11r/DYVxE+GM0kf8PnGMhv17Z/znUSeHBB4osEZriQSZV45RzcvS6eqEn
         of/mWynxxW2a7mtavqCqQ5XqTuS8ZWsuNSOM78rCIC3k9lzfLiIHnl1x0nmSG5ZbUsy0
         KAVTIYxALPO2r8K6Mw35t1yDupbKAHt5sdhO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ub8cvY3qgnScNwJepLWbSZHUuE+KWCIwpEaiHVULiDk=;
        b=UZDLBSW1dDIQxX7gmhl9nTg3nxA3XYj6tFjQT8pANhCTtPfzAnX0mYJbuCx6x39VmV
         GmX2vbiw6TLfUs9uAb0xsGN84Ylg0FYsFzLRLCtUB4xuDSCs2eSz1ZZMYVKsQqrDZHXk
         Dvh9NB3+9J2/3hn4aMQloqwg6HtlOfdG5GnVFZSk5fzKHDDzN1iP28n6C6DHxR+rKL6S
         O+Fqrtba5Qki/lJeH+uuyCvXtuNGYQ9FNvkPnA6eJ3CN/lSguhzG19vukd94eZOjpWT2
         /1ehQo7r09sdwwoJlUtKgdpcgPaP4WMBcUfZK5UvubqjHf9DM6RzpotJmYVQLN+rSSmm
         uR8w==
X-Gm-Message-State: AOAM532KkZYMoaJEXHpl27dMqM1Wf8Xy7S6CH6azFvIvIV45UJVVt+iJ
        gH+v2bS2cu1b51ELb89bRoueZBnaOePJ/OCLaEwAzg==
X-Google-Smtp-Source: ABdhPJxurEjYCrkjAS5zpbushlqwhl+1dnUfia/FFKtk2OK04p/DGX12blqcAxKbH8XK0kE8WFAQdoiEcp2DBTPmG+w=
X-Received: by 2002:a05:6830:12d5:: with SMTP id a21mr2757816otq.281.1606931535626;
 Wed, 02 Dec 2020 09:52:15 -0800 (PST)
MIME-Version: 1.0
References: <20201130125200.10416-1-tzimmermann@suse.de> <alpine.LRH.2.02.2011300843270.29199@file01.intranet.prod.int.rdu2.redhat.com>
 <20201130154147.GT401619@phenom.ffwll.local> <alpine.LRH.2.02.2011301241470.21432@file01.intranet.prod.int.rdu2.redhat.com>
 <ac639546-d97e-b197-8998-180b0535fae2@suse.de> <alpine.LRH.2.02.2012010615080.1371@file01.intranet.prod.int.rdu2.redhat.com>
 <9e7cad29-a9c0-2e02-04a9-3149d7e15838@suse.de>
In-Reply-To: <9e7cad29-a9c0-2e02-04a9-3149d7e15838@suse.de>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Wed, 2 Dec 2020 18:52:04 +0100
Message-ID: <CAKMK7uF+uu3taQL-FPXymvnVhKyWWtNy9Z2xes=+j-B+BHaTgA@mail.gmail.com>
Subject: Re: [PATCH] fbdev: Remove udlfb driver
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Bernie Thompson <bernie@plugable.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sam Ravnborg <sam@ravnborg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, Dec 2, 2020 at 8:55 AM Thomas Zimmermann <tzimmermann@suse.de> wrot=
e:
>
> Hi
>
> Am 01.12.20 um 12:20 schrieb Mikulas Patocka:
> >
> >
> > On Tue, 1 Dec 2020, Thomas Zimmermann wrote:
> >
> >> Hi
> >>
> >> Am 30.11.20 um 19:39 schrieb Mikulas Patocka:
> >>>
> >>>
> >>> On Mon, 30 Nov 2020, Daniel Vetter wrote:
> >>>
> >>>> On Mon, Nov 30, 2020 at 09:31:15AM -0500, Mikulas Patocka wrote:
> >>>>>
> >>>>> The framebuffer driver supports programs running full-screen direct=
ly on
> >>>>> the framebuffer console, such as web browser "links -g", image view=
er
> >>>>> "fbi", postscript+pdf viewer "fbgs", ZX Spectrum emulator "fuse-sdl=
",
> >>>>> movie player "mplayer -vo fbdev". The DRM driver doesn't run them.
> >>>>
> >>>> Hm this should in general work on drm drivers. Without that it's cle=
ar the
> >>>> switch-over isn't really ready yet.
> >>>
> >>> I fixed it with this patch two years ago:
> >>> https://lists.freedesktop.org/archives/dri-devel/2018-June/179023.htm=
l
> >>>
> >>> But the patch never went through and the fb_defio feature was removed=
 in
> >>> the kernel 5.6 (commit d0c4fc5a4814e431c15272935c8dc973c18073aa).
> >>>
> >>>
> >>> Without fb_defio, the only other possibility how to update the screen=
 is
> >>> the ioctl DRM_IOCTL_MODE_DIRTYFB. But this ioctl requires master mode=
, so
> >>> user programs like "links -g" can't issue it.
> >>
> >> That's confusing. DIRTYFB is only for DRM.
> >
> > Yes, you're right.
> >
> >> And why can links not run as DRM master mode? If it renders to the ter=
minal,
> >> it should act like a composer. In that case it almost certainly wants =
master
> >> status.
> >>
> >> Best regards
> >> Thomas
> >
> > How can a userspace program acquire master mode without being suid?
>
> For my understanding, there's no easy solution to that. :/

If you're absolutely the only thing running, the first one to open the
card* node wins. But usually you have something like logind managing
this for you (for vt switching), since ad-hoc this is a very fragile
scheme.

I'm not exactly sure how logind gives you an already opened drm device
in master mode, that's a bit tricky. Without either being suid root or
participating in the logind scheme you won't be able to vt switch
though.

But bare metal kms usage should work I as-is.
-Daniel

>
> I guess we (DRM devs) have to treat fbdev as the solution for use cases
> such as ours.
>
> For the unplug issue, I'll try to reproduce and fix it.
>
> For the performance problems, we might be able to squeeze a few more
> cycles out of it.
>
> Best regards
> Thomas
>
> >
> > Is there some "Hello World!" program that shows how to use DRM? I'm not=
 an
> > expert in DRM, but if there were some tutorial+documentation, I could
> > consider porting "links" to it.
> >
> > Mikulas
> >
>
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
> (HRB 36809, AG N=C3=BCrnberg)
> Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer
>


--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
