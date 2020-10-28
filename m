Return-Path: <SRS0=wnYw=ED=vger.kernel.org=linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66691C388F7
	for <linux-fbdev@archiver.kernel.org>; Wed, 28 Oct 2020 23:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1911C20724
	for <linux-fbdev@archiver.kernel.org>; Wed, 28 Oct 2020 23:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n5x+LUX2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgJ1XmV (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 28 Oct 2020 19:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbgJ1XmR (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 28 Oct 2020 19:42:17 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D654BC0613CF;
        Wed, 28 Oct 2020 16:42:16 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id t20so637838qvv.8;
        Wed, 28 Oct 2020 16:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Q2w0GJP+O24zlClsx6Zd9yJQfOlv+kG1yF/TN+Wun14=;
        b=n5x+LUX2iOSa9A1Ozlkg4pr/k5hWJnKWLWekiVdEHyz16IbWcYLK5XhIxltZ7k4Wp3
         vJ6VwZsa2HTmIvjsJbsOaDp8NwxAvELwDzeav6QYQqDfAy7YbNqfa3GrdkRWSfitq1bQ
         JKnm1rC6ubNYvLGylAs8E9v3WRC8dQfrQcUBDi9+m5W2wNEc5WBTFBbZAw1SrNAyQiR0
         985XTzcK7/EGV279NJLpxcy5w2l1x+MFZCueGBlsGvcDAZ3Q/of1Qk2NYPRKkEGnS7CG
         EuOurqQcrXotkY7o+MOGAYUOJtgDlvHXMyCzwZbnwjp6S7+3kQYi7xhqWAynaSWXp0no
         l2sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q2w0GJP+O24zlClsx6Zd9yJQfOlv+kG1yF/TN+Wun14=;
        b=ogftfustdUPHXLYZxJZdyViHiGa5uLoB7xGA9iYaXVmDA++Vtl3jkPHT7m3r8F/4rp
         Gu5gKJio7nhmLxvb3ukVnjvKeZctFzkQ0Sr25IIRH4pVi2jCjkgMOTyfNLX66lPyBIQz
         p+YNI2vh7iz8E2VC71kBQj2XXBAUzozSoh+bDEAo9ecEuoOIPCeXs8dyCUV+0DoTx6Q3
         I3FziC6Ji9gKyOZz4w+ah4LX3a0aGWgCFRhBdRBOpHnbcC/3Eh8cybEXpwwcs5s2oHnv
         3NuQ8qCCKPCz9k3t5/maL8cNJdQYA3zEYf6hwfF7ozy7S6GP1xo5KWrWnRLyWP9Cv8ko
         L7Mw==
X-Gm-Message-State: AOAM5325d3V1Ornz5cVyQs01M+u+zdgi0S+jy9utwYhCO050thf2q0/b
        9BMn/KG+W9IuK0tXHUnnMymUSWTw8EPa
X-Google-Smtp-Source: ABdhPJyKmvi+wrim6ggQx3fuKG0hwNY5mHGUXX+rZcx02E6mWjNckXz9MyfFa4GcSkcckzQuBqpKtw==
X-Received: by 2002:a62:b515:0:b029:155:95e8:fbed with SMTP id y21-20020a62b5150000b029015595e8fbedmr6479066pfe.49.1603881064332;
        Wed, 28 Oct 2020 03:31:04 -0700 (PDT)
Received: from PWN (n11212042025.netvigator.com. [112.120.42.25])
        by smtp.gmail.com with ESMTPSA id il17sm4149183pjb.39.2020.10.28.03.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 03:31:03 -0700 (PDT)
Date:   Wed, 28 Oct 2020 06:30:50 -0400
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-parisc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] Fonts: Make font size unsigned in font_desc
Message-ID: <20201028103050.GA1209391@PWN>
References: <cover.1603788511.git.yepeilin.cs@gmail.com>
 <cb5bb49a33ff54fef41e719ee9d301a6a73c5f9c.1603788512.git.yepeilin.cs@gmail.com>
 <54f7d42e07eca2a2f13669575a9de88023ebc1ac.1603788512.git.yepeilin.cs@gmail.com>
 <20201027185058.GM401619@phenom.ffwll.local>
 <20201028054307.GA1205568@PWN>
 <20201028081844.GS401619@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028081844.GS401619@phenom.ffwll.local>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, Oct 28, 2020 at 09:18:44AM +0100, Daniel Vetter wrote:
> On Wed, Oct 28, 2020 at 01:43:07AM -0400, Peilin Ye wrote:
> > On Tue, Oct 27, 2020 at 07:50:58PM +0100, Daniel Vetter wrote:
> > > On Tue, Oct 27, 2020 at 12:33:05PM -0400, Peilin Ye wrote:
> > > > It is improper to define `width` and `height` as signed in `struct
> > > > font_desc`. Make them unsigned. Also, change the corresponding printk()
> > > > format identifiers from `%d` to `%u`, in sti_select_fbfont().
> > > > 
> > > > Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
> > > 
> > > I'm not entirely sure of the motivation here ... height/width should never
> > > ever be even close to the limit here. Or have you seen integer math that
> > > could potentially go wrong if we go with unsigned instead of int?
> > 
> > Oh... No, I have not. I just thought we shouldn't represent a length
> > using a signed value. Also, width and height in console_font are
> > unsigned int - that shouldn't matter that much though.
> 
> Oh this is actually a good reason, since that's the uapi structure. And so
> using the exact same signedness should help a bit with accidental casting
> bugs.
> 
> If you mention this in the commit message I think this is good to go.

Ah, I see, v2 on the way. Please ignore [v2 3/5], that doesn't hunk with
this patch in effect...

One newbie question, should I mention in the commit message, if a patch
depends on another patch in the series in order to hunk properly?

Peilin

