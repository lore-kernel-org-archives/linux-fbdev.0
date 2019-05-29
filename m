From: Sean Paul <sean@poorly.run>
Date: Wed, 29 May 2019 14:35:37 +0000
Subject: Re: [PATCH] drm: Fix docbook warnings in hdr metadata helper structures
Message-Id: <20190529143537.GF17077@art_vandelay>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1559141030-4386-1-git-send-email-uma.shankar@intel.com>
In-Reply-To: <1559141030-4386-1-git-send-email-uma.shankar@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Uma Shankar <uma.shankar@intel.com>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Maxime Ripard <maxime.ripard@bootlin.com>, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, Hans Verkuil <hansverk@cisco.com>, David Airlie <airlied@linux.ie>

On Wed, May 29, 2019 at 08:13:50PM +0530, Uma Shankar wrote:
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
> Signed-off-by: Uma Shankar <uma.shankar@intel.com>
> ---
>  drivers/gpu/drm/drm_connector.c | 8 ++++++++
>  include/drm/drm_connector.h     | 3 ++-
>  include/drm/drm_mode_config.h   | 2 +-
>  include/linux/hdmi.h            | 1 +
>  4 files changed, 12 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connec=
tor.c
> index c9ac8b9..702307c 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -1003,6 +1003,14 @@ int drm_display_info_set_bus_formats(struct drm_di=
splay_info *info,
>   *	can also expose this property to external outputs, in which case they
>   *	must support "None", which should be the default (since external scre=
ens
>   *	have a built-in scaler).
> + *
> + * HDR_OUTPUT_METADATA:
> + *	Connector property to enable userspace to send HDR Metadata to driver.
> + *	This metadata is based on the composition and blending policies decid=
ed
> + *	by user, taking into account the hardware and sink capabilties.

capabilities

> + *	The driver gets this metadata and creates a Dynamic Range and Masteri=
ng
> + *	Infoframe (DRM) which is then sent to sink. This notifies the sink of
> + *	the upcoming frame's Color Encoding and Luminance parameters.
>   */
> =20
>  int drm_connector_create_standard_properties(struct drm_device *dev)
> diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> index f8f4003..f226ef0 100644
> --- a/include/drm/drm_connector.h
> +++ b/include/drm/drm_connector.h
> @@ -1244,8 +1244,9 @@ struct drm_connector {
>  	 */
>  	struct llist_node free_node;
> =20
> -	/* HDR metdata */
> +	/** @hdr_output_metadata: HDR Metadata to be sent to sink */
>  	struct hdr_output_metadata hdr_output_metadata;
> +	/** @hdr_sink_metadata: HDR Metadata Information read from sink */
>  	struct hdr_sink_metadata hdr_sink_metadata;
>  };
> =20
> diff --git a/include/drm/drm_mode_config.h b/include/drm/drm_mode_config.h
> index 4f88cc9..0b180e0 100644
> --- a/include/drm/drm_mode_config.h
> +++ b/include/drm/drm_mode_config.h
> @@ -837,7 +837,7 @@ struct drm_mode_config {
>  	struct drm_property *writeback_out_fence_ptr_property;
> =20
>  	/**
> -	 * hdr_output_metadata_property: Connector property containing hdr
> +	 * @hdr_output_metadata_property: Connector property containing hdr
>  	 * metatda. This will be provided by userspace compositors based

May as well fix the spelling of "metadata" while you're here.

>  	 * on HDR content
>  	 */
> diff --git a/include/linux/hdmi.h b/include/linux/hdmi.h
> index ee55ba5..ea5858e 100644
> --- a/include/linux/hdmi.h
> +++ b/include/linux/hdmi.h
> @@ -398,6 +398,7 @@ ssize_t hdmi_vendor_infoframe_pack_only(const struct =
hdmi_vendor_infoframe *fram
>   * @spd: spd infoframe
>   * @vendor: union of all vendor infoframes
>   * @audio: audio infoframe
> + * @drm: DRM infoframe

Can you spell this out here so it's unambiguous which DRM you're talking ab=
out?

With the nits fixed,

Reviewed-by: Sean Paul <sean@poorly.run>


>   *
>   * This is used by the generic pack function. This works since all infof=
rames
>   * have the same header which also indicates which type of infoframe sho=
uld be
> --=20
> 1.9.1
>=20

--=20
Sean Paul, Software Engineer, Google / Chromium OS
