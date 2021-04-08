Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F56C433ED
	for <linux-fbdev@archiver.kernel.org>; Thu,  8 Apr 2021 10:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBAEB61006
	for <linux-fbdev@archiver.kernel.org>; Thu,  8 Apr 2021 10:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbhDHKpQ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 8 Apr 2021 06:45:16 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:42449 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhDHKpP (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 8 Apr 2021 06:45:15 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MZTVu-1l6kMj0BHi-00WYhw; Thu, 08 Apr 2021 12:45:03 +0200
Received: by mail-wm1-f53.google.com with SMTP id n11-20020a05600c4f8bb029010e5cf86347so3793931wmq.1;
        Thu, 08 Apr 2021 03:45:02 -0700 (PDT)
X-Gm-Message-State: AOAM532U5DmibPh5axgL06iKWCJDxcQM065UjrxcNOQs6UVtqhBfYMTK
        I4eN57J54/L8hQgd75IY/BgJxXQnSZ6owHhCfrA=
X-Google-Smtp-Source: ABdhPJytz/lV77i5o3bCVeCx28eGBRpFGJa3HAhceDBuu8+SNlIqf7YyHBd9MAcXBsV7ViVqwijCZWLATsW/w+YkaWY=
X-Received: by 2002:a1c:4c0c:: with SMTP id z12mr7558571wmf.38.1617878702742;
 Thu, 08 Apr 2021 03:45:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210408092011.52763-1-david@redhat.com> <20210408092011.52763-3-david@redhat.com>
 <CAK8P3a09LdJ-87ZrN28y=t8Sa0zL-3NOvEWhkStMY+2EbO7UAw@mail.gmail.com> <cd14d4b4-da82-b21c-2cd6-8e474d97b955@redhat.com>
In-Reply-To: <cd14d4b4-da82-b21c-2cd6-8e474d97b955@redhat.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 8 Apr 2021 12:44:46 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0Wg1mGZoBkD_RwMx-jzQNK2krrDxDQV5uhCHoyz-e=dw@mail.gmail.com>
Message-ID: <CAK8P3a0Wg1mGZoBkD_RwMx-jzQNK2krrDxDQV5uhCHoyz-e=dw@mail.gmail.com>
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
X-Provags-ID: V03:K1:01bNjQRf0DYjZTk/3T6t8Ul/ByuLNZHbaYNUKAIkE/wUn0iS+nJ
 r+h1hTknz6RnJwK+4yvsSTTMDMfP0wL/SBleBUgrfq8H2feG3qdKiYvzS8OVk72H7KQScSR
 knajtXwvzME3w0XfFP0a/6Wd30DjfL/sgcg7Bf7y7ZaQXKCU4GVJL2zM8mqHXzPWrBP2UHe
 10Efb4EJhESAXIRtFm2Zw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aDTbPNUdFEo=:vhAsJPTvzcLggZm9K/4Tpl
 htY+I+Iu8AdJIb0v4563U2egO7I4kONwaespbZfWaJXeQWBb+fVkWGntATwNxaDywY24u4S3F
 94wUCL6AZJz0UEEHJm8NQeMUCts0nLcS73G0AUpXicJ9ovYIG1CQDXmqwLgkIOAxmsiEtFR6I
 ULAL3i9ElfeRXPsX1QFTuDb0gmpskonTu6j+cpupC+3EoSedZWz3ERUyCwyzlpBBa67zwOqJL
 KJ8x8miIl2o+cagsDe+3/iV7Y7SbCHne4zTfjmxDRarhU4OMIZBoNGUfCouWNQ/c9bvvVZ4nb
 Y/srdzXinqVQGwisicSq7/fOhhcyCC5F9isVUG1OQ28VA+HSgI4HhM2ov6XmRXTnwwNCXWsNZ
 Z+F4fMpsEOKMZope86rm/lIdg/JGRqWNEPHjw8tXgCh+eNkdIoVkJ0nqdhWSoxRT97T+fPvln
 R5kuG+6wD0SkwOuMaBYimNtIYZ3GFF7Yt/Wgt8pewIjWrSBdpeIkkhpmGW5Vnk7H7g7/PdKA0
 qlPWufSxFXKY/CCB2WSl6Y6xsMryR6lSxzD8BctnF1OwB1l0xAR0074Knkm1Bpy8JPWoylhgE
 XXZnWjddIwV59gB0NeRvEsVNvLZJPK1T63
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Thu, Apr 8, 2021 at 12:29 PM David Hildenbrand <david@redhat.com> wrote:
> On 08.04.21 12:20, Arnd Bergmann wrote:
> > On Thu, Apr 8, 2021 at 11:22 AM David Hildenbrand <david@redhat.com> wrote:
> >>
> >> Random drivers should not override a user configuration of core knobs
> >> (e.g., CONFIG_DMA_CMA=n). Use "imply" instead, to still respect
> >> dependencies and manual overrides.
> >>
> >> "This is similar to "select" as it enforces a lower limit on another
> >>   symbol except that the "implied" symbol's value may still be set to n
> >>   from a direct dependency or with a visible prompt."
> >>
> >> Implying DRM_CMA should be sufficient, as that depends on CMA.
> >>
> >> Note: If this is a real dependency, we should use "depends on DMA_CMA"
> >> instead -  but I assume the driver can work without CMA just fine --
> >> esp. when we wouldn't have HAVE_DMA_CONTIGUOUS right now.
> >
> > 'imply' is almost never the right solution, and it tends to cause more
> > problems than it solves.
>
> I thought that was the case with "select" :)

Yes, but that's a different set of problems

> >
> > In particular, it does not prevent a configuration with 'DRM_CMA=m'
>
> I assume you meant "DRM_CMA=n" ? DRM_CMA cannot be built as a module.

Ok, at least that makes it easier.

> > and 'DRMA_ASPEED_GFX=y', or any build failures from such
> > a configuration.
>
> I don't follow. "DRM_CMA=n" and 'DRMA_ASPEED_GFX=y' is supposed to work
> just fine (e.g., without HAVE_DMA_CONTIGUOUS) or what am I missing?

I thought you were trying to solve the problem where DRMA_ASPEED_GFX
can optionally link against CMA but would fail to build when the CMA code
is in a loadable module.

If the problem you are trying to solve is a different one, you need a different
solution, not what I posted above.

> > If you want this kind of soft dependency, you need
> > 'depends on DRM_CMA || !DRM_CMA'.
>
> Seriously? I think the point of imply is "please enable if possible and
> not prevented by someone else".

That used to be the meaning, but it changed a few years ago. Now
it means "when a used manually turns on this symbol, turn on the
implied one as well, but let them turn it off again if they choose".

This is pretty much a NOP.

> Your example looks more like a NOP - no?
> Or will it have the same effect?

The example I gave is only meaningful if both are tristate, which is
not the case here as you explain.

It is a somewhat awkward way to say "prevent this symbol from
being =y if the dependency is =m".

      Arnd
