Return-Path: <SRS0=EkD8=D5=vger.kernel.org=linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D5BC4363A
	for <linux-fbdev@archiver.kernel.org>; Thu, 22 Oct 2020 07:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42D9B20BED
	for <linux-fbdev@archiver.kernel.org>; Thu, 22 Oct 2020 07:34:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508580AbgJVHeP (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 22 Oct 2020 03:34:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:59490 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2506555AbgJVHeO (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 22 Oct 2020 03:34:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B6DC5B195;
        Thu, 22 Oct 2020 07:34:12 +0000 (UTC)
Subject: Re: [PATCH 1/1] video: fbdev: fix divide error in fbcon_switch
To:     saeed.mirzamohammadi@oracle.com, linux-kernel@vger.kernel.org
Cc:     linux-fbdev@vger.kernel.org, b.zolnierkie@samsung.com,
        jani.nikula@intel.com, daniel.vetter@ffwll.ch,
        gustavoars@kernel.org, dri-devel@lists.freedesktop.org,
        akpm@linux-foundation.org, rppt@kernel.org
References: <20201021235758.59993-1-saeed.mirzamohammadi@oracle.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <ad87c5c1-061d-8a81-7b2c-43a8687a464f@suse.de>
Date:   Thu, 22 Oct 2020 09:34:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201021235758.59993-1-saeed.mirzamohammadi@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi

On 22.10.20 01:57, saeed.mirzamohammadi@oracle.com wrote:
> From: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
> 
> This patch fixes the issue due to:
> 
> [   89.572883] divide_error: 0000 [#1] SMP KASAN PTI
> [   89.572897] CPU: 3 PID: 16083 Comm: repro Not tainted 5.9.0-rc7.20200930.rc1.allarch-19-g3e32d0d.syzk #5
> [   89.572902] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.5.1 01/01/2011
> [   89.572934] RIP: 0010:cirrusfb_check_var+0x84/0x1260

BTW, if you run qemu with cirrus, there's also a DRM driver named
cirrus.ko. Might be a better choice than the old fbdev driver. If you
just care about qemu, but not the actual graphics device, take a look at

  https://www.kraxel.org/blog/2014/10/qemu-using-cirrus-considered-harmful/

Anyway, thanks for your patch.

Best regards
Thomas

> 
> The error happens when the pixels value is calculated before performing the sanity checks on bits_per_pixel.
> A bits_per_pixel set to zero causes divide by zero error.
> 
> This patch moves the calculation after the sanity check.
> 
> Signed-off-by: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
> Tested-by: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
> ---
>  drivers/video/fbdev/cirrusfb.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/cirrusfb.c b/drivers/video/fbdev/cirrusfb.c
> index 15a9ee7cd734..a7749101b094 100644
> --- a/drivers/video/fbdev/cirrusfb.c
> +++ b/drivers/video/fbdev/cirrusfb.c
> @@ -531,7 +531,7 @@ static int cirrusfb_check_var(struct fb_var_screeninfo *var,
>  {
>  	int yres;
>  	/* memory size in pixels */
> -	unsigned pixels = info->screen_size * 8 / var->bits_per_pixel;
> +	unsigned int pixels;
>  	struct cirrusfb_info *cinfo = info->par;
>  
>  	switch (var->bits_per_pixel) {
> @@ -573,6 +573,7 @@ static int cirrusfb_check_var(struct fb_var_screeninfo *var,
>  		return -EINVAL;
>  	}
>  
> +	pixels = info->screen_size * 8 / var->bits_per_pixel;
>  	if (var->xres_virtual < var->xres)
>  		var->xres_virtual = var->xres;
>  	/* use highest possible virtual resolution */
> 

-- 
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
(HRB 36809, AG Nürnberg)
Geschäftsführer: Felix Imendörffer
