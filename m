From: Sean Paul <sean@poorly.run>
Date: Thu, 23 May 2019 17:12:37 +0000
Subject: Re: [PATCH] drm/edid: Fix docbook in drm_hdmi_infoframe_set_hdr_metadata()
Message-Id: <20190523171237.GD17077@art_vandelay>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190523135504.184354-1-sean@poorly.run>
 <E7C9878FBA1C6D42A1CA3F62AEB6945F8203029D@BGSMSX104.gar.corp.intel.com>
In-Reply-To: <E7C9878FBA1C6D42A1CA3F62AEB6945F8203029D@BGSMSX104.gar.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: "Shankar, Uma" <uma.shankar@intel.com>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Maxime Ripard <maxime.ripard@bootlin.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Hans Verkuil <hansverk@cisco.com>, David Airlie <airlied@linux.ie>, Sean Paul <seanpaul@chromium.org>, Sean Paul <sean@poorly.run>

On Thu, May 23, 2019 at 02:38:37PM +0000, Shankar, Uma wrote:
>=20
>=20
> >-----Original Message-----
> >From: Sean Paul [mailto:sean@poorly.run]
> >Sent: Thursday, May 23, 2019 7:25 PM
> >To: dri-devel@lists.freedesktop.org
> >Cc: Sean Paul <seanpaul@chromium.org>; Shankar, Uma <uma.shankar@intel.c=
om>;
> >Sharma, Shashank <shashank.sharma@intel.com>; Ville Syrj=E4l=E4
> ><ville.syrjala@linux.intel.com>; Maarten Lankhorst
> ><maarten.lankhorst@linux.intel.com>; Maxime Ripard
> ><maxime.ripard@bootlin.com>; Sean Paul <sean@poorly.run>; David Airlie
> ><airlied@linux.ie>; Daniel Vetter <daniel@ffwll.ch>; Bartlomiej Zolnierk=
iewicz
> ><b.zolnierkie@samsung.com>; Hans Verkuil <hansverk@cisco.com>; linux-
> >fbdev@vger.kernel.org
> >Subject: [PATCH] drm/edid: Fix docbook in drm_hdmi_infoframe_set_hdr_met=
adata()
> >
> >From: Sean Paul <seanpaul@chromium.org>
> >
> >Fixes the following warnings:
> >../drivers/gpu/drm/drm_edid.c:4925: warning: Function parameter or member
> >'conn_state' not described in 'drm_hdmi_infoframe_set_hdr_metadata'
> >../drivers/gpu/drm/drm_edid.c:4925: warning: Excess function parameter
> >'hdr_metadata' description in 'drm_hdmi_infoframe_set_hdr_metadata'
>=20
> Thanks Sean Paul for fixing this.
> Reviewed-by: Uma Shankar <uma.shankar@intel.com>

Pushed to -misc-next, thank you for the review!

Sean

>=20
> >Fixes: 2cdbfd66a829 ("drm: Enable HDR infoframe support")
> >Cc: Uma Shankar <uma.shankar@intel.com>
> >Cc: Shashank Sharma <shashank.sharma@intel.com>
> >Cc: Ville Syrj=E4l=E4 <ville.syrjala@linux.intel.com>
> >Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> >Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> >Cc: Sean Paul <sean@poorly.run>
> >Cc: David Airlie <airlied@linux.ie>
> >Cc: Daniel Vetter <daniel@ffwll.ch>
> >Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> >Cc: "Ville Syrj=E4l=E4" <ville.syrjala@linux.intel.com>
> >Cc: Hans Verkuil <hansverk@cisco.com>
> >Cc: dri-devel@lists.freedesktop.org
> >Cc: linux-fbdev@vger.kernel.org
> >Signed-off-by: Sean Paul <seanpaul@chromium.org>
> >---
> > drivers/gpu/drm/drm_edid.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c ind=
ex
> >262510c2a670..d87f574feeca 100644
> >--- a/drivers/gpu/drm/drm_edid.c
> >+++ b/drivers/gpu/drm/drm_edid.c
> >@@ -4914,7 +4914,7 @@ static inline bool is_eotf_supported(u8 output_eot=
f, u8
> >sink_eotf)
> >  * drm_hdmi_infoframe_set_hdr_metadata() - fill an HDMI DRM infoframe w=
ith
> >  *                                         HDR metadata from userspace
> >  * @frame: HDMI DRM infoframe
> >- * @hdr_metadata: hdr_source_metadata info from userspace
> >+ * @conn_state: Connector state containing HDR metadata
> >  *
> >  * Return: 0 on success or a negative error code on failure.
> >  */
> >--
> >Sean Paul, Software Engineer, Google / Chromium OS
>=20

--=20
Sean Paul, Software Engineer, Google / Chromium OS
