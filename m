Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D35DC25B07
	for <linux-fbdev@archiver.kernel.org>; Wed, 10 Aug 2022 15:59:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbiHJP7T (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 10 Aug 2022 11:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbiHJP7J (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 10 Aug 2022 11:59:09 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC52250716
        for <linux-fbdev@vger.kernel.org>; Wed, 10 Aug 2022 08:59:07 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id k6-20020a05600c1c8600b003a54ecc62f6so1204346wms.5
        for <linux-fbdev@vger.kernel.org>; Wed, 10 Aug 2022 08:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc;
        bh=5J/+lzEP3tSd3WPCvbjczX9ZLB61OBoGBALKUmRBw5s=;
        b=ObbzQmaiZonvgZXM6vJSd38JNEFOl1Gu5gzz2JK4cCiW02dTTl9lARpq5+KEgkwx5t
         cZJhbJXz1x3QyfajbDqIBIK4mbujsEdG9ys1inAOUjcSj9Wthi41cGYBetIvCKmHUnmo
         XO09Qv92NvVrVC0xszkX26ZJeWoeHIRqb67s8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=5J/+lzEP3tSd3WPCvbjczX9ZLB61OBoGBALKUmRBw5s=;
        b=6W3EBccWjDqL3ZZrQ/Sh9DWY0VFr27AE4BGuzAjpuWbEDMV6gn1YB1Nc5HD/+69co8
         ew0nsL1HnAIRs4kmWsMhiQk8ODxNZPSdGTBkRxPjTgtw4uiqq2LEDn8bAgEk/COBGXR1
         rqEmlT6ahqMk/r42U1BMfoDPYVpzks9gaGsiSx/BXyu80QxkrVlE8QG/v2StkO9Cyh2O
         weKBMy4fDuAnzubpAHcyp2R9wWPEZg07rEHBygnIQTIGDkL+yaoE22nCIazYokiEiZHx
         OqXlggCGNyYUSVj64Oc1lx5IGRdiX7xMl0w5SctXcGh3eJPib5/0F1rpKVIwzKqbfPV0
         I8dw==
X-Gm-Message-State: ACgBeo2bOKp8JCNUZpi5IkI17+YdUBAuf1RLUs8FHQ+swpPWcBoa9ZO+
        2FiiG6Q20YChWveB7hqH41AvMw==
X-Google-Smtp-Source: AA6agR7HY0wQU3y5yY6Kddj9MwzCY8wYP5mk/EVfoL8kIoQTc3N+5GNg+l+pO2qUm7O0zYD6sEsViQ==
X-Received: by 2002:a05:600c:4f44:b0:3a5:6de3:8375 with SMTP id m4-20020a05600c4f4400b003a56de38375mr2992173wmq.198.1660147146409;
        Wed, 10 Aug 2022 08:59:06 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id e5-20020a05600c4e4500b003a32251c3f9sm3033032wmq.5.2022.08.10.08.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 08:59:05 -0700 (PDT)
Date:   Wed, 10 Aug 2022 17:59:03 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: Re: [PATCH v3 01/10] drm/fourcc: Add drm_format_info_bpp() helper
Message-ID: <YvPVxy4kYKdzWgT8@phenom.ffwll.local>
Mail-Followup-To: Geert Uytterhoeven <geert@linux-m68k.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-m68k@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Javier Martinez Canillas <javierm@redhat.com>
References: <cover.1657294931.git.geert@linux-m68k.org>
 <1cae5ebc28513ec1c91c66b00647ce3ca23bfba7.1657294931.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cae5ebc28513ec1c91c66b00647ce3ca23bfba7.1657294931.git.geert@linux-m68k.org>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Fri, Jul 08, 2022 at 08:20:46PM +0200, Geert Uytterhoeven wrote:
> Add a helper to retrieve the actual number of bits per pixel for a
> plane, taking into account the number of characters and pixels per
> block for tiled formats.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
> v3:
>   - Add Reviewed-by,
> 
> v2:
>   - Move up.
> ---
>  drivers/gpu/drm/drm_fourcc.c | 19 +++++++++++++++++++
>  include/drm/drm_fourcc.h     |  1 +
>  2 files changed, 20 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
> index 07741b678798b0f1..cf48ea0b2cb70ba8 100644
> --- a/drivers/gpu/drm/drm_fourcc.c
> +++ b/drivers/gpu/drm/drm_fourcc.c
> @@ -370,6 +370,25 @@ unsigned int drm_format_info_block_height(const struct drm_format_info *info,
>  }
>  EXPORT_SYMBOL(drm_format_info_block_height);
>  
> +/**
> + * drm_format_info_bpp - number of bits per pixel
> + * @info: pixel format info
> + * @plane: plane index
> + *
> + * Returns:
> + * The actual number of bits per pixel, depending on the plane index.
> + */
> +unsigned int drm_format_info_bpp(const struct drm_format_info *info, int plane)
> +{
> +	if (!info || plane < 0 || plane >= info->num_planes)
> +		return 0;
> +
> +	return info->char_per_block[plane] * 8 /
> +	       (drm_format_info_block_width(info, plane) *
> +		drm_format_info_block_height(info, plane));

Do we really needs this for blocky formats where this is potentially
ill-defined? I think if there's no need then this should also return 0
when block_width/height != 1, it doesn't make much sense to compute bpp
when it's not really bits per _pixel_.

Minimally this needs to check whether the division actually makes sense or
whether there's a reminder, and if there's  reminder, then fail. But that
feels like a bad hack and I think we should avoid it if it's not
absolutely necessary.

Otherwise lgtm.
-Daniel

> +}
> +EXPORT_SYMBOL(drm_format_info_bpp);
> +
>  /**
>   * drm_format_info_min_pitch - computes the minimum required pitch in bytes
>   * @info: pixel format info
> diff --git a/include/drm/drm_fourcc.h b/include/drm/drm_fourcc.h
> index 22aa64d07c7905e2..3800a7ad7f0cda7a 100644
> --- a/include/drm/drm_fourcc.h
> +++ b/include/drm/drm_fourcc.h
> @@ -313,6 +313,7 @@ unsigned int drm_format_info_block_width(const struct drm_format_info *info,
>  					 int plane);
>  unsigned int drm_format_info_block_height(const struct drm_format_info *info,
>  					  int plane);
> +unsigned int drm_format_info_bpp(const struct drm_format_info *info, int plane);
>  uint64_t drm_format_info_min_pitch(const struct drm_format_info *info,
>  				   int plane, unsigned int buffer_width);
>  
> -- 
> 2.25.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
