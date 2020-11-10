Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67629C388F7
	for <linux-fbdev@archiver.kernel.org>; Tue, 10 Nov 2020 13:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7AAB20797
	for <linux-fbdev@archiver.kernel.org>; Tue, 10 Nov 2020 13:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="KxuHLtsg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730097AbgKJNqd (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 10 Nov 2020 08:46:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729898AbgKJNqc (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 10 Nov 2020 08:46:32 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11B5C0613CF
        for <linux-fbdev@vger.kernel.org>; Tue, 10 Nov 2020 05:46:32 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id k26so14387284oiw.0
        for <linux-fbdev@vger.kernel.org>; Tue, 10 Nov 2020 05:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KSBi0cYcjL14hFjS1VAuiIs1ge6Q0TvGqc9wyqKWxHU=;
        b=KxuHLtsg4+HcSlPWK50gx/phNUgDf2ThbSkQ0CvIKqVqDXDWiOfJFapkmTC+NbQ5JB
         K4Lhqy06jvz+cYx+9bOre8LpBa0uzPT6Y4W0Bw0/QCuBi6hCWzKPknd789z+5/2kENxe
         Bb9zMaOyo5IMlrKKcAqWka1ecPC9DB1wrlXgg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KSBi0cYcjL14hFjS1VAuiIs1ge6Q0TvGqc9wyqKWxHU=;
        b=YhKsnimuHORHicWaS2Oen4qS17+KxPNYrRdmT19B/qvjSQ9gdCWUPBF+cekPZJdORg
         B1/CJbjShI4mWYlJX8Pwsy0qURzg+ySEAnmT8g/e+u3VICUrKue54pwf390Yg+jDUjYz
         wd2FUhzQppEfWnvUobiy5vsw8iDtIWCHK6S6DMIzvFvPGSXnG1PkmH1e/nkRwglC1K6S
         09Vp4adFZFTnrGt4LnDjvyi2dgBpM0VeEwKPLV64P2Cf6yk3qsfHZ4ohMu7HTzeUeOnX
         L/JxjwRx8VXGWWrxYIQj3NIZQymVT7UkBKaxVzY0zFzmd4/uq/QdzbTBCq/PRdC4FdNM
         UU+g==
X-Gm-Message-State: AOAM5336uJ/Eiv3TlpcwR3VdPz6wAUY+5hHLXYxKMdzGg/V64wob0P++
        ohTFdPTafvQ9dXIX95UIo40ny6OfZU8/Op9YE1v/zQ==
X-Google-Smtp-Source: ABdhPJyzdDByyzNbzdz/0OYKTLWy3l6toxa9onFy7mPNpemKtfLkC9dXi+UGbqU1YjK1W1TIvOZMjHKrFai3k7UKmkY=
X-Received: by 2002:aca:b141:: with SMTP id a62mr2579473oif.101.1605015991893;
 Tue, 10 Nov 2020 05:46:31 -0800 (PST)
MIME-Version: 1.0
References: <c5563eeea36aae7bd72ea2e985bc610d585ece40.1604128639.git.yepeilin.cs@gmail.com>
 <20201106105058.GA2801856@kroah.com> <20201110124946.GF401619@phenom.ffwll.local>
 <20201110132445.GA2483842@PWN>
In-Reply-To: <20201110132445.GA2483842@PWN>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 10 Nov 2020 14:46:20 +0100
Message-ID: <CAKMK7uFiCTu9bz1uJqmCvwBSUK4XmuVyRf2C-U=zoArZMb0Pgg@mail.gmail.com>
Subject: Re: [PATCH 1/2] console: Remove dummy con_font_op() callback implementations
To:     Peilin Ye <yepeilin.cs@gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Tue, Nov 10, 2020 at 2:24 PM Peilin Ye <yepeilin.cs@gmail.com> wrote:
>
> On Tue, Nov 10, 2020 at 01:49:46PM +0100, Daniel Vetter wrote:
> > Peilin, can you pls resend this together with all the other pending
> > patches from you? I think that's better than me trying to cherry-pick the
> > bits we decided to keep from random places.
>
> Oh, are we doing an -rc3 backmerge soon? At the moment I can base these
> patches on neither drm-misc (due to the font_copy removal), nor mainline
> (due to the signedness issue in font_desc we've talked about), so I'm
> waiting for a backmerge to rebase everything properly. Sorry that I
> didn't mention earlier.

linux-next has all the trees, so you can always use that. And yes I'm
pushing the backmerge through, so in a few days at most I can pull in
all your patches. Meanwhile you can base your work of linux-next.

> > Greg, ok if I just pull these in through drm-misc-next? It's a pretty bad
> > hairball anyway and that avoids the tree coordination issues. Only thing
> > that might get in the way is the vt font_copy removal, but that's in -rc3
> > so easy to backmerge.
>
> I will rebase and send everything (including the font_copy
> garbage-collecting) in a v3 series after the backmerge. Thanks,

No need to be blocked on a backmerge, this is only needed for merging
the patches. Development should not be blocked like this.
-Daniel

>
> Peilin Ye
>


-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
