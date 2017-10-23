From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Date: Mon, 23 Oct 2017 12:43:26 +0000
Subject: Re: [PATCH v3 1/7] fbcon: Add fbcon_rotate_hint to struct fb_info
Message-Id: <20171023124326.db5mbmtseblb4fj7@earth>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="mpmcl7wrcjf73j5h"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171023071425.5090-1-hdegoede@redhat.com>
 <20171023071425.5090-2-hdegoede@redhat.com>
In-Reply-To: <20171023071425.5090-2-hdegoede@redhat.com>
To: Hans de Goede <j.w.r.degoede@gmail.com>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, David Airlie <airlied@linux.ie>, intel-gfx <intel-gfx@lists.freedesktop.org>, Daniel Drake <drake@endlessm.com>, Hans de Goede <hdegoede@redhat.com>, dri-devel@lists.freedesktop.org, Bastien Nocera <hadess@hadess.net>, Daniel Vetter <daniel.vetter@intel.com>


--mpmcl7wrcjf73j5h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Hans,

On Mon, Oct 23, 2017 at 09:14:19AM +0200, Hans de Goede wrote:
> On some hardware the LCD panel is not mounted upright in the casing,
> but upside-down or rotated 90 degrees. In this case we want the console
> to automatically be rotated to compensate.
>=20
> The fbdev-driver may know about the need to rotate. Add a new
> fbcon_rotate_hint field to struct fb_info, which gets initialized to -1.
> If the fbdev-driver knows that some sort of rotation is necessary then
> it can set this field to a FB_ROTATE_* value to tell the fbcon console
> driver to rotate the console.
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---

Thanks for your work. I will give it a try with Droid 4 and N950
once I find some time :)

[...]

> +	p->con_rotate =3D initial_rotation;
> +	if (p->con_rotate =3D=3D -1)
> +		p->con_rotate =3D info->fbcon_rotate_hint;
> +	if (p->con_rotate =3D=3D -1)
>  		p->con_rotate =3D fbcon_platform_get_rotate(info);

[...]

> +	p->con_rotate =3D initial_rotation;
> +	if (p->con_rotate =3D=3D -1)
> +		p->con_rotate =3D info->fbcon_rotate_hint;
> +	if (p->con_rotate =3D=3D -1)
>  		p->con_rotate =3D fbcon_platform_get_rotate(info);
> +

maybe add a little helper function to reduce code duplication?

-- Sebastian

--mpmcl7wrcjf73j5h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlnt4+oACgkQ2O7X88g7
+pomCxAAqW/zZIMYTEM+Hpk+udXuTBqlF7q7vEDtxUGMRkwR6/NLpCZP5LZ+7AHX
X9RdxFehyPqy/Kq0AHHujAXR/xbBUvN1bY5pNNV5/U6hLMVkircaDAREpEPSJKeL
Ke127RncolWhF4bijpDu9s4Xlzlrgq894nnX9PweNOZAlGVGrnn5KYWR0jzQhh3J
4kmhYY/ukIgzS0sCt5Nln83lmPLlvpskEGI8zxkjkqUokrkX9+kyFDurf4RAmyDH
V3JuI0yRHc/4UwIwCcVXVqXOt5ECM1Ld6jJaz5R/0OFNZkIpJh873fpi9pS5Ehou
OklFwC9QdeL4PKXMSwJtMj5Ni/BAF5Ebj8F9S2FK+ynRYyG8I5JpswcFWM3KodBK
J/ir+CGiJXb5GBc2l0HrKmmT6hSoB7yw+kqGn28S/RdD4eCxVlBtsZTBApXt2N1g
da6cHpdQOeAR3ZTJggFzVLyOua8crTus31lmtna2/3SU7iUf31jy1TZkREu2+5iM
ubLla2zwPASLTsIcuNPbQw/KOfZjlpWtO23hy5PJcqnFOd2jpxdky8DoEYMXt2AA
HAHwtYzDAUo7Qm6ikyKYYBw06miFaHD7lo/Y9/reGAPYopUydmQse36092gsWanT
4+PMdA8DQk7i6fxvPFgKvq6q+IMxYYR5/jrICt3AYM9qhq3nC0g=
=fzO6
-----END PGP SIGNATURE-----

--mpmcl7wrcjf73j5h--
