Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63CDBC433B4
	for <linux-fbdev@archiver.kernel.org>; Thu,  8 Apr 2021 09:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FB0B610FA
	for <linux-fbdev@archiver.kernel.org>; Thu,  8 Apr 2021 09:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhDHJ40 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 8 Apr 2021 05:56:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:37298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231308AbhDHJ4Z (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 8 Apr 2021 05:56:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BF61761157;
        Thu,  8 Apr 2021 09:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617875774;
        bh=qJxRS7vx1sXE6xcXQMcJdpuIhDNb8doWc5nvVib8CKg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KZ/oVYIMYnAgYH6QJVktZeIA6/aSYiWme3mBgwnkCxayRdrH5xziAm66YyvKrRth7
         7v9gmEr4vet9wOPetc8R4/QVlcGIuJddziUeRsFMPVcGZa22P9mvPmv43q1B6aD+Js
         Z0e/fme4iIuOE27WCM3w3jK+/81p4DNorwJ+lgUEckK3vbax8fc4dOwWS9QFQ50bHB
         QomrNySbhnrnJqtGC3+M/ApvRrBBJ3ceKHuJulDCYWyiIvtQy3nj4mRUzMnqnyL+hH
         vDqGLXtnBvDVuKNFVaO2Flj0rH/To18bMy5Xeu6DijPGj4p0ZU4/aKk0Y4ceO01yyY
         OTrdegR9Enwbw==
Date:   Thu, 8 Apr 2021 12:56:02 +0300
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
Subject: Re: [PATCH v1 1/2] drivers/video/fbdev: don't select DMA_CMA
Message-ID: <YG7TMt0cgGucCPUX@kernel.org>
References: <20210408092011.52763-1-david@redhat.com>
 <20210408092011.52763-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408092011.52763-2-david@redhat.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Thu, Apr 08, 2021 at 11:20:10AM +0200, David Hildenbrand wrote:
> Random drivers should not override a user configuration of core knobs
> (e.g., CONFIG_DMA_CMA=n). Use "imply" instead, to still respect
> dependencies and manual overrides.
> 
> "This is similar to "select" as it enforces a lower limit on another
>  symbol except that the "implied" symbol's value may still be set to n
>  from a direct dependency or with a visible prompt."
> 
> Implying DRM_CMA should be sufficient, as that depends on CMA.

	  ^ DMA_CMA ?

> Note: If this is a real dependency, we should use "depends on DMA_CMA"
> instead -  but I assume the driver can work without CMA just fine --
> esp. when we wouldn't have HAVE_DMA_CONTIGUOUS or CMA right now.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  drivers/video/fbdev/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
> index 4f02db65dede..d37cd5341e1b 100644
> --- a/drivers/video/fbdev/Kconfig
> +++ b/drivers/video/fbdev/Kconfig
> @@ -2186,7 +2186,7 @@ config FB_HYPERV
>  	select FB_CFB_COPYAREA
>  	select FB_CFB_IMAGEBLIT
>  	select FB_DEFERRED_IO
> -	select DMA_CMA if HAVE_DMA_CONTIGUOUS && CMA
> +	imply DMA_CMA
>  	help
>  	  This framebuffer driver supports Microsoft Hyper-V Synthetic Video.
>  
> -- 
> 2.30.2
> 

-- 
Sincerely yours,
Mike.
