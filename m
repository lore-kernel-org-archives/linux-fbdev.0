Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 564F5C4338F
	for <linux-fbdev@archiver.kernel.org>; Fri, 13 Aug 2021 15:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38C0E610FC
	for <linux-fbdev@archiver.kernel.org>; Fri, 13 Aug 2021 15:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241079AbhHMPBR (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 13 Aug 2021 11:01:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:46678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241052AbhHMPBR (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 13 Aug 2021 11:01:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BDF7E610F7;
        Fri, 13 Aug 2021 15:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628866850;
        bh=6RC6vslFjh+wQ8aj4nLqwnEjlCwuuO/dIriJN4spDOU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q5nskbAqluCwv1ZaznzfE/fQY3JWn0B9SKicAEJHrm1haXbQ7RCSqc434mUzOfsgK
         NfZJgizQZaTPiMBKMfZMtfogIhi79RFVigtolj9VowNQTi+PbWl9uNoVSBqXuDC6xN
         dXkf2sPnSL6UO+rmXL97gx0jg3QDbn/4pRNDU7tM=
Date:   Fri, 13 Aug 2021 17:00:47 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oliver Graute <oliver.graute@kococonnector.com>
Cc:     oliver.graute@gmail.com, Carlis <zhangxuezhi1@yulong.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] staging: fbtft: fb_st7789v: reset display before
 initialization
Message-ID: <YRaJH5Sj+X4Z3xH/@kroah.com>
References: <20210813125928.3734-1-oliver.graute@kococonnector.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210813125928.3734-1-oliver.graute@kococonnector.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Fri, Aug 13, 2021 at 02:59:27PM +0200, Oliver Graute wrote:
> In rare cases the display is flipped or mirrored. This was observed more
> often in a low temperature environment. A clean reset on init_display()
> should help to get registers in a sane state.
> 
> Signed-off-by: Oliver Graute <oliver.graute@kococonnector.com>
> ---
>  drivers/staging/fbtft/fb_st7789v.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/staging/fbtft/fb_st7789v.c b/drivers/staging/fbtft/fb_st7789v.c
> index 3a280cc1892c..0a2dbed9ffc7 100644
> --- a/drivers/staging/fbtft/fb_st7789v.c
> +++ b/drivers/staging/fbtft/fb_st7789v.c
> @@ -82,6 +82,8 @@ enum st7789v_command {
>  {
>  	int rc;
> 
> +	par->fbtftops.reset(par);
> +
>  	rc = init_tearing_effect_line(par);
>  	if (rc)
>  		return rc;
> -- 
> 2.17.1
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

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for what needs to be done
  here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
