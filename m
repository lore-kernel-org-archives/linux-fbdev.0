Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85FB181BB9
	for <linux-fbdev@vger.kernel.org>; Wed, 17 Jul 2024 15:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721228662; cv=none; b=E9Mg1QjpP7CW6lBKwVJPf/WKtey0FCMoSenS/yTwoBeIyJB2WvT5KdIeBW4nK0pNxdHiXfegN/72P7oj4ZCpIcLtxVXfeXazsWXw2+cQUBv+SF5V6UobwgEfTvsaqcJcsq2Uk7hI/A4REu/pg0zNNnWiif6dCwF2DJGVgWfZvEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721228662; c=relaxed/simple;
	bh=cEVK6GIdWYaMZGA/hOHwHVgRjYyYadpMzyQcAdayBwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qPwa0qfahPOY+3LfGwS5EkXwrHhQ97AqhBGHoC39R0cpxrWPhu8y4jTtVi1CeXVFF0ouOmWPT7g+3uc4xJVyOt17wVyGk+zBBblOglxqVEAOV8ZkaVHICHBxadgMf6jkPVALM+yZ+m4NOeWBMVAfaaiwj+UeFL2QovAC7reLG0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=UA8DGrlt; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="UA8DGrlt"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-427bc3877d0so2000435e9.2
        for <linux-fbdev@vger.kernel.org>; Wed, 17 Jul 2024 08:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1721228659; x=1721833459; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u5pjr/7PlGU0bno59J3w/W6V2Jp6tDpULmroTCCRYAE=;
        b=UA8DGrlt4trcsuvR5a2AbRTmQiIbtgLVuqyHK0SRfN4/F4N41CYRLv8Jpyu8SZZ3yw
         mj9vTPL1KmpnzKHNTkeRTBMRSQxBMz4rZsDGPfCgP5kUopfworoXIku4P6lQVfUnS9tx
         8ZSLmmPHaLh7ERlBsK6NuloqkQch7ZjC5OE6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721228659; x=1721833459;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u5pjr/7PlGU0bno59J3w/W6V2Jp6tDpULmroTCCRYAE=;
        b=lt2fflwbnYHp8MLZAqx075ywyRSVmbEqBVn0An7Puc6E6Ru7I1WEtl8pB4sO7FI1Ow
         L1x6CKMWBsEkeQKS8m+6NoZ+1ewSxNtetAW55GJSwN9dlp+bs5NpAFuP8ph0/EIPNs3d
         vlqgGiQGD+6rDdkFvgApH90CClfZg1KMB0btNY6Ws7qOUONZTN98Rh8zrFsYDzcSC3ra
         ucEbCZrrXc6+Cier7uDImf64Hcv3p0KUn5ZSVgn5+TaiAOFfCueF4h/ASsGx32qQYGgr
         jWrraNEdl27ARovFY7SgUsk4M4Vpa3Zw+ezJrsE8U6ZASib8qgGgQDkCySfDOG4+Fojb
         zwTA==
X-Forwarded-Encrypted: i=1; AJvYcCUNcEd8pnOlAlvQtdXAv5rfRh57ZRkZyn+dA48QBqlTGT1Jx1QCVY2bp9iOuPCBw3M25qUw3SuUpidVcYS7em5vxHCWLOtysA0BuMU=
X-Gm-Message-State: AOJu0Yy81xVmxuPo+bbuz7Th7X0GexQMoDsNWnS3YDEYNCgafJZEZqOt
	VXVjEq8PQDlMufsZwnIg99gEAi6I6dgt7UPstDc+P8ht5V8K34LX0VO++VvIjDXAGGZ44wcnVx6
	pF9E=
X-Google-Smtp-Source: AGHT+IGnQq5qn3XFcUVytJqVgSB3xoYK5wfjBzWyxNvSmCk4IGCgYkb1mLjSP+9pJg5W/Sm0P9gk8w==
X-Received: by 2002:a05:600c:1c86:b0:424:ac9f:5c61 with SMTP id 5b1f17b1804b1-427c2d0c8eemr8946465e9.3.1721228659021;
        Wed, 17 Jul 2024 08:04:19 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427c78076f7sm1074075e9.37.2024.07.17.08.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 08:04:18 -0700 (PDT)
