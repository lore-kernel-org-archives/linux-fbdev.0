From: Daniel Vetter <daniel@ffwll.ch>
Date: Tue, 31 Oct 2017 10:40:58 +0000
Subject: Re: [Intel-gfx] [PATCH v3 4/7] drm/fb-helper: Apply panel orientation connector prop to the primary 
Message-Id: <20171031104058.cc7nw6y6hfjxj6xm@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171023071425.5090-1-hdegoede@redhat.com>
 <20171023071425.5090-5-hdegoede@redhat.com>
 <20171030095212.fuglrxyc3jpfrnjg@phenom.ffwll.local>
 <873cb3a6-342f-a1aa-0569-874d86f320b3@redhat.com>
 <20171031101430.k2ogtgk7smvoklxh@phenom.ffwll.local>
 <0c7c79ef-c08a-402f-1566-e4c070abc5a1@redhat.com>
In-Reply-To: <0c7c79ef-c08a-402f-1566-e4c070abc5a1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-fbdev@vger.kernel.org, Bastien Nocera <hadess@hadess.net>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, intel-gfx <intel-gfx@lists.freedesktop.org>, Daniel Drake <drake@endlessm.com>, dri-devel@lists.freedesktop.org, Daniel Vetter <daniel.vetter@intel.com>

On Tue, Oct 31, 2017 at 11:24:14AM +0100, Hans de Goede wrote:
> Hi,
>=20
> On 31-10-17 11:14, Daniel Vetter wrote:
> > On Mon, Oct 30, 2017 at 12:09:27PM +0100, Hans de Goede wrote:
> > > Hi,
> > >=20
> > > On 30-10-17 10:52, Daniel Vetter wrote:
> > > > On Mon, Oct 23, 2017 at 09:14:22AM +0200, Hans de Goede wrote:
> > > > > Apply the "panel orientation" drm connector prop to the primary p=
lane so
> > > > > that fbcon and fbdev using userspace programs display the right w=
ay up.
> > > > >=20
> > > > > Fixes: https://bugs.freedesktop.org/show_bug.cgi?id=94894
> > > > > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > > > > ---
> > > > > Changes in v2:
> > > > > -New patch in v2 of this patch-set
> > > > >=20
> > > > > Changes in v3:
> > > > > -Use a rotation member in struct drm_fb_helper_crtc and set that =
from
> > > > >    drm_setup_crtcs instead of looping over all crtc's to find the=
 right one
