Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 719CBC433EF
	for <linux-fbdev@archiver.kernel.org>; Sun, 26 Jun 2022 09:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233848AbiFZJ6r (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 26 Jun 2022 05:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbiFZJ6q (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sun, 26 Jun 2022 05:58:46 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B4FE0F2
        for <linux-fbdev@vger.kernel.org>; Sun, 26 Jun 2022 02:58:44 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id c13so9168360eds.10
        for <linux-fbdev@vger.kernel.org>; Sun, 26 Jun 2022 02:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eOQ2h2PN7Q8f3N8xyxH26Dzet5W+a2jwnNsGimzLoCU=;
        b=RmJNAF1Yw2GFQyCzjCnRFWOHoojqGwzUpkK8yByvWr6JXHlTclntETHfsQ8C7E5/DO
         OMphFuqYeCKCXSqcZf2jOJOqwUcGvcmbltLEhz0FfB8WT6lpGhjQeumfjfYqItYSirIg
         n+enPNZzcSiANeKP4Fh94jRkSwsr5mSHWUIR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eOQ2h2PN7Q8f3N8xyxH26Dzet5W+a2jwnNsGimzLoCU=;
        b=QoRZkDR3zBYINDASKiI+fMstowPJWdwREYPhvhuYxj2Q07Lwwz98QzeRnu2NrdiZx5
         ERhv4KjFKdGT7/GU1p/PuJH48XE0PNdUi4DctFp1bHBUi8E1FHWLgPVJPOsZs4kS2/cT
         bjb95nOPqm3gTuJfTy6tkDQdhYd3kycCmkO9m7i2m5NJohAgwRX0QI14wHaInc+BhXaA
         xHMzpPLkkCSvLsdLyVbupL1pFc1Te0uJcLg5lXzzql9iUGl1lFIzc1R46shwXO6zM8JK
         wAON1FbU0+Aa97fnA1rVldIIUE+jtAjG6fNwlVqrOsA9V5tGIZ6pMISevjvZy7fn+Ff9
         bzdA==
X-Gm-Message-State: AJIora9/5W8/6DP0hU8h1KqwCqYFld95O6kR7uOnOxgaCt8+OOoq5qjN
        DHpP4JWGBtjFa8bo8xWgpqhjow==
X-Google-Smtp-Source: AGRyM1u36LB6OvWR+ikyDWR7knlr+ZogwD+FcpqHAEFTglVMQ46HwwMAgm2vFGOBMK8jLKTVtwM54w==
X-Received: by 2002:a05:6402:2804:b0:431:7dde:6fb5 with SMTP id h4-20020a056402280400b004317dde6fb5mr10024324ede.379.1656237523374;
        Sun, 26 Jun 2022 02:58:43 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id b5-20020aa7cd05000000b0042bc5a536edsm5571111edw.28.2022.06.26.02.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jun 2022 02:58:42 -0700 (PDT)
Date:   Sun, 26 Jun 2022 11:58:41 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Helge Deller <deller@gmx.de>
Cc:     dri-devel@lists.freedesktop.org, daniel.vetter@ffwll.ch,
        linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v5 3/4] fbcon: Prevent that screen size is smaller than
 font size
Message-ID: <Yrgt0dUnZjAm3eZT@phenom.ffwll.local>
References: <20220626085615.53728-1-deller@gmx.de>
 <20220626085615.53728-4-deller@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220626085615.53728-4-deller@gmx.de>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Sun, Jun 26, 2022 at 10:56:14AM +0200, Helge Deller wrote:
> We need to prevent that users configure a screen size which is smaller than the
> currently selected font size. Otherwise rendering chars on the screen will
> access memory outside the graphics memory region.
> 
> This patch adds a new function fbcon_modechange_possible() which
> implements this check and which later may be extended with other checks
> if necessary.  The new function is called from the FBIOPUT_VSCREENINFO
> ioctl handler in fbmem.c, which will return -EINVAL if userspace asked
> for a too small screen size.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> Cc: stable@vger.kernel.org # v5.4+

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/video/fbdev/core/fbcon.c | 27 +++++++++++++++++++++++++++
>  drivers/video/fbdev/core/fbmem.c |  4 +++-
>  include/linux/fbcon.h            |  4 ++++
>  3 files changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
> index e162d5e753e5..69c7261ac334 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -2736,6 +2736,33 @@ void fbcon_update_vcs(struct fb_info *info, bool all)
>  }
>  EXPORT_SYMBOL(fbcon_update_vcs);
> 
> +/* let fbcon check if it supports a new screen resolution */
> +int fbcon_modechange_possible(struct fb_info *info, struct fb_var_screeninfo *var)
> +{
> +	struct fbcon_ops *ops = info->fbcon_par;
> +	struct vc_data *vc;
> +	int i;
> +
> +	WARN_CONSOLE_UNLOCKED();
> +
> +	if (!ops || ops->currcon < 0)
> +		return -EINVAL;
> +
> +	/* prevent setting a screen size which is smaller than font size */
> +	for (i = first_fb_vc; i <= last_fb_vc; i++) {
> +		vc = vc_cons[i].d;
> +		if (!vc || registered_fb[con2fb_map[i]] != info)
> +			continue;
> +
> +		if (vc->vc_font.width  > FBCON_SWAP(var->rotate, var->xres, var->yres) ||
> +		    vc->vc_font.height > FBCON_SWAP(var->rotate, var->yres, var->xres))
> +			return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(fbcon_modechange_possible);
> +
>  int fbcon_mode_deleted(struct fb_info *info,
>  		       struct fb_videomode *mode)
>  {
> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> index 5dfa4bbee642..b6e1d0f2b974 100644
> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -1112,7 +1112,9 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
>  			return -EFAULT;
>  		console_lock();
>  		lock_fb_info(info);
> -		ret = fb_set_var(info, &var);
> +		ret = fbcon_modechange_possible(info, &var);
> +		if (!ret)
> +			ret = fb_set_var(info, &var);
>  		if (!ret)
>  			fbcon_update_vcs(info, var.activate & FB_ACTIVATE_ALL);
>  		unlock_fb_info(info);
> diff --git a/include/linux/fbcon.h b/include/linux/fbcon.h
> index ff5596dd30f8..2382dec6d6ab 100644
> --- a/include/linux/fbcon.h
> +++ b/include/linux/fbcon.h
> @@ -15,6 +15,8 @@ void fbcon_new_modelist(struct fb_info *info);
>  void fbcon_get_requirement(struct fb_info *info,
>  			   struct fb_blit_caps *caps);
>  void fbcon_fb_blanked(struct fb_info *info, int blank);
> +int  fbcon_modechange_possible(struct fb_info *info,
> +			       struct fb_var_screeninfo *var);
>  void fbcon_update_vcs(struct fb_info *info, bool all);
>  void fbcon_remap_all(struct fb_info *info);
>  int fbcon_set_con2fb_map_ioctl(void __user *argp);
> @@ -33,6 +35,8 @@ static inline void fbcon_new_modelist(struct fb_info *info) {}
>  static inline void fbcon_get_requirement(struct fb_info *info,
>  					 struct fb_blit_caps *caps) {}
>  static inline void fbcon_fb_blanked(struct fb_info *info, int blank) {}
> +static inline int  fbcon_modechange_possible(struct fb_info *info,
> +				struct fb_var_screeninfo *var) { return 0; }
>  static inline void fbcon_update_vcs(struct fb_info *info, bool all) {}
>  static inline void fbcon_remap_all(struct fb_info *info) {}
>  static inline int fbcon_set_con2fb_map_ioctl(void __user *argp) { return 0; }
> --
> 2.35.3
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
