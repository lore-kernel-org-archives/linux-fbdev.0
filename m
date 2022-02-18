Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2AB1C433EF
	for <linux-fbdev@archiver.kernel.org>; Fri, 18 Feb 2022 09:35:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233625AbiBRJgE (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 18 Feb 2022 04:36:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbiBRJgD (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 18 Feb 2022 04:36:03 -0500
Received: from mx1.smtp.larsendata.com (mx1.smtp.larsendata.com [91.221.196.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAED9B2E1C
        for <linux-fbdev@vger.kernel.org>; Fri, 18 Feb 2022 01:35:46 -0800 (PST)
Received: from mail01.mxhotel.dk (mail01.mxhotel.dk [91.221.196.236])
        by mx1.smtp.larsendata.com (Halon) with ESMTPS
        id 30a45a6b-909e-11ec-baa1-0050568c148b;
        Fri, 18 Feb 2022 09:36:03 +0000 (UTC)
Received: from ravnborg.org (80-162-45-141-cable.dk.customer.tdc.net [80.162.45.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sam@ravnborg.org)
        by mail01.mxhotel.dk (Postfix) with ESMTPSA id 57E25194B47;
        Fri, 18 Feb 2022 10:35:45 +0100 (CET)
Date:   Fri, 18 Feb 2022 10:35:41 +0100
X-Report-Abuse-To: abuse@mxhotel.dk
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     daniel@ffwll.ch, deller@gmx.de, javierm@redhat.com,
        geert@linux-m68k.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 1/2] fbdev: Improve performance of sys_fillrect()
Message-ID: <Yg9obUp9f08zQUEf@ravnborg.org>
References: <20220217103405.26492-1-tzimmermann@suse.de>
 <20220217103405.26492-2-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217103405.26492-2-tzimmermann@suse.de>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Thomas,

On Thu, Feb 17, 2022 at 11:34:04AM +0100, Thomas Zimmermann wrote:
> Improve the performance of sys_fillrect() by using word-aligned
> 32/64-bit mov instructions. While the code tried to implement this,
> the compiler failed to create fast instructions. The resulting
> binary instructions were even slower than cfb_fillrect(), which
> uses the same algorithm, but operates on I/O memory.
> 
> A microbenchmark measures the average number of CPU cycles
> for sys_fillrect() after a stabilizing period of a few minutes
> (i7-4790, FullHD, simpledrm, kernel with debugging). The value
> for CFB is given as a reference.
> 
>   sys_fillrect(), new:  26586 cycles
>   sys_fillrect(), old: 166603 cycles
>   cfb_fillrect():       41012 cycles
> 
> In the optimized case, sys_fillrect() is now ~6x faster than before
> and ~1.5x faster than the CFB implementation.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Nice optimization.
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

> ---
>  drivers/video/fbdev/core/sysfillrect.c | 16 +++-------------
>  1 file changed, 3 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/video/fbdev/core/sysfillrect.c b/drivers/video/fbdev/core/sysfillrect.c
> index 33ee3d34f9d2..bcdcaeae6538 100644
> --- a/drivers/video/fbdev/core/sysfillrect.c
> +++ b/drivers/video/fbdev/core/sysfillrect.c
> @@ -50,19 +50,9 @@ bitfill_aligned(struct fb_info *p, unsigned long *dst, int dst_idx,
>  
>  		/* Main chunk */
>  		n /= bits;
> -		while (n >= 8) {
> -			*dst++ = pat;
> -			*dst++ = pat;
> -			*dst++ = pat;
> -			*dst++ = pat;
> -			*dst++ = pat;
> -			*dst++ = pat;
> -			*dst++ = pat;
> -			*dst++ = pat;
> -			n -= 8;
> -		}
> -		while (n--)
> -			*dst++ = pat;
> +		memset_l(dst, pat, n);
> +		dst += n;
> +
>  		/* Trailing bits */
>  		if (last)
>  			*dst = comp(pat, *dst, last);
> -- 
> 2.34.1
