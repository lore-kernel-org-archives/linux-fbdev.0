Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5483C433B4
	for <linux-fbdev@archiver.kernel.org>; Thu,  8 Apr 2021 13:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A126610CB
	for <linux-fbdev@archiver.kernel.org>; Thu,  8 Apr 2021 13:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbhDHNTu (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 8 Apr 2021 09:19:50 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:35519 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbhDHNTu (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 8 Apr 2021 09:19:50 -0400
Received: from mail-oi1-f177.google.com ([209.85.167.177]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MdeKd-1m3YL2141x-00ZfPn; Thu, 08 Apr 2021 15:19:37 +0200
Received: by mail-oi1-f177.google.com with SMTP id x2so2135702oiv.2;
        Thu, 08 Apr 2021 06:19:36 -0700 (PDT)
X-Gm-Message-State: AOAM5325plcV8cW0pNg1cEVA/yI0jN6GcHvkfWjBhgNShnI/Ix5ZQdMb
        EDc0i2+YgF2AKDsmVBAavTmt7L/1TqqLnnMriuo=
X-Google-Smtp-Source: ABdhPJzHb7t36K8Eh3/YW98i9jFFwt105TSLCljFkAhUwPloRFuMsDPsNoXrOsOYqi1vkp97GaHnIbSFi7HvVPlRimE=
X-Received: by 2002:a05:6808:313:: with SMTP id i19mr5867255oie.67.1617887975911;
 Thu, 08 Apr 2021 06:19:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210408092011.52763-1-david@redhat.com> <20210408092011.52763-3-david@redhat.com>
 <CAK8P3a09LdJ-87ZrN28y=t8Sa0zL-3NOvEWhkStMY+2EbO7UAw@mail.gmail.com>
 <cd14d4b4-da82-b21c-2cd6-8e474d97b955@redhat.com> <CAK8P3a0Wg1mGZoBkD_RwMx-jzQNK2krrDxDQV5uhCHoyz-e=dw@mail.gmail.com>
 <7496ac87-9676-1b4e-3444-c2a662ec376b@redhat.com> <CAK8P3a1tVwkDbtvKi8atkrg1-CfoQHGrXLCzn_uo+=dfZJfdQA@mail.gmail.com>
 <3a2d64a7-8425-8daf-17ee-95b9f0c635f9@redhat.com> <CACRpkdYizKGhtYzE+22oZAduLNCOGP9Vbp=LQbXG1C-a+MyMcg@mail.gmail.com>
In-Reply-To: <CACRpkdYizKGhtYzE+22oZAduLNCOGP9Vbp=LQbXG1C-a+MyMcg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 8 Apr 2021 15:19:19 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2Wu7tT-YajfdXSSVvg5MYMEnEy3APJ83DcLeJdGkkSrQ@mail.gmail.com>
Message-ID: <CAK8P3a2Wu7tT-YajfdXSSVvg5MYMEnEy3APJ83DcLeJdGkkSrQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] drivers/gpu/drm: don't select DMA_CMA or CMA from
 aspeed or etnaviv
To:     Linus Walleij <linus.walleij@linaro.org>
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
X-Provags-ID: V03:K1:9Bi1GcZUabLvLIcpGf703kW71as+Zj0GIqb+tueq5ZGRzccsQbH
 QPSOV/f5P+7HU9/8riwOK4l+oMn93qaNiGvkKQsuw6gg+DVeNDJWn9VldXZEBTWhhSawOuv
 4b5wQeJGl38TcLxoRO40zrplN7LjQOWx2TRhQmxF9Y8cA2zLTLbmRPuVUbcu4nRn3wB8eWX
 dd8SY6Kz51dqe8Celk2Pw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MXnR8ADf6+g=:w0F9nTQidogO6icGFYdtXN
 3zMpmydVLLrQ5o7Z2jOT0gusfoeol0NoCM5KPVI4vMp6eJDk4IxSBSKeSAc93oThWJX1l2gEV
 4pNmCxDf6lw6Z5ADvdvId7hqigkqRrjgSrRSsD3Y8JSCibJDBKBugNJm4HeWuxOdW07+tpuW4
 VA3d93DrSD+vJ+O25whCrCUiTTEHAq4WFLqJjkkaDQgRmFN1G6M4+UHMlYEe/86CPFYDcBMSe
 yYS1LTH4gMxGSrEOmDWr2wT65ShIQSJ/3voyt5UhqxvhTnZ7Evo1R6N6NAAfZDpjzJ65JaGQc
 c2ABMzSN5HJqbeqVYw0f5W7Cu6ATus/Y77pJCeMQG6vO48l7tzTfk76lIh9YvOgc1XfsZY7rb
 0O8r5hkQPfk6/De0yWZwjSHe5s1wBnuLl3x82l7STN3ZoJ6L+ff99VdSd+oq54RUuELehh1Fu
 lSE7Nse/TpmReRASE6g/aNGdd47eSME=
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Thu, Apr 8, 2021 at 2:50 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Thu, Apr 8, 2021 at 2:01 PM David Hildenbrand <david@redhat.com> wrote:
>
> > > This is something you could do using a hidden helper symbol like
> > >
> > > config DRMA_ASPEED_GFX
> > >         bool "Aspeed display driver"
> > >         select DRM_WANT_CMA
> > >
> > > config DRM_WANT_CMA
> > >         bool
> > >         help
> > >            Select this from any driver that benefits from CMA being enabled
> > >
> > > config DMA_CMA
> > >         bool "Use CMA helpers for DRM"
> > >         default DRM_WANT_CMA
> > >
> > >           Arnd
> > >
> >
> > That's precisely what I had first, with an additional "WANT_CMA" --  but
> > looking at the number of such existing options (I was able to spot 1 !)
>
> If you do this it probably makes sense to fix a few other drivers
> Kconfig in the process. It's not just a problem with your driver.
> "my" drivers:
>
> drivers/gpu/drm/mcde/Kconfig
> drivers/gpu/drm/pl111/Kconfig
> drivers/gpu/drm/tve200/Kconfig
>
> certainly needs this as well, and pretty much anything that is
> selecting DRM_KMS_CMA_HELPER or
> DRM_GEM_CMA_HELPER "wants" DMA_CMA.

Are there any that don't select either of the helpers and
still want CMA? If not, it would be easy to just add

   default  DRM_KMS_CMA_HELPER || DRM_GEM_CMA_HELPER

and skipt the extra symbol.

        Arnd
