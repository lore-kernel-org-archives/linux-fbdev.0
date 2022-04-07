Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B806BC433F5
	for <linux-fbdev@archiver.kernel.org>; Thu,  7 Apr 2022 09:11:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243613AbiDGJNn (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 7 Apr 2022 05:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243622AbiDGJNl (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 7 Apr 2022 05:13:41 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB233C90E2
        for <linux-fbdev@vger.kernel.org>; Thu,  7 Apr 2022 02:11:33 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id l26so9527468ejx.1
        for <linux-fbdev@vger.kernel.org>; Thu, 07 Apr 2022 02:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=RUqwFRBKiy3Of7LlIlozTAVQBDGmsY1swdmuSjymSg4=;
        b=Dwig1lDH/CD6wp+0muFEkyqscS1kh60CsqsPd4pTvM38WbbpVW7g0SpyiRvJIHG2KA
         x8oT4fL3umaFDzh74fKUR/e2xEdy+hwOHWGwVhNnOECj4TF9o5VF3kjtTa+4PP8ECxxY
         pIsmR9GqdtZ7VZLoUaMmOHyE8pbibPWyjXGnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=RUqwFRBKiy3Of7LlIlozTAVQBDGmsY1swdmuSjymSg4=;
        b=KdjQRF5CnLepNwFxdLDcWRNW3lfQzhA7tH+2ICUYamvQa/Xzr4MJa7LqEHDPXcn/xH
         1QemIO0Ybg69hsyra3p414ji/fLxZqYXjKTPNYcjDfB65cHIwGWu/NZsojqdQdT0W8lc
         PCmfbIPcrBDGHg5TTcb49gyuB0NeroNxS/Ex6qbHf81aLgmvZddLs6Ra5e+7+Hft3C1C
         rVBenWnmuHsopJfiGRAzHzf4kCrRATvaX6gY/Wj6mc4IN7AnE6Psp2st7S0TNZsC5b5F
         NNFUeR+LjP+rP1bI1P9ofK7WiiFL+fvTR3bgn5/9/0JJ0ZMq7gcEBu2HGLgCpzD3YQzF
         +tBg==
X-Gm-Message-State: AOAM532Ondo3wT913W7LIIAnokuXLJ5d+RnB1n7j6+vGkDLchrK/JTLx
        gSuhnRyS+l0SiqwV+vazIA8dAw==
X-Google-Smtp-Source: ABdhPJzRxOsuBj4F85jbQqgWte67L+b9pbcgsASEyEWhJb6OkaNfDfq7RQMxbT5cI+yZeKBQkA6bWg==
X-Received: by 2002:a17:906:1b46:b0:6e8:4cc:b381 with SMTP id p6-20020a1709061b4600b006e804ccb381mr12205836ejg.563.1649322692479;
        Thu, 07 Apr 2022 02:11:32 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id s11-20020a1709066c8b00b006e7ca6f0401sm4982037ejr.136.2022.04.07.02.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 02:11:31 -0700 (PDT)
Date:   Thu, 7 Apr 2022 11:11:30 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Helge Deller <deller@gmx.de>, Sam Ravnborg <sam@ravnborg.org>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-fbdev@vger.kernel.org
Subject: Re: [RESEND RFC PATCH 4/5] fbdev: Fix some race conditions between
 fbmem and sysfb
Message-ID: <Yk6qwiP2kEh2M3Fm@phenom.ffwll.local>
Mail-Followup-To: Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Alex Deucher <alexander.deucher@amd.com>,
        Guenter Roeck <linux@roeck-us.net>, Helge Deller <deller@gmx.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Zhen Lei <thunder.leizhen@huawei.com>, linux-fbdev@vger.kernel.org
References: <20220406213919.600294-1-javierm@redhat.com>
 <20220406213919.600294-5-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406213919.600294-5-javierm@redhat.com>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, Apr 06, 2022 at 11:39:18PM +0200, Javier Martinez Canillas wrote:
> The platform devices registered in sysfb match with a firmware-based fbdev
> or DRM driver, that are used to have early graphics using framebuffers set
> up by the system firmware.
> 
> Real DRM drivers later are probed and remove all conflicting framebuffers,
> leading to these platform devices for generic drivers to be unregistered.
> 
> But the current solution has two issues that this patch fixes:
> 
> 1) It is a layering violation for the fbdev core to unregister a device
>    that was registered by sysfb.
> 
>    Instead, the sysfb_try_unregister() helper function can be called for
>    sysfb to attempt unregistering the device if is the one registered.
> 
> 2) The sysfb_init() function could be called after a DRM driver is probed
>    and requested to unregister devices for drivers with a conflicting fb.
> 
>    To prevent this, disable any future sysfb platform device registration
>    by calling sysfb_disable(), if a driver requested to remove conflicting
>    framebuffers with remove_conflicting_framebuffers().
> 
> Suggested-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
> 
>  drivers/video/fbdev/core/fbmem.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> index c1bfb8df9cba..acf641b05d11 100644
> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -19,6 +19,7 @@
>  #include <linux/kernel.h>
>  #include <linux/major.h>
>  #include <linux/slab.h>
> +#include <linux/sysfb.h>
>  #include <linux/mm.h>
>  #include <linux/mman.h>
>  #include <linux/vt.h>
> @@ -1588,7 +1589,10 @@ static void do_remove_conflicting_framebuffers(struct apertures_struct *a,
>  				 * unregister_framebuffer() function that takes it.
>  				 */
>  				mutex_unlock(&registration_lock);
> -				platform_device_unregister(to_platform_device(device));
> +				if (!sysfb_try_unregister(device)) {
> +					/* sysfb didn't register this device, unregister it */

Maybe explain in the commit message that this is still needed for drivers
which set up their platform_dev themselves, like vga16fb.

Also I'm not sure we want to have an assumption encoded in fbmem.c here
that the sysfb device is always a platform device. I think it would be
better to call sysfb_try_unregister on any device, and then fall back to
the forced removal on our own if it's a platform device.

Also maybe change the comment to /* FIXME: Not all platform fb drivers use sysfb yet */

> +					platform_device_unregister(to_platform_device(device));
> +				}
>  				mutex_lock(&registration_lock);
>  				/*
>  				 * Restart the removal now that the platform device
> @@ -1781,6 +1785,17 @@ int remove_conflicting_framebuffers(struct apertures_struct *a,
>  		do_free = true;
>  	}
>  
> +	/*
> +	 * If a driver asked to unregister a platform device registered by
> +	 * sysfb, then can be assumed that this is a driver for a display
> +	 * that is set up by the system firmware and has a generic driver.
> +	 *
> +	 * Drivers for devices that don't have a generic driver will never
> +	 * ask for this, so let's assume that a real driver for the display
> +	 * was already probed and prevent sysfb to register devices later.
> +	 */

Yeah it's disappointing, but no worse than the piles of hacks we have now.

With the bikesheds addressed above:

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> +	sysfb_disable();
> +
>  	mutex_lock(&registration_lock);
>  	do_remove_conflicting_framebuffers(a, name, primary);
>  	mutex_unlock(&registration_lock);
> -- 
> 2.35.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
