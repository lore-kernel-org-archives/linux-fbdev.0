Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D670CC433EF
	for <linux-fbdev@archiver.kernel.org>; Thu, 26 May 2022 20:12:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348916AbiEZUMX (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 26 May 2022 16:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348900AbiEZUMU (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 26 May 2022 16:12:20 -0400
X-Greylist: delayed 521 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 26 May 2022 13:12:05 PDT
Received: from 0.smtp.remotehost.it (unknown [213.190.28.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7BF39A9B5;
        Thu, 26 May 2022 13:12:05 -0700 (PDT)
Message-ID: <672f03a9-9ffa-c2f8-a369-e958c79a57f3@0.smtp.remotehost.it>
Date:   Thu, 26 May 2022 22:03:05 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] fbdev: vesafb: Fix a use-after-free due early fb_info
 cleanup
Content-Language: en-US
To:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Helge Deller <deller@gmx.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
References: <20220526194752.307192-1-javierm@redhat.com>
From:   Pascal Ernster <dri-devel@hardfalcon.net>
In-Reply-To: <20220526194752.307192-1-javierm@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

[2022-05-26 21:47:52] Javier Martinez Canillas:
> Commit b3c9a924aab6 ("fbdev: vesafb: Cleanup fb_info in .fb_destroy rather
> than .remove") fixed a use-after-free error due the vesafb driver freeing
> the fb_info in the .remove handler instead of doing it in .fb_destroy.
> 
> This can happen if the .fb_destroy callback is executed after the .remove
> callback, since the former tries to access a pointer freed by the latter.
> 
> But that change didn't take into account that another possible scenario is
> that .fb_destroy is called before the .remove callback. For example, if no
> process has the fbdev chardev opened by the time the driver is removed.
> 
> If that's the case, fb_info will be freed when unregister_framebuffer() is
> called, making the fb_info pointer accessed in vesafb_remove() after that
> to no longer be valid.
> 
> To prevent that, move the expression containing the info->par to happen
> before the unregister_framebuffer() function call.
> 
> Fixes: b3c9a924aab6 ("fbdev: vesafb: Cleanup fb_info in .fb_destroy rather than .remove")
> Reported-by: Pascal Ernster <dri-devel@hardfalcon.net>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

Tested on a bare metal machine and on a test VM that had both crashed 
when booting a kernel lacking this patch.
Again, thanks a lot for the quick fix! :)

Tested-by: Pascal Ernster <dri-devel@hardfalcon.net>


> ---
> 
>   drivers/video/fbdev/vesafb.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/fbdev/vesafb.c b/drivers/video/fbdev/vesafb.c
> index e25e8de5ff67..929d4775cb4b 100644
> --- a/drivers/video/fbdev/vesafb.c
> +++ b/drivers/video/fbdev/vesafb.c
> @@ -490,11 +490,12 @@ static int vesafb_remove(struct platform_device *pdev)
>   {
>   	struct fb_info *info = platform_get_drvdata(pdev);
>   
> -	/* vesafb_destroy takes care of info cleanup */
> -	unregister_framebuffer(info);
>   	if (((struct vesafb_par *)(info->par))->region)
>   		release_region(0x3c0, 32);
>   
> +	/* vesafb_destroy takes care of info cleanup */
> +	unregister_framebuffer(info);
> +
>   	return 0;
>   }
>   

