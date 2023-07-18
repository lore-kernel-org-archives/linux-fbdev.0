Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A78EEB64DA
	for <linux-fbdev@archiver.kernel.org>; Tue, 18 Jul 2023 13:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbjGRNdq (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 18 Jul 2023 09:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232757AbjGRNdo (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 18 Jul 2023 09:33:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B7CE5;
        Tue, 18 Jul 2023 06:33:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 345526158A;
        Tue, 18 Jul 2023 13:33:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF596C433C8;
        Tue, 18 Jul 2023 13:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689687222;
        bh=/gnZG6o0DMnotHgfldqGvalM6a/Vulwkk2wHnxMrZAA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=upk/z28T72VgEyaJkNGdvIrsytrYpric58NXQB6VYUVRyy3OcNMqBWEtVf4ZIsT04
         46s9mJsM3Ox9Mg6EJqNjwVJqwnJfiQWrUisHJ82lvg9rJh/9MzFuZZkBapJHUcy8Zl
         0MJdaybC9IRqWDbu3/WTtODTkXY/jyp0H69miUmY=
Date:   Tue, 18 Jul 2023 15:33:35 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Raphael Gallais-Pou <rgallaispou@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2] staging: fbtft: ili9341: use macro
 FBTFT_REGISTER_SPI_DRIVER
Message-ID: <2023071817-enslave-unlovable-f8ae@gregkh>
References: <20230718081759.28902-1-rgallaispou@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718081759.28902-1-rgallaispou@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Tue, Jul 18, 2023 at 10:17:59AM +0200, Raphael Gallais-Pou wrote:
> Using FBTFT_REGISTER_DRIVER resolves to a NULL struct spi_device_id. This
> ultimately causes a warning when the module probes. Fixes it.
> 
> Changes in v2:
> 	- dropped MODULE_ALIAS changes
> 	- changed commit log for more accurate description
> 
> Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
> ---
>  drivers/staging/fbtft/fb_ili9341.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Why is this a resend?

And the changes need to go below the --- line as per the documentation.

thanks,

greg k-h
