Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F8A0C433B4
	for <linux-fbdev@archiver.kernel.org>; Thu,  8 Apr 2021 11:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FDCA61139
	for <linux-fbdev@archiver.kernel.org>; Thu,  8 Apr 2021 11:38:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbhDHLif (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 8 Apr 2021 07:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbhDHLie (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 8 Apr 2021 07:38:34 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6523CC061760
        for <linux-fbdev@vger.kernel.org>; Thu,  8 Apr 2021 04:38:21 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id e12so1759635wro.11
        for <linux-fbdev@vger.kernel.org>; Thu, 08 Apr 2021 04:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=HNjO0LstTaF0YJ+tzxAFP4Syvm5fGCE8nxebVcvJLjU=;
        b=eS60djC9Lqi8q7fWOXC+yuTwdoDdp/fK2d8XmHmBdVmsTRb7l+NFwK+960b7+jwa0f
         FmsY22x6AYJ4yv6tWLC7INl0trTXzlztAcd+b0jK6akV35kkzli/s4AEGxnp0E9T3Hzm
         WeCrdaOppkgKGi6FkMG4W1g5pPS3g8Esg94hM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=HNjO0LstTaF0YJ+tzxAFP4Syvm5fGCE8nxebVcvJLjU=;
        b=oJHqvlsCBPz+ujs9mfZrc5lQdDfnACXI+9JMVWEBJRDsooBdWb3bg+hjasHE21C21M
         42OUGB1EeKKyB3lzrij22TIIO1TZia6OSwJK126WH7ifqCDFGECEeTVC5U84UrsXwNTU
         29c06+l1GFsfl9nYaNBNV6g6icF3jvTMBFEgLu/KvrXdAGbLS7Jqt+JYS5ztMLTAKBWB
         Rg1ZNY5msL9aj+Fi0Zz1iCbv398gbwoo7d4/veCHDPxya6WUBUvpM7ZBV99tGwsaIhVQ
         MTQFWOFK4xDj2uEKY84aR6MGnzrfQKFCzw4s84S2k/1GL4X55IO+mGDUOCdqIp+Lg5Gu
         ICbQ==
X-Gm-Message-State: AOAM532tc0aERg6k+IKEbGcGTEfUn0C/JHSjuPW7Kr+8e0wxbPvWGDRS
        H2Hob752uERNeFrhXVy89M3mQQ==
X-Google-Smtp-Source: ABdhPJySG7qOaE9NShNXxHx9QrPK+umWifIaVL7kyUfSfMRMt7h7zvfu4kAyJkMeLpb8wsS1VXGRaA==
X-Received: by 2002:a5d:6d0f:: with SMTP id e15mr9348009wrq.218.1617881900156;
        Thu, 08 Apr 2021 04:38:20 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id n5sm24657875wrp.50.2021.04.08.04.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 04:38:19 -0700 (PDT)
Date:   Thu, 8 Apr 2021 13:38:17 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     David Hildenbrand <david@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Joel Stanley <joel@jms.id.au>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrew Jeffery <andrew@aj.id.au>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Peter Collingbourne <pcc@google.com>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        The etnaviv authors <etnaviv@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>
Subject: Re: [PATCH v1 2/2] drivers/gpu/drm: don't select DMA_CMA or CMA from
 aspeed or etnaviv
Message-ID: <YG7rKfJkTDJorqvY@phenom.ffwll.local>
Mail-Followup-To: Arnd Bergmann <arnd@arndb.de>,
        David Hildenbrand <david@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Joel Stanley <joel@jms.id.au>,
        David Airlie <airlied@linux.ie>, Andrew Jeffery <andrew@aj.id.au>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Peter Collingbourne <pcc@google.com>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        The etnaviv authors <etnaviv@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>
References: <20210408092011.52763-1-david@redhat.com>
 <20210408092011.52763-3-david@redhat.com>
 <CAK8P3a09LdJ-87ZrN28y=t8Sa0zL-3NOvEWhkStMY+2EbO7UAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a09LdJ-87ZrN28y=t8Sa0zL-3NOvEWhkStMY+2EbO7UAw@mail.gmail.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Thu, Apr 08, 2021 at 12:20:50PM +0200, Arnd Bergmann wrote:
> On Thu, Apr 8, 2021 at 11:22 AM David Hildenbrand <david@redhat.com> wrote:
> >
> > Random drivers should not override a user configuration of core knobs
> > (e.g., CONFIG_DMA_CMA=n). Use "imply" instead, to still respect
> > dependencies and manual overrides.
> >
> > "This is similar to "select" as it enforces a lower limit on another
> >  symbol except that the "implied" symbol's value may still be set to n
> >  from a direct dependency or with a visible prompt."
> >
> > Implying DRM_CMA should be sufficient, as that depends on CMA.
> >
> > Note: If this is a real dependency, we should use "depends on DMA_CMA"
> > instead -  but I assume the driver can work without CMA just fine --
> > esp. when we wouldn't have HAVE_DMA_CONTIGUOUS right now.
> 
> 'imply' is almost never the right solution, and it tends to cause more
> problems than it solves.
> 
> In particular, it does not prevent a configuration with 'DRM_CMA=m'
> and 'DRMA_ASPEED_GFX=y', or any build failures from such
> a configuration.
> 
> If you want this kind of soft dependency, you need
> 'depends on DRM_CMA || !DRM_CMA'.

The problem is that depends on is a real pain for users to find their
drivers. This is why we have a ton of select, because the kconfig ui tends
to suck.

If you want to change this, we need automatic conflict resolution like apt
and other package managers have, with suggestions how to fix the config if
you want to enable a driver, but some of its requirements are missing. The
current approach of hiding driver symbols complete if any of their
dependencies are off is really not great.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
