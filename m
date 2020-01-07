From: Daniel Vetter <daniel@ffwll.ch>
Date: Tue, 07 Jan 2020 15:56:09 +0000
Subject: Re: [PATCH] drm/fb-helper: Round up bits_per_pixel if possible
Message-Id: <20200107155609.GC43062@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191230132734.4538-1-geert+renesas@glider.be>
In-Reply-To: <20191230132734.4538-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel.vetter@ffwll.ch>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Sean Paul <sean@poorly.run>

On Mon, Dec 30, 2019 at 02:27:34PM +0100, Geert Uytterhoeven wrote:
> When userspace requests a video mode parameter value that is not
> supported, frame buffer device drivers should round it up to a supported
> value, if possible, instead of just rejecting it.  This allows
> applications to quickly scan for supported video modes.
> 
> Currently this rule is not followed for the number of bits per pixel,
> causing e.g. "fbset -depth N" to fail, if N is smaller than the current
> number of bits per pixel.
> 
> Fix this by returning an error only if bits per pixel is too large, and
> setting it to the current value otherwise.
> 
> See also Documentation/fb/framebuffer.rst, Section 2 (Programmer's View
> of /dev/fb*").
> 
> Fixes: 865afb11949e5bf4 ("drm/fb-helper: reject any changes to the fbdev")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied to drm-misc-fixes with a cc:stable.

Aside, would be really lovely if someone who cares about these fbdev
details would start to with some unit tests in the drm testsuite:

https://dri.freedesktop.org/docs/drm/gpu/drm-uapi.html?highlight=igt#testing-and-validation

The drm version is gearing up to be _the_ fbdev implementation, that way
we could make sure it wont break (e.g. intel gfx CI would run this stuff
if it's in igt).

Thanks, Daniel

> ---
> Against drm-misc#for-linux-next.
> Applies with some fuzz against v5.5-rc4.
> ---
>  drivers/gpu/drm/drm_fb_helper.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
> index f8e9051926083373..cae8fa74781c8db0 100644
> --- a/drivers/gpu/drm/drm_fb_helper.c
> +++ b/drivers/gpu/drm/drm_fb_helper.c
> @@ -1267,7 +1267,7 @@ int drm_fb_helper_check_var(struct fb_var_screeninfo *var,
>  	 * Changes struct fb_var_screeninfo are currently not pushed back
>  	 * to KMS, hence fail if different settings are requested.
>  	 */
> -	if (var->bits_per_pixel != fb->format->cpp[0] * 8 ||
> +	if (var->bits_per_pixel > fb->format->cpp[0] * 8 ||
>  	    var->xres > fb->width || var->yres > fb->height ||
>  	    var->xres_virtual > fb->width || var->yres_virtual > fb->height) {
>  		drm_dbg_kms(dev, "fb requested width/height/bpp can't fit in current fb "
> @@ -1292,6 +1292,11 @@ int drm_fb_helper_check_var(struct fb_var_screeninfo *var,
>  		drm_fb_helper_fill_pixel_fmt(var, fb->format->depth);
>  	}
>  
> +	/*
> +	 * Likewise, bits_per_pixel should be rounded up to a supported value.
> +	 */
> +	var->bits_per_pixel = fb->format->cpp[0] * 8;
> +
>  	/*
>  	 * drm fbdev emulation doesn't support changing the pixel format at all,
>  	 * so reject all pixel format changing requests.
> -- 
> 2.17.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