> > > > >    later
> > > > > -Since we now no longer look at rotation quirks directly in the f=
bcon code,
> > > > >    set fb_info.fbcon_rotate_hint when the panel is not mounted up=
right and
> > > > >    we cannot use hardware rotation
> > > > > ---
> > > > >    drivers/gpu/drm/drm_fb_helper.c | 76 +++++++++++++++++++++++++=
++++++++++++++--
> > > > >    include/drm/drm_fb_helper.h     |  8 +++++
> > > > >    2 files changed, 82 insertions(+), 2 deletions(-)
> > > > >=20
> > > > > diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/dr=
m_fb_helper.c
> > > > > index 116d1f1337c7..e0f95f2cc52f 100644
> > > > > --- a/drivers/gpu/drm/drm_fb_helper.c
> > > > > +++ b/drivers/gpu/drm/drm_fb_helper.c
> > > > > @@ -41,6 +41,7 @@
> > > > >    #include <drm/drm_atomic.h>
> > > > >    #include <drm/drm_atomic_helper.h>
> > > > > +#include "drm_crtc_internal.h"
> > > > >    #include "drm_crtc_helper_internal.h"
> > > > >    static bool drm_fbdev_emulation =3D true;
> > > > > @@ -350,6 +351,7 @@ EXPORT_SYMBOL(drm_fb_helper_debug_leave);
> > > > >    static int restore_fbdev_mode_atomic(struct drm_fb_helper *fb_=
helper, bool active)
> > > > >    {
> > > > >    	struct drm_device *dev =3D fb_helper->dev;
> > > > > +	struct drm_plane_state *plane_state;
> > > > >    	struct drm_plane *plane;
> > > > >    	struct drm_atomic_state *state;
> > > > >    	int i, ret;
> > > > > @@ -368,8 +370,6 @@ static int restore_fbdev_mode_atomic(struct d=
rm_fb_helper *fb_helper, bool activ
> > > > >    retry:
> > > > >    	plane_mask =3D 0;
> > > > >    	drm_for_each_plane(plane, dev) {
> > > > > -		struct drm_plane_state *plane_state;
> > > > > -
> > > > >    		plane_state =3D drm_atomic_get_plane_state(state, plane);
> > > > >    		if (IS_ERR(plane_state)) {
> > > > >    			ret =3D PTR_ERR(plane_state);
> > > > > @@ -392,6 +392,11 @@ static int restore_fbdev_mode_atomic(struct =
drm_fb_helper *fb_helper, bool activ
> > > > >    	for (i =3D 0; i < fb_helper->crtc_count; i++) {
> > > > >    		struct drm_mode_set *mode_set =3D &fb_helper->crtc_info[i].m=
ode_set;
> > > > > +		struct drm_plane *primary =3D mode_set->crtc->primary;
> > > > > +
> > > > > +		/* Cannot fail as we've already gotten the plane state above */
> > > > > +		plane_state =3D drm_atomic_get_new_plane_state(state, primary);
> > > > > +		plane_state->rotation =3D fb_helper->crtc_info[i].rotation;
> > > > >    		ret =3D __drm_atomic_helper_set_config(mode_set, state);
> > > > >    		if (ret !=3D 0)
> > > > > @@ -2334,6 +2339,57 @@ static int drm_pick_crtcs(struct drm_fb_he=
lper *fb_helper,
> > > > >    	return best_score;
> > > > >    }
> > > > > +/*
> > > > > + * This function checks if rotation is necessary because of pane=
l orientation
> > > > > + * and if it is, if it is supported.
> > > > > + * If rotation is necessary and supported, its gets set in fb_cr=
tc.rotation.
> > > > > + * If rotation is necessary but not supported, a DRM_MODE_ROTATE=
_* flag gets
> > > > > + * or-ed into fb_helper->rotations. In drm_setup_crtcs_fb() we c=
heck if only
> > > > > + * one bit is set and then we set fb_info.fbcon_rotate_hint to m=
ake fbcon do
> > > > > + * the unsupported rotation.
> > > > > + */
> > > > > +static void drm_setup_crtc_rotation(struct drm_fb_helper *fb_hel=
per,
> > > > > +				    struct drm_fb_helper_crtc *fb_crtc,
> > > > > +				    struct drm_connector *connector)
> > > > > +{
> > > > > +	struct drm_plane *plane =3D fb_crtc->mode_set.crtc->primary;
> > > > > +	uint64_t valid_mask =3D 0;
> > > > > +	int i, rotation;
> > > > > +
> > > > > +	fb_crtc->rotation =3D DRM_MODE_ROTATE_0;
> > > > > +
> > > > > +	switch (connector->display_info.panel_orientation) {
> > > > > +	case DRM_MODE_PANEL_ORIENTATION_BOTTOM_UP:
> > > > > +		rotation =3D DRM_MODE_ROTATE_180;
> > > > > +		break;
> > > > > +	case DRM_MODE_PANEL_ORIENTATION_LEFT_UP:
> > > > > +		rotation =3D DRM_MODE_ROTATE_90;
> > > > > +		break;
> > > > > +	case DRM_MODE_PANEL_ORIENTATION_RIGHT_UP:
> > > > > +		rotation =3D DRM_MODE_ROTATE_270;
> > > > > +		break;
> > > >=20
> > > > For 90/270 hw rotation you need to flip the coordinates/sizes of th=
e fb.
> > >=20
> > > You're probably right, I don't have any hardware supporting
> > > 270 degree rotation to test this with.
> > >=20
> > > > > +	default:
> > > > > +		rotation =3D DRM_MODE_ROTATE_0;
> > > > > +	}
> > > > > +
> > > > > +	if (rotation =3D DRM_MODE_ROTATE_0 || !plane->rotation_property=
) {
> > > > > +		fb_helper->rotations |=3D rotation;
> > > > > +		return;
> > > > > +	}
> > > > > +
> > > > > +	for (i =3D 0; i < plane->rotation_property->num_values; i++)
> > > > > +		valid_mask |=3D (1ULL << plane->rotation_property->values[i]);
> > > >=20
> > > > This isn't a good enough check for atomic drivers (and not for gen9=
+ intel
> > > > hw), since we might expose 90=B0 rotations, but it only works if yo=
u have
> > > > the correct tiling format.
> > > >=20
> > > > For atomic drivers it'd be really good if we could do a TEST_ONLY c=
ommit
> > > > first, and if that fails, fall back to sw rotation.
> > > >=20
> > > > But that poses a bit a chicken&egg with creating the framebuffer (w=
e need
> > > > one for the TEST_ONLY), so probably a bit too much more for this. A=
nd
> > > > afaiui your quirk list only applies to older stuff.
> > > >=20
> > > > At least add a FIXME meanwhile? In a way we have a FIXME already for
> > > > multi-pipe, since we don't try to fall back to fewer pipes if the s=
ingle
> > > > atomic commit failed.
> > > >=20
> > > > Or maybe just don't use 90/270 hw rotation for now since it seems b=
uggy in
> > > > your code anyway.
> > >=20
> > > I was wondering about this (need for special fb layout) myself too, I
> > > agree also given the above comment that it is probably best to only
> > > support 0/180 degree hardware rotation for now, I will do for the next
> > > version (and add a TODO comment).
> >=20
> > It'll work on i915 at least, on current hw. Might still be broken on
> > other, but then that's a larger issue with the fbcon atomic code right
> > now.
> > >=20
> > >=20
> > > > > +
> > > > > +	if (!(rotation & valid_mask)) {
> > > > > +		fb_helper->rotations |=3D rotation;
> > > > > +		return;
> > > > > +	}
> > > > > +
> > > > > +	fb_crtc->rotation =3D rotation;
> > > > > +	/* Rotating in hardware, fbcon should not rotate */
> > > > > +	fb_helper->rotations |=3D DRM_MODE_ROTATE_0;
> > > >=20
> > > > Wrong bitopt I think.
> > >=20
> > > No this is intentional, if we've a panel requiring say 90 degree rota=
tion
> > > which we will do in software and another panel (weird example) doing =
180
> > > degree rotation in hardware, then we want to or both
> > > DRM_MODE_ROTATE_90 and DRM_MODE_ROTATE_0 into the rotations bitmask
> > > (0 since the hardware rotation requires no sw rotation).
> > > The rotations bitmask is the *combination* of all rotations we need
> > > fbcon to do in software and when that ends up being more then one
> > > rotation we chicken out and just don't do any software rotation,
> > > maybe I should rename rotations to sw_rotations?
> > >=20
> > > A better real world example is a 90 degree rotated panel with
> > > an external monitor, in that case for the panel we hit:
> > >=20
> > > 	if (!(rotation & valid_mask)) {
> > > 		fb_helper->rotations |=3D rotation;
> > > 		return;
> > > 	}
> > >=20
> > > Or-ing in the panel's DRM_MODE_ROTATE_90.
> > >=20
> > > And for the monitor we hit:
> > >=20
> > > 	if (rotation =3D DRM_MODE_ROTATE_0 || !plane->rotation_property) {
> > > 		fb_helper->rotations |=3D rotation;
> > > 		return;
> > > 	}
> > >=20
> > > Or-ing in the monitors's DRM_MODE_ROTATE_0.
> > >=20
> > > So we end up with 2 bits set in fb_helper->rotations, hitting the
> > > default in the switch case and picking FB_ROTATE_UR, since we cannot
> > > satisfy both rotations in fbcon at the same time.
> > >=20
> > >=20
> > > > Or you're doing some really funny control logic by oring in another=
 value
> > > > to hit the default case below which doesn't rotate anything. I thin=
k that
> > > > should be done explicitly, by explicitly setting to rotation to ROT=
ATE_0
> > > > instead of this. Same for the check above.
> > >=20
> > > I hope my explanation above explains why I'm or-ing together rotation=
s,
> > > basically I want to detect if we need more then 1 type of software-ro=
tation
> > > in fbcon and in that case bail out and fallback to FB_ROTATE_UR.
> >=20
> > Yeah I suspected this is what you're trying to do, but imo it's too cle=
ar.
> > Can't we do an explicit check for this instead of uncommented magic
>=20
> Erm, my patch contains a big(ish) comment above drm_setup_crtc_rotation w=
hich
> tries to explain this already.
> > that takes half an hour to understand? I'm thinking of
> >=20
> > if (count_bits(fbb_helper->rotation)) {
> > 	/* conflicting rotation requests on different connnectors, fall
> > 	 * back to unrotated. */
> >=20
> > 	 fb_helper->rotation =3D ROTATE_0
> > }
> >=20
> > Or something similar at the end of drm_setup_crtcs (plus maybe doing the
> > resolve in there too). Right now that logic is split between 2 function=
s,
> > and no comment explaining what's going on.
> >=20
> > But not sure that's actually going to help with readability.
>=20
> I was thinking of just changing the code setting the fbcon_rotate_hint
> to something like this:
>=20
>         switch (fb_helper->sw_rotations) {
>         case DRM_MODE_ROTATE_0:
>                 info->fbcon_rotate_hint =3D FB_ROTATE_UR;
>                 break;
>         case DRM_MODE_ROTATE_90:
>                 info->fbcon_rotate_hint =3D FB_ROTATE_CCW;
>                 break;
>         case DRM_MODE_ROTATE_180:
>                 info->fbcon_rotate_hint =3D FB_ROTATE_UD;
>                 break;
>         case DRM_MODE_ROTATE_270:
>                 info->fbcon_rotate_hint =3D FB_ROTATE_CW;
>                 break;
>         default:
> 		/*
> 		 * Multiple bits are set / multiple rotations requested
> 		 * fbcon cannot handle separate rotation settings per
> 		 * output, so fallback to unrotated.
> 		 */
>                 info->fbcon_rotate_hint =3D FB_ROTATE_UR;
>         }
>=20
> Would that work for you ?

Ack.
-Daniel
--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
