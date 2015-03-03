From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Tue, 03 Mar 2015 09:40:46 +0000
Subject: Re: [PATCHv2 10/10] fbdev: ssd1307fb: Turn off display on driver unload.
Message-Id: <20150303094046.GD4911@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="F8dlzb82+Fcn6AgP"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de>
 <1425248883-25367-1-git-send-email-niederp@physik.uni-kl.de>
 <1425248883-25367-11-git-send-email-niederp@physik.uni-kl.de>
In-Reply-To: <1425248883-25367-11-git-send-email-niederp@physik.uni-kl.de>
To: Thomas =?iso-8859-1?Q?Niederpr=FCm?= <niederp@physik.uni-kl.de>
Cc: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org


--F8dlzb82+Fcn6AgP
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 01, 2015 at 11:28:03PM +0100, Thomas Niederpr=FCm wrote:
> This patch turns off the display when the driver is unloaded.
>=20
> Signed-off-by: Thomas Niederpr=FCm <niederp@physik.uni-kl.de>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--F8dlzb82+Fcn6AgP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIbBAEBAgAGBQJU9YGeAAoJEBx+YmzsjxAg4xcP9AhD/C16EsMloeHBFU0IXXQf
46PMjwEJI83hbd0a3KHJIshVgCPAbGWzoJbPA1lBgz5rLNj3eq3Rtlvdzfb/TTc9
KbZlXU5XZIgGmLckA+gCrY3J0lvVXeEbVQgJPzykqF6KvbX9crszSGv+JShf6XtU
5d3kdSyxcwLy/ATVb4B12/fgiXE8u4ak91akUFpSAY1Sr/ng3hA31YVi8SnoQq2x
vmNu/SxELY9uksQwWZRdZQLLtAXaHtPhOSEMeRBtuH3DsHql/2HPTFZbdshlhppZ
VO90UfaCoc9E7N09qJq5it3kJX247ag3QzvVOj9ADYLF7i+AgbC7sHTn0buFneQj
rPVr6Xiek0vs2v5hGRMpOtrvF41IzXQDVjRbahsv7Kbjs9otrmWCpPuEZXvQnDTS
1tSEzJkmZ2LPo+h6/5j+TN+9j/yW2Z5857TU4XjfWCXcWwgkqPr0RHOHV9shff1t
r0T1mgiSv1BF4BBN2T5+qTOHD6bARf77L8dO/suwWm3um4ABNB7rELCQphM2nrrd
J2GLkIiWucQxAzzUn/9CX1sRp4Dysb88eTpfAQUdvxJfPhxhYdzp51/b4YfT5f0x
ASYiLpiKirKPRrnpvAI90jeGVCS3Ph6pfoZVqBcEmClOVYgjqUhV5CVl70n+QFy8
RSef21fA9uoxVwajywI=
=HJX9
-----END PGP SIGNATURE-----

--F8dlzb82+Fcn6AgP--
