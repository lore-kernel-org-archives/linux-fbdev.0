Return-Path: <SRS0=Io7n=D4=vger.kernel.org=linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17879C4363A
	for <linux-fbdev@archiver.kernel.org>; Wed, 21 Oct 2020 23:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85F1B22248
	for <linux-fbdev@archiver.kernel.org>; Wed, 21 Oct 2020 23:07:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="acEch0rd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507049AbgJUXHn (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 21 Oct 2020 19:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439350AbgJUXHn (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 21 Oct 2020 19:07:43 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A38C0613CE
        for <linux-fbdev@vger.kernel.org>; Wed, 21 Oct 2020 16:07:42 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0238252F;
        Thu, 22 Oct 2020 01:07:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1603321660;
        bh=+WdOvFjpRjvrv6B+F7afibmUjbgU1KtzOI9H01Uwlcw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=acEch0rd/KOHPm5hzTCGdtnqcfSg5H5g0n+0pUmWx9fPM1g8djEdE+T2GBaTT/W+P
         cD4tpGfAvoas/GDRnbZvtEXpi3wKkA1cH68xJxn6pBQBzTJK2o4NPRSY5pVn6nGoY1
         FGo7zsVLpgQCCPW/k9MvvpiZENbB9+Lv0jmekNCI=
Date:   Thu, 22 Oct 2020 02:06:54 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     b.zolnierkie@samsung.com, gwan-gyeong.mun@intel.com,
        sam@ravnborg.org, daniel.vetter@ffwll.ch, bernard@vivo.com,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH] drivers/video: Fix -Wstringop-truncation in hdmi.c
Message-ID: <20201021230654.GS3942@pendragon.ideasonboard.com>
References: <20201021121241.17623-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201021121241.17623-1-tzimmermann@suse.de>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Thomas,

Thank you for the patch.

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

As this seems to be a legitimate use of strncpy(), isn't there a way to
silence the warning without requiring this additional runtime complexity
?

>  
>  	return 0;
>  }

-- 
Regards,

Laurent Pinchart
