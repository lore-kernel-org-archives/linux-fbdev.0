Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16422F2B
	for <linux-fbdev@vger.kernel.org>; Mon, 22 Jul 2024 14:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721657757; cv=none; b=Kfv1nQFEo3KONMfnEZdAn9lYs1r2dOxesln98h6JIpsR17V80eyZfEb/Gr3qv45I6vnFl6nALu55np9meL8p8piFHIl3tWrBE+fbJtXEwfi9t3HikDc8y+Wm4tBdK8UOtGgd4HZ4Q9odhBmbY9pVwtDN9IkCTqRb0bY0LGGYK6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721657757; c=relaxed/simple;
	bh=/bMCdeAxD7K7BVgmnDjAgP6K3m38Gu8o6wtZ2yOsJU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jAwh4gLudoTkUD8lqre4zGXSK9FHgjMsbCMGlAJ1kxBkq1IfX5BVOCej7/HY3l0EGdtx9JnwuaG/aIy+Z/m9Kp2wTLlGOtoIZMAPzXftaXIPBmtxNdcA8vbHddZxOxE5nHgk54h0XppJRV05uhrlZ4DqUO8op930XB+ikFkw/5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=ZUzFTEuW; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="ZUzFTEuW"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-426659ff58bso5017405e9.2
        for <linux-fbdev@vger.kernel.org>; Mon, 22 Jul 2024 07:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1721657754; x=1722262554; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kx0TDuI5m4f7x9Raak4pwIhIi0qr9N6AUQbyBu7jk58=;
        b=ZUzFTEuW+Va0VQGICJNQHdT7Hve0n6AeQR08q2MMrDDB5CqDcykRON6BYdMPq1evYZ
         xOu+bCxcnSGL0hufw7fF/q0lh3X3nLG46AjAx24ng3AAilzKfPRauSLge1TbcKlxmv4M
         kHsOpMhFMYEkF4fwlUe/czwrS+pLLTVASzANc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721657754; x=1722262554;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kx0TDuI5m4f7x9Raak4pwIhIi0qr9N6AUQbyBu7jk58=;
        b=aZR3qC4bYFuelJgp8rRARz+yJP+pVe7f+nRVgf7klPDjg+iCbQeVJ+V1jly1nSO1yz
         Svyv/eCLooAR6Reih+mAUruD+lpHrGDURDcF/e/q5Gv8YCrs66KFoxHFMEODQDaM8T+I
         hSueN+pKQiLdpQWLhRUpiYhAofEgwnaLEkYkBNX2FZRAu7q6550mGd2tnRaD8+vl0lJN
         g8GENFbg32oVXvC+lrUnsOXyN4CjB6djSOqnbFIbVYEZDSxbOV8SssOEkl5d4qEGmJaG
         ekeZWp1yltJNG1x0TN7tDC7j32sD8tCi1igWIar26BJm07H/Pln09agzA5BYc6QZAoTV
         8V+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVP3wLzhhfsprvzFYtBqkyc1VawGDu8Z4btsdKu78og+KQMVum+T432yuhWdR4+bQpuA/VNobqiE10p45N5d53kcWF8jEINFIFJcS8=
X-Gm-Message-State: AOJu0YxkZLGt0PggYrcgzr+xAIe4zaiHhUVMn62q/gy5jHFtkO09hh4/
	PSwWXY+jmW46gh8ag/m839Ie0cBsS8078vQDWrSlh235HatUHF2HGTuk6RJVvgs=
X-Google-Smtp-Source: AGHT+IEzv1gd5cKrmvegzH0V6jzWs76B0Fz3js/yNH+DTr8Mw5A+t9aAP9Md+Wa9gE0EqI3ymSu7Cw==
X-Received: by 2002:a05:6000:2a1:b0:367:4d9d:56a6 with SMTP id ffacd0b85a97d-369b6750465mr3248168f8f.1.1721657754218;
        Mon, 22 Jul 2024 07:15:54 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3687868b5fdsm8596021f8f.38.2024.07.22.07.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 07:15:53 -0700 (PDT)
Date: Mon, 22 Jul 2024 16:15:51 +0200
From: Daniel Vetter <daniel.vetter@ffwll.ch>
To: Jocelyn Falempe <jfalempe@redhat.com>
Cc: lkp@intel.com, Daniel Vetter <daniel@ffwll.ch>,
	Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Javier Martinez Canillas <javierm@redhat.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] fbcon: Use oops_in_progress instead of panic_cpu
Message-ID: <Zp5pl4kcu9q6FWTP@phenom.ffwll.local>
References: <202407210203.2ISiIC9m-lkp@intel.com>
 <20240722114800.174558-1-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722114800.174558-1-jfalempe@redhat.com>
X-Operating-System: Linux phenom 6.9.7-amd64 

On Mon, Jul 22, 2024 at 01:47:51PM +0200, Jocelyn Falempe wrote:
> Panic_cpu is not exported, so it can't be used if fbcon is used as
> a module. Use oops_in_progress in this case, but non-fatal oops won't
> be printed.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202407210203.2ISiIC9m-lkp@intel.com/
> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>

Yeah it's not great but gets the job done.

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Cheers, Sima

> ---
>  drivers/video/fbdev/core/fbcon.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
> index 498d9c07df80..2e093535884b 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -64,6 +64,8 @@
>  #include <linux/console.h>
>  #include <linux/string.h>
>  #include <linux/kd.h>
> +#include <linux/panic.h>
> +#include <linux/printk.h>
>  #include <linux/slab.h>
>  #include <linux/fb.h>
>  #include <linux/fbcon.h>
> @@ -272,7 +274,14 @@ static int fbcon_get_rotate(struct fb_info *info)
>  
>  static bool fbcon_skip_panic(struct fb_info *info)
>  {
> +/* panic_cpu is not exported, and can't be used if built as module. Use
> + * oops_in_progress instead, but non-fatal oops won't be printed.
> + */
> +#if defined(MODULE)
> +	return (info->skip_panic && unlikely(oops_in_progress));
> +#else
>  	return (info->skip_panic && unlikely(atomic_read(&panic_cpu) != PANIC_CPU_INVALID));
> +#endif
>  }
>  
>  static inline int fbcon_is_inactive(struct vc_data *vc, struct fb_info *info)
> 
> base-commit: 7e33fc2ff6754b5ff39b11297f713cd0841d9962
> -- 
> 2.45.2
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
