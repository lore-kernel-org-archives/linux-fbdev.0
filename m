Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4935C433EF
	for <linux-fbdev@archiver.kernel.org>; Wed, 27 Oct 2021 13:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA3CE60E76
	for <linux-fbdev@archiver.kernel.org>; Wed, 27 Oct 2021 13:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237566AbhJ0Nvm (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 27 Oct 2021 09:51:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:33776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231458AbhJ0Nvl (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 27 Oct 2021 09:51:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 69AB960E74;
        Wed, 27 Oct 2021 13:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635342556;
        bh=fYZWrsKGlOp7lc/xKrJeyNzK/8u8cgiGUJ+/2sKfEe4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=U77fnHxIIXJm4+qiC90pNvz1GrZM8catxUQG7co8cVjv+UYRYVBKwCeKgPPwHViuj
         xoJ27M5dFmNBhFvyMPli6fYHsUydemysyTGE9Ebf0eWT8F2Ulk9F04sK1UnFnlhiJF
         0vm6HcrSv3i8ETCP2piQNWl+EDlH3FTJ1cAzruc0ybYXacPFwluwmr2EdnzUyJ+Iep
         +SOUOC4U5ZF59ELZ475X7m09U5PLF/OnvDVfcHidoo8TzjjHp+FUfWWfgMQ007IbRo
         b5gi4tQFssHjeeHLKRHrH2Yns7c+HmBmUHKYMHTx4ccmilVI/ycU+QmygFQ9Kvxseo
         FxFxqsIBUdY9A==
Received: by mail-wr1-f44.google.com with SMTP id g7so3222305wrb.2;
        Wed, 27 Oct 2021 06:49:16 -0700 (PDT)
X-Gm-Message-State: AOAM531HAkaFUXR3s1IJhODxmY28mhlcwa8vj1Et1/y202pyOxJn35Xr
        Qy3ahsRhFw2OYtCtA9hHfPGVUgtWfH4AonQ0MK8=
X-Google-Smtp-Source: ABdhPJwyFrogSswX9aFMchaesz3OloZkKeoRK58xGE8J8a1euHLGUsdWENXaWPhRgbPktw6Hq/mkQOMklICoHioJnp4=
X-Received: by 2002:a5d:4692:: with SMTP id u18mr210674wrq.428.1635342554955;
 Wed, 27 Oct 2021 06:49:14 -0700 (PDT)
MIME-Version: 1.0
References: <20211027132732.3993279-1-arnd@kernel.org> <20211027132732.3993279-3-arnd@kernel.org>
 <87r1c6h9ek.fsf@intel.com>
In-Reply-To: <87r1c6h9ek.fsf@intel.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 27 Oct 2021 15:48:59 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0Lcwb4mROKt-sZHYFfCF2ji-dAbpWyy5_f7v6SHnzpjQ@mail.gmail.com>
Message-ID: <CAK8P3a0Lcwb4mROKt-sZHYFfCF2ji-dAbpWyy5_f7v6SHnzpjQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] [v2] i915: fix backlight configuration issue
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Matthew Auld <matthew.auld@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, Oct 27, 2021 at 3:41 PM Jani Nikula <jani.nikula@linux.intel.com> wrote:
> > @@ -16,10 +18,6 @@ config DRM_I915
> >       select IRQ_WORK
> >       # i915 depends on ACPI_VIDEO when ACPI is enabled
> >       # but for select to work, need to select ACPI_VIDEO's dependencies, ick
>
> The comment needs updating as well.

Right, I've removed that comment now.

> Other than that,
>
> Acked-by: Jani Nikula <jani.nikula@intel.com>
>
> on the series.

Thanks!

         Arnd
