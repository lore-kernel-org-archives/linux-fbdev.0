From: Sean Paul <sean@poorly.run>
Date: Thu, 13 Jun 2019 19:06:31 +0000
Subject: Re: [PATCH] drm/connector: Fix kerneldoc warning in HDR_OUTPUT_METADATA description
Message-Id: <20190613190631.GH179831@art_vandelay>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190613151727.133696-1-sean@poorly.run>
 <CADnq5_NFNtcgM2HaxEnZi_VcKB=FhxTH7pg0wrWzJcw4YaPzOw@mail.gmail.com>
In-Reply-To: <CADnq5_NFNtcgM2HaxEnZi_VcKB=FhxTH7pg0wrWzJcw4YaPzOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Alex Deucher <alexdeucher@gmail.com>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, Hans Verkuil <hansverk@cisco.com>, David Airlie <airlied@linux.ie>, Uma Shankar <uma.shankar@intel.com>, Sean Paul <seanpaul@chromium.org>, Sean Paul <sean@poorly.run>

On Thu, Jun 13, 2019 at 12:57:29PM -0400, Alex Deucher wrote:
> On Thu, Jun 13, 2019 at 11:17 AM Sean Paul <sean@poorly.run> wrote:
> >
> > From: Sean Paul <seanpaul@chromium.org>
> >
> > Fixes the following warning:
> > ../drivers/gpu/drm/drm_connector.c:981: WARNING: Definition list ends w=
ithout a blank line; unexpected unindent.
> >
> > Fixes: a09db883e5d9 ("drm: Fix docbook warnings in hdr metadata helper =
structures")
> > Cc: Shashank Sharma <shashank.sharma@intel.com>
> > Cc: Ville Syrj=E4 <ville.syrjala@linux.intel.com>
> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> > Cc: Sean Paul <sean@poorly.run>
> > Cc: David Airlie <airlied@linux.ie>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > Cc: "Ville Syrj=E4" <ville.syrjala@linux.intel.com>
> > Cc: Hans Verkuil <hansverk@cisco.com>
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: linux-fbdev@vger.kernel.org
> > Cc: Sean Paul <sean@poorly.run> (v1)
> > Cc: Uma Shankar <uma.shankar@intel.com>
> > Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> > Cc: "Ville Syrj=E4l=E4" <ville.syrjala@linux.intel.com>
> > Signed-off-by: Sean Paul <seanpaul@chromium.org>
>=20
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Thanks Alex, I've applied this to -misc-next

>=20
> > ---
> >  drivers/gpu/drm/drm_connector.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_conn=
ector.c
> > index a598a5eb48d21..3ccdcf3dfcde2 100644
> > --- a/drivers/gpu/drm/drm_connector.c
> > +++ b/drivers/gpu/drm/drm_connector.c
> > @@ -978,6 +978,7 @@ static const struct drm_prop_enum_list hdmi_colorsp=
aces[] =3D {
> >   *     Userspace will be responsible to do Tone mapping operation in c=
ase:
> >   *             - Some layers are HDR and others are SDR
> >   *             - HDR layers luminance is not same as sink
> > + *
> >   *     It will even need to do colorspace conversion and get all layers
> >   *     to one common colorspace for blending. It can use either GL, Me=
dia
> >   *     or display engine to get this done based on the capabilties of =
the
> > --
> > Sean Paul, Software Engineer, Google / Chromium OS
> >
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel

--=20
Sean Paul, Software Engineer, Google / Chromium OS
