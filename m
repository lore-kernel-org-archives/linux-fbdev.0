From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Tue, 03 Mar 2015 07:17:27 +0000
Subject: Re: [PATCHv2 01/10] fbdev: ssd1307fb: fix memory address smem_start.
Message-Id: <20150303071727.GD4713@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="rqzD5py0kzyFAOWN"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de>
 <1425248883-25367-1-git-send-email-niederp@physik.uni-kl.de>
 <1425248883-25367-2-git-send-email-niederp@physik.uni-kl.de>
In-Reply-To: <1425248883-25367-2-git-send-email-niederp@physik.uni-kl.de>
To: Thomas =?iso-8859-1?Q?Niederpr=FCm?= <niederp@physik.uni-kl.de>
Cc: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org


--rqzD5py0kzyFAOWN
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 01, 2015 at 11:27:54PM +0100, Thomas Niederpr=FCm wrote:
> the smem_start pointer of the framebuffer info struct needs to hold the
> physical address rather than the virtual address. This patch fixes a
> driver crash on mmaping the framebuffer memory due to an access to the
> memory address.
>=20
> Note however that the memory allocated by kzalloc is not page aligned,
> while the address presented on a mmap call is aligned to the next page
> boudary.
>=20
> Signed-off-by: Thomas Niederpr=FCm <niederp@physik.uni-kl.de>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--rqzD5py0kzyFAOWN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU9WAHAAoJEBx+YmzsjxAgGckQAJbPcdQVdA+gkGiqYHFat+Qr
XE2SAxrE/Cj7ll6EhrrzSvw/BokoTbSq8GFf2svypWu2N/IgbNPEFnKb9O5f+ruC
K1uI3T6RkQWlDzXwAG8HfV6ZWuGSb7dYMFAbwvwCq74BKd15vNVneT1fGjNKBgsv
PcNmGtry+Udgift/4g7uTsSeGWBR84RP2eW6bAe4SHgh+QSk2Cv1UiHcy2FjGheD
1AFWzUW/lg7zKjqUn1EUqzaE2BKmTyuqsVw0DA+ahtaaZcOMS+HlEW6SF4pSrJHo
/mzd0GONQ7fHMGXG883EiYItsU2jx5K/CRAZqnOqsblb8dUugnDlpmWKusGSNl+s
594kDnRcyFfnrh5KU4YQncNvsTuYjJIUYGVI6bCMXfMl4T+B4MtOJZcG3diMWE6Q
XZTKlw4+y8RV5M/ROdG+MhX5k42Ht8B3QPLMScDtBUJiHKoO4z09lMD+WrHhxsR3
xayJuuCLBB6uwPKwRKDP0GNGfa6DFJ9CX5UaEHzSxmYQRzm4WxDrLSFSeG2yXLSJ
P0QiCWKzyf972gmPSKukSBO4pSMGQo+mMIjNeja84DbZvrvkj/87aqIVU+KnSkyY
BGqNKy56X2U4tKVguj0mjxVyyKICiKVrtrH8puUhaWExisRrsndX1J7vMSHuAUkp
WgEIP3WMZ71FXeLR/LT0
=1NGU
-----END PGP SIGNATURE-----

--rqzD5py0kzyFAOWN--
