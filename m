Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D3CC433F5
	for <linux-fbdev@archiver.kernel.org>; Sat,  4 Sep 2021 07:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 666E360F51
	for <linux-fbdev@archiver.kernel.org>; Sat,  4 Sep 2021 07:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbhIDHBt (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 4 Sep 2021 03:01:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:50604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229994AbhIDHBt (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 4 Sep 2021 03:01:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CBB2B60F22;
        Sat,  4 Sep 2021 07:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630738848;
        bh=JWHgFlJay6hn929l3kdfasud5yj7kPB4NU/hGrLmm2E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rReBveCxjFV2UwyVBjq5O26tDrsz2OrRdJSotTPMUOKoUz1MhcfYqymR11VYmJ82b
         O0VfuafiwBmrfCG44Yys7run/29xG6f4mbIIccWc70Xj1VI01aR0x8p5cSmeOFGb7/
         9FBS+gj9NO/ujP0Z6F+os9+TcaOPW662F+JUntyM=
Date:   Sat, 4 Sep 2021 09:00:45 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     srivathsa <srivathsa729.8@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix ERROR: trailing statements should be on next line
Message-ID: <YTMZndMjTmN1RK8S@kroah.com>
References: <20210904063127.11142-1-srivathsa729.8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210904063127.11142-1-srivathsa729.8@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Sat, Sep 04, 2021 at 12:01:27PM +0530, srivathsa wrote:
> Signed-off-by: Srivathsa Dara <srivathsa729.8@gmail.com>
> ---
>  drivers/staging/fbtft/fbtft-core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
> index ed992ca605eb..65de1c02e7dc 100644
> --- a/drivers/staging/fbtft/fbtft-core.c
> +++ b/drivers/staging/fbtft/fbtft-core.c
> @@ -1038,7 +1038,8 @@ int fbtft_init_display(struct fbtft_par *par)
>  			i++;
>  
>  			/* make debug message */
> -			for (j = 0; par->init_sequence[i + 1 + j] >= 0; j++);
> +			for (j = 0; par->init_sequence[i + 1 + j] >= 0; j++)
> +				;
>  
>  			fbtft_par_dbg(DEBUG_INIT_DISPLAY, par,
>  				      "init: write(0x%02X) %*ph\n",
> -- 
> 2.25.1
> 
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what is needed in order to
  properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what a proper Subject: line should
  look like.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
