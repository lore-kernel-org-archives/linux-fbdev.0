Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03DC8C433ED
	for <linux-fbdev@archiver.kernel.org>; Thu,  8 Apr 2021 12:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD68861105
	for <linux-fbdev@archiver.kernel.org>; Thu,  8 Apr 2021 12:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbhDHMuQ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 8 Apr 2021 08:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbhDHMuQ (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 8 Apr 2021 08:50:16 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6563C061761
        for <linux-fbdev@vger.kernel.org>; Thu,  8 Apr 2021 05:50:04 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 184so2099678ljf.9
        for <linux-fbdev@vger.kernel.org>; Thu, 08 Apr 2021 05:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ue62b/nOsWagddlxWSHgZE+xJ7jpEp33uT3hApzk61s=;
        b=vvSgQJ10J71/hJsIWwLP3XbsOekOzbhwMvBACn4AWfAGleRLrUNzHNNK5uzeLyioMB
         oXIl0KjQfY0cc+zIdEytIHzN42/OjUgsVSyQzPNF7LHyemG4aoQzWGjp1kQcgyP994UF
         PBZBxmSiF5r5UO7u4g9kPbjUHVxyNNgYMU5Knd5mi7CHQ+mjXkXFxyyxdoyhMqiKcHh7
         KD6xoCCNSIaQ7e7UvoyagNDB6CPkDalEXBqyL+CK5Z+carCsx1vQWABrVJ+/Y/1Z2juI
         00Ab6erVT5dMmK0+1wheunsMvAYIodPt4qdrCvcG+ZzapbmUF0rbOlXfcBEE0hLDekJq
         R2NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ue62b/nOsWagddlxWSHgZE+xJ7jpEp33uT3hApzk61s=;
        b=V7MdfsJ4L29cZGuHSrn0i2LYiR3UA9woTdA5BJBwxiIuS61BZAh0wxSKgWIM+Ngj8L
         1HbmkrZZJjhMlZZr9Ks7r4MTxOOZRFtX/MUm/ukbj0T2TtYbCeM48Ejk9wdJPDecesry
         ZVuJybawez5TAxnTDKQ97fsDkGCM88wYMRXBKIhOeEFDxghEdE/w1nvPpaWqNhWgMLny
         pRbjJCmTdFQV+Kq5vBlzThEPtEspPcQ+W9riszcAjDLFylhao4Bicy3LlMz5BJLu6cJq
         DH8doXD6HCu9uUDkB4KG/UBzKPrI2qAX/hdMVORtd9xXR/6AX2z0voxlJ2KAWIFV7ccQ
         Zxpw==
X-Gm-Message-State: AOAM530WMrI14mZ77vW8lMlWwvqaXCzMLVl9caHlY9wTDhrqQbN5UAU5
        yB//eHsyhcagcRGnv6LeI9shiHA0SrG1Ngngi6yEZA==
X-Google-Smtp-Source: ABdhPJzHwP6BmbIRqU1HYc3FQkCjshHvviqMY3IIos9nhT5ENCEad5QCJ7O5xWMp2CMbQh00KOeiYn4d7d9pP/p57KM=
X-Received: by 2002:a2e:7001:: with SMTP id l1mr5550860ljc.200.1617886202537;
 Thu, 08 Apr 2021 05:50:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210408092011.52763-1-david@redhat.com> <20210408092011.52763-3-david@redhat.com>
 <CAK8P3a09LdJ-87ZrN28y=t8Sa0zL-3NOvEWhkStMY+2EbO7UAw@mail.gmail.com>
 <cd14d4b4-da82-b21c-2cd6-8e474d97b955@redhat.com> <CAK8P3a0Wg1mGZoBkD_RwMx-jzQNK2krrDxDQV5uhCHoyz-e=dw@mail.gmail.com>
 <7496ac87-9676-1b4e-3444-c2a662ec376b@redhat.com> <CAK8P3a1tVwkDbtvKi8atkrg1-CfoQHGrXLCzn_uo+=dfZJfdQA@mail.gmail.com>
 <3a2d64a7-8425-8daf-17ee-95b9f0c635f9@redhat.com>
In-Reply-To: <3a2d64a7-8425-8daf-17ee-95b9f0c635f9@redhat.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 8 Apr 2021 14:49:51 +0200
Message-ID: <CACRpkdYizKGhtYzE+22oZAduLNCOGP9Vbp=LQbXG1C-a+MyMcg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] drivers/gpu/drm: don't select DMA_CMA or CMA from
 aspeed or etnaviv
To:     David Hildenbrand <david@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
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
        Michal Simek <michal.simek@xilinx.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Peter Collingbourne <pcc@google.com>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        The etnaviv authors <etnaviv@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Thu, Apr 8, 2021 at 2:01 PM David Hildenbrand <david@redhat.com> wrote:

> > This is something you could do using a hidden helper symbol like
> >
> > config DRMA_ASPEED_GFX
> >         bool "Aspeed display driver"
> >         select DRM_WANT_CMA
> >
> > config DRM_WANT_CMA
> >         bool
> >         help
> >            Select this from any driver that benefits from CMA being enabled
> >
> > config DMA_CMA
> >         bool "Use CMA helpers for DRM"
> >         default DRM_WANT_CMA
> >
> >           Arnd
> >
>
> That's precisely what I had first, with an additional "WANT_CMA" --  but
> looking at the number of such existing options (I was able to spot 1 !)

If you do this it probably makes sense to fix a few other drivers
Kconfig in the process. It's not just a problem with your driver.
"my" drivers:

drivers/gpu/drm/mcde/Kconfig
drivers/gpu/drm/pl111/Kconfig
drivers/gpu/drm/tve200/Kconfig

certainly needs this as well, and pretty much anything that is
selecting DRM_KMS_CMA_HELPER or
DRM_GEM_CMA_HELPER "wants" DMA_CMA.

Yours,
Linus Walleij
