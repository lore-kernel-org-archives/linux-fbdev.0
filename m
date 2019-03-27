From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Date: Wed, 27 Mar 2019 10:00:57 +0000
Subject: Re: [PATCH 07/11] drm/fbdevdrm: Add DRM <-> fbdev pixel-format conversion
Message-Id: <20190327100057.GB3888@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190326091744.11542-1-tzimmermann@suse.de>
 <20190326091744.11542-8-tzimmermann@suse.de>
 <20190326162910.GY3888@intel.com>
 <44049a77-d9b8-992e-2107-55e33845a398@suse.de>
In-Reply-To: <44049a77-d9b8-992e-2107-55e33845a398@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: airlied@linux.ie, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, b.zolnierkie@samsung.com

On Wed, Mar 27, 2019 at 09:28:49AM +0100, Thomas Zimmermann wrote:
> Hi
>=20
> Am 26.03.19 um 17:29 schrieb Ville Syrj=E4l=E4:
> >> +
> >> +static bool is_c8(const struct fb_info* fb_info)
> >> +{
> >> +	return fb_info->var.bits_per_pixel =3D 8;
> >> +}
> >> +
> >> +static bool is_rgb565_be(const struct fb_info* fb_info)
> >> +{
> >> +	return (fb_info->var.bits_per_pixel =3D 16) &&
> >> +	       (fb_info->var.red.offset =3D 0) &&
> >> +	       (fb_info->var.red.length =3D 5) &&
> >> +	       (fb_info->var.green.offset =3D 5) &&
> >> +	       (fb_info->var.green.length =3D 6) &&
> >> +	       (fb_info->var.blue.offset =3D 11) &&
> >> +	       (fb_info->var.blue.length =3D 5);
> >> +}
> >=20
> > You can't distinguish LE vs. BE like this.
> >=20
> > Maybe FBINFO_FOREIGN_ENDIAN is trustworthy?
> >=20
>=20
> The test function means 'is the framebuffer in RGB565 format if the host
> uses big-endian access'. Further below in the file, there are macros
> that reverse the order of fields for little-endian hosts.

And that does not work. Wrong endianness swaps bytes, not components.

>=20
> However, mapping all this to DRM formats is confusing.
>=20
> According to the documentation, DRM_FORMAT_ is always in little-endian
> format. But does that mean that the device uses little endian or that
> the host uses little endian? If the device and the host disagree on
> endianess, which takes precedence?

It just means "the pixel value listed is stored in memory=20
least significant byte first".

>=20
> In the end, I tried different combinations of tests and DRM formats, and
> checked the resulting output on the screen.

This was just pointed out to me recently:
https://github.com/afrantzis/pixel-format-guide

It seems to interpret drm formats correctly.

Though I wouldn't mind if someone improved the drm_fourcc.h docs since
everyone except me seems to get confused by the current wording.

--=20
Ville Syrj=E4l=E4
Intel
