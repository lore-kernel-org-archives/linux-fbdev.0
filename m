Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F30C433ED
	for <linux-fbdev@archiver.kernel.org>; Thu,  8 Apr 2021 20:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A45BB61159
	for <linux-fbdev@archiver.kernel.org>; Thu,  8 Apr 2021 20:29:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbhDHU3r (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 8 Apr 2021 16:29:47 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:36493 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbhDHU3r (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 8 Apr 2021 16:29:47 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MN5S1-1lBYKG1VzB-00J4Sz; Thu, 08 Apr 2021 22:29:33 +0200
Received: by mail-ot1-f52.google.com with SMTP id s16-20020a0568301490b02901b83efc84a0so3565046otq.10;
        Thu, 08 Apr 2021 13:29:33 -0700 (PDT)
X-Gm-Message-State: AOAM533IzKuF6xVPdGPXgaJ7d9hCS2usV+irVM3gy6KKTf9iL1J8S5mx
        2SKJHagcAFjDp9gEb0Q3LJna/pICxMjoOcw0F+w=
X-Google-Smtp-Source: ABdhPJyfPECLeLOF/Bs3NvQ2GDzKFAUyLZwtkCfbxO3pPqunDWbqv1JOjJ/RM4Y98JdJ7lIhjCGjr/ZYV8r3IjuTvvw=
X-Received: by 2002:a05:6830:148c:: with SMTP id s12mr9613770otq.251.1617913771943;
 Thu, 08 Apr 2021 13:29:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210408092011.52763-1-david@redhat.com> <20210408092011.52763-3-david@redhat.com>
 <CAK8P3a09LdJ-87ZrN28y=t8Sa0zL-3NOvEWhkStMY+2EbO7UAw@mail.gmail.com>
 <cd14d4b4-da82-b21c-2cd6-8e474d97b955@redhat.com> <CAK8P3a0Wg1mGZoBkD_RwMx-jzQNK2krrDxDQV5uhCHoyz-e=dw@mail.gmail.com>
 <7496ac87-9676-1b4e-3444-c2a662ec376b@redhat.com> <CAK8P3a1tVwkDbtvKi8atkrg1-CfoQHGrXLCzn_uo+=dfZJfdQA@mail.gmail.com>
 <3a2d64a7-8425-8daf-17ee-95b9f0c635f9@redhat.com> <CACRpkdYizKGhtYzE+22oZAduLNCOGP9Vbp=LQbXG1C-a+MyMcg@mail.gmail.com>
 <2ef3b65c-c0ef-7bbe-0e05-39ee8f2bae48@redhat.com>
In-Reply-To: <2ef3b65c-c0ef-7bbe-0e05-39ee8f2bae48@redhat.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 8 Apr 2021 22:29:15 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3sqZBo8-zye1yiZuD2uMUr0oE_q_QfaK9K54TEgd1Cdw@mail.gmail.com>
Message-ID: <CAK8P3a3sqZBo8-zye1yiZuD2uMUr0oE_q_QfaK9K54TEgd1Cdw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] drivers/gpu/drm: don't select DMA_CMA or CMA from
 aspeed or etnaviv
To:     David Hildenbrand <david@redhat.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
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
X-Provags-ID: V03:K1:fqqdWmjqgGPSFQNtx2u/McZyT6vettSJXcSMUXMdN/UJ3fO/C9u
 C3+w9mdOt4mQnuWGysw7m9929aavPF/zq24mhsaz2oIdLqqZAN+M4e0Zm2WDlTAKavRVS2r
 HgcKqJyA+81sEB8853g3CkXCGiRlfiC+d+BYheY5MqvkUnu2OSnjt1LkIBf5VufAplnCJC/
 m2jMqllwW93M91BydfUAw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:H0Ecz/ctCws=:qA7hK+RyuDUndr+rW+7SpC
 DrvfkzNbjln6bwVh2BFZOQ5zGhpOdm0w/9CgQIyihWtoTzGR2SKHpYTlvRglIQbGptkSNDsKN
 lNb/FrfLV4f4pa8/5pTpJLi/0ROAf2fSVm00bSz1mcuEx67y8xOaoQFr3D8pS/3YaViLRiEBd
 gjMQ5zfMYS1NsYo7FQRQbmC40qcDC3MIaR2GMOYQ6ul+bTjbT3x8nQp9ovv2Ekmj7pDBq8yl3
 mw/+WmTIMA3rTW3g65eMfSf3Kh1AgetiYeXMgPjr1EIvgHtaWBDhZEgpBS0K0lfdTnL/0aVGE
 WHLds0K1ft0DKzj+ErTb0M0UB84yPiuW64AzgiQdvhmb3H1FlFMudUfvZjOHiE7J6KkCk2FIz
 15u5J+j5DKPkSMYdIjR5vxSZ0X/w5bxb8PuWrSmV3GnhWd2t6OqDQH6KnE8c70K9f2UtsO/Vp
 BVDKVGenTrGxUuhwoxwydw2toaSzPKWDcEhQeuaCU9qDuCNRnze3A1MVAE+961Z5B9jT78W9T
 klxz/D1Zv9MeMgDqhNgkTVoNgXr5zPnEKecBo2fT/p3wbgYFpZQzEY6borHx35QVjbSfptgmK
 5mh8dZ7yAJj4YZAN+lUGTJBMgm1bfoTa+Y
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Thu, Apr 8, 2021 at 6:45 PM David Hildenbrand <david@redhat.com> wrote:
> On 08.04.21 14:49, Linus Walleij wrote:
> > On Thu, Apr 8, 2021 at 2:01 PM David Hildenbrand <david@redhat.com> wrote:
> >
> >>> This is something you could do using a hidden helper symbol like
> >>>
> >>> config DRMA_ASPEED_GFX
> >>>          bool "Aspeed display driver"
> >>>          select DRM_WANT_CMA
> >>>
> >>> config DRM_WANT_CMA
> >>>          bool
> >>>          help
> >>>             Select this from any driver that benefits from CMA being enabled
> >>>
> >>> config DMA_CMA
> >>>          bool "Use CMA helpers for DRM"
> >>>          default DRM_WANT_CMA
> >>>
> >>>            Arnd
> >>>
> >>
> >> That's precisely what I had first, with an additional "WANT_CMA" --  but
> >> looking at the number of such existing options (I was able to spot 1 !)
> >
> > If you do this it probably makes sense to fix a few other drivers
> > Kconfig in the process. It's not just a problem with your driver.
> > "my" drivers:
> >
>
> :) I actually wanted to convert them to "depends on DMA_CMA" but ran
> into recursive dependencies ...
>
> > drivers/gpu/drm/mcde/Kconfig
> > drivers/gpu/drm/pl111/Kconfig
> > drivers/gpu/drm/tve200/Kconfig

Right, this is the main problem caused by using 'select' to
force-enable symbols that other drivers depend on.

Usually, the answer is to be consistent about the use of 'select'
and 'depends on', using the former only to enable symbols that
are hidden, while using 'depends on' for anything that is an
actual build time dependency.

> I was assuming these are "real" dependencies. Will it also work without
> DMA_CMA?

I think in this case, it is fairly likely to work without DMA_CMA when the
probe function gets called during a fresh boot, but fairly likely to fail if
it gets called after the system has run for long enough to fragment the
free memory.

The point of DMA_CMA is to make it work reliably.

      Arnd
