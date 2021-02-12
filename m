Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C118C433DB
	for <linux-fbdev@archiver.kernel.org>; Fri, 12 Feb 2021 15:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6B4964E57
	for <linux-fbdev@archiver.kernel.org>; Fri, 12 Feb 2021 15:03:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbhBLPDl (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 12 Feb 2021 10:03:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:51276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229465AbhBLPDk (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 12 Feb 2021 10:03:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4969564E00;
        Fri, 12 Feb 2021 15:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613142179;
        bh=EAuHpm5/CirPOX+FrG/WqMowYIetJKRyv+lKo0kk1qw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zFLZJP6/r6ue2b986HktAb/MtNiT8YM9oB4oRxzD1iy/btRaCJ6BYmahwWN6MJ4Yw
         MpbuM6QiYBel1Y/5pu8J+ws7cZjrdiBtEriYgDvV8/DTyxRpmdV4TYPM6Od3KxAP+Q
         uZafpt/s8BVmUz0wbP6s0YvHr9ZlCXojWnUQhJgg=
Date:   Fri, 12 Feb 2021 16:02:57 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alaa Emad <alaaemadhossney.ae@gmail.com>
Cc:     mh12gx2825@gmail.com, sbrivio@redhat.com, colin.king@canonical.com,
        oliver.graute@kococonnector.com, devel@driverdev.osuosl.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] Fix space prohibited issue in fbtft-bus.c
Message-ID: <YCaYoZSM3BvwK7IK@kroah.com>
References: <20210212145833.3809-1-alaaemadhossney.ae@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210212145833.3809-1-alaaemadhossney.ae@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Fri, Feb 12, 2021 at 04:58:33PM +0200, Alaa Emad wrote:
> This change fixes a checkpatch error for "space prohibited before that close parenthesis ')'"
> 
> Signed-off-by: Alaa Emad <alaaemadhossney.ae@gmail.com>
> ---
>  certs/x509_revocation_list        | 0
>  drivers/staging/fbtft/fbtft-bus.c | 4 ++--
>  2 files changed, 2 insertions(+), 2 deletions(-)
>  create mode 100644 certs/x509_revocation_list
> 
> diff --git a/certs/x509_revocation_list b/certs/x509_revocation_list
> new file mode 100644
> index 000000000000..e69de29bb2d1
> diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtft-bus.c
> index 63c65dd67b17..847cbfbbd766 100644
> --- a/drivers/staging/fbtft/fbtft-bus.c
> +++ b/drivers/staging/fbtft/fbtft-bus.c
> @@ -62,9 +62,9 @@ out:									      \
>  }                                                                             \
>  EXPORT_SYMBOL(func);
>  
> -define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, )
> +define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8)
>  define_fbtft_write_reg(fbtft_write_reg16_bus8, __be16, u16, cpu_to_be16)
> -define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, )
> +define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16)
>  
>  void fbtft_write_reg8_bus9(struct fbtft_par *par, int len, ...)
>  {
> -- 
> 2.25.1
> 
> _______________________________________________
> devel mailing list
> devel@linuxdriverproject.org
> http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

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

- Your patch breaks the build.

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
