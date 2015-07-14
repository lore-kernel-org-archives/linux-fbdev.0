From: Mark Brown <broonie@kernel.org>
Date: Tue, 14 Jul 2015 10:50:19 +0000
Subject: Re: [RFC PATCH 14/15] regulator: pwm: implement ->enable(), ->disable() and ->is_enabled methods
Message-Id: <20150714105019.GR11162@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="+k3B0vOyg/ewl1oH"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
 <1435738921-25027-15-git-send-email-boris.brezillon@free-electrons.com>
In-Reply-To: <1435738921-25027-15-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org


--+k3B0vOyg/ewl1oH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 01, 2015 at 10:22:00AM +0200, Boris Brezillon wrote:
> Implement the ->enable(), ->disable() and ->is_enabled methods and remove
> the PWM call in ->set_voltage_sel().

This doesn't apply, please check and resend.

--+k3B0vOyg/ewl1oH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVpOlrAAoJECTWi3JdVIfQDTMH/AtQ50vnAugEewxCHd4ABmx6
AWC8HTnnr+NYfQRCNdLLEgrv8TP2Q7uBFJAR92gnzBnvQOHtXLSbK6VRYtN0Libk
DYqnJ/pCSzBSJW6goi7uKc6LjVclpjLdO9PGY7ZL1YIt3vH5eJyenvxQMnnjMiNQ
hoPkN7o9tWWDpMJU5Qg/1azA99i98WhTH31VAg79UmzNLrvXmKOxeo9q/hGo1Wve
48EfVl+lLyX7b7lEXPeBk3EXGzLFNBHeTld3bl4RNu/ME6y1Qv7lo3FVOPhiOAbm
PQ7veL5IqSTgixX/zbc5os0y0XSeLP3hG5FZGAVVZQg3kEQjvScN1hSEzCvExms=
=fS+L
-----END PGP SIGNATURE-----

--+k3B0vOyg/ewl1oH--
