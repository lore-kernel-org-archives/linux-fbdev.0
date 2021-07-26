Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 482D8C4320A
	for <linux-fbdev@archiver.kernel.org>; Mon, 26 Jul 2021 13:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29E43608FB
	for <linux-fbdev@archiver.kernel.org>; Mon, 26 Jul 2021 13:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234152AbhGZMUD (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 26 Jul 2021 08:20:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:51670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234072AbhGZMUD (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 26 Jul 2021 08:20:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6E24260EB2;
        Mon, 26 Jul 2021 13:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627304431;
        bh=Gx/Vu6b5lzcfCCty2qy4h00ua5IDYhArV6JrOmQxNS8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o9aDp1ctvx10cMjlC0OosTWfFezUbdRDRuQu1+MFYpb8tIhL5aOmRbXZBg1ZeHtO3
         riGsjq9UYMhSgJdfLhE0CFvjViQRi2xUL9a42dzMsO6zenIWRF2FDoTmRCZbKhcVZd
         qnUoC54u7kjQi2h8T2RlDDwYjiy1q4xjHpU81Nng=
Date:   Mon, 26 Jul 2021 15:00:28 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     =?utf-8?B?dGNzX2tlcm5lbCjohb7orq/kupHlhoXmoLjlvIDlj5HogIUp?= 
        <tcs_kernel@tencent.com>
Cc:     "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>,
        "yepeilin.cs@gmail.com" <yepeilin.cs@gmail.com>,
        "penguin-kernel@I-love.SAKURA.ne.jp" 
        <penguin-kernel@i-love.sakura.ne.jp>,
        "tzimmermann@suse.de" <tzimmermann@suse.de>,
        "george.kennedy@oracle.com" <george.kennedy@oracle.com>,
        "ducheng2@gmail.com" <ducheng2@gmail.com>,
        "sam@ravnborg.org" <sam@ravnborg.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fbcon: Out-Of-Bounds write in sys_imageblit, add range
 check
Message-ID: <YP6x7C1OJg2mVHAd@kroah.com>
References: <D5DF8A1C-5FA2-426B-AAB4-3199AEA0A02E@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D5DF8A1C-5FA2-426B-AAB4-3199AEA0A02E@tencent.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Mon, Jul 26, 2021 at 11:32:37AM +0000, tcs_kernel(腾讯云内核开发者) wrote:
> yres and vyres can be controlled by user mode paramaters, and cause p->vrows to become a negative value. While this value be passed to real_y function, the ypos will be out of screen range.
> This is an out-of-bounds write bug.
> 
> 
> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
> index 22bb3892f6bd..0970de46782f 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -1956,11 +1956,12 @@ static void updatescrollmode(struct fbcon_display *p,
>         int yres = FBCON_SWAP(ops->rotate, info->var.yres, info->var.xres);
>         int vyres = FBCON_SWAP(ops->rotate, info->var.yres_virtual,
>                                    info->var.xres_virtual);
> +       int rows = vc->vc_rows;
>  
>         p->vrows = vyres/fh;
> -       if (yres > (fh * (vc->vc_rows + 1)))
> -               p->vrows -= (yres - (fh * vc->vc_rows)) / fh;
> -       if ((yres % fh) && (vyres % fh < yres % fh))
> +       if ((yres > (fh * (rows + 1))) && (vyres >= (yres - (fh * rows))) && p->vrows)
> +               p->vrows -= (yres - (fh * rows)) / fh;
> +       if ((yres % fh) && (vyres % fh < yres % fh) && p->vrows)
>                 p->vrows--;
>  }
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

- Your patch is malformed (tabs converted to spaces, linewrapped, etc.)
  and can not be applied.  Please read the file,
  Documentation/email-clients.txt in order to fix this.

- Your patch does not have a Signed-off-by: line.  Please read the
  kernel file, Documentation/SubmittingPatches and resend it after
  adding that line.  Note, the line needs to be in the body of the
  email, before the patch, not at the bottom of the patch or in the
  email signature.

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what is needed in order to
  properly describe the change.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
