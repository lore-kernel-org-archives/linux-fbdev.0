Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC3C7C433B4
	for <linux-fbdev@archiver.kernel.org>; Fri,  9 Apr 2021 12:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC28461106
	for <linux-fbdev@archiver.kernel.org>; Fri,  9 Apr 2021 12:36:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233470AbhDIMgT (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 9 Apr 2021 08:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233108AbhDIMgS (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Fri, 9 Apr 2021 08:36:18 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7A2C061762
        for <linux-fbdev@vger.kernel.org>; Fri,  9 Apr 2021 05:36:05 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id s17so6257166ljc.5
        for <linux-fbdev@vger.kernel.org>; Fri, 09 Apr 2021 05:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tg6sgY5o6KJ5S57CRLT5oBYc675XGvjvO0a75IDhy4M=;
        b=tD/+WsHQQWYusIiNpWcK7bwWVSNKlMLnyRF8CoJ3CZhMIHxMdvtXVATkH2bY6CsvV6
         4EeqLJcMu8Lx6dXjIGijM9Z71Ysw7FoPhIt4pVwzFK6l7vQQG0p8gmVQcZtmvl5D6mmc
         vnQ4vXPZDk4T7ERYAIs5HJIK9/rMwsb/PGlIkgHlPxrLJNQV9qOSD2eFT+qGhgN9rW/v
         i+5TnZ7zezyrlf0LjEA3nkURPCbcKV3D0THgJHWfMYiU94A6/Dnr2CLqYXHUaZSeUV9C
         jYnvEDTnSyDvM2CCXvtBaB8N7OxfbX9Umv48J+Clvg4cWNbqEuv5MYIvFfkzoLNaHZdC
         sk4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tg6sgY5o6KJ5S57CRLT5oBYc675XGvjvO0a75IDhy4M=;
        b=OZQZM+d+MnJSotMw8KnG3kb2bUkejGIPRc3GiUrEJEOjoDdzBwtAzHThurJrWgMtGy
         4LRQgX4K4qvhM3illUa4qaQzVG6R9+86cyksBJ2W48glCFozrFt0YxvHIo3xnx3QP0xG
         z7nad1AdeeSaa241ciiYQ210HkOClKTO0w258nzRjA7UOLQCMpwKtHugMo5fk3yD4Kio
         I5IEoIY4CcEcg2TsMq07EWuyLlsWUb+OEgBQRjtoA9nhVYijivcPEWQMqNebnjlzgOMV
         3s/45Wzucvybz6vHJuwOZlu6hpJQKC/VTaDSh2qCBjONfXNtrrLxR7l7YaJpBvmjrbra
         fdNQ==
X-Gm-Message-State: AOAM532U5YkqW2R6+NSYz3b6BypbJDPpsaGmCVCh5Gjr4J9ZqkhmHRfQ
        5T7ZWjvJsEWjs9jrzhWOm+JWdfmpJfbUQBx8VLtfFQ==
X-Google-Smtp-Source: ABdhPJxh1RNVQiQp5bCHRakekzyhAZR4aqS7papfBzgGL0DdgK61i7YYHDZZLT+jLT3UuH+d/zlCtwSkkzSHByUlUhw=
X-Received: by 2002:a2e:1649:: with SMTP id 9mr9682701ljw.74.1617971763963;
 Fri, 09 Apr 2021 05:36:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210409112035.27221-1-david@redhat.com>
In-Reply-To: <20210409112035.27221-1-david@redhat.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 9 Apr 2021 14:35:52 +0200
Message-ID: <CACRpkdb_eQrcCFV9Q9uho8E6HO4X0dRJp1qAdJBcT82=sZ1v7A@mail.gmail.com>
Subject: Re: [PATCH v3] drivers: introduce and use WANT_DMA_CMA for soft
 dependencies on DMA_CMA
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Eric Anholt <eric@anholt.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Peter Collingbourne <pcc@google.com>,
        Suman Anna <s-anna@ti.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        The etnaviv authors <etnaviv@lists.freedesktop.org>,
        linux-mips@vger.kernel.org,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Fri, Apr 9, 2021 at 1:20 PM David Hildenbrand <david@redhat.com> wrote:

> Random drivers should not override a user configuration of core knobs
> (e.g., CONFIG_DMA_CMA=n). Applicable drivers would like to use DMA_CMA,
> which depends on CMA, if possible; however, these drivers also have to
> tolerate if DMA_CMA is not available/functioning, for example, if no CMA
> area for DMA_CMA use has been setup via "cma=X". In the worst case, the
> driver cannot do it's job properly in some configurations.

Looks good to me. At least a lot better than what we have.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

> Let's see if this approach is better for soft dependencies (and if we
> actually have some hard dependencies in there). This is the follow-up
> of
>   https://lkml.kernel.org/r/20210408092011.52763-1-david@redhat.com
>   https://lkml.kernel.org/r/20210408100523.63356-1-david@redhat.com

You can just add these to the commit message with Link:
when applying so people can easily find the discussion from the
commit.

> I was wondering if it would make sense in some drivers to warn if either
> CONFIG_DMA_CMA is not available or if DRM_CMA has not been configured
> properly - just to give people a heads up that something might more likely
> go wrong; that would, however, be future work.

I think the frameworks  (DRM_*_CMA_HELPER)
should pr_info something about it so the individual drivers
don't have to sanity check their entire world.

Yours,
Linus Walleij
