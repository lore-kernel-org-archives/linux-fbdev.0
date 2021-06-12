Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F92C48BCF
	for <linux-fbdev@archiver.kernel.org>; Sat, 12 Jun 2021 11:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 356B9613AA
	for <linux-fbdev@archiver.kernel.org>; Sat, 12 Jun 2021 11:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbhFLMAH (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 12 Jun 2021 08:00:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:51220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230191AbhFLMAH (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 12 Jun 2021 08:00:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 032F0613A9;
        Sat, 12 Jun 2021 11:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623499072;
        bh=UwAZa/YA/87dlDJ+IAPZQ0Ba7P9WCrmF43C+R9dF0xg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sbLMo8DtwvxPziSaTTHl6G0wuslvNqekjXOqaHnh02jxNE4oFbtBpxgVm8BIzvBgi
         zowzdmsufX9+Ifg1axFX/DXy1cLNORqg+vSO+bDoHo2KSTh6mH82UYjFuu0xcK1wlS
         +3yCnQaAptwmil+v8d7xIDne6qWYepiDQj4tisWY=
Date:   Sat, 12 Jun 2021 13:57:48 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     arjuncr <arjuncr00@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix for checkpatch.pl
Message-ID: <YMShPMuUiWNKxav0@kroah.com>
References: <20210612114505.6833-1-arjuncr00@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210612114505.6833-1-arjuncr00@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Sat, Jun 12, 2021 at 05:15:05PM +0530, arjuncr wrote:
> Signed-off-by: arjuncr <arjuncr00@gmail.com>
> ---
>  drivers/staging/fbtft/fbtft-bus.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtft-bus.c
> index 63c65dd67..cdb451dd3 100644
> --- a/drivers/staging/fbtft/fbtft-bus.c
> +++ b/drivers/staging/fbtft/fbtft-bus.c
> @@ -62,9 +62,9 @@ out:									      \
>  }                                                                             \
>  EXPORT_SYMBOL(func);
>  
> -define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, )
> +define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8,)
>  define_fbtft_write_reg(fbtft_write_reg16_bus8, __be16, u16, cpu_to_be16)
> -define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, )
> +define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16,)
>  
>  void fbtft_write_reg8_bus9(struct fbtft_par *par, int len, ...)
>  {
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

- It looks like you did not use your "real" name for the patch on either
  the Signed-off-by: line, or the From: line (both of which have to
  match).  Please read the kernel file, Documentation/SubmittingPatches
  for how to do this correctly.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
