Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B76DC12002
	for <linux-fbdev@archiver.kernel.org>; Wed, 21 Jul 2021 16:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41A2860FF3
	for <linux-fbdev@archiver.kernel.org>; Wed, 21 Jul 2021 16:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbhGUPtu (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 21 Jul 2021 11:49:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:60390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235501AbhGUPt3 (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 21 Jul 2021 11:49:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7678F61242;
        Wed, 21 Jul 2021 16:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626885005;
        bh=/yc+E0kAuhJRP5Rh3EmC/tYRFWNCrNcyKuD79ykVRyg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fyoek8Bqt1r6Z9RyyoyDYkx2SLZbxehZG0+ZpXG+dhtohk48n5YRCHWCTv22aqBpb
         VMNxImCHyu8s0asowGbJhIyevh6mfA3oobRdRne9ttQRpiTNCddxhU3QIX4ROYx8+O
         v8QhFy+YxssLxfvgpqaSkXbL3R/gl4aLnhyDdpKd/As9AuD4wRSa6T5ijR8Qp7STkY
         ICoqkA5i5l7bcW5lVmn+zea1xNvx1w9lKg+DSlCKww2PssF5xpFNQztWbgC7yQ7gzP
         LurS9Y/St4SxcR21Xl3GI/V2/c7OC9UVAIVEGVLg+4PVq3ZcABaPYhX5D9d74MWsQ4
         GJD7fXFFVChsQ==
Received: by mail-ed1-f48.google.com with SMTP id ee25so3145395edb.5;
        Wed, 21 Jul 2021 09:30:05 -0700 (PDT)
X-Gm-Message-State: AOAM5308FcPqmoslHCXpkq6ss6T7Z9LNyI8zRpXPg3zf9+XIRmXT9m4Q
        Xr0QVvnFMIoASPJv7Bi4H2CfyLunVllb9Lhadg==
X-Google-Smtp-Source: ABdhPJzEtVFObrsQpwr41HgLxTFwCfKhI/yLs9CyoCDtGBoAde4UHndoYEelcI1LxE6gOLfzns97J7HSCIC59jQJbZ8=
X-Received: by 2002:aa7:df12:: with SMTP id c18mr49131896edy.62.1626885004024;
 Wed, 21 Jul 2021 09:30:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210721151839.2484245-1-arnd@kernel.org>
In-Reply-To: <20210721151839.2484245-1-arnd@kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 21 Jul 2021 10:29:52 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKu=08VvrkP7hWeW=Sr0oYoDUsEZGKCQmTMgtPc9gxHkg@mail.gmail.com>
Message-ID: <CAL_JsqKu=08VvrkP7hWeW=Sr0oYoDUsEZGKCQmTMgtPc9gxHkg@mail.gmail.com>
Subject: Re: [PATCH] fbdev: simplefb: fix Kconfig dependencies
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Maxime Ripard <maxime@cerno.tech>,
        Arnd Bergmann <arnd@arndb.de>,
        Frank Rowand <frowand.list@gmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, Jul 21, 2021 at 9:18 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> Configurations with both CONFIG_FB_SIMPLE=y and CONFIG_DRM_SIMPLEDRM=m
> are allowed by Kconfig because the 'depends on !DRM_SIMPLEDRM' dependency
> does not disallow FB_SIMPLE as long as SIMPLEDRM is not built-in. This

Double negative. How about:

allows FB_SIMPLE as long as SIMPLEDRM is not built-in.

> can however result in a build failure when cfb_fillrect() etc are then
> also in loadable modules:
>
> x86_64-linux-ld: drivers/video/fbdev/simplefb.o:(.rodata+0x1f8): undefined reference to `cfb_fillrect'
> x86_64-linux-ld: drivers/video/fbdev/simplefb.o:(.rodata+0x200): undefined reference to `cfb_copyarea'
> x86_64-linux-ld: drivers/video/fbdev/simplefb.o:(.rodata+0x208): undefined reference to `cfb_imageblit'
>
> To work around this, change FB_SIMPLE to be a 'tristate' symbol,
> which still allows both to be =m together, but not one of them to
> be =y if the other one is =m. If a distro kernel picks this
> configuration, it can be determined by local policy which of
> the two modules gets loaded. The 'of_chosen' export is needed
> as this is the first loadable module referencing it.
>
> Alternatively, the Kconfig dependency could be changed to
> 'depends on DRM_SIMPLEDRM=n', which would forbid the configuration
> with both drivers.
>
> Fixes: 11e8f5fd223b ("drm: Add simpledrm driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/of/base.c           | 1 +
>  drivers/video/fbdev/Kconfig | 5 +++--
>  2 files changed, 4 insertions(+), 2 deletions(-)

For the DT change:

Acked-by: Rob Herring <robh@kernel.org>
