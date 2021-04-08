Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E5CC433B4
	for <linux-fbdev@archiver.kernel.org>; Thu,  8 Apr 2021 10:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88C7861164
	for <linux-fbdev@archiver.kernel.org>; Thu,  8 Apr 2021 10:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbhDHKVW (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 8 Apr 2021 06:21:22 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:60941 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhDHKVU (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 8 Apr 2021 06:21:20 -0400
Received: from mail-oi1-f169.google.com ([209.85.167.169]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MQdpG-1lFWE61c3C-00Nj76; Thu, 08 Apr 2021 12:21:08 +0200
Received: by mail-oi1-f169.google.com with SMTP id i81so1626652oif.6;
        Thu, 08 Apr 2021 03:21:08 -0700 (PDT)
X-Gm-Message-State: AOAM530sxuF05PDzT2jBOo8M3i32n8pLJVhYSCLGHVlZwWmzFIxsyOgu
        dNiMGjq03FgkfiZH3DknYTLX/D52Qg6jKSjzCnM=
X-Google-Smtp-Source: ABdhPJy3jeKTxPcNwfngsbvoonksh80soCCHxiz4gKJ4G+0Fm3IstMzm5ZSVa0dFJZ+2JUBZ8yF1Sx9mjNQUOlISLnU=
X-Received: by 2002:a05:6808:3d9:: with SMTP id o25mr5654228oie.4.1617877267082;
 Thu, 08 Apr 2021 03:21:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210408092011.52763-1-david@redhat.com> <20210408092011.52763-3-david@redhat.com>
In-Reply-To: <20210408092011.52763-3-david@redhat.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 8 Apr 2021 12:20:50 +0200
X-Gmail-Original-Message-ID: <CAK8P3a09LdJ-87ZrN28y=t8Sa0zL-3NOvEWhkStMY+2EbO7UAw@mail.gmail.com>
Message-ID: <CAK8P3a09LdJ-87ZrN28y=t8Sa0zL-3NOvEWhkStMY+2EbO7UAw@mail.gmail.com>
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
X-Provags-ID: V03:K1:HYWuExe01cF59zwb7JFXEVWaI54v42eJ6tJQybH8gWFDHJxeBaC
 loL5xqMuS4QapORYDUtQIowlQjAz1wBbhLbigSUsH7gdX06+xx8dYPIrRUefUs4E18xhccd
 siCnxPqx3br3xy5SxDCES1JOPH+CPxLWbi7H3JdQEmMrnAQqJSBy6TaZVP2tCza2UaFgKEr
 NeCaqDyf4S3pbaerotdpA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7kdEQ9WMOGE=:ludBy7ITFhUJW/Tf2bRp7J
 UgYmiM9UzaGV6JgHN48Udsf6ozTMG+ohcgyhy0UXCVf4NWM2j/XdhPdcMj8f1bDQg7ohvl4AA
 DU2tzHUhQMA4Egj5JKwEVppz1BuMc6pzHmiMBPQKbiRrj3N0TghDkav3cpsPEkoLN210A62MM
 cYf5h1cAtR34rtLe1h+VGJiSCwOtjAyG1rtdNLaNrob5EKC+Tu5rFq4StWb+dudTFGcuo9w6U
 HrWhOG+moSMVqquib4IG3nhwM2/W71Wvn3Bo3yKR8GlGt5yQP97HpOrf8j5fqqwq/5tV5WrIC
 7hTK5uqPL1oZKA0EmX0wGV806hyFL4n+x0BChnhyoVlE6f8Ln5IXx54Qgy7So3BBWMMSFLbJI
 G90jn4Q1qmB5NwchaN8/JtyvndbhuEvjGj8l3C1KBrrReBtQvfqHAHGD4lDP12qt3p52aCeVA
 DeroMFGxUcAPOMV1ZUH6pfmoTfBCIc8ZoYDnro+gEu8s5iE00yuPzHqUi/SMFUB1pbZW2sw96
 GvgapO+jocqevyRsM1tgmRtk8Dxym8qbzpyN+qD0UG6yrb6VxmCabJuGM5/oIZGeKk5760eiv
 5h1MiIqWlVHythk+mXyRcz5aTpr4mARlkf
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Thu, Apr 8, 2021 at 11:22 AM David Hildenbrand <david@redhat.com> wrote:
>
> Random drivers should not override a user configuration of core knobs
> (e.g., CONFIG_DMA_CMA=n). Use "imply" instead, to still respect
> dependencies and manual overrides.
>
> "This is similar to "select" as it enforces a lower limit on another
>  symbol except that the "implied" symbol's value may still be set to n
>  from a direct dependency or with a visible prompt."
>
> Implying DRM_CMA should be sufficient, as that depends on CMA.
>
> Note: If this is a real dependency, we should use "depends on DMA_CMA"
> instead -  but I assume the driver can work without CMA just fine --
> esp. when we wouldn't have HAVE_DMA_CONTIGUOUS right now.

'imply' is almost never the right solution, and it tends to cause more
problems than it solves.

In particular, it does not prevent a configuration with 'DRM_CMA=m'
and 'DRMA_ASPEED_GFX=y', or any build failures from such
a configuration.

If you want this kind of soft dependency, you need
'depends on DRM_CMA || !DRM_CMA'.

         Arnd
