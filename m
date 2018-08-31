From: Daniel Vetter <daniel@ffwll.ch>
Date: Fri, 31 Aug 2018 08:56:56 +0000
Subject: Re: [PATCH v2 02/12] fbdev: allow apertures == NULL in remove_conflicting_framebuffers()
Message-Id: <20180831085656.GR21634@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1535656077.git.mirq-linux@rere.qmqm.pl>
	<7e3a48e397298b38d7ddc7f45d48226d1f5db3e4.1535656077.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <7e3a48e397298b38d7ddc7f45d48226d1f5db3e4.1535656077.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, David Airlie <airlied@linux.ie>, amd-gfx@lists.freedesktop.org, virtualization@lists.linux-foundation.org, Alex Deucher <alexander.deucher@amd.com>, Thierry Reding <thierry.reding@gmail.com>, dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org, Maxime Ripard <maxime.ripard@bootlin.com>, linux-arm-kernel@lists.infradead.org

On Thu, Aug 30, 2018 at 11:00:05PM +0200, Michał Mirosław wrote:
> Interpret (otherwise-invalid) NULL apertures argument to mean all-memory
> range. This will allow to remove several duplicates of this code from
> drivers in following patches.
> 
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> [for v1]
> Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> 
> ---
> v2: added kerneldoc to corresponding DRM helper
> ---
>  drivers/video/fbdev/core/fbmem.c | 14 ++++++++++++++
>  include/drm/drm_fb_helper.h      | 10 ++++++++++
>  2 files changed, 24 insertions(+)
> 
> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> index 30a18d4c9de4..0df148eb4699 100644
> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -1779,11 +1779,25 @@ int remove_conflicting_framebuffers(struct apertures_struct *a,
>  				    const char *name, bool primary)
>  {
>  	int ret;
> +	bool do_free = false;
> +
> +	if (!a) {
> +		a = alloc_apertures(1);
> +		if (!a)
> +			return -ENOMEM;
> +
> +		a->ranges[0].base = 0;
> +		a->ranges[0].size = ~0;
> +		do_free = true;
> +	}
>  
>  	mutex_lock(&registration_lock);
>  	ret = do_remove_conflicting_framebuffers(a, name, primary);
>  	mutex_unlock(&registration_lock);
>  
> +	if (do_free)
> +		kfree(a);
> +
>  	return ret;
>  }
>  EXPORT_SYMBOL(remove_conflicting_framebuffers);
> diff --git a/include/drm/drm_fb_helper.h b/include/drm/drm_fb_helper.h
> index b069433e7fc1..1c1e53abb25d 100644
> --- a/include/drm/drm_fb_helper.h
> +++ b/include/drm/drm_fb_helper.h
> @@ -566,6 +566,16 @@ static inline void drm_fb_helper_output_poll_changed(struct drm_device *dev)
>  
>  #endif
>  
> +/**
> + * drm_fb_helper_remove_conflicting_framebuffers - remove firmware framebuffers
> + * @a: memory range, users of which are to be removed
> + * @name: requesting driver name
> + * @primary: also kick vga16fb if present
> + *
> + * This function removes framebuffer devices (eg. initialized by firmware)
> + * which use memory range described by @a. If @a is NULL all such devices are
> + * removed.
> + */

This looks like misplaced copypasta. You only need this once I think.
-Daniel

>  static inline int
>  drm_fb_helper_remove_conflicting_framebuffers(struct apertures_struct *a,
>  					      const char *name, bool primary)
> -- 
> 2.18.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
