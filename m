Return-Path: <SRS0=n/V2=EH=vger.kernel.org=linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6CCC2D0A3
	for <linux-fbdev@archiver.kernel.org>; Sun,  1 Nov 2020 09:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8100620853
	for <linux-fbdev@archiver.kernel.org>; Sun,  1 Nov 2020 09:50:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbgKAJu1 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 1 Nov 2020 04:50:27 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:40376 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgKAJu1 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Sun, 1 Nov 2020 04:50:27 -0500
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 050DC20022;
        Sun,  1 Nov 2020 10:50:22 +0100 (CET)
Date:   Sun, 1 Nov 2020 10:50:21 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     b.zolnierkie@samsung.com, gwan-gyeong.mun@intel.com,
        daniel.vetter@ffwll.ch, bernard@vivo.com,
        laurent.pinchart@ideasonboard.com, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drivers/video: Fix -Wstringop-truncation in hdmi.c
Message-ID: <20201101095021.GE1166694@ravnborg.org>
References: <20201021121241.17623-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021121241.17623-1-tzimmermann@suse.de>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VbvZwmh9 c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=7gkXJVJtAAAA:8 a=e5mUnYsNAAAA:8
        a=k1JbnSd-xrAZQLa3rtgA:9 a=CjuIK1q_8ugA:10 a=E9Po1WZjFZOl8hwRPBS3:22
        a=Vxmtnl_E_bksehYqCbjh:22
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, Oct 21, 2020 at 02:12:41PM +0200, Thomas Zimmermann wrote:
> Trying to copy into the string fields with strncpy() gives a warning from
> gcc. Both fields are part of a packed HDMI header and do not require a
> terminating \0 character.
> 
> ../drivers/video/hdmi.c: In function 'hdmi_spd_infoframe_init':
> ../drivers/video/hdmi.c:230:2: warning: 'strncpy' specified bound 8 equals destination size [-Wstringop-truncation]
>   230 |  strncpy(frame->vendor, vendor, sizeof(frame->vendor));
>       |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../drivers/video/hdmi.c:231:2: warning: 'strncpy' specified bound 16 equals destination size [-Wstringop-truncation]
>   231 |  strncpy(frame->product, product, sizeof(frame->product));
>       |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Just use memcpy() instead.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
I assume vendor is guaranteed to be 0-termindated.
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

> ---
>  drivers/video/hdmi.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/hdmi.c b/drivers/video/hdmi.c
> index b7a1d6fae90d..1e4cb63d0d11 100644
> --- a/drivers/video/hdmi.c
> +++ b/drivers/video/hdmi.c
> @@ -221,14 +221,18 @@ EXPORT_SYMBOL(hdmi_avi_infoframe_pack);
>  int hdmi_spd_infoframe_init(struct hdmi_spd_infoframe *frame,
>  			    const char *vendor, const char *product)
>  {
> +	size_t len;
> +
>  	memset(frame, 0, sizeof(*frame));
>  
>  	frame->type = HDMI_INFOFRAME_TYPE_SPD;
>  	frame->version = 1;
>  	frame->length = HDMI_SPD_INFOFRAME_SIZE;
>  
> -	strncpy(frame->vendor, vendor, sizeof(frame->vendor));
> -	strncpy(frame->product, product, sizeof(frame->product));
> +	len = strlen(vendor);
> +	memcpy(frame->vendor, vendor, min(len, sizeof(frame->vendor)));
> +	len = strlen(product);
> +	memcpy(frame->product, product, min(len, sizeof(frame->product)));
>  
>  	return 0;
>  }
> -- 
> 2.28.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
