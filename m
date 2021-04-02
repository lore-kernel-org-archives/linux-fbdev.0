Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D23C43460
	for <linux-fbdev@archiver.kernel.org>; Fri,  2 Apr 2021 08:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 816BB61104
	for <linux-fbdev@archiver.kernel.org>; Fri,  2 Apr 2021 08:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233894AbhDBI5H (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 2 Apr 2021 04:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbhDBI5F (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Fri, 2 Apr 2021 04:57:05 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AF7C0613E6
        for <linux-fbdev@vger.kernel.org>; Fri,  2 Apr 2021 01:57:03 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id d8-20020a1c1d080000b029010f15546281so4015411wmd.4
        for <linux-fbdev@vger.kernel.org>; Fri, 02 Apr 2021 01:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=S7ce0Vxpg2sR3Lixx6Rl5vj4I10NemweROF9R1wsVX4=;
        b=YsObxn3+33f0x47mw+a2YdWHzIAq5V3WcbiNe7j7zNPdwdnowgW+oxga2m7hqNvI+B
         7rU41kLGQlBEYigBn89HOt0+v80Cmajma8pI6iY347QTK9XQdFbKIoDO/vrvQoJLpHqO
         obXkXNg6VuOLbLbqHSaOpl1pdPXVN8P2YmOQysruh8fNhO/vCv3HnxA5xiu0NPu9/aG/
         fMD1paRHHJg4uHgZj2hvLNSlbizzZpRH2Ec+uz6klP56c4BzTIwQCvlYOAkgC7s7xoRd
         mlLBMWwaqxEOMZ+lH6qZVGj74qd9ehpoTcmROC5A968tecDYHLrm+ea8CwkghCMr10AT
         8f0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S7ce0Vxpg2sR3Lixx6Rl5vj4I10NemweROF9R1wsVX4=;
        b=YE1IndypglgPhER5NXjzLNIKKLklFK+ORCDmb3CyqigmoJ2fjePdYyvQbvy6oEAo3w
         IDjkllF/2mHa9+37LByM5o32yNeRnyc2OU+jArRsX7v92EPcX38XHecWEJ8HrFpk4QKn
         NulfOiYOFHIeoHtAtKC0GmgsJ7OLGIR1mAzNd0OA3BhkfzWpCBosxZ6FDqkBMcar4ADp
         W81zpApwn1mnd3VH3kQVBOyNm/8CCy/H5sKaeMBIPRSRVrK5z1L50aVG8tvRgdB7fEn+
         /BHc+fo9g1/iI5F5CDPVEsdJ7GNlycTXDhh6HOKk9q7QA4Zh66ipyF4D4ekWgDMU4vgA
         jnqg==
X-Gm-Message-State: AOAM532NJj3SUdAD5yaHMeqYvhYr2JwJqrWTh8DNS3HNIJ3JqxvadQDP
        98W1a4GI+74qF6hToQw/elT4EA==
X-Google-Smtp-Source: ABdhPJyubigy03RcapzbnkfaAKQTZy3/TqkRV465izj294G5yfa90DXKok09jfrNBuiR9P3XMwdkZw==
X-Received: by 2002:a1c:3d46:: with SMTP id k67mr11724458wma.188.1617353822549;
        Fri, 02 Apr 2021 01:57:02 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id h8sm13874239wrt.94.2021.04.02.01.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 01:57:02 -0700 (PDT)
Date:   Fri, 2 Apr 2021 09:57:00 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] zero-fill colormap in drivers/video/fbdev/core/fbcmap.c
Message-ID: <YGbcXMfP5pbCkG/9@equinox>
References: <20210331220719.1499743-1-phil@philpotter.co.uk>
 <CAMuHMdVh9JPZKphSi5+KR+BMJL7cQpVifrPBzhR3ees8QBhBXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVh9JPZKphSi5+KR+BMJL7cQpVifrPBzhR3ees8QBhBXw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Thu, Apr 01, 2021 at 11:55:50AM +0200, Geert Uytterhoeven wrote:
> On Thu, Apr 1, 2021 at 12:09 AM Phillip Potter <phil@philpotter.co.uk> wrote:
> > Use kzalloc() rather than kmalloc() for the dynamically allocated parts
> > of the colormap in fb_alloc_cmap_gfp, to prevent a leak of random kernel
> > data to userspace under certain circumstances.
> >
> > Fixes a KMSAN-found infoleak bug reported by syzbot at:
> > https://syzkaller.appspot.com/bug?id=741578659feabd108ad9e06696f0c1f2e69c4b6e
> >
> > Reported-by: syzbot+47fa9c9c648b765305b9@syzkaller.appspotmail.com
> > Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
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

Dear Geert

Thank you for your review :-)

Regards,
Phil