Date: Wed, 17 Jul 2024 17:04:16 +0200
From: Daniel Vetter <daniel.vetter@ffwll.ch>
To: Jocelyn Falempe <jfalempe@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Helge Deller <deller@gmx.de>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Samuel Thibault <samuel.thibault@ens-lyon.org>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 2/3] fbcon: Add an option to disable fbcon in panic.
Message-ID: <ZpfdcC2Es9rweHW_@phenom.ffwll.local>
Mail-Followup-To: Jocelyn Falempe <jfalempe@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Helge Deller <deller@gmx.de>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Samuel Thibault <samuel.thibault@ens-lyon.org>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-fbdev@vger.kernel.org
References: <20240717090102.968152-1-jfalempe@redhat.com>
 <20240717090102.968152-3-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717090102.968152-3-jfalempe@redhat.com>
X-Operating-System: Linux phenom 6.9.7-amd64 

On Wed, Jul 17, 2024 at 10:48:40AM +0200, Jocelyn Falempe wrote:
> This is required to avoid conflict between DRM_PANIC, and fbcon. If
> a drm device already handle panic with drm_panic, it should set
> the skip_panic field in fb_info, so that fbcon will stay quiet, and
> not overwrite the panic_screen.
> 
> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
> ---
>  drivers/gpu/drm/drm_fb_helper.c  | 2 ++
>  drivers/video/fbdev/core/fbcon.c | 7 ++++++-
>  include/linux/fb.h               | 1 +
>  3 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
> index e2e19f49342e..3662d664d8f9 100644
> --- a/drivers/gpu/drm/drm_fb_helper.c
> +++ b/drivers/gpu/drm/drm_fb_helper.c
> @@ -40,6 +40,7 @@
>  #include <drm/drm_fourcc.h>
>  #include <drm/drm_framebuffer.h>
>  #include <drm/drm_modeset_helper_vtables.h>
> +#include <drm/drm_panic.h>
>  #include <drm/drm_print.h>
>  #include <drm/drm_vblank.h>
>  
> @@ -524,6 +525,7 @@ struct fb_info *drm_fb_helper_alloc_info(struct drm_fb_helper *fb_helper)
>  	fb_helper->info = info;
>  	info->skip_vt_switch = true;
>  
> +	info->skip_panic = drm_panic_is_enabled(fb_helper->dev);
>  	return info;
>  
>  err_release:

Bit a bikeshed, but I'd split this patch out since it's for drm's fbdev
emulation, not the fbcon core code. With that:

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
> index 3f7333dca508..498d9c07df80 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -270,12 +270,17 @@ static int fbcon_get_rotate(struct fb_info *info)
>  	return (ops) ? ops->rotate : 0;
>  }
>  
> +static bool fbcon_skip_panic(struct fb_info *info)
> +{
> +	return (info->skip_panic && unlikely(atomic_read(&panic_cpu) != PANIC_CPU_INVALID));
> +}
> +
>  static inline int fbcon_is_inactive(struct vc_data *vc, struct fb_info *info)
>  {
>  	struct fbcon_ops *ops = info->fbcon_par;
>  
>  	return (info->state != FBINFO_STATE_RUNNING ||
> -		vc->vc_mode != KD_TEXT || ops->graphics);
> +		vc->vc_mode != KD_TEXT || ops->graphics || fbcon_skip_panic(info));
>  }
>  
>  static int get_color(struct vc_data *vc, struct fb_info *info,
> diff --git a/include/linux/fb.h b/include/linux/fb.h
> index db7d97b10964..865dad03e73e 100644
> --- a/include/linux/fb.h
> +++ b/include/linux/fb.h
> @@ -510,6 +510,7 @@ struct fb_info {
>  	void *par;
>  
>  	bool skip_vt_switch; /* no VT switch on suspend/resume required */
> +	bool skip_panic; /* Do not write to the fb after a panic */
>  };
>  
>  /* This will go away
> -- 
> 2.45.2
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
