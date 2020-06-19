From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Date: Fri, 19 Jun 2020 07:21:19 +0000
Subject: Re: [PATCH 0/6] remove deprecated i2c_new_device API
Message-Id: <20200619072119.GB1705@kunai>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="LpQ9ahxlCli8rRTG"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200615075816.2848-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20200615075816.2848-1-wsa+renesas@sang-engineering.com>
To: linux-i2c@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, platform-driver-x86@vger.kernel.org, linux-media@vger.kernel.org


--LpQ9ahxlCli8rRTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2020 at 09:58:09AM +0200, Wolfram Sang wrote:
> I want to remove the above API this cycle, and just a few patches have
> not made it into 5.8-rc1. They have been reviewed and most had been
> promised to get into linux-next, but well, things happen. So, I hope it
> is okay for everyone to collect them like this and push them via I2C for
> 5.8-rc2.
>=20
> One minor exception is the media documentation patch which I simply have
> missed so far, but it is trivial.
>=20
> And then, finally, there is the removal of the old API as the final
> patch. Phew, that's been a long ride.
>=20
> I am open for comments, of course.

Applied to for-current, thanks!


--LpQ9ahxlCli8rRTG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl7sZ2sACgkQFA3kzBSg
KbZVtBAAjxj8/yCiqHPP8gPXOpd8hStQqYaqlvw6NW5ddjUNy8nDaA/ztSbvpdDv
RKtamlqk9b6JKoOgP0Fxe6xQfysX5qdg9DOKGlAS+atbNTQNydlCovfYbUARyJtz
RoiP0jzxCquuoLcSWAtGWzBhG350v33bysM+zVe4yakWp2ILF8Y1y5l+7/tgXFZB
HbVGxYihsGm76WPlXRRACWrKB1HsieEPVUXDCzG9BLMicuy1Ly7en7UdhkiJnzpz
+Pk1OVCXpDHoKewKv2uK8sbf+TSy9hdesPCO40TZC1Oe1hB2fJGPOV3XsR0CZ7iS
mC7vRPd3rNw62m4zMDxIX0Le5QlCQCpwiW8uSNj7IuadxM5p34b2J6cqTeQBEz5K
y33mJTVybc2yClSvrFDnXNj1Zagz1M4vMVpDLGTBX45rzxmShlzl2inG9hVZblw8
EMSYAefZUHfgc7HptbdTQsTQkjlS1Q5wg9lHXWXGdtFE/oEhOV/DGQOLQwlBH6jD
shVnrzLQcr7mUgJCq2+x8dTs73TnupyVCcRIDh2iTXPmd6UGByIAUN5yTC5GkUIf
wmtRQyJfYHNEvtdFC+jehCarVj0zO0JmzDX434FUDJMFvXa9a2vqJLORds5ASJl7
3K+Xupy+eSX6trVDd7StjIQYraYbn2rFko60famD5ePLbfpGuDE=
=kh1x
-----END PGP SIGNATURE-----

--LpQ9ahxlCli8rRTG--
