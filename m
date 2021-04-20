Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9227BC433B4
	for <linux-fbdev@archiver.kernel.org>; Tue, 20 Apr 2021 07:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51DEF61154
	for <linux-fbdev@archiver.kernel.org>; Tue, 20 Apr 2021 07:19:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhDTHTu (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 20 Apr 2021 03:19:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:56298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230227AbhDTHTt (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 20 Apr 2021 03:19:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3DD2F60C40;
        Tue, 20 Apr 2021 07:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618903158;
        bh=pktyu9GGKjTObq0rU5/41yUklfwS8kQ21/mqPt8V+QM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hP5I0a8Z6H63iP4GVjgKXs6PS4lmyGeoOI68kBxEG36thouvMInr+buISN7xUY51c
         z03bn/K0dn21GscboQv7l7voWkHt6cw6RQeOwQEVmo8FxRzOyYnpOTMbd8DiMd384D
         wbytYch/wqtQ04/LADGgGHxXABWN3eAW3h6c+jDs=
Date:   Tue, 20 Apr 2021 09:19:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] video: fbdev: sm501fb:  Fix deallocation of buffers order
Message-ID: <YH6AdPxOE8d51pXy@kroah.com>
References: <20210406233519.2205389-1-pakki001@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406233519.2205389-1-pakki001@umn.edu>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Tue, Apr 06, 2021 at 06:35:17PM -0500, Aditya Pakki wrote:
> The resource release in sm501fb_remove() is not in the inverse order of
> sm501fb_probe(), for the buffers. Release the info object after
> deallocating the buffers.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---
>  drivers/video/fbdev/sm501fb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/sm501fb.c b/drivers/video/fbdev/sm501fb.c
> index 6a52eba64559..4c32c9e88850 100644
> --- a/drivers/video/fbdev/sm501fb.c
> +++ b/drivers/video/fbdev/sm501fb.c
> @@ -2060,11 +2060,11 @@ static int sm501fb_remove(struct platform_device *pdev)
>  		unregister_framebuffer(fbinfo_pnl);
>  
>  	sm501fb_stop(info);
> -	kfree(info);
>  
>  	framebuffer_release(fbinfo_pnl);
>  	framebuffer_release(fbinfo_crt);
>  
> +	kfree(info);
>  	return 0;
>  }
>  
> -- 
> 2.25.1
> 

There is no function change here at all, please stop it with pointless
patches.

greg k-h
