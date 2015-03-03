From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Tue, 03 Mar 2015 09:31:33 +0000
Subject: Re: [PATCHv2 05/10] fbdev: ssd1307fb: fix in tree users of ssd1306
Message-Id: <20150303093133.GC4911@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="GZVR6ND4mMseVXL/"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de>
 <1425248883-25367-1-git-send-email-niederp@physik.uni-kl.de>
 <1425248883-25367-6-git-send-email-niederp@physik.uni-kl.de>
In-Reply-To: <1425248883-25367-6-git-send-email-niederp@physik.uni-kl.de>
To: Thomas =?iso-8859-1?Q?Niederpr=FCm?= <niederp@physik.uni-kl.de>
Cc: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org


--GZVR6ND4mMseVXL/
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 01, 2015 at 11:27:58PM +0100, Thomas Niederpr=FCm wrote:
> introducing the new DT properties the in tree users of the SSD1306
> controller are updated to be up to date.
>=20
> Signed-off-by: Thomas Niederpr=FCm <niederp@physik.uni-kl.de>

This should be prefixed by "ARM: mxs:", and sent to the MXS
maintainers.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--GZVR6ND4mMseVXL/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU9X91AAoJEBx+YmzsjxAgd1cQAKLDwaab8wtoBaEBl81xNoUP
neB4m7zdCk9L2I1rPJmhZOW+h3G0djnZWj6FUhFbXaV1ySu0/ZV2Wm3JxcIg1a9s
8l6asgKe5ZRymjaOEtJU71mV9JLWqFRwIuOw1c3NEdyYiZOFQNY2ZDeHUTDr0jDS
LcMnuJresqD2KrLLhxScZ9CaX5wNb3rk3vT4pgR8EuoZRXloMxxkS0RJ1aB+zHOG
Y0e3p7b2wNN4LtR00D3MLgWbCG21FoWGJa1nS3lrx0J3FN4j4Rvf9ua/yGw5Nk0+
lwXnGYq3dLXnb4oFPaz5tsNdFw9JDSGufS85hsgWmo4D+X+wHiOZMWOWf76iZ/dP
3JyqrIQ+iLJ0BvejyIppCzCdIvMoT3PHUJSMWm0tAmvSUD4h+wU/k7h8jC8yfILp
WWtHcVYHrPz9EdEShefyeF/SHFGS872KKUV57fN3u3FCfVJa39Ldi7rfSZABb1tO
BYabkCIx2quKR+sb+nSrCAn6/D/ElMeCZri2kRbOIqEtexuDmKaXBGXBflICCgkW
/zP6jhlmBPteNbeUz6QV+Lq9BlM+mXmfjdfq4IKaFQgkmlsTtXUIkj8kjFtcSrR9
gNnp4vI6icduUN0GIsJ8ys1HA6o/Pg3E5VE+J93iVYCpFPBjfT/2RCwzlQflSbrv
Mx1njewZquf0Qr7y++vi
=dFl6
-----END PGP SIGNATURE-----

--GZVR6ND4mMseVXL/--
