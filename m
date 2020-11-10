Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B011C388F7
	for <linux-fbdev@archiver.kernel.org>; Tue, 10 Nov 2020 13:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A58C20797
	for <linux-fbdev@archiver.kernel.org>; Tue, 10 Nov 2020 13:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fk7RE+5W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730909AbgKJNzQ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 10 Nov 2020 08:55:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730070AbgKJNzQ (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 10 Nov 2020 08:55:16 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD8F1C0613CF;
        Tue, 10 Nov 2020 05:55:14 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id y7so11476730pfq.11;
        Tue, 10 Nov 2020 05:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tuDMy+iN/NZ/U/XMn7m7h6ztvG8bpQuonUkFjpduYg0=;
        b=fk7RE+5W4RtH2sfW6GeeGC+y9ug+te2P5xp7Rr544DQQQ6Mhd1qHY/aiGRbieXrFfQ
         m0/Y0PWifOgTfmdIUFdQRg0lwg4zP94tJDS7108rRZTFfWecofHxI2Zj7ei8iYiGf9Ys
         bTgmxZjOyzFiTGf2mN3bylUXs6d7BVgs2iHSaejw4PNAbjVss1mfQlOdN3yLqISPSW/6
         G4gNUcea4RgUBuT7fsk59DwBdyAUWkcUmKkmA4fjLgdGEc/3a6PYdyERmcPF2a9m2gp2
         toNlPWXx4pikIumD3cK/ZmW07kGCWoeOgTvAf6Z0iYRY/qTwY2P308K46QfhUB7CkZvE
         qxaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tuDMy+iN/NZ/U/XMn7m7h6ztvG8bpQuonUkFjpduYg0=;
        b=C8zMCQwe+O/sbdilyuHY0KM3/2JPcOYlAJnics6+/GWQ4hsa5oDA+GaGvsBwh6CJJG
         0fDjxydviIaPDdZQmHK4keCdagvfb654FflSGXfXQL+MsxVXT5vmL4uUM5AcFgEjwGuv
         Xf88d4soeSz4kDoJaoT63sAK2+wWOB0/OMN0Ia07F3a1m5EmiWoFhngPBQ7XfmHGE8Tq
         z8PPLd7QQllMOaUW6NweexUaWNTztgQfdyl3CqcDDGNYGLK14v46LUaGGYXsfyB0LJfz
         zxvVByUdiKr3h1T/aYr4HiHZTendxRiNv1GWS0SzEIhxOTt41ivdYf93g5UnjwF5h/41
         yvDw==
X-Gm-Message-State: AOAM530glx9vOcJkISYLiO2FtRClzGZlW0IYVIIlN0T2RwHOw01Qln/U
        rmilqALTb78RYAzBh+rxWOUbOZ4ecIR8e8U=
X-Google-Smtp-Source: ABdhPJxpknnDPzLcIlfsAZoWTOzvr0K2yQz18ucWIcJsbGk6GKdy/ZWv6XiDw/O3mgX9wBTKkZMaDA==
X-Received: by 2002:a63:3346:: with SMTP id z67mr17193856pgz.111.1605016514261;
        Tue, 10 Nov 2020 05:55:14 -0800 (PST)
Received: from PWN (59-125-13-244.HINET-IP.hinet.net. [59.125.13.244])
        by smtp.gmail.com with ESMTPSA id j11sm14221319pfe.80.2020.11.10.05.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 05:55:13 -0800 (PST)
Date:   Tue, 10 Nov 2020 08:55:00 -0500
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Thomas Winischhofer <thomas@winischhofer.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        George Kennedy <george.kennedy@oracle.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Peter Rosin <peda@axentia.se>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>
Subject: Re: [PATCH 1/2] console: Remove dummy con_font_op() callback
 implementations
Message-ID: <20201110135500.GA2484495@PWN>
References: <c5563eeea36aae7bd72ea2e985bc610d585ece40.1604128639.git.yepeilin.cs@gmail.com>
 <20201106105058.GA2801856@kroah.com>
 <20201110124946.GF401619@phenom.ffwll.local>
 <20201110132445.GA2483842@PWN>
 <CAKMK7uFiCTu9bz1uJqmCvwBSUK4XmuVyRf2C-U=zoArZMb0Pgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uFiCTu9bz1uJqmCvwBSUK4XmuVyRf2C-U=zoArZMb0Pgg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Tue, Nov 10, 2020 at 02:46:20PM +0100, Daniel Vetter wrote:
> On Tue, Nov 10, 2020 at 2:24 PM Peilin Ye <yepeilin.cs@gmail.com> wrote:
> > Oh, are we doing an -rc3 backmerge soon? At the moment I can base these
> > patches on neither drm-misc (due to the font_copy removal), nor mainline
> > (due to the signedness issue in font_desc we've talked about), so I'm
> > waiting for a backmerge to rebase everything properly. Sorry that I
> > didn't mention earlier.
> 
> linux-next has all the trees, so you can always use that. And yes I'm
> pushing the backmerge through, so in a few days at most I can pull in
> all your patches. Meanwhile you can base your work of linux-next.
> 
> > > Greg, ok if I just pull these in through drm-misc-next? It's a pretty bad
> > > hairball anyway and that avoids the tree coordination issues. Only thing
> > > that might get in the way is the vt font_copy removal, but that's in -rc3
> > > so easy to backmerge.
> >
> > I will rebase and send everything (including the font_copy
> > garbage-collecting) in a v3 series after the backmerge. Thanks,
> 
> No need to be blocked on a backmerge, this is only needed for merging
> the patches. Development should not be blocked like this.

I see. Thanks!

Peilin Ye

