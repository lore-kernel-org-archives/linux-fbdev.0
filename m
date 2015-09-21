From: Mark Brown <broonie@kernel.org>
Date: Mon, 21 Sep 2015 21:10:53 +0000
Subject: Re: [PATCH v3 12/12] regulator: pwm: properly initialize the ->state field
Message-Id: <20150921211053.GF30445@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="GVmdUcABewnKtUm9"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1442828009-6241-1-git-send-email-boris.brezillon@free-electrons.com>
 <1442828009-6241-13-git-send-email-boris.brezillon@free-electrons.com>
In-Reply-To: <1442828009-6241-13-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org


--GVmdUcABewnKtUm9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 21, 2015 at 11:33:29AM +0200, Boris Brezillon wrote:
> The ->state field is currently initialized to 0, thus referencing the
> voltage selector at index 0, which might not reflect the current voltage
> value.
> If possible, retrieve the current voltage selector from the PWM state, else
> return -EINVAL.

Acked-by: Mark Brown <broonie@kernel.org>

--GVmdUcABewnKtUm9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWAHJYAAoJECTWi3JdVIfQxPsH/0ivENz0SB+aLAU4UrJXE0ky
Q1xie9LI6dab8dc6e7rmAOSDhkMJ1DvCyAEqSDqcFvsdxh2gdu2cz9cQ7divIjjP
XFJwuyHftuGzRWH3a1J9gp8VT/PyEvUUMWXnq2NrKGOZBTetd8WncixWV0ArxkZf
5BEOf1pkq4FHYD9pwRrhk3qJWPPUjjhCzziUC6o3Q1Mge29gIBAj8KE4VPRI4MCJ
M6Se8MJy1VcBml1eNoYcsDgwBA+j74sDCLuAb2YrX0naLxHqn1VUVY4V4HwwH4cx
XrXTdGmq9ke/jjBaKKRc8mXi6H4s3taKy2HNj6clxBH7bQsdoMD1GWgalYYdErE=
=8m4a
-----END PGP SIGNATURE-----

--GVmdUcABewnKtUm9--
