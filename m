From: Daniel Vetter <daniel@ffwll.ch>
Date: Mon, 03 Jun 2019 08:23:16 +0000
Subject: Re: [PATCH 2/4] drm: Fix docbook warnings in hdr metadata helper structures
Message-Id: <20190603082316.GI21222@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1559159944-21103-1-git-send-email-uma.shankar@intel.com>
 <1559159944-21103-3-git-send-email-uma.shankar@intel.com>
In-Reply-To: <1559159944-21103-3-git-send-email-uma.shankar@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Uma Shankar <uma.shankar@intel.com>
Cc: Sean Paul <sean@poorly.run>, linux-fbdev@vger.kernel.org, dcastagna@chromium.org, jonas@kwiboo.se, Maxime Ripard <maxime.ripard@bootlin.com>, intel-gfx@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, emil.l.velikov@gmail.com, dri-devel@lists.freedesktop.org, Hans Verkuil <hansverk@cisco.com>, David Airlie <airlied@linux.ie>, seanpaul@chromium.org

On Thu, May 30, 2019 at 01:29:02AM +0530, Uma Shankar wrote:
> Fixes the following warnings:
> ./include/drm/drm_mode_config.h:841: warning: Incorrect use of
> kernel-doc format:          * hdr_output_metadata_property: Connector
> property containing hdr
> ./include/drm/drm_mode_config.h:918: warning: Function parameter or membe=
r 'hdr_output_metadata_property' not described in 'drm_mode_config'
> ./include/drm/drm_connector.h:1251: warning: Function parameter or member=
 'hdr_output_metadata' not described in 'drm_connector'
> ./include/drm/drm_connector.h:1251: warning: Function parameter or member=
 'hdr_sink_metadata' not described in 'drm_connector'
