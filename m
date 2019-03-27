From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Wed, 27 Mar 2019 08:28:49 +0000
Subject: Re: [PATCH 07/11] drm/fbdevdrm: Add DRM <-> fbdev pixel-format conversion
Message-Id: <44049a77-d9b8-992e-2107-55e33845a398@suse.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="urgwLYDtAxzJaiXTI5KpBEObj0taSclSS"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190326091744.11542-1-tzimmermann@suse.de>
 <20190326091744.11542-8-tzimmermann@suse.de>
 <20190326162910.GY3888@intel.com>
In-Reply-To: <20190326162910.GY3888@intel.com>
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: airlied@linux.ie, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, b.zolnierkie@samsung.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--urgwLYDtAxzJaiXTI5KpBEObj0taSclSS
Content-Type: multipart/mixed; boundary="rNnd15ZzLSjMuQ0pH55B6y49J00XUCiyK";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: airlied@linux.ie, daniel@ffwll.ch, b.zolnierkie@samsung.com,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Message-ID: <44049a77-d9b8-992e-2107-55e33845a398@suse.de>
Subject: Re: [PATCH 07/11] drm/fbdevdrm: Add DRM <-> fbdev pixel-format
 conversion
References: <20190326091744.11542-1-tzimmermann@suse.de>
 <20190326091744.11542-8-tzimmermann@suse.de>
 <20190326162910.GY3888@intel.com>
In-Reply-To: <20190326162910.GY3888@intel.com>

--rNnd15ZzLSjMuQ0pH55B6y49J00XUCiyK
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 26.03.19 um 17:29 schrieb Ville Syrj=C3=A4l=C3=A4:
>> +
>> +static bool is_c8(const struct fb_info* fb_info)
>> +{
>> +	return fb_info->var.bits_per_pixel =3D=3D 8;
>> +}
>> +
>> +static bool is_rgb565_be(const struct fb_info* fb_info)
>> +{
>> +	return (fb_info->var.bits_per_pixel =3D=3D 16) &&
>> +	       (fb_info->var.red.offset =3D=3D 0) &&
>> +	       (fb_info->var.red.length =3D=3D 5) &&
>> +	       (fb_info->var.green.offset =3D=3D 5) &&
>> +	       (fb_info->var.green.length =3D=3D 6) &&
>> +	       (fb_info->var.blue.offset =3D=3D 11) &&
>> +	       (fb_info->var.blue.length =3D=3D 5);
>> +}
>=20
> You can't distinguish LE vs. BE like this.
>=20
> Maybe FBINFO_FOREIGN_ENDIAN is trustworthy?
>=20

The test function means 'is the framebuffer in RGB565 format if the host
uses big-endian access'. Further below in the file, there are macros
that reverse the order of fields for little-endian hosts.

However, mapping all this to DRM formats is confusing.

According to the documentation, DRM_FORMAT_ is always in little-endian
format. But does that mean that the device uses little endian or that
the host uses little endian? If the device and the host disagree on
endianess, which takes precedence?

In the end, I tried different combinations of tests and DRM formats, and
checked the resulting output on the screen.

Best regards
Thomas

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Linux GmbH, Maxfeldstrasse 5, 90409 Nuernberg, Germany
GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N=C3=BCrnberg)


--rNnd15ZzLSjMuQ0pH55B6y49J00XUCiyK--

--urgwLYDtAxzJaiXTI5KpBEObj0taSclSS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAlybNEEACgkQaA3BHVML
eiM1TAgAsxKC+TVVDfB2e2g5N+wAyNiOvrwaQBCdjRGixiBP4vL2Vn/iTopPEfzq
oT7btxw2RKNeKWfPlh9e6J49EIxpaV/qTcOEkDEUURBsTcNmFDhmcHdra1M6Fwt6
gzc/pTIus0KBZPFOYpIzdHTy7xPNo1KtRPkZssq7mJkhSAQ0HvK/Qh+N7in91kwf
jYtdXRPkKFfaY0bo2WsUUwlNRxBgrvSKfftgLJv7Q92xz3aAQscjid8gp7mzKxjX
JHPNmzAH194VVpu4H5hFj7yTf4+xU8VqVLyZxyDaoON08hqxzkDe01eZpLJKi50J
wiG7dFSziyfLuwPboYbLe0lkeRSxgg==
=/jww
-----END PGP SIGNATURE-----

--urgwLYDtAxzJaiXTI5KpBEObj0taSclSS--
