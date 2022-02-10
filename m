Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A48DDC433EF
	for <linux-fbdev@archiver.kernel.org>; Thu, 10 Feb 2022 21:16:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236222AbiBJVQv (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 10 Feb 2022 16:16:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344566AbiBJVQv (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 10 Feb 2022 16:16:51 -0500
Received: from mx2.smtp.larsendata.com (mx2.smtp.larsendata.com [91.221.196.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D01C26C9
        for <linux-fbdev@vger.kernel.org>; Thu, 10 Feb 2022 13:16:50 -0800 (PST)
Received: from mail01.mxhotel.dk (mail01.mxhotel.dk [91.221.196.236])
        by mx2.smtp.larsendata.com (Halon) with ESMTPS
        id ca444ea8-8ab6-11ec-b2df-0050568cd888;
        Thu, 10 Feb 2022 21:17:02 +0000 (UTC)
Received: from ravnborg.org (80-162-45-141-cable.dk.customer.tdc.net [80.162.45.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sam@ravnborg.org)
        by mail01.mxhotel.dk (Postfix) with ESMTPSA id 3615B194B55;
        Thu, 10 Feb 2022 22:16:48 +0100 (CET)
Date:   Thu, 10 Feb 2022 22:16:45 +0100
X-Report-Abuse-To: abuse@mxhotel.dk
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     daniel@ffwll.ch, javierm@redhat.com, noralf@tronnes.org,
        andriy.shevchenko@linux.intel.com, deller@gmx.de,
        bernie@plugable.com, jayalk@intworks.biz,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 2/2] fbdev: Don't sort deferred-I/O pages by default
Message-ID: <YgWAvXF+WClk/fyk@ravnborg.org>
References: <20220210141111.5231-1-tzimmermann@suse.de>
 <20220210141111.5231-3-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210141111.5231-3-tzimmermann@suse.de>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Thomas,

On Thu, Feb 10, 2022 at 03:11:13PM +0100, Thomas Zimmermann wrote:
> Fbdev's deferred I/O sorts all dirty pages by default, which incurs a
> significant overhead. Make the sorting step optional and update the few
> drivers that require it. Use a FIFO list by default.
> 
> Sorting pages by memory offset for deferred I/O performs an implicit
> bubble-sort step on the list of dirty pages. The algorithm goes through
> the list of dirty pages and inserts each new page according to its
> index field. Even worse, list traversal always starts at the first
> entry. As video memory is most likely updated scanline by scanline, the
> algorithm traverses through the complete list for each updated page.
> 
> For example, with 1024x768x32bpp a page covers exactly one scanline.
> Writing a single screen update from top to bottom requires updating
> 768 pages. With an average list length of 384 entries, a screen update
> creates (768 * 384 =) 294912 compare operation.
> 
> Fix this by making the sorting step opt-in and update the few drivers
> that require it. All other drivers work with unsorted page lists. Pages
> are appended to the list. Therefore, in the common case of writing the
> framebuffer top to bottom, pages are still sorted by offset, which may
> have a positive effect on performance.
> 
> Playing a video [1] in mplayer's benchmark mode shows the difference
> (i7-4790, FullHD, simpledrm, kernel with debugging).
> 
>   mplayer -benchmark -nosound -vo fbdev ./big_buck_bunny_720p_stereo.ogg
> 
> With sorted page lists:
> 
>   BENCHMARKs: VC:  32.960s VO:  73.068s A:   0.000s Sys:   2.413s =  108.441s
>   BENCHMARK%: VC: 30.3947% VO: 67.3802% A:  0.0000% Sys:  2.2251% = 100.0000%
> 
> With unsorted page lists:
> 
>   BENCHMARKs: VC:  31.005s VO:  42.889s A:   0.000s Sys:   2.256s =   76.150s
>   BENCHMARK%: VC: 40.7156% VO: 56.3219% A:  0.0000% Sys:  2.9625% = 100.0000%
> 
> VC shows the overhead of video decoding, VO shows the overhead of the
> video output. Using unsorted page lists reduces the benchmark's run time
> by ~32s/~25%.
Nice!

> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Link: https://download.blender.org/peach/bigbuckbunny_movies/big_buck_bunny_720p_stereo.ogg # [1]
> ---
>  drivers/staging/fbtft/fbtft-core.c  |  1 +
>  drivers/video/fbdev/broadsheetfb.c  |  1 +
>  drivers/video/fbdev/core/fb_defio.c | 19 ++++++++++++-------
>  drivers/video/fbdev/metronomefb.c   |  1 +
>  drivers/video/fbdev/udlfb.c         |  1 +
>  include/linux/fb.h                  |  1 +
>  6 files changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
> index f2684d2d6851..4a35347b3020 100644
> --- a/drivers/staging/fbtft/fbtft-core.c
> +++ b/drivers/staging/fbtft/fbtft-core.c
> @@ -654,6 +654,7 @@ struct fb_info *fbtft_framebuffer_alloc(struct fbtft_display *display,
>  	fbops->fb_blank     =      fbtft_fb_blank;
>  
>  	fbdefio->delay =           HZ / fps;
> +	fbdefio->sort_pagelist =   true;
>  	fbdefio->deferred_io =     fbtft_deferred_io;
>  	fb_deferred_io_init(info);
>  
> diff --git a/drivers/video/fbdev/broadsheetfb.c b/drivers/video/fbdev/broadsheetfb.c
> index fd66f4d4a621..b9054f658838 100644
> --- a/drivers/video/fbdev/broadsheetfb.c
> +++ b/drivers/video/fbdev/broadsheetfb.c
> @@ -1059,6 +1059,7 @@ static const struct fb_ops broadsheetfb_ops = {
>  
>  static struct fb_deferred_io broadsheetfb_defio = {
>  	.delay		= HZ/4,
> +	.sort_pagelist	= true,
>  	.deferred_io	= broadsheetfb_dpy_deferred_io,
>  };
>  
> diff --git a/drivers/video/fbdev/core/fb_defio.c b/drivers/video/fbdev/core/fb_defio.c
> index 3727b1ca87b1..1f672cf253b2 100644
> --- a/drivers/video/fbdev/core/fb_defio.c
> +++ b/drivers/video/fbdev/core/fb_defio.c
> @@ -132,15 +132,20 @@ static vm_fault_t fb_deferred_io_mkwrite(struct vm_fault *vmf)
>  	if (!list_empty(&page->lru))
>  		goto page_already_added;
>  
> -	/* we loop through the pagelist before adding in order
> -	to keep the pagelist sorted */
> -	list_for_each_entry(cur, &fbdefio->pagelist, lru) {
> -		if (cur->index > page->index)
> -			break;
> +	if (fbdefio->sort_pagelist) {
> +		/*
> +		 * We loop through the pagelist before adding in order
> +		 * to keep the pagelist sorted.
> +		 */
> +		list_for_each_entry(cur, &fbdefio->pagelist, lru) {
> +			if (cur->index > page->index)
> +				break;
> +		}
> +		list_add_tail(&page->lru, &cur->lru);
> +	} else {
> +		list_add_tail(&page->lru, &fbdefio->pagelist);
>  	}
Bikeshedding - my personal style is to have the likely part first.
This makes reading the code easier.


The following drivers uses deferred io but are not listed as
they need the page list sorted:

- hecubafb
- hyperv_fb
- sh_mobile_lcdcfb
- smscufx
- ssd1307fb 
- xen-fbfront

It would be nice with some info in the commit log that they do not need
the pages sorted.
To make the list complete include the drm stuff too.

It did not jump to me why they did not need sorted pages,
so some sort of reassurance that they have been checked would be nice.

With the following addressed:
Acked-by: Sam Ravnborg <sam@ravnborg.org>

I hope someone else looks that can verify that the list of drivers
without sort_pagelist is correct so someone knowledgeable have looked
too.

	Sam
