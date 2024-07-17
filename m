Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F3917FABC
	for <linux-fbdev@vger.kernel.org>; Wed, 17 Jul 2024 15:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721228941; cv=none; b=Mpyn6qY5akl8gfUXS0PTxhIy0b09I7IybRg/j1z9M2PD1x+T7XCLB/MZejYhmnpaIbhyvR9WPAFri9vG5kAHloNXFzQglmpVdqCH5CaYLWcJKhg97kHfvjRqWmdFA/KdgyOQKotRdveKxlmxiDjGx8ruzugJpZzEayYbmyw4Phs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721228941; c=relaxed/simple;
	bh=r46AnO6z5V7ywCMqp7Rmp0vQNfGHGsHx6bjdydhM20U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U/H7il1ZfBoTOuHfjrpSQ1ZNzteHHuU6Gm/VzhfMSWTCDh+4BsKRAIkC3aq8jV+jo8pbQufvmMp0So2OetQMq+Egokl63l+K4fvXq7a5FGVcOpl/uW2Qa0lRmiYiiQwgJrFG48NckAsq2C6+QgZ0OD6p8sCi/sK7VyYIfa8T/pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=K+tZme9C; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="K+tZme9C"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-427bc3877d0so2004755e9.2
        for <linux-fbdev@vger.kernel.org>; Wed, 17 Jul 2024 08:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1721228938; x=1721833738; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s77sxARyPcLu/24QtoN8ND9W5Zo8PTRc1Nw51x3CKtQ=;
        b=K+tZme9CTDUNALaJHh70qlr8DqdbojMp//PZzYbu5RQH7BBN+Q5gQTT75stOF8xwpd
         g0xb/CJl2Mb0JQnZN4uegjkYcROgu0eEpCEwJLDfVoSg3m/MuCQj5/GT3QCsH970RA5R
         ykLWPQDSikKL6HWUKMwuTeXz/1FTbNyjzRHvw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721228938; x=1721833738;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s77sxARyPcLu/24QtoN8ND9W5Zo8PTRc1Nw51x3CKtQ=;
        b=T6vNmhtvCkgVUuyxSNqvNmXwZOXO+lP5wCjnAcafwD7nPi5R4bzrC17G5SWvp8kuC6
         TKSxl9a1fWWM7XX98Nffzrm5T9R465/SYlvH9/abqb7LTK8Xz452vpFmpERPUUItZov+
         HKCYtzra/VEbVq6t2YMiHySFu+nJ33GnyiZDCHqDl9OsNXypdfrb4PJweOt/jar4jnKE
         8QkAsan0WU5uixp/+n8+KcPSQ1DLmHscQ9w0gIcuTYxKXp9+3jsBKH8JrBmD+Jn3hCpA
         T9qMiD6VK/1eG7i5Y2QvHAyAKX5hE12EvFhQoIyakLs1rbl2IfOfUxXmf/Be2ruZ+GGN
         ckQA==
X-Forwarded-Encrypted: i=1; AJvYcCVP5ua5oKDdqinSO4adt9caFT48kK8UVH9nTwpbQAgGpwBuutTr9Hnsv7fp0UYJKFzYOwQ85zjsrKHrqrfRlPcBFVjCXWpBrGSGSYQ=
X-Gm-Message-State: AOJu0YzLrjmoBoD/REbjp/H84+tDit0DqjG0mwAFWJtgtjj8qdbXOqBJ
	4v47RjiwkYe8oiRbKr79riRPNlAwt6wdIBIcx5FiJ/2aSBzyNfRZNIiIputW1PY=
X-Google-Smtp-Source: AGHT+IH1i/w84Z4TRUoKj/BGXwmxibTxvjiniJriyPObqoZKHx+24ILVUcBSnoq6KRs8SxxUKsqewA==
X-Received: by 2002:a05:600c:3501:b0:426:6a0d:1ae5 with SMTP id 5b1f17b1804b1-427c2c0ef1bmr9093365e9.0.1721228938505;
        Wed, 17 Jul 2024 08:08:58 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427c77b05aesm1309505e9.14.2024.07.17.08.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 08:08:58 -0700 (PDT)
Date: Wed, 17 Jul 2024 17:08:56 +0200
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
Subject: Re: [PATCH 1/3] drm/panic: Add drm_panic_is_enabled()
Message-ID: <ZpfeiMj48JQTQcOE@phenom.ffwll.local>
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
 <20240717090102.968152-2-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717090102.968152-2-jfalempe@redhat.com>
X-Operating-System: Linux phenom 6.9.7-amd64 

On Wed, Jul 17, 2024 at 10:48:39AM +0200, Jocelyn Falempe wrote:
> It allows to check if the drm device supports drm_panic.
> Prepare the work to have better integration with fbcon and vtconsole.
> 
> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
> ---
>  drivers/gpu/drm/drm_panic.c | 20 ++++++++++++++++++++
>  include/drm/drm_panic.h     |  2 ++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
> index 948aed00595e..d9a25c2d0a65 100644
> --- a/drivers/gpu/drm/drm_panic.c
> +++ b/drivers/gpu/drm/drm_panic.c
> @@ -703,6 +703,26 @@ static void debugfs_register_plane(struct drm_plane *plane, int index)
>  static void debugfs_register_plane(struct drm_plane *plane, int index) {}
>  #endif /* CONFIG_DRM_PANIC_DEBUG */
>  
> +/**
> + * drm_panic_is_enabled
> + * @dev: the drm device that may supports drm_panic
> + *
> + * returns true if the drm device supports drm_panic
> + */
> +bool drm_panic_is_enabled(struct drm_device *dev)
> +{
> +	struct drm_plane *plane;
> +
> +	if (!dev->mode_config.num_total_plane)
> +		return false;
> +
> +	drm_for_each_plane(plane, dev)
> +		if (plane->helper_private && plane->helper_private->get_scanout_buffer)
> +			return true;
> +	return false;
> +}
> +EXPORT_SYMBOL(drm_panic_is_enabled);

This feels like overkill since you currently only have one user in the
fbdev emulation code, but maybe useful in some other places ...

> +
>  /**
>   * drm_panic_register() - Initialize DRM panic for a device
>   * @dev: the drm device on which the panic screen will be displayed.
> diff --git a/include/drm/drm_panic.h b/include/drm/drm_panic.h
> index 73bb3f3d9ed9..c3a358dc3e27 100644
> --- a/include/drm/drm_panic.h
> +++ b/include/drm/drm_panic.h
> @@ -148,11 +148,13 @@ struct drm_scanout_buffer {
>  
>  #ifdef CONFIG_DRM_PANIC
>  
> +bool drm_panic_is_enabled(struct drm_device *dev);

Since it's internal only, this should be in
drivers/gpu/drm/drm_crtc_internal.h and not int he include for drivers.
With that:

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

>  void drm_panic_register(struct drm_device *dev);
>  void drm_panic_unregister(struct drm_device *dev);

These two are only used in drm.ko. Can you please move them to
drm_crtc_internal.h too and drop the EXPORT_SYMBOL in a follow-up patch?
We're trying to limit the exported interface and official headers to
really only the pieces drivers actually need.

Thanks, Sima

>  
>  #else
>  
> +bool drm_panic_is_enabled(struct drm_device *dev) {return false; }
>  static inline void drm_panic_register(struct drm_device *dev) {}
>  static inline void drm_panic_unregister(struct drm_device *dev) {}
>  
> -- 
> 2.45.2
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
