From: Felipe Balbi <balbi@ti.com>
Date: Tue, 14 Oct 2014 18:34:26 +0000
Subject: Re: [PATCH 2/3] video: fbdev: omap2: omapfb: add missing MODULE_ALIAS()
Message-Id: <20141014183426.GA19491@saruman>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="HcAYCG3uE/tztfnV"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1413311335-25083-1-git-send-email-balbi@ti.com>
 <1413311335-25083-2-git-send-email-balbi@ti.com>
In-Reply-To: <1413311335-25083-2-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org

--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2014 at 01:28:54PM -0500, Felipe Balbi wrote:
> without MODULE_ALIAS(), omapfb won't get loaded
> automatically.
>=20
> Signed-off-by: Felipe Balbi <balbi@ti.com>

little note here. This makes omapfb load automatically, but display
still doesn't work with DSS as modules. Backlight is working and pixel
clock is running just fine. Still, nothing on display.

I thought I'd leave that for Tomi to deal with.

--=20
balbi

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUPWyyAAoJEIaOsuA1yqRE3VIP/2Svy4xnAzPdCvDOlBxrls9a
RNqXtnuoHyAQDixzbMA17mES/EduhIUiYDUyjew4gfmCqV7p1XEJ/o3pJX25Fk61
Eh9fmn88bmDo4fYTwfTVagTJ3NwrXfqanwLgW+uXwS0BjqHwVkGPQs8lP9dk61I4
Av+QQ8lBwCUxI4CxqUgfj6zvGPCk7bWo/gSs9uyDqdRXpzV3xb50m2myx3+oFcVx
btSxwdJ6X6ukUNfoC+K7xgIJhP85D6vYgR6rn2Gt+uGUY2YSuJ41jyCZE6em76fH
S/p1m2fjRJJekqaWuvpcZyOlrsWaC0gNTLIrvGktNzlc0U37PH//kLZmHHZobCCO
FCl4qRuCt9/mZCptwllTksAR4r1bZcQNnXNY7SyW7hizFdl+8HuQQFAY8T+Is72d
q7owXGm0L9ZB2OtVnzDzdG6qBjYC5BtDW/H8mbbo29fH0kOP04AE1Ug4bNYj0ust
VLPaOF9qWQ+fyZ+9IEJJzTH2GnRr8nbr+YCG2JFC7E+vwJSvXEV1ClMF8l2qI37i
zFJRJob3jzvsFs/JH0Fwm35KijhSDq2xuMl/MJwiQgFlvHRavIor9/g+Ulx+LxlF
wpmzoeMc67yITRA5xr2oaoaqQWqxUrLXgT8/xc0ij1W35Ib+jr+5Q4ucJ8Y+vdi7
rju75M+fI0viRklfUHQS
=dBCq
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
