Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82441C43460
	for <linux-fbdev@archiver.kernel.org>; Fri, 21 May 2021 12:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62B146101B
	for <linux-fbdev@archiver.kernel.org>; Fri, 21 May 2021 12:55:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbhEUM4u (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 21 May 2021 08:56:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:36520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231795AbhEUMzk (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 21 May 2021 08:55:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E10FD60FEE;
        Fri, 21 May 2021 12:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621601657;
        bh=BD4wTuQPIxItsa6Cujs6ISBIpsLi0+lXyF4Ny/3AnN0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h6mSH0CxaEQFEayJFhlghOdEOUn/drwHIUEZG/gmy7wtc08bf6cD/G1e8oGdhM3bQ
         BfruQqYo0eYcbeK0KroOJ/uSb3MX3X9I6uLtPrHv7PcbD6T3c5ux1RsOwlgOD7KKna
         C40sfd6rnnoORKhtPXGkfpoqYroMSI1wVIo6fDb4=
Date:   Fri, 21 May 2021 14:54:13 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Ferenc Bakonyi <fero@drama.obuda.kando.hu>,
        Igor Matheus Andrade Torrente <igormtorrente@gmail.com>,
        linux-nvidia@lists.surfsouth.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] hgafb: fix probe function
Message-ID: <YKetdZTqjOUPQXS8@kroah.com>
References: <YKIuWEcIJvTIuE2j@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKIuWEcIJvTIuE2j@mwanda>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Mon, May 17, 2021 at 11:50:32AM +0300, Dan Carpenter wrote:
> There is a reversed if statement in this probe function so the driver is
> completely broken.
> 
> Fixes: dc13cac4862c ("video: hgafb: fix potential NULL pointer dereference")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/video/fbdev/hgafb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/hgafb.c b/drivers/video/fbdev/hgafb.c
> index cc8e62ae93f6..bd3d07aa4f0e 100644
> --- a/drivers/video/fbdev/hgafb.c
> +++ b/drivers/video/fbdev/hgafb.c
> @@ -558,7 +558,7 @@ static int hgafb_probe(struct platform_device *pdev)
>  	int ret;
>  
>  	ret = hga_card_detect();
> -	if (!ret)
> +	if (ret)
>  		return ret;
>  
>  	printk(KERN_INFO "hgafb: %s with %ldK of memory detected.\n",
> -- 
> 2.30.2
> 

Someone _just_ beat you to this:
	https://lore.kernel.org/r/20210516192714.25823-1-mail@anirudhrb.com

I'll add your s-o-b to that one as it's identical to yours.

thanks,

greg k-h

