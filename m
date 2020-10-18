Return-Path: <SRS0=OfnY=DZ=vger.kernel.org=linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA2BC433E7
	for <linux-fbdev@archiver.kernel.org>; Sun, 18 Oct 2020 20:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 156052227E
	for <linux-fbdev@archiver.kernel.org>; Sun, 18 Oct 2020 20:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Sp9iIrfZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbgJRUdX (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 18 Oct 2020 16:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgJRUdX (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sun, 18 Oct 2020 16:33:23 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F03FC061755
        for <linux-fbdev@vger.kernel.org>; Sun, 18 Oct 2020 13:33:23 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id t77so10163139oie.4
        for <linux-fbdev@vger.kernel.org>; Sun, 18 Oct 2020 13:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2tjt8ngbdIU3h9PETCczfJ9vnTQ40FaapLpDo2xIhaE=;
        b=Sp9iIrfZIvjznRS75UO82B6KhHY8UwiZ3t5UFaGmGqwmbjlttQPIxbes+8+VYGfeUc
         vBjeQ28RaYl66uxePh4ZL0rA8ul4c6tJl5y34Ezn0mtkJ7fpCfvAm+1vc/JkXxoDiX+m
         XWZgtLUI+RJeQdB9hmX2gJ2FWQlkhnbRrBU7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2tjt8ngbdIU3h9PETCczfJ9vnTQ40FaapLpDo2xIhaE=;
        b=osvjLf/b6N4NGMa+gU1Mb2ByJKoxTHxusNo0R3pjtTiGJTLLxfW+qkSGetiAP6YN9+
         smy7t9k7A5eWiIisML1HGNOffT8cVactSe1uDuV//99BlR3HKPo5TfxZV7we4Idy4K6S
         z710z8F41APhLKzRXdzJHgPX/IDJCxSMybry7YM7bvNeE+N9iIG9zo2xODlBPG6gjA81
         A+VVBZWzxPVUQzvN1YYXZOYRBsfxfErzzQ13l/Hi5u9URS1Hi/UEpJSCXSrkYMBugU9n
         8gDyhdIqwwV01ft5vk8A6ibVCqd+Q/LtPsIFHe9BLYDQA42l6zOJ9fR3qs4l8f3MrL8B
         cj9A==
X-Gm-Message-State: AOAM531ZtBgmP91rQhWpNBVzwNazkp94MXwjYhr+LnPJmXBJXKFFY8PB
        a3MfADQC7BtxkOGwcw+swBCgmdJQRPacD79dZ14hGgyMZApURw==
X-Google-Smtp-Source: ABdhPJxGp/avmYnxlHs5bpREP0kcu2f1x3Av0xEFWBggKhyJihr+jjRB7wtkrc3DNtVCdX/JVjLJsFJDIiHvWMvOt4s=
X-Received: by 2002:aca:6083:: with SMTP id u125mr9349336oib.14.1603053202045;
 Sun, 18 Oct 2020 13:33:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200820082137.5907-1-s.hauer@pengutronix.de> <926453876c92caac34cba8545716a491754d04d5.1603037079.git.yepeilin.cs@gmail.com>
 <CAKMK7uF9E24P=vzKt28=1_iaFTYD7obHs+tEPwwZPNMhh7DBrg@mail.gmail.com> <20201018201811.GA697615@PWN>
In-Reply-To: <20201018201811.GA697615@PWN>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Sun, 18 Oct 2020 22:33:11 +0200
Message-ID: <CAKMK7uFEmNnBdpoHYqvCUYS=nxh99gKs6P1-1pgp-ouvTSioGw@mail.gmail.com>
Subject: Re: [PATCH 1/2] Fonts: Support FONT_EXTRA_WORDS macros for font_6x8
To:     Peilin Ye <yepeilin.cs@gmail.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sven Schneider <s.schneider@arkona-technologies.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org
Message-ID: <20201018203311.YIYmFRTIRCY95wz1e9xKsBHvl8Xa2RI1Qer-988gI-I@z>

On Sun, Oct 18, 2020 at 10:18 PM Peilin Ye <yepeilin.cs@gmail.com> wrote:
>
> On Sun, Oct 18, 2020 at 10:09:06PM +0200, Daniel Vetter wrote:
> > Adding dri-devel too, not sure anyone is still listening on linux-fbdev.
>
> I see, thanks!
>
> > On Sun, Oct 18, 2020 at 8:13 PM Peilin Ye <yepeilin.cs@gmail.com> wrote:
> > >
> > > Recently, in commit 6735b4632def ("Fonts: Support FONT_EXTRA_WORDS macros
> > > for built-in fonts"), we wrapped each of our built-in data buffers in a
> > > `font_data` structure, in order to use the following macros on them, see
> > > include/linux/font.h:
> > >
> > >         #define REFCOUNT(fd)    (((int *)(fd))[-1])
> > >         #define FNTSIZE(fd)     (((int *)(fd))[-2])
> > >         #define FNTCHARCNT(fd)  (((int *)(fd))[-3])
> > >         #define FNTSUM(fd)      (((int *)(fd))[-4])
> > >
> > >         #define FONT_EXTRA_WORDS 4
> > >
> > > Do the same thing to our new 6x8 font. For built-in fonts, currently we
> > > only use FNTSIZE(). Since this is only a temporary solution for an
> > > out-of-bounds issue in the framebuffer layer (see commit 5af08640795b
> > > ("fbcon: Fix global-out-of-bounds read in fbcon_get_font()")), all the
> > > three other fields are intentionally set to zero in order to discourage
> > > using these negative-indexing macros.
> > >
> > > Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
> >
> > Patch looks good to me, but it says 1/2 and I can't find 2/2 anywhere,
> > not even on lore. Did that get lost?
>
> 2/2 is just updating the fb documentation:
>
> [PATCH 2/2] docs: fb: Add font_6x8 to available built-in fonts
> https://lore.kernel.org/lkml/717bb41dda8e2ed615f3faadfbc3e215de726d38.1603037079.git.yepeilin.cs@gmail.com/
>
> I did `git format-patch -2 --thread=deep`, did I do something wrong when
> sending it?

No idea, it just didn't arrive anywhere I could find. And I did get
your previous patch series. Maybe just try again with dri-devel
included and hope it works then?
-Daniel

>


--
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
