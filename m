From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Date: Thu, 01 Feb 2018 13:19:07 +0000
Subject: Re: [PATCH] drm/fb-helper: Scale back depth to supported maximum
Message-Id: <20180201131907.GO5453@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180201130446.6165-1-linus.walleij@linaro.org>
In-Reply-To: <20180201130446.6165-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-fbdev@vger.kernel.org, David Lechner <david@lechnology.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>, linux-arm-kernel@lists.infradead.org

On Thu, Feb 01, 2018 at 02:04:46PM +0100, Linus Walleij wrote:
> The following happened when migrating an old fbdev driver to DRM:
>=20
> The Integrator/CP PL111 supports 16BPP but only ARGB1555/ABGR1555
> or XRGB1555/XBGR1555 i.e. the maximum depth is 15.
>=20
> This makes the initialization of the framebuffer fail since
> the code in drm_fb_helper_single_fb_probe() assigns the same value
> to sizes.surface_bpp and sizes.surface_depth. I.e. it simply assumes
> a 1-to-1 mapping between BPP and depth, which is true in most cases
> but typically not for this hardware.
>=20
> To support the odd case of a driver supporting 16BPP with only 15
> bits of depth, this patch will make the code loop over the formats
> supported on the primary plane and cap the depth to the maximum
> supported.
>=20
> On the PL110 Integrator, this makes drm_mode_legacy_fb_format()
> select DRM_FORMAT_XRGB1555 which is acceptable for this driver, and
> thus we get framebuffer, penguin and console on the Integrator/CP.
>=20
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/gpu/drm/drm_fb_helper.c | 40 +++++++++++++++++++++++++++++++++++=
++++-
>  1 file changed, 39 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_hel=
per.c
> index e56166334455..5076f9103740 100644
> --- a/drivers/gpu/drm/drm_fb_helper.c
> +++ b/drivers/gpu/drm/drm_fb_helper.c
> @@ -1720,6 +1720,8 @@ static int drm_fb_helper_single_fb_probe(struct drm=
_fb_helper *fb_helper,
>  	int i;
>  	struct drm_fb_helper_surface_size sizes;
>  	int gamma_size =3D 0;
> +	struct drm_plane *plane;
> +	int best_depth =3D 0;
> =20
>  	memset(&sizes, 0, sizeof(struct drm_fb_helper_surface_size));
>  	sizes.surface_depth =3D 24;
> @@ -1727,7 +1729,10 @@ static int drm_fb_helper_single_fb_probe(struct dr=
m_fb_helper *fb_helper,
>  	sizes.fb_width =3D (u32)-1;
>  	sizes.fb_height =3D (u32)-1;
> =20
> -	/* if driver picks 8 or 16 by default use that for both depth/bpp */
> +	/*
> +	 * If driver picks 8 or 16 by default use that for both depth/bpp
> +	 * to begin with
> +	 */
>  	if (preferred_bpp !=3D sizes.surface_bpp)
>  		sizes.surface_depth =3D sizes.surface_bpp =3D preferred_bpp;
> =20
> @@ -1762,6 +1767,39 @@ static int drm_fb_helper_single_fb_probe(struct dr=
m_fb_helper *fb_helper,
>  		}
>  	}
> =20
> +	/*
> +	 * If we run into a situation where, for example, the primary plane
> +	 * supports RGBA5551 (16 bpp, depth 15) but not RGB565 (16 bpp, depth
> +	 * 16) we need to scale down the depth of the sizes we request.
> +	 */
> +	drm_for_each_plane(plane, fb_helper->dev) {
> +		/* Only check the primary plane */
> +		if (plane->type !=3D DRM_PLANE_TYPE_PRIMARY)
> +			continue;

I think this should look at crtc->primary for each of the crtcs managed
by the fb_helper.

Also this probably shouldn't look at YUV formats at all?

I do wonder if instead we should just have the driver specify the
pixel format explicitly instead of trying to guess based on bpp?

> +
> +		for (i =3D 0; i < plane->format_count; i++) {
> +			const struct drm_format_info *fmt;
> +
> +			fmt =3D drm_format_info(plane->format_types[i]);
> +			/* We found a perfect fit, great */
> +			if (fmt->depth =3D sizes.surface_depth)
> +				break;
> +
> +			/* Skip depths above what we're looking for */
> +			if (fmt->depth > sizes.surface_depth)
> +				continue;
> +
> +			/* Best depth found so far */
> +			if (fmt->depth > best_depth)
> +				best_depth =3D fmt->depth;
> +		}
> +	}
> +	if (sizes.surface_depth !=3D best_depth) {
> +		DRM_DEBUG("requested bpp %d, scaled depth down to %d",
> +			  sizes.surface_bpp, best_depth);
> +		sizes.surface_depth =3D best_depth;
> +	}
> +
>  	crtc_count =3D 0;
>  	for (i =3D 0; i < fb_helper->crtc_count; i++) {
>  		struct drm_display_mode *desired_mode;
> --=20
> 2.14.3
>=20
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

--=20
Ville Syrj=E4l=E4
Intel OTC
