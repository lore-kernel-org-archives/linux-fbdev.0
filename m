From: Daniel Vetter <daniel@ffwll.ch>
Date: Sat, 04 May 2013 17:45:55 +0000
Subject: Re: [PATCH 2/7] drm (ast, cirrus, mgag200, nouveau, savage, vmwgfx): Rework drm_mtrr_{add, del}
Message-Id: <20130504174555.GT5763@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1367621038.git.luto@amacapital.net>
	<4615b8566e9530e2169a36a5870f1b2eb7e621cd.1367621039.git.luto@amacapital.net>
In-Reply-To: <4615b8566e9530e2169a36a5870f1b2eb7e621cd.1367621039.git.luto@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andy Lutomirski <luto@amacapital.net>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org

On Fri, May 03, 2013 at 04:00:30PM -0700, Andy Lutomirski wrote:
> This replaces drm_mtrr_{add,del} with drm_mtrr_{add,del}_wc.  The
> interface is simplified (because the base and size parameters to
> drm_mtrr_del never did anything) and it uses
> mtrr_{add,del}_wc_if_needed to avoid allocating MTRRs on systems
> that don't need them.
> 
> Signed-off-by: Andy Lutomirski <luto@amacapital.net>
> ---

[snip]

> diff --git a/include/drm/drmP.h b/include/drm/drmP.h
> index 2d94d74..2a3e1fd 100644
> --- a/include/drm/drmP.h
> +++ b/include/drm/drmP.h
> @@ -1250,18 +1250,15 @@ static inline int drm_core_has_MTRR(struct drm_device *dev)
>  	return drm_core_check_feature(dev, DRIVER_USE_MTRR);
>  }
>  
> -#define DRM_MTRR_WC		MTRR_TYPE_WRCOMB
> -
> -static inline int drm_mtrr_add(unsigned long offset, unsigned long size,
> -			       unsigned int flags)
> +static inline int __must_check drm_mtrr_add_wc(unsigned long offset,
> +					       unsigned long size)
>  {
> -	return mtrr_add(offset, size, flags, 1);
> +	return mtrr_add_wc_if_needed(offset, size);
>  }
>  
> -static inline int drm_mtrr_del(int handle, unsigned long offset,
> -			       unsigned long size, unsigned int flags)
> +static inline void drm_mtrr_del_wc(int handle)
>  {
> -	return mtrr_del(handle, offset, size);
> +	mtrr_del_wc_if_needed(handle);
>  }
>  
>  #else
> @@ -1269,16 +1266,14 @@ static inline int drm_mtrr_del(int handle, unsigned long offset,
>  
>  #define DRM_MTRR_WC		0
>  
> -static inline int drm_mtrr_add(unsigned long offset, unsigned long size,
> -			       unsigned int flags)
> +static inline int __must_check drm_mtrr_add_wc(unsigned long offset,
> +					       unsigned long size)
>  {
> -	return 0;
> +	return -1;
>  }
>  
> -static inline int drm_mtrr_del(int handle, unsigned long offset,
> -			       unsigned long size, unsigned int flags)
> +static inline void drm_mtrr_del_wc(int handle)
>  {
> -	return 0;
>  }

Tbh I'm not a big fan of the drm_ indirection. Historically that was
useful as an OS abstraction layer so that the same drivers could be used
unchanged on Linux and the *BSD. But those days are long gone and drm
drivers are now proper Linux drivers, and generally OS HALs seem to be
frowned upon.

Is there another reason than just being consistent with the historic stuff
here? If we need dummy functions for !CONFIG_MTRR I think those should
simply be in the core.

And if the inconsistency bugs you I'd volunteer myself to ditch the old
drm_ mtrr helpers.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
