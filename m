Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB074C433ED
	for <linux-fbdev@archiver.kernel.org>; Thu,  8 Apr 2021 10:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9080061176
	for <linux-fbdev@archiver.kernel.org>; Thu,  8 Apr 2021 10:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbhDHKRX (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 8 Apr 2021 06:17:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:37654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229686AbhDHKRW (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 8 Apr 2021 06:17:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9B02961168;
        Thu,  8 Apr 2021 10:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617877031;
        bh=ivICCofV+HelFF0TfxwG+thYyuD+sKqQrEHToDgsMAA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UNNx+EGN0stAmujBkpKG7B+a3LZ9QOfURYpggW8gdYq7xt5P1gLMLgwM1dC5MpZ1P
         X7O4uDbSKKlPnIU+8/Y6gRxg4fPUuzhIsu8w6Fwb8B4xVKXHz8CvWH4QrtvBFITSEV
         Sxnv93leCr2IDHcwq6kptb/L86gB1Q+cqPtKBLHQ//heoRdly7V3dD/x0CXRA503pn
         1M5OyO5KbAozxLmR9Dpq5Oefs1XuUJn5xBFlPTXTgFi1TPnK0/r/Y/ZRa7Exep2Gdn
         1zCmFnWIMn66t09SBdrHP7u2VGOwHIiutu2GPaNpPda2430uojqFF+YO6UXZrmbRAJ
         /5bajopeTFScQ==
Date:   Thu, 8 Apr 2021 13:16:59 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Joel Stanley <joel@jms.id.au>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrew Jeffery <andrew@aj.id.au>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Peter Collingbourne <pcc@google.com>,
        linux-aspeed@lists.ozlabs.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        etnaviv@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v2 0/2] drivers: don't select DMA_CMA or CMA
Message-ID: <YG7YGxN83VxtKAeo@kernel.org>
References: <20210408100523.63356-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408100523.63356-1-david@redhat.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Thu, Apr 08, 2021 at 12:05:21PM +0200, David Hildenbrand wrote:
> Trying to set CONFIG_CMA=y with CONFIG_DMA_CMA=n revealed that we have
> three drivers that select these options. Random drivers should not
> override user settings of such core knobs. Let's use "imply DMA_CMA"
> instead, such that user configuration and dependencies are respected.
> 
> v1 -> v2:
> - Fix DRM_CMA -> DMA_CMA
> 
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Andrew Jeffery <andrew@aj.id.au>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Russell King <linux+etnaviv@armlinux.org.uk>
> Cc: Christian Gmeiner <christian.gmeiner@gmail.com>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Peter Collingbourne <pcc@google.com>
> Cc: linux-aspeed@lists.ozlabs.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: etnaviv@lists.freedesktop.org
> Cc: linux-fbdev@vger.kernel.org
> 
> David Hildenbrand (2):
>   drivers/video/fbdev: don't select DMA_CMA
>   drivers/gpu/drm: don't select DMA_CMA or CMA from aspeed or etnaviv
> 
>  drivers/gpu/drm/aspeed/Kconfig  | 3 +--
>  drivers/gpu/drm/etnaviv/Kconfig | 3 +--
>  drivers/video/fbdev/Kconfig     | 2 +-
>  3 files changed, 3 insertions(+), 5 deletions(-)

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

> -- 
> 2.30.2
> 

-- 
Sincerely yours,
Mike.
