From: Daniel Vetter <daniel@ffwll.ch>
Date: Mon, 02 Oct 2017 08:15:57 +0000
Subject: Re: [PATCH v2 4/4] drm/fb-helper: Apply panel orientation connector prop to the primary plane
Message-Id: <20171002081557.hfhecrmpvc4gxx25@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171001153317.2343-1-hdegoede@redhat.com>
 <20171001153317.2343-5-hdegoede@redhat.com>
In-Reply-To: <20171001153317.2343-5-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Hans de Goede <j.w.r.degoede@gmail.com>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Hans de Goede <hdegoede@redhat.com>, dri-devel@lists.freedesktop.org, Bastien Nocera <hadess@hadess.net>, Daniel Vetter <daniel.vetter@intel.com>

On Sun, Oct 01, 2017 at 05:33:17PM +0200, Hans de Goede wrote:
> Apply the "panel orientation" drm connector prop to the primary plane,
> so that fbcon and fbdev using userspace programs display the right way
> up.
>=20
> Fixes: https://bugs.freedesktop.org/show_bug.cgi?id=94894
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -New patch in v2 of this patch-set
> ---
>  drivers/gpu/drm/drm_fb_helper.c | 53 +++++++++++++++++++++++++++++++++++=
++++--
>  1 file changed, 51 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_hel=
per.c
> index 1b8f013ffa65..75c409430a26 100644
> --- a/drivers/gpu/drm/drm_fb_helper.c
> +++ b/drivers/gpu/drm/drm_fb_helper.c
> @@ -41,6 +41,7 @@
>  #include <drm/drm_atomic.h>
>  #include <drm/drm_atomic_helper.h>
> =20
> +#include "drm_crtc_internal.h"
>  #include "drm_crtc_helper_internal.h"
> =20
>  static bool drm_fbdev_emulation =3D true;
> @@ -347,6 +348,53 @@ int drm_fb_helper_debug_leave(struct fb_info *info)
>  }
>  EXPORT_SYMBOL(drm_fb_helper_debug_leave);
> =20
> +static int get_plane_rotation_from_panel_orientation(
> +	struct drm_fb_helper *fb_helper, struct drm_plane *plane)
> +{
> +	int i, rotation =3D DRM_MODE_ROTATE_0;
> +	struct drm_connector *conn;
> +	uint64_t valid_mask =3D 0;
> +
> +	drm_fb_helper_for_each_connector(fb_helper, i) {
> +		conn =3D fb_helper->connector_info[i]->connector;
> +		if (conn->state->crtc && conn->state->crtc->primary =3D plane) {
> +			switch (conn->display_info.panel_orientation) {
> +			case DRM_MODE_PANEL_ORIENTATION_BOTTOM_UP:
> +				rotation =3D DRM_MODE_ROTATE_180;
> +				break;
> +			case DRM_MODE_PANEL_ORIENTATION_LEFT_UP:
> +				rotation =3D DRM_MODE_ROTATE_90;
> +				break;
> +			case DRM_MODE_PANEL_ORIENTATION_RIGHT_UP:
> +				rotation =3D DRM_MODE_ROTATE_270;
> +				break;
> +			}
> +			break;
> +		}
> +	}
> +
> +	/*
> +	 * Check the necessary rotation to compensate for the panel orientation
> +	 * is supported.
> +	 * Note currently we simply leave things as is when not supported, maybe
> +	 * we shouls set a hint in fb_info to tell fbcon to rotate in this case
> +	 * so that atleast the console ends up the right way. Maybe, but this:
> +	 * a) Is not necessary for any known models with a non upright panel
> +	 * b) Is tricky because fbcon rotation applies to all outputs rather
> +	 *    then a single one
> +	 */
> +	if (!plane->rotation_property)
> +		return DRM_MODE_ROTATE_0;
> +
> +	for (i =3D 0; i < plane->rotation_property->num_values; i++)
> +		valid_mask |=3D (1ULL << plane->rotation_property->values[i]);
> +
> +	if (rotation & ~valid_mask)
> +		return DRM_MODE_ROTATE_0;
> +
> +	return rotation;
> +}
> +
>  static int restore_fbdev_mode_atomic(struct drm_fb_helper *fb_helper, bo=
ol active)
>  {
>  	struct drm_device *dev =3D fb_helper->dev;
> @@ -376,8 +424,9 @@ static int restore_fbdev_mode_atomic(struct drm_fb_he=
lper *fb_helper, bool activ
>  			goto out_state;
>  		}
> =20
> -		plane_state->rotation =3D DRM_MODE_ROTATE_0;
> -
> +		plane_state->rotation > +			get_plane_rotation_from_panel_orientation(=
fb_helper,
> +								  plane);

This is the loop to reset all the planes to default values, feels a bit
awkward to change the rotation value in there. Also gives you that
unpretty loop to check you're on the right plane.

I think a cleaner way to do this would be:
- add a rotation member to struct drm_fb_helper_crtc
- set that when setting up the configuration drm_setup_crtcs
- look up crtc->primary plane_state and set it int the loop below this one
  here (which is the one that actually sets the mode)

Cheers, Daniel
>  		plane->old_fb =3D plane->fb;
>  		plane_mask |=3D 1 << drm_plane_index(plane);
> =20
> --=20
> 2.14.2
>=20
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
