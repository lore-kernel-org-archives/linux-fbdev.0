From: Mark Brown <broonie@kernel.org>
Date: Wed, 22 Apr 2015 19:33:13 +0000
Subject: Re: [PATCH 5/5] ASoC: omap-hdmi-audio: Fix invalid combination of DM_INH and CA
Message-Id: <20150422193313.GH22845@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="ihETVmeDfwOC2qSl"
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1429705991.git.jsarha@ti.com>
 <79f95cefe5f69f90698520adab90ce83b8539bf8.1429705991.git.jsarha@ti.com>
In-Reply-To: <79f95cefe5f69f90698520adab90ce83b8539bf8.1429705991.git.jsarha@ti.com>
To: Jyri Sarha <jsarha@ti.com>
Cc: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, peter.ujfalusi@ti.com, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com, misael.lopez@ti.com


--ihETVmeDfwOC2qSl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2015 at 04:23:01PM +0300, Jyri Sarha wrote:
> From: Misael Lopez Cruz <misael.lopez@ti.com>
>=20
> DM_INH =3D 1 (stereo downmix prohibited) and CA =3D 0x00 (Channel
> Allocation: FR, FL) is an invalid combination according to the
> HDMI Compliance Test 7.31 "Audio InfoFrame".

Acked-by: Mark Brown <broonie@kernel.org>

--ihETVmeDfwOC2qSl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVN/d5AAoJECTWi3JdVIfQ1B0H/RH1CMCOvjHT11HvPlHGbq3q
pWbWilp+CkrdaNu2T7rPbHj2yP++zhNohGPFAiadxOSixt8VBXEWArJFnFN/9aBC
i6wcKu68JZw13aA6MPj7yHim5wmCSSeJ9IhBVZ1Ja3Lm8SU3fy/t1ESx22NZqCCf
dI5iGiXZaFZ/Z1KML+G+gzcSCHCcn8bHFffZVG0FdMkItED0aOEl01RQuI0DYnFh
7AfhTgBngELmoMW2LFcz8Y5515Oi+r0UKtm7gQ3mAtxXHAg4AnT//18zpTifxPSU
glS8gTAvy5xHUFghp5ZnoGY3SgAMa06n1oJuou5BHVBvNBLKPYQUGKVcilSOvYg=
=02az
-----END PGP SIGNATURE-----

--ihETVmeDfwOC2qSl--
