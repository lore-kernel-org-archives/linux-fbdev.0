From: Daniel Vetter <daniel@ffwll.ch>
Date: Tue, 05 Dec 2017 09:52:06 +0000
Subject: Re: [PATCH] drm: Document that drm_panel_orientation_quirks.c is shared with fbdev
Message-Id: <20171205095205.or7ua5d42g264u6k@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171204223321.15799-1-hdegoede@redhat.com>
In-Reply-To: <20171204223321.15799-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, Daniel Vetter <daniel.vetter@intel.com>

On Mon, Dec 04, 2017 at 11:33:21PM +0100, Hans de Goede wrote:
> Add a comment to the DRM_PANEL_ORIENTATION_QUIRKS documenting that the
> reason for a separate Kconfig for this is because
> drm_panel_orientation_quirks.c code is shared with fbdev.
> 
> Suggested-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/gpu/drm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index 0b166e626eb6..d853989848d6 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -27,6 +27,7 @@ config DRM_MIPI_DSI
>  	bool
>  	depends on DRM
>  
> +# Separate option because drm_panel_orientation_quirks.c is shared with fbdev
>  config DRM_PANEL_ORIENTATION_QUIRKS
>  	tristate
>  
> -- 
> 2.14.3
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
