Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2194FC48BCF
	for <linux-fbdev@archiver.kernel.org>; Wed,  9 Jun 2021 10:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CC41608FE
	for <linux-fbdev@archiver.kernel.org>; Wed,  9 Jun 2021 10:39:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238408AbhFIKld (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 9 Jun 2021 06:41:33 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:39701 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239003AbhFIKlc (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 9 Jun 2021 06:41:32 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1McH1O-1lKs6f1wqK-00ckMn for <linux-fbdev@vger.kernel.org>; Wed, 09 Jun
 2021 11:30:17 +0200
Received: by mail-wr1-f44.google.com with SMTP id a11so22812364wrt.13
        for <linux-fbdev@vger.kernel.org>; Wed, 09 Jun 2021 02:30:17 -0700 (PDT)
X-Gm-Message-State: AOAM533lyQ88rRG4B1UxzXa+7ZsghyUc76MYLIoDOsz+VJh11671z/l2
        87h5sdSKf32nbS3GdAS2iPcYBO1ecvVwkdrDdOc=
X-Google-Smtp-Source: ABdhPJzSUnfxZ8LwqKlwrv2bklC04HJaA0aceSDDVOkdulM4vUlC4C4l0QpvA5YJj63Bv3ttsWTULoaeeZe1hMG9qiE=
X-Received: by 2002:a5d:4050:: with SMTP id w16mr27202710wrp.99.1623231017160;
 Wed, 09 Jun 2021 02:30:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210608103833.598348-1-joel@jms.id.au> <CAK8P3a00xuEAKTHrCDw52M-YPJUphSU8bYayW9P_xyNDsTsNzg@mail.gmail.com>
 <3877ae18-dbda-242a-60b2-f73734f8ba03@xs4all.nl>
In-Reply-To: <3877ae18-dbda-242a-60b2-f73734f8ba03@xs4all.nl>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 9 Jun 2021 11:28:24 +0200
X-Gmail-Original-Message-ID: <CAK8P3a18EdBKQdGDOZc9cPKsf=hY8==v2cO0DBE_tyd82Uq-Ng@mail.gmail.com>
Message-ID: <CAK8P3a18EdBKQdGDOZc9cPKsf=hY8==v2cO0DBE_tyd82Uq-Ng@mail.gmail.com>
Subject: Re: [PATCH] ARM: config: Refresh mutli v7
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Joel Stanley <joel@jms.id.au>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:ubJD44owI8GHbnwNBdgHmpqRY0SXVUG2hNKxxV6GkXj7GZvfHmI
 0rudlleekyZwKV6h5E6C3MDIZ9H8QgfHBurZpDPpzYndni6Dy4yqJhtXnlUt81lY508ckdQ
 7GMOYmsWLwQBS0ZiMgY6d+ncn4bu4JQTY+GHUNPDsoMF6UdJrmqxd9XZQGfOtyQINeMl5N3
 4qiLL7VZGuac+b65dbhtQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hPjVuFo0dyY=:Pjps992iAMb029I6l6dH1Z
 YpnscJsL2sQbtgOTutF1TFdgg/nl12ErAS6RxMZq+Q6hCVUEhFtl6390rARSP5hrbwR17ZFMh
 kfNusCxinwYfUMZHi3T7aOQYI6epSV/zuCDVgVsnv/CqMu0hvTuLNNpuiwb4epovWRxPgE26s
 VQdnWy82+g2NTsY6Yhr439XfC9fF6w//xZAr0Quqp2xWDDWsSx5ej+W/C+yAKtjSwXuFqYXFB
 c81o9b0zLvkpnPiHMsvF5yH7VolSw1srhARA1HtHJm1nIkShNnJUl4HwsDSzQW05zmLVGG/og
 j/Oup97Wpblssw8Qt+QAyWNQ1DZoB/aUVb6cDhaIBJzBI17SIf+3bQdV+6UH+3LTjDdGsIwg2
 6F5KwchsIdpJIakRh8SiapyxdAO7XNrC8nvT2JKPFY9UeCKzQHFi50qKLZzoqOYJeEJy1fsXu
 vyoYe4v4NHFhQHyaMU8AwJsgKwJOlbyszVgYtNEYX3dL66fj4bhOrjKtJS70pR5p+oQfie7t4
 hpSeOfeYc3YUUfW0GU1a/M=
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Tue, Jun 8, 2021 at 6:49 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
> On 08/06/2021 18:14, Arnd Bergmann wrote:
>
> Right now it is inherent to the driver. It is probably possible to drop support
> for video overlay devices if CONFIG_FB=n, but it is not something I have time
> for. It's just a test driver (albeit a very useful test driver), so it is no
> big deal if it is disabled when CONFIG_FB=n.

Ok, thanks for the reply, makes sense.

I checked what other consequences there are if we disable CONFIG_FB
and CONFIG_DRM_KMS_FB_HELPER=y in all the defconfigs now,
as the patch from Kees did.

It appears that the only other arm32 framebuffers that remain are
FB_EFI=y, FB_WM8505=y, FB_MX3=m and FB_SIMPLE=y.

On arm64, losing CONFIG_FB=y would disable FB_EFI=y,
XEN_FBDEV_FRONTEND=y, and FB_MX3=m

On x86, it's only CONFIG_FB_EFI

It appears that FB_MX3 is orphaned since commit e1324ece2af4
("ARM: imx: Remove i.MX35 board files") because all Armv6 or
newer i.MX now use drivers/gpu/drm/mxsfb/mxsfb_drv.c, and
FB_WM8505 is probably unused as well (we discussed removing the
platform last winter, but decided to give it another year to see if
new users come up, which has not happened).

As long as simplefb, efifb and xenfb are needed though, we probably
want CONFIG_FB=y anyway and leaving VIVID=m with the dependency
does not cause problems until those are all turned into drm drivers.

      Arnd
