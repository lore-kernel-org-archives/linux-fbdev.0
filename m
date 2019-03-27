From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Wed, 27 Mar 2019 08:31:43 +0000
Subject: Re: [PATCH 11/11] drm/fbdevdrm: Detect and validate display modes
Message-Id: <66e6a23f-f634-2c42-30e1-1c9716276e76@suse.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="mwCnnkQ1iUJJcAv9a1rsG7q2BSXOagB3m"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190326091744.11542-1-tzimmermann@suse.de>
 <20190326091744.11542-12-tzimmermann@suse.de>
 <20190326164741.GA3888@intel.com>
In-Reply-To: <20190326164741.GA3888@intel.com>
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: airlied@linux.ie, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, b.zolnierkie@samsung.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mwCnnkQ1iUJJcAv9a1rsG7q2BSXOagB3m
Content-Type: multipart/mixed; boundary="8lYd0VrImza8sLQCMwNTanMUN2EtqJlbc";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: airlied@linux.ie, daniel@ffwll.ch, b.zolnierkie@samsung.com,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Message-ID: <66e6a23f-f634-2c42-30e1-1c9716276e76@suse.de>
Subject: Re: [PATCH 11/11] drm/fbdevdrm: Detect and validate display modes
References: <20190326091744.11542-1-tzimmermann@suse.de>
 <20190326091744.11542-12-tzimmermann@suse.de>
 <20190326164741.GA3888@intel.com>
In-Reply-To: <20190326164741.GA3888@intel.com>

--8lYd0VrImza8sLQCMwNTanMUN2EtqJlbc
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 26.03.19 um 17:47 schrieb Ville Syrj=C3=A4l=C3=A4:
>> +static int connector_helper_get_modes(struct drm_connector *connector=
)
>> +{
>> +	struct fbdevdrm_modeset *modeset;
>> +	struct list_head *pos;
>> +	int ret, num_modes =3D 0;
>> +
>> +	modeset =3D fbdevdrm_modeset_of_connector(connector);
>> +
>> +	ret =3D update_display_info(&connector->display_info, modeset->fb_in=
fo);
>> +	if (ret)
>> +		return 0;
>> +
>> +	/* update connector properties from video modes */
>> +	connector->interlace_allowed =3D 0;
>> +	connector->doublescan_allowed =3D 0;
>> +	connector->stereo_allowed =3D 0;
>> +
>> +	if (!num_modes && modeset->fb_info->mode) {
>> +		ret =3D drm_mode_probed_add_from_fb_videomode(
>> +			connector, modeset->fb_info->mode, modeset->fb_info);
>> +		if (!ret)
>> +			++num_modes;
>> +	}
>> +
>> +	if (!num_modes) {
>> +
>> +		/* DRM backporting notes: we go through all modes in the
>> +		 * fb_info's mode list and convert each to a DRM modes. If
>> +		 * you convert an fbdev driver to DRM, replace this code
>> +		 * with an actual hardware query. This will usually involve
>> +		 * reading the monitor EDID via DDC.
>> +		 */
>> +
>> +		list_for_each(pos, &modeset->fb_info->modelist) {
>=20
> fbdev has a modelist?

Yes, and its content is surprisingly random! Some drivers fill it with
'real' values coming from DDC probing, some drivers fill it with modes
that have worked before, and some drivers fill it with... something.

Best regards
Thomas

I guess it does. But not exposed to
> userspace, which is probably the reason I never realized this.
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Linux GmbH, Maxfeldstrasse 5, 90409 Nuernberg, Germany
GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N=C3=BCrnberg)


--8lYd0VrImza8sLQCMwNTanMUN2EtqJlbc--

--mwCnnkQ1iUJJcAv9a1rsG7q2BSXOagB3m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAlybNO8ACgkQaA3BHVML
eiNyrQgAwjPm52TpWvyHGfe3939Aw5FJO2XpufMTQy6KL8ijbOP+1XcSuHTiNaUz
dpS1y17XSwG6HuojBnpy8wdo7Xsq8P07iwlsTD7wV4mpabBCuBn69vqOfwaZ8yJg
2EHc4gCbAIAh90fqH4CBXt5Fpk/iVBoTLCZsZ7pLNBvxnJowBHwZLqELhZX+R5Ol
/iMSXq8TgY7Ivu4fkKCPeyX0NAccUyokuxV8mBM/roKSb6yVMdlLV2TEzpDgyyg4
qS8dckn0DPsx97HnyO/W0sUgzccW0o+hH1yfucJPr818NSPL4+eydmv0YQtVihed
O+ucaX4RhQvDuuapl6sHm2WjpgJqhg==
=3pjA
-----END PGP SIGNATURE-----

--mwCnnkQ1iUJJcAv9a1rsG7q2BSXOagB3m--
