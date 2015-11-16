From: Thierry Reding <treding@nvidia.com>
Date: Mon, 16 Nov 2015 11:50:39 +0000
Subject: Re: [PATCH] [media] hdmi: added functions for MPEG InfoFrames
Message-Id: <20151116115037.GF31033@ulmo.nvidia.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="10jrOL3x2xqLmOsH"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1447526299-4222-1-git-send-email-enric.balletbo@collabora.com>
In-Reply-To: <1447526299-4222-1-git-send-email-enric.balletbo@collabora.com>
To: Enric Balletbo i Serra <eballetbo@gmail.com>
Cc: linux-fbdev@vger.kernel.org, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Hans Verkuil <hans.verkuil@cisco.com>, Martin Bugge <marbugge@cisco.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>

--10jrOL3x2xqLmOsH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 14, 2015 at 07:38:19PM +0100, Enric Balletbo i Serra wrote:
> The MPEG Source (MS) InfoFrame is in EIA/CEA-861B. It describes aspects of
> the compressed video stream that were used to produce the uncompressed
> video.
>=20
> The patch adds functions to work with MPEG InfoFrames.
>=20
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>  drivers/video/hdmi.c | 156 +++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  include/linux/hdmi.h |  24 ++++++++
>  2 files changed, 180 insertions(+)

According to the CEA specification a source is expected to send this
type of infoframe once per video frame. I'm curious how you envision
this to be ensured. Would hardware provide a mechanism to store this
data and send the infoframe automatically? How would you ensure that
updates sent to the hardware match the upcoming frame?

> diff --git a/drivers/video/hdmi.c b/drivers/video/hdmi.c
[...]
> @@ -435,6 +510,8 @@ hdmi_infoframe_pack(union hdmi_infoframe *frame, void=
 *buffer, size_t size)
>  		length =3D hdmi_vendor_any_infoframe_pack(&frame->vendor,
>  							buffer, size);
>  		break;
> +	case HDMI_INFOFRAME_TYPE_MPEG:
> +		length =3D hdmi_mpeg_infoframe_pack(&frame->mpeg, buffer, size);

Missing "break;"?

> @@ -899,6 +978,41 @@ static void hdmi_audio_infoframe_log(const char *lev=
el,
>  			frame->downmix_inhibit ? "Yes" : "No");
>  }
> =20
> +static const char *hdmi_mpeg_picture_get_name(enum hdmi_mpeg_picture_typ=
e type)
> +{
> +	switch (type) {
> +	case HDMI_MPEG_PICTURE_TYPE_UNKNOWN:
> +		return "Unknown";
> +	case HDMI_MPEG_PICTURE_TYPE_I:
> +		return "Intra-coded picture";
> +	case HDMI_MPEG_PICTURE_TYPE_B:
> +		return "Bi-predictive picture";
> +	case HDMI_MPEG_PICTURE_TYPE_P:
> +		return "Predicted picture";
> +	}

I'd have chosen the slightly more canonical "I-Frame", "P-Frame",
"B-Frame" here, but that's not a strong objection.

> +	return "Reserved";

There really can't be another value here, so I think this should either
return NULL or even go as far as let it crash. There should be no way
for the invalid value to make it this far.

> +static int hdmi_mpeg_infoframe_unpack(struct hdmi_mpeg_infoframe *frame,
> +				     void *buffer)
> +{
> +	u8 *ptr =3D buffer;
> +
> +	if (ptr[0] !=3D HDMI_INFOFRAME_TYPE_MPEG ||
> +	    ptr[1] !=3D 1 ||
> +	    ptr[2] !=3D HDMI_MPEG_INFOFRAME_SIZE) {
> +		return -EINVAL;
> +	}

There's no need for the braces here.

> @@ -314,6 +336,7 @@ union hdmi_vendor_any_infoframe {
>   * @spd: spd infoframe
>   * @vendor: union of all vendor infoframes
>   * @audio: audio infoframe
> + * @mpeg: mpeg infoframe

s/mpeg/MPEG/

Thierry

--10jrOL3x2xqLmOsH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWScMKAAoJEN0jrNd/PrOheZ8P/3NQ3ENkv+JsHvgRzXHVELuE
U5IJStwM08UjMPTDRUoLyUMWGilsd6/Ax1oEZDWogShBb9e7or3ATPmTyGTKVXPc
6NytBYdxJL4p6l/qThaE8be+F8Mv9AAZvatkj1Vu2hVi8UmEahTarBygm8ed6VyF
4IlJbEAVCquMdI/9bvg3+Ck8ozKU+2B5/mWVTs3+GtpzBN4/4H70xuAh25tx64Pe
aPudFIAONzK3+sJ0rLqvjDSXf80pPAX9ELhA8bEOeNd9D0I4bo+uZQeIyQfUzs9O
COip/Dt1oTFePtNGoOE8AxKorCALhItyQBUOCcJaICbOXExaPz6iF+I+nhnd/h8Y
XJmY7NFFdSViEMCGeJOIh/mHHX7c/fi9UEWIS0QRyHvKGOh40OwqZt0jjkKjklgI
AB0ljV4vO3rvr91YhNl2bR3pP80i6B9sWyW3uLprZy4lBEE2l66xhhDYFjbY+EnI
5KmpYcDTMgONYLC5lkC3sPrAH3z7AdKb13S/FRLwC90P92kyy5uNp0YWbo27/XNH
I6XaausGpMuoiWrpbKjIR/QBw+FiJA7J7Us1ht8FpvDnFk2oFUQykgNGk7Ryg6fr
sXi5Rhd/JZTbeU6yGwwQAe5qOkYcGqOVaFcQecr1ESAawzjWzczphF2V2Shgiwlq
oBc7CgMg55Nz6zRouXAQ
=rO+1
-----END PGP SIGNATURE-----

--10jrOL3x2xqLmOsH--
