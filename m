Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D83AC43334
	for <linux-fbdev@archiver.kernel.org>; Sun, 26 Jun 2022 08:50:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbiFZIu0 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 26 Jun 2022 04:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiFZIu0 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sun, 26 Jun 2022 04:50:26 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD67A11453
        for <linux-fbdev@vger.kernel.org>; Sun, 26 Jun 2022 01:50:24 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id h23so12995347ejj.12
        for <linux-fbdev@vger.kernel.org>; Sun, 26 Jun 2022 01:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SFCEfpaDlOL9hYml7KkA/FOqx9Sb54eiS155GWVwklM=;
        b=MnWD6z0LPe34WH9gWk0zAiiztfYEz9A65uau3VeI5LtTrqAcQZraMuJMlqpb6gl64/
         11JQ6GCkiCalO4Zoc4ASTm1txitASCcYx9jjzVmuF3WXfGJnMloVIsOlrsHCjb1z2DVJ
         cOGaFkjFnDN9kFluKqkKpkuEgNdqHkYD5jbwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SFCEfpaDlOL9hYml7KkA/FOqx9Sb54eiS155GWVwklM=;
        b=lRwpw5qihpBd3ETXM/muL9BM0GYd9gSX2Z0OMiLsOpf1QfeR77ZDc9grDtJkbun43p
         pcX4tvAI8s/YqHKOkvN77VrsPruF2iad9k5pZXcAYiB9J67HZ648lPUbdyW22WjWZE+l
         zk5Jaa20LM48s6VEV4QHc7IHs1OSdlpLk8ALQ2XNY2Xj7cgrWYoEKbpdQQNA1L/zA9+k
         1ARAflFGWTS7KMv1/2nrKPC4j8VwKA2QFWfZiiy/dEPE4lQl2znpn8RLO6TkGyiS2THd
         dJsZxeFjDdpKEh3SlAkZ3MB1rsK4Gj3egfNSgE/VsMz+ZG5tpyEEkGexzv9Yf+T7nHc9
         Ah3Q==
X-Gm-Message-State: AJIora8HmDOOc/955Y4nUA9sE5O8it/bNbkgWMyL4Jj0GlXcn+GQlI8y
        19txXbkahoJolMgf7VNHQJJNCA==
X-Google-Smtp-Source: AGRyM1vELRzz0C9nDQlgjLFs2MvjZPAik8xdHUmKO6PMy3pgJPjIGZlWyN8EOdnZ+vFlJwec2qFneg==
X-Received: by 2002:a17:907:94ce:b0:726:449e:73cc with SMTP id dn14-20020a17090794ce00b00726449e73ccmr6040264ejc.270.1656233423330;
        Sun, 26 Jun 2022 01:50:23 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id i10-20020a170906698a00b0071cbc7487e0sm3556304ejr.71.2022.06.26.01.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jun 2022 01:50:22 -0700 (PDT)
Date:   Sun, 26 Jun 2022 10:50:21 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Helge Deller <deller@gmx.de>
Cc:     dri-devel@lists.freedesktop.org, daniel.vetter@ffwll.ch,
        linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v4 2/3] fbcon: Prevent that screen size is smaller than
 font size
Message-ID: <YrgdzT7LwoCv6Vok@phenom.ffwll.local>
References: <20220625232703.401821-1-deller@gmx.de>
 <20220625232703.401821-3-deller@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220625232703.401821-3-deller@gmx.de>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Sun, Jun 26, 2022 at 01:27:02AM +0200, Helge Deller wrote:
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
> This patch depends on commit 409d6c95f9c6 ("fbcon: Introduce wrapper for console->fb_info lookup"),
> so it needs to be backported as well.
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
> index e162d5e753e5..2ab7515ac842 100644
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
> +		if (!vc || fbcon_info_from_console(i) != info)
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
> index afa2863670f3..160389365a36 100644
> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -1106,7 +1106,9 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
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
