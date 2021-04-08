Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C198C433ED
	for <linux-fbdev@archiver.kernel.org>; Thu,  8 Apr 2021 12:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31D2B61107
	for <linux-fbdev@archiver.kernel.org>; Thu,  8 Apr 2021 12:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbhDHMNE (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 8 Apr 2021 08:13:04 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:54669 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbhDHMND (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 8 Apr 2021 08:13:03 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MpD7H-1lvWIO0k4F-00qgzI; Thu, 08 Apr 2021 14:12:51 +0200
Received: by mail-ot1-f51.google.com with SMTP id y19-20020a0568301d93b02901b9f88a238eso2007403oti.11;
        Thu, 08 Apr 2021 05:12:50 -0700 (PDT)
X-Gm-Message-State: AOAM533aQ5x2KJXqDZ4QIKID1luXPLRkW+oLSy1Gzf8ZUrad1i6ySbHB
        ufTeJn2FORdxmaa+3UyWrrpy67VYPvwhS1VrEEo=
X-Google-Smtp-Source: ABdhPJxHyCWMenVUxv33s1E6jvbsFFZTfTMiy2a27GKmZ/Mw2GJW7+vO9jPST57wudsWVl6e6VoT2RKQT0t6kEAsZEE=
X-Received: by 2002:a9d:316:: with SMTP id 22mr7238748otv.210.1617883969787;
 Thu, 08 Apr 2021 05:12:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210408092011.52763-1-david@redhat.com> <20210408092011.52763-3-david@redhat.com>
 <CAK8P3a09LdJ-87ZrN28y=t8Sa0zL-3NOvEWhkStMY+2EbO7UAw@mail.gmail.com>
 <cd14d4b4-da82-b21c-2cd6-8e474d97b955@redhat.com> <CAK8P3a0Wg1mGZoBkD_RwMx-jzQNK2krrDxDQV5uhCHoyz-e=dw@mail.gmail.com>
 <7496ac87-9676-1b4e-3444-c2a662ec376b@redhat.com> <CAK8P3a1tVwkDbtvKi8atkrg1-CfoQHGrXLCzn_uo+=dfZJfdQA@mail.gmail.com>
 <3a2d64a7-8425-8daf-17ee-95b9f0c635f9@redhat.com>
In-Reply-To: <3a2d64a7-8425-8daf-17ee-95b9f0c635f9@redhat.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 8 Apr 2021 14:12:33 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3v2aY3CNLED5NkONJ6bS74WgLu=KCTwr1pKjnAmDeSjw@mail.gmail.com>
Message-ID: <CAK8P3a3v2aY3CNLED5NkONJ6bS74WgLu=KCTwr1pKjnAmDeSjw@mail.gmail.com>
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
X-Provags-ID: V03:K1:Fhq6otmHI4POdFwHt6AOwgyAZRigRhN6pYbDOSuC4J1om7dvrxN
 5Ja69gop/zE0tH6oGXFj2WuiEReiKVTdhjARmeZqehRikmeHB1KRTCWyAzVLPZwVHqmj4Jx
 6aeO7SDSa6Y9EBsqax8EYS9n8MB67Gl2tRVMhvRKM+Bdy5fkBBIW72BtVuwevJh6orrXC2/
 PWGIsjYCGxliLoXtNqRjg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:v1yEok7Aps8=:oJGvh1r5lWw1xJfdrq+xlr
 Ht9WHwiKNTWEOBrNy/4Bgan/MFdgbYC5OvRhWjdWFE8NWDfmSvAsJT0pdJF3P/eVwu2FApR67
 4YCuSWZp2QV7APeU1Tqqej/hmGOQ+1TTef8YZQbVU9tVdq1TC6N8iwQQe74z/6EjKJJXcZJZz
 81opv8h8QXywWH8nwCVSDi4BFruWpXuK15bVajIssq//NO0WmnQsDuCT9l86UxzF3UPnZNbQx
 z8ecfWzUimGTm33Xh7b2GpKEKSSnjbvWTl1NKGOrWMBJN12JzGSS1dk7GSNMGsZw81PYj1i/5
 NXslN3720iOd/Qg8/A9UQw0QknFagfOI4FMIlzI/fAfnkeW8LBLi3owHrPz4PDoVjWBXetNDd
 FS7Uai+RV5dsFQSoUbMxyCAx9C0SNi6h3snLzp6ii88+ePyuDjDN8HNm9Qfon4t29xz1GtMo2
 1JRBjAzZPks5cebUx+uOwaJYUzlTqnTxg2uMAhp93SPzLhOUky1+nMgP2DtyHLA2Ywt5hrKge
 ABKjLB2RnIGpsEev7X0TWm+jpwFGfgKMwpUmU/t22vn89iLI/5upVlGcILlCaMjuCGklDmav9
 FoIuKO9SXBk3Et8Rj8wEXzbiymI3/iX3wm
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Thu, Apr 8, 2021 at 2:00 PM David Hildenbrand <david@redhat.com> wrote:
>
> On 08.04.21 13:44, Arnd Bergmann wrote:
> > On Thu, Apr 8, 2021 at 1:00 PM David Hildenbrand <david@redhat.com> wrote:
> >>>
> >>> It is a somewhat awkward way to say "prevent this symbol from
> >>> being =y if the dependency is =m".
> >>
> >> What would be the right thing to do in the case here then to achieve the
> >> "if DRMA_ASPEED_GFX is enabled, also enable DMA_CMA id possible"?
> >>
> >> One approach could be to have for DMA_CMA
> >>
> >> default y if DRMA_ASPEED_GFX
> >>
> >> but it feels like the wrong way to tackle this.
> >
> > I'm still not sure what you are trying to achieve. Is the idea only to provide
> > a useful default for DMA_CMA depending on which drivers are enabled?
>
> "Random drivers should not override a user configuration of core knobs
> (e.g., CONFIG_DMA_CMA=n)."
>
> Let's assume I'm a distribution and want to set CONFIG_CMA=n or want to
> set CONFIG_DMA_CMA=n with CONFIG_CMA=y; there is no way to do that with
> e.g., DRMA_ASPEED_GFX=y because it will always override my (user!)
> setting -- even though it doesn't really always need it. Using "select"
> is the problem here.

I agree on the part of removing the 'select' if we don't need it. The
part I couldn't figure out was what the 'imply' is supposed to help with.
Most other users that added imply tried (and failed) to fix a build problem.

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
> I wondered if there is a better approach to achieve the same; "imply"
> sounded like a good candidate.

I can probably find a couple more, but regardless of how many others
exist, this would be a much clearer way of doing it than 'imply' since it
has none of the ambiguity and misuse problems.

I think the reason we don't see more is that generally speaking, those
defaults are widely ignored anyway. You almost always start out with
a defconfig file that contains everything you know you need, and then
you add bits to that. Having the default in any form only helps to
make that defconfig file one line shorter, while requiring other users
to add another line to turn it off when they do not want it.

         Arnd
