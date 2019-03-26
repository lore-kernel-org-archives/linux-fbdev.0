From: Daniel Vetter <daniel@ffwll.ch>
Date: Tue, 26 Mar 2019 18:20:38 +0000
Subject: Re: [PATCH 11/11] drm/fbdevdrm: Detect and validate display modes
Message-Id: <20190326182038.GP2665@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190326091744.11542-1-tzimmermann@suse.de>
 <20190326091744.11542-12-tzimmermann@suse.de>
 <20190326164741.GA3888@intel.com>
In-Reply-To: <20190326164741.GA3888@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc: linux-fbdev@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>, b.zolnierkie@samsung.com, airlied@linux.ie, dri-devel@lists.freedesktop.org

On Tue, Mar 26, 2019 at 06:47:41PM +0200, Ville Syrj=E4l=E4 wrote:
> On Tue, Mar 26, 2019 at 10:17:44AM +0100, Thomas Zimmermann wrote:
> > Mode detection currently reports the modes listed in fb_info::modelist.
> > The list is either build from EDID information or, more often, a list of
> > previously set modes. A later update to the mode detection could also
> > take into account the modes in fb_monspecs::modedb or test pre-defined
> > VESA modes.
> >=20
> > Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> > ---
> >  drivers/gpu/drm/fbdevdrm/fbdevdrm_modeset.c | 163 +++++++++++++++++++-
> >  1 file changed, 162 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/gpu/drm/fbdevdrm/fbdevdrm_modeset.c b/drivers/gpu/=
drm/fbdevdrm/fbdevdrm_modeset.c
> > index 87f56ec76edf..e89eca4b58df 100644
> > --- a/drivers/gpu/drm/fbdevdrm/fbdevdrm_modeset.c
> > +++ b/drivers/gpu/drm/fbdevdrm/fbdevdrm_modeset.c
> > @@ -21,9 +21,16 @@
> >  #include <drm/drm_print.h>
> >  #include <drm/drm_probe_helper.h>
> >  #include <linux/fb.h>
> > +#include "fbdevdrm_device.h"
> >  #include "fbdevdrm_modes.h"
> >  #include "fbdevdrm_primary.h"
> > =20
> > +static struct fbdevdrm_modeset* fbdevdrm_modeset_of_connector(
> > +	struct drm_connector *connector)
> > +{
> > +	return container_of(connector, struct fbdevdrm_modeset, connector);
> > +}
> > +
> >  static struct fbdevdrm_modeset* fbdevdrm_modeset_of_crtc(
> >  	struct drm_crtc *crtc)
> >  {
> > @@ -353,11 +360,130 @@ static const struct drm_encoder_funcs fbdevdrm_e=
ncoder_funcs =3D {
> >   * Connector
> >   */
> > =20
> > -static int connector_helper_get_modes(struct drm_connector *connector)
> > +static int update_display_info(struct drm_display_info *info, struct f=
b_info *fb_info)
> > +{
> > +	int num_pixel;
> > +
> > +	if (fb_info->fix.type !=3D FB_TYPE_PACKED_PIXELS)
> > +		return -EINVAL; /* rule out text mode, etc. */
> > +
> > +	if (fb_info->fix.id[0]) {
> > +		strncpy(info->name, fb_info->fix.id, sizeof(info->name) - 1);
> > +		info->name[sizeof(info->name) - 1] =3D '\0';
> > +	} else {
> > +		memset(info->name, '\0', sizeof(info->name));
> > +	}
> > +
> > +	info->width_mm =3D fb_info->var.width;
> > +	info->height_mm =3D fb_info->var.height;
> > +	info->pixel_clock =3D PICOS2KHZ(fb_info->var.pixclock);
> > +
> > +	num_pixel =3D 0;
> > +	if (fb_info->var.red.length)
> > +		++num_pixel;
> > +	if (fb_info->var.green.length)
> > +		++num_pixel;
> > +	if (fb_info->var.blue.length)
> > +		++num_pixel;
> > +	if (fb_info->var.transp.length)
> > +		++num_pixel;
> > +
> > +	if (num_pixel)
> > +		info->bpc =3D fb_info->var.bits_per_pixel;
> > +	else
> > +		info->bpc =3D 0;
> > +
> > +	info->subpixel_order =3D SubPixelUnknown;
> > +	info->color_formats =3D DRM_COLOR_FORMAT_RGB444;
> > +	info->bus_formats =3D &info->color_formats;
> > +	info->num_bus_formats =3D 1;
> > +	info->bus_flags =3D 0;
> > +	info->max_tmds_clock =3D 0;
> > +	info->dvi_dual =3D false;
> > +	info->has_hdmi_infoframe =3D false;
> > +	info->edid_hdmi_dc_modes =3D 0;
> > +	info->cea_rev =3D 0;
> > +	memset(&info->hdmi, 0, sizeof(info->hdmi));
> > +	info->non_desktop =3D 0;
>=20
> I think the only things here you may want to set are
> width_mm and height_mm. The rest should not matter.
>=20
> > +
> > +	return 0;
> > +}
> > +
> > +static int drm_mode_probed_add_from_fb_videomode(
> > +	struct drm_connector *connector, const struct fb_videomode *fb_mode,
> > +	struct fb_info *fb_info)
> >  {
> > +	struct drm_display_mode *mode;
> > +
> > +	mode =3D drm_mode_create_from_fb_videomode(connector->dev, fb_mode);
> > +	if (!mode)
> > +		return -ENOMEM;
> > +
> > +	mode->width_mm =3D fb_info->var.width;
> > +	mode->height_mm =3D fb_info->var.height;
> > +
> > +	drm_mode_probed_add(connector, mode);
> > +
> > +	/* update connector properties from display mode */
> > +	if (mode->flags & DRM_MODE_FLAG_INTERLACE)
> > +		connector->interlace_allowed =3D true;
> > +	if (mode->flags & DRM_MODE_FLAG_DBLSCAN)
> > +		connector->doublescan_allowed =3D true;
> > +	if (mode->flags & DRM_MODE_FLAG_3D_MASK)
> > +		connector->stereo_allowed =3D true;
> > +
> >  	return 0;
> >  }
> > =20
> > +static int connector_helper_get_modes(struct drm_connector *connector)
> > +{
> > +	struct fbdevdrm_modeset *modeset;
> > +	struct list_head *pos;
> > +	int ret, num_modes =3D 0;
> > +
> > +	modeset =3D fbdevdrm_modeset_of_connector(connector);
> > +
> > +	ret =3D update_display_info(&connector->display_info, modeset->fb_inf=
o);
> > +	if (ret)
> > +		return 0;
> > +
> > +	/* update connector properties from video modes */
> > +	connector->interlace_allowed =3D 0;
> > +	connector->doublescan_allowed =3D 0;
> > +	connector->stereo_allowed =3D 0;
> > +
> > +	if (!num_modes && modeset->fb_info->mode) {
> > +		ret =3D drm_mode_probed_add_from_fb_videomode(
> > +			connector, modeset->fb_info->mode, modeset->fb_info);
> > +		if (!ret)
> > +			++num_modes;
> > +	}
> > +
> > +	if (!num_modes) {
> > +
> > +		/* DRM backporting notes: we go through all modes in the
> > +		 * fb_info's mode list and convert each to a DRM modes. If
> > +		 * you convert an fbdev driver to DRM, replace this code
> > +		 * with an actual hardware query. This will usually involve
> > +		 * reading the monitor EDID via DDC.
> > +		 */
> > +
> > +		list_for_each(pos, &modeset->fb_info->modelist) {
>=20
> fbdev has a modelist? I guess it does. But not exposed to
> userspace, which is probably the reason I never realized this.

It's exposed in sysfs.

Don't ask why I know this, it hurts.
-Daniel
--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
