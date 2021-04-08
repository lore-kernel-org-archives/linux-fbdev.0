Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD39C433ED
	for <linux-fbdev@archiver.kernel.org>; Thu,  8 Apr 2021 11:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D10861154
	for <linux-fbdev@archiver.kernel.org>; Thu,  8 Apr 2021 11:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbhDHLow (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 8 Apr 2021 07:44:52 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:45501 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbhDHLow (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 8 Apr 2021 07:44:52 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MCGag-1lL5Px2EnS-009Q4d; Thu, 08 Apr 2021 13:44:39 +0200
Received: by mail-ot1-f43.google.com with SMTP id g8-20020a9d6c480000b02901b65ca2432cso1968094otq.3;
        Thu, 08 Apr 2021 04:44:39 -0700 (PDT)
X-Gm-Message-State: AOAM532PVEKJCOydP4oD3gqf9/0QX1PB2iJN/lLZDhCWmvSDhFf2USKR
        23FoZiclzWNxirnXf9rgmHD7DHhhWBIGFKt2xM4=
X-Google-Smtp-Source: ABdhPJw/Kt6oueYEiXqyZYSL7pDJ4LuFJYHMs1Y8FL1ZmuGq8xfxN7KNWR6IE58DyzqBWI3T+US+8jsx0JeptqGIBk4=
X-Received: by 2002:a9d:316:: with SMTP id 22mr7135730otv.210.1617882278035;
 Thu, 08 Apr 2021 04:44:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210408092011.52763-1-david@redhat.com> <20210408092011.52763-3-david@redhat.com>
 <CAK8P3a09LdJ-87ZrN28y=t8Sa0zL-3NOvEWhkStMY+2EbO7UAw@mail.gmail.com>
 <cd14d4b4-da82-b21c-2cd6-8e474d97b955@redhat.com> <CAK8P3a0Wg1mGZoBkD_RwMx-jzQNK2krrDxDQV5uhCHoyz-e=dw@mail.gmail.com>
 <7496ac87-9676-1b4e-3444-c2a662ec376b@redhat.com>
In-Reply-To: <7496ac87-9676-1b4e-3444-c2a662ec376b@redhat.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 8 Apr 2021 13:44:22 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1tVwkDbtvKi8atkrg1-CfoQHGrXLCzn_uo+=dfZJfdQA@mail.gmail.com>
Message-ID: <CAK8P3a1tVwkDbtvKi8atkrg1-CfoQHGrXLCzn_uo+=dfZJfdQA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] drivers/gpu/drm: don't select DMA_CMA or CMA from
 aspeed or etnaviv
To:     David Hildenbrand <david@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:MOWjxzUM/juLxZVwoDmvgjbj1GMzi9SdTRgf5tDlGz7krnsVOLt
 1Z1WcCI0BOKgmu8eCsvSTCIrLBZx4t6agx3x7VgJYOwAI+NPAtBeNtbFDAcNI4/v6FE9IUx
 JBK+ZGNcu7sCreU+ajo+q/7DPpDgLGbkZk4GCnWY7pLJ+vyjpbthaXuHbugcAzoS5PT3HOi
 fXBQOrWGH6a6gIZ7wXh2A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FUKfpKU5/WU=:zOKSjAjtGSgC+Yja8Db356
 D2PuQypz6UegVxYfSX0xarOyj8i+7QYIwzi0uJN47jjvsA3EQ81m2WosCxvpKJ+JTKSUofmua
 F4/F2CVlZfravPwCG8j8tTSaGaO5Cjx1ni6EO88x7PCus0pceDuDUEAyjRZ+DwyuAHsqUoCoR
 UM/Pn3wx6Mf6DvmD49eHPYoespAgksSJFg/yjA7ETOAqXZGYmzOKCdh4/r1e98c5RzNuY+Ice
 mdc0U9faKK8XJtN3MyeeCIrOdaloHSIhbnVAjgFnifQKPZTQEniVfwA/twuDQRBRl0qs03LRH
 9dRvohVo3W0SFioMhxysfSg0NsZgeKAtjxRR+11FBMEtYqyiveuLAcEvYmdk1/kNXujnhLbLo
 mDS7WJNFHrXqeXlxP9thl567kk2C3zGX2Pwiwh6qYhUhZv8bKwjwxLc3tqBU7pXYoIc/1yUJ/
 6IxyfxPPaHOopn19js2zdVjuBd17CUDe8ht5DjG5Yms9Xjt2Yh5XcIB8aL0PgbpsAWfBz9xQy
 LGQPkJSSYyMS2MvKINwxb6qq+tl/qzA/A3av/v7S/gyR/z290ceF4HVMNoHQbDXAYHVKwN4Py
 XL7Bube7z68KzL5aGT4lihP+MZMFX3p5LV
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Thu, Apr 8, 2021 at 1:00 PM David Hildenbrand <david@redhat.com> wrote:
> >
> > It is a somewhat awkward way to say "prevent this symbol from
> > being =y if the dependency is =m".
>
> What would be the right thing to do in the case here then to achieve the
> "if DRMA_ASPEED_GFX is enabled, also enable DMA_CMA id possible"?
>
> One approach could be to have for DMA_CMA
>
> default y if DRMA_ASPEED_GFX
>
> but it feels like the wrong way to tackle this.

I'm still not sure what you are trying to achieve. Is the idea only to provide
a useful default for DMA_CMA depending on which drivers are enabled?

This is something you could do using a hidden helper symbol like

config DRMA_ASPEED_GFX
       bool "Aspeed display driver"
       select DRM_WANT_CMA

config DRM_WANT_CMA
       bool
       help
          Select this from any driver that benefits from CMA being enabled

config DMA_CMA
       bool "Use CMA helpers for DRM"
       default DRM_WANT_CMA

         Arnd