>=20
> Also adds some property documentation for HDR Metadata Connector
> Property in connector property create function.
>=20
> v2: Fixed Sean Paul's review comments.
>=20
> v3: Fixed Daniel Vetter's review comments, added the UAPI structure
> definition section in kernel docs.
>=20
> Cc: Shashank Sharma <shashank.sharma@intel.com>
> Cc: Ville Syrj=E4l=E4 <ville.syrjala@linux.intel.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Cc: Sean Paul <sean@poorly.run>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: "Ville Syrj=E4l=E4" <ville.syrjala@linux.intel.com>
> Cc: Hans Verkuil <hansverk@cisco.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-fbdev@vger.kernel.org
> Reviewed-by: Sean Paul <sean@poorly.run>
> Signed-off-by: Uma Shankar <uma.shankar@intel.com>
> ---
>  Documentation/gpu/drm-uapi.rst  |  9 +++++++++
>  drivers/gpu/drm/drm_connector.c | 31 +++++++++++++++++++++++++++++++
>  include/drm/drm_connector.h     |  1 +
>  include/drm/drm_mode_config.h   |  4 ++--
>  include/linux/hdmi.h            |  1 +
>  include/uapi/drm/drm_mode.h     | 37 +++++++++++++++++++++++++++++++++++=
+-
>  6 files changed, 80 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/gpu/drm-uapi.rst b/Documentation/gpu/drm-uapi.=
rst
> index 05874d0..6b39e2c 100644
> --- a/Documentation/gpu/drm-uapi.rst
> +++ b/Documentation/gpu/drm-uapi.rst
> @@ -329,3 +329,12 @@ DRM_IOCTL_MODESET_CTL
>      mode setting, since on many devices the vertical blank counter is
>      reset to 0 at some point during modeset. Modern drivers should not
>      call this any more since with kernel mode setting it is a no-op.
> +
> +Userspace API Structures
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +.. kernel-doc:: include/uapi/drm/drm_mode.h
> +   :doc: overview
> +
> +.. kernel-doc:: include/uapi/drm/drm_mode.h
> +   :internal:
> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connec=
tor.c
> index c9ac8b9..6a93527 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -956,6 +956,37 @@ int drm_display_info_set_bus_formats(struct drm_disp=
lay_info *info,
>   *	  is no longer protected and userspace should take appropriate action
>   *	  (whatever that might be).
>   *
> + * HDR_OUTPUT_METADATA:
> + *	Connector property to enable userspace to send HDR Metadata to
> + *	driver. This metadata is based on the composition and blending
> + *	policies decided by user, taking into account the hardware and
> + *	sink capabilities. The driver gets this metadata and creates a
> + *	Dynamic Range and Mastering Infoframe (DRM) in case of HDMI,
> + *	SDP packet (Non-audio INFOFRAME SDP v1.3) for DP. This is then
> + *	sent to sink. This notifies the sink of the upcoming frame's Color
> + *	Encoding and Luminance parameters.
> + *
> + *	Userspace first need to detect the HDR capabilities of sink by
> + *	reading and parsing the EDID. Details of HDR metadata for HDMI
> + *	are added in CTA 861.G spec. For DP , its defined in VESA DP
> + *	Standard v1.4. It needs to then get the metadata information
> + *	of the video/game/app content which are encoded in HDR (basically
> + *	using HDR transfer functions). With this information it needs to
> + *	decide on a blending policy and compose the relevant
> + *	layers/overlays into a common format. Once this blending is done,
> + *	userspace will be aware of the metadata of the composed frame to
> + *	be send to sink. It then uses this property to communicate this
> + *	metadata to driver which then make a Infoframe packet and sends
> + *	to sink based on the type of encoder connected.
> + *
> + *	Userspace will be responsible to do Tone mapping operation in case:
> + *		- Some layers are HDR and others are SDR
> + *		- HDR layers luminance is not same as sink
> + *	It will even need to do colorspace conversion and get all layers
> + *	to one common colorspace for blending. It can use either GL, Media
> + *	or display engine to get this done based on the capabilties of the
> + *	associated hardware.

I think it'd be good to add 1-2 sentences here about what this looks like
for the driver side. E.g. which function drivers need to call to set up
hdr, how to get at the metadata and whether there's any helpers for these.

Here I'd point at hdr_output_metadata, hdr_sink_metadata, and
drm_add_display_info() for filling in the former.

I think with that this is a solid doc patch.

> + *
>   * max bpc:
>   *	This range property is used by userspace to limit the bit depth. When
>   *	used the driver would limit the bpc in accordance with the valid range
> diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> index 5476561..47e749b 100644
> --- a/include/drm/drm_connector.h
> +++ b/include/drm/drm_connector.h
> @@ -1244,6 +1244,7 @@ struct drm_connector {
>  	 */
>  	struct llist_node free_node;
> =20
> +	/** @hdr_sink_metadata: HDR Metadata Information read from sink */
>  	struct hdr_sink_metadata hdr_sink_metadata;

Something I realized while reading the code: This should probably be put
into the drm_display_info struct, like all the other things we parse out
of the edid. I think that would be a lot more consistent with the code -
the driver interface function which calls this code is called
drm_add_display_info() after all.

Can you pls change that in a follow-up patch?

>  };
> =20
> diff --git a/include/drm/drm_mode_config.h b/include/drm/drm_mode_config.h
> index 4f88cc9..759d462 100644
> --- a/include/drm/drm_mode_config.h
> +++ b/include/drm/drm_mode_config.h
> @@ -837,8 +837,8 @@ struct drm_mode_config {
>  	struct drm_property *writeback_out_fence_ptr_property;
> =20
>  	/**
> -	 * hdr_output_metadata_property: Connector property containing hdr
> -	 * metatda. This will be provided by userspace compositors based
> +	 * @hdr_output_metadata_property: Connector property containing hdr
> +	 * metatada. This will be provided by userspace compositors based
>  	 * on HDR content
>  	 */
>  	struct drm_property *hdr_output_metadata_property;
> diff --git a/include/linux/hdmi.h b/include/linux/hdmi.h
> index ee55ba5..55c6db5 100644
> --- a/include/linux/hdmi.h
> +++ b/include/linux/hdmi.h
> @@ -398,6 +398,7 @@ ssize_t hdmi_vendor_infoframe_pack_only(const struct =
hdmi_vendor_infoframe *fram
>   * @spd: spd infoframe
>   * @vendor: union of all vendor infoframes
>   * @audio: audio infoframe
> + * @drm: Dynamic Range and Mastering infoframe
>   *
>   * This is used by the generic pack function. This works since all infof=
rames
>   * have the same header which also indicates which type of infoframe sho=
uld be
> diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
> index 997a7e0..5d3964f 100644
> --- a/include/uapi/drm/drm_mode.h
> +++ b/include/uapi/drm/drm_mode.h
> @@ -33,6 +33,15 @@
>  extern "C" {
>  #endif
> =20
> +/**
> + * DOC: overview
> + *
> + * DRM exposes many UAPI and structure definition to have a consistent
> + * and standardized interface with user.
> + * Userspace can refer to these structure definitions and UAPI formats
> + * to communicate to driver
> + */
> +
>  #define DRM_CONNECTOR_NAME_LEN	32
>  #define DRM_DISPLAY_MODE_LEN	32
>  #define DRM_PROP_NAME_LEN	32
> @@ -630,7 +639,26 @@ struct drm_color_lut {
>  	__u16 reserved;
>  };
> =20
> -/* HDR Metadata Infoframe as per 861.G spec */

Keep the spec reference imo, maybe even add a note that this is supposed
to perfectly match it.

> +/**
> + * struct hdr_metadata_infoframe - HDR Metadata Infoframe Data.
> + * @eotf: Electro-Optical Transfer Function (EOTF) used in the stream.
> + * @metadata_type: Static_Metadata_Descriptor_ID.
> + * @display_primaries: Color Primaries of the Data.
> + * @display_primaries.x: X cordinate of color primary.

Would be good to spend a few more words about "in which standard/format"
this color number is. I.e. fixed point or whatever, and color space.

> + * @display_primaries.y: Y cordinate of color primary.
> + * @white_point: White Point of Colorspace Data.
> + * @white_point.x: X cordinate of whitepoint of color primary.
> + * @white_point.y: Y cordinate of whitepoint of color primary.
> + * @max_display_mastering_luminance: Max Mastering Display Luminance.
> + * @min_display_mastering_luminance: Min Mastering Display Luminance.
> + * @max_cll: Max Content Light Level.
> + * @max_fall: Max Frame Average Light Level.

btw for long structs I prefer the inline kerneldoc style. This one is just
at the edge imo.

> + *
> + * With drm subsystem using struct drm_rect to manage rectangular area t=
his

struct &drm_rect to make it a hyperlink. Once we have drm_rect documented
:-)

> + * export it to user-space.
> + *
> + * Currently used by drm_mode_atomic blob property FB_DAMAGE_CLIPS.
> + */
>  struct hdr_metadata_infoframe {
>  	__u8 eotf;
>  	__u8 metadata_type;
> @@ -646,6 +674,13 @@ struct hdr_metadata_infoframe {
>  	__u16 max_fall;
>  };
> =20
> +/**
> + * struct hdr_output_metadata - HDR output metadata
> + *
> + * Metadata Information to be passed from userspace
> + * @metadata_type: Static_Metadata_Descriptor_ID.
> + * @hdmi_metadata_type1: HDR Metadata Infoframe.

If you want to move the member docs closer to their definition, go with
the inline style.

Thanks, Daniel

> + */
>  struct hdr_output_metadata {
>  	__u32 metadata_type;
>  	union {
> --=20
> 1.9.1
>=20

--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
