Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A402C433F5
	for <linux-fbdev@archiver.kernel.org>; Thu, 24 Mar 2022 21:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355199AbiCXVln (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 24 Mar 2022 17:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355191AbiCXVln (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 24 Mar 2022 17:41:43 -0400
X-Greylist: delayed 1457 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 24 Mar 2022 14:40:10 PDT
Received: from gateway33.websitewelcome.com (gateway33.websitewelcome.com [192.185.146.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081AC65827
        for <linux-fbdev@vger.kernel.org>; Thu, 24 Mar 2022 14:40:09 -0700 (PDT)
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id 94EED746E5
        for <linux-fbdev@vger.kernel.org>; Thu, 24 Mar 2022 16:15:51 -0500 (CDT)
Received: from 162-215-252-75.unifiedlayer.com ([208.91.199.152])
        by cmsmtp with SMTP
        id XUoBn9vXuHnotXUoBn9w3x; Thu, 24 Mar 2022 16:15:51 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=oNH0IkBh0WKyV1JhSrDOxEeCgmKqMdr8USyoFPQc2hQ=; b=I21bRrH6+3RN1onGy8mjMGiVMd
        OyKFzY2wm6A27hVjWGCTWGFEOSOz10N0SxyJwDcOza3LJ2wjeQwLamKZWXMMhiVi7F7lncLvlOxGO
        qcAvWjiFRHhgXM1dz4Tbe+IUY1GiY6rMAHlP93KXTQ6pUJ+QL8OamImC7CfO170Xqy4LZ/S/VX0FZ
        1s5HxqStcR1ud5+WZkw6bx3OsFqXkLZXnwbJcZgrOgArP5NefndL3bXy0M1fMshp7n2q7bLxwU09e
        EuahCZQODG5M/RqHUMOLsVZqjz/K/U/Q+p7JPXPS8csUKQ6T8Z+ME6hY2A2IOP88kIf1xnwIm5UJ1
        p87+JTpA==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:57652 helo=localhost)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@roeck-us.net>)
        id 1nXUoA-004GiL-HC; Thu, 24 Mar 2022 21:15:50 +0000
Date:   Thu, 24 Mar 2022 14:15:49 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     daniel@ffwll.ch, deller@gmx.de, m.szyprowski@samsung.com,
        geert@linux-m68k.org, javierm@redhat.com, sam@ravnborg.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [2/2] fbdev: Fix cfb_imageblit() for arbitrary image widths
Message-ID: <20220324211549.GA1895931@roeck-us.net>
References: <20220313192952.12058-3-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220313192952.12058-3-tzimmermann@suse.de>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1nXUoA-004GiL-HC
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (localhost) [108.223.40.66]:57652
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 2
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Sun, Mar 13, 2022 at 08:29:52PM +0100, Thomas Zimmermann wrote:
> Commit 0d03011894d2 ("fbdev: Improve performance of cfb_imageblit()")
> broke cfb_imageblit() for image widths that are not aligned to 8-bit
> boundaries. Fix this by handling the trailing pixels on each line
> separately. The performance improvements in the original commit do not
> regress by this change.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: 0d03011894d2 ("fbdev: Improve performance of cfb_imageblit()")
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/video/fbdev/core/cfbimgblt.c | 28 ++++++++++++++++++++++++----
>  1 file changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/video/fbdev/core/cfbimgblt.c b/drivers/video/fbdev/core/cfbimgblt.c
> index 7361cfabdd85..9ebda4e0dc7a 100644
> --- a/drivers/video/fbdev/core/cfbimgblt.c
> +++ b/drivers/video/fbdev/core/cfbimgblt.c
> @@ -218,7 +218,7 @@ static inline void fast_imageblit(const struct fb_image *image, struct fb_info *
>  {
>  	u32 fgx = fgcolor, bgx = bgcolor, bpp = p->var.bits_per_pixel;
>  	u32 ppw = 32/bpp, spitch = (image->width + 7)/8;
> -	u32 bit_mask, eorx;
> +	u32 bit_mask, eorx, shift;
>  	const char *s = image->data, *src;
>  	u32 __iomem *dst;
>  	const u32 *tab = NULL;
> @@ -259,17 +259,23 @@ static inline void fast_imageblit(const struct fb_image *image, struct fb_info *
>  
>  	for (i = image->height; i--; ) {
>  		dst = (u32 __iomem *)dst1;
> +		shift = 8;
>  		src = s;
>  
> +		/*
> +		 * Manually unroll the per-line copying loop for better
> +		 * performance. This works until we processed the last
> +		 * completely filled source byte (inclusive).
> +		 */
>  		switch (ppw) {
>  		case 4: /* 8 bpp */
> -			for (j = k; j; j -= 2, ++src) {
> +			for (j = k; j >= 2; j -= 2, ++src) {
>  				FB_WRITEL(colortab[(*src >> 4) & bit_mask], dst++);
>  				FB_WRITEL(colortab[(*src >> 0) & bit_mask], dst++);
>  			}
>  			break;
>  		case 2: /* 16 bpp */
> -			for (j = k; j; j -= 4, ++src) {
> +			for (j = k; j >= 4; j -= 4, ++src) {
>  				FB_WRITEL(colortab[(*src >> 6) & bit_mask], dst++);
>  				FB_WRITEL(colortab[(*src >> 4) & bit_mask], dst++);
>  				FB_WRITEL(colortab[(*src >> 2) & bit_mask], dst++);
> @@ -277,7 +283,7 @@ static inline void fast_imageblit(const struct fb_image *image, struct fb_info *
>  			}
>  			break;
>  		case 1: /* 32 bpp */
> -			for (j = k; j; j -= 8, ++src) {
> +			for (j = k; j >= 8; j -= 8, ++src) {
>  				FB_WRITEL(colortab[(*src >> 7) & bit_mask], dst++);
>  				FB_WRITEL(colortab[(*src >> 6) & bit_mask], dst++);
>  				FB_WRITEL(colortab[(*src >> 5) & bit_mask], dst++);
> @@ -290,6 +296,20 @@ static inline void fast_imageblit(const struct fb_image *image, struct fb_info *
>  			break;
>  		}
>  
> +		/*
> +		 * For image widths that are not a multiple of 8, there
> +		 * are trailing pixels left on the current line. Print
> +		 * them as well.
> +		 */
> +		for (; j--; ) {
> +			shift -= ppw;
> +			FB_WRITEL(colortab[(*src >> shift) & bit_mask], dst++);
> +			if (!shift) {
> +				shift = 8;
> +				++src;
> +			}
> +		}
> +
>  		dst1 += p->fix.line_length;
>  		s += spitch;
>  	}
