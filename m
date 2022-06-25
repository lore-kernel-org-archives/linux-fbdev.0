Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900BCC43334
	for <linux-fbdev@archiver.kernel.org>; Sat, 25 Jun 2022 22:34:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233529AbiFYWeP (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 25 Jun 2022 18:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbiFYWeO (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 25 Jun 2022 18:34:14 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17BDBE31
        for <linux-fbdev@vger.kernel.org>; Sat, 25 Jun 2022 15:34:13 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id z19so8059428edb.11
        for <linux-fbdev@vger.kernel.org>; Sat, 25 Jun 2022 15:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=L4B2P55ZFiYVCJ5DZUrHpNuoCg7yfMFjsA7dxqf94Ng=;
        b=CqNHYBzkAe+4uRJq+tgr9R+4iN85PvgiXpvwNIYaGcGIXorRGxtHVNIGaK99IVdvHT
         pUVMoPtPZq21KAi119Y47YaNA7tifutRngx+CWoVeN99hg/akvJEXvPC0wNJ41pEdVG9
         0ynPpYCeziouXY4GdLbb6tymzQXgUcd37bbyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L4B2P55ZFiYVCJ5DZUrHpNuoCg7yfMFjsA7dxqf94Ng=;
        b=suJf6A8ghZBMr3PbORqgSBzAz1ifUepaKjyzcihyZT8ECs6c88mnS3IxBq6aBSjE28
         iRYl7EZ8t+iB4t+jdXJp+uP8eFjUfn7asSy2hEpRYRmvE+9dsk4qDNVfFglDX7Jpqki+
         fw9RpmR8Lg0Qxl949ygPlTCpsDtMFTHvilXcOfJoZc18lHjnZ6BWG0bY2wf1EiJyRdl1
         ibOo7kT+aTI5APN5/36u6tlnJdsz6LylQL7moSWH9lGldec1Yr2cqGSx3lelc15Hk6Y4
         rLA38CGJX43MiuYaVYo9lgtX/9E9PCUs7s5bxXR4VnkLzQ2CuHXJuxILM1fKLFWCk0j9
         Ep4w==
X-Gm-Message-State: AJIora+q+wYUnfmxJ7mvv40sZMGTZAnZhKMKWg89Uiym2MZSbQzhyiWd
        z9FXcyFtzea2khBMmoX40MjVLg==
X-Google-Smtp-Source: AGRyM1vFAMaVxrejgeHUVQtzbSf/+IsHavPxXruTBVbtBZT+dYhiGU9cCoDUlUW+zQyF/K8weo8tQA==
X-Received: by 2002:a05:6402:50f:b0:435:7996:e90f with SMTP id m15-20020a056402050f00b004357996e90fmr7436475edv.110.1656196452357;
        Sat, 25 Jun 2022 15:34:12 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id o7-20020a170906860700b00722d5f07864sm3004263ejx.225.2022.06.25.15.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jun 2022 15:34:11 -0700 (PDT)
Date:   Sun, 26 Jun 2022 00:34:10 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Helge Deller <deller@gmx.de>
Cc:     dri-devel@lists.freedesktop.org, daniel.vetter@ffwll.ch,
        linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v3 4/4] fbmem: Prevent invalid virtual screen sizes
Message-ID: <YreNYlP17bJGx6NV@phenom.ffwll.local>
References: <20220625220630.333705-1-deller@gmx.de>
 <20220625220630.333705-5-deller@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220625220630.333705-5-deller@gmx.de>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Sun, Jun 26, 2022 at 12:06:30AM +0200, Helge Deller wrote:
> Prevent that drivers or the user sets the virtual screen resolution
> smaller than the physical screen resolution.  This is important, because
> otherwise we may get accesses outside of the graphics memory area.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> Cc: stable@vger.kernel.org # v5.4+

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/video/fbdev/core/fbmem.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> index 160389365a36..b6e1d0f2b974 100644
> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -1006,6 +1006,12 @@ fb_set_var(struct fb_info *info, struct fb_var_screeninfo *var)
>  	if (var->xres < 8 || var->yres < 8)
>  		return -EINVAL;
> 
> +	/* make sure virtual resolution >= physical resolution */
> +	if (var->xres_virtual < var->xres)
> +		return -EINVAL;
> +	if (var->yres_virtual < var->yres)
> +		return -EINVAL;
> +
>  	/* Too huge resolution causes multiplication overflow. */
>  	if (check_mul_overflow(var->xres, var->yres, &unused) ||
>  	    check_mul_overflow(var->xres_virtual, var->yres_virtual, &unused))
> --
> 2.35.3
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
