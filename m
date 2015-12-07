From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 07 Dec 2015 16:11:54 +0000
Subject: Re: [PATCH] fbdev: sm712fb: avoid unused function warnings
Message-Id: <5665AFCA.7090800@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="j4EL6rNIQkARcS6knj2kCrNKKq5uHm2vB"
List-Id: <linux-fbdev.vger.kernel.org>
References: <4240710.SWINpxTKzN@wuerfel>
In-Reply-To: <4240710.SWINpxTKzN@wuerfel>
To: linux-arm-kernel@lists.infradead.org

--j4EL6rNIQkARcS6knj2kCrNKKq5uHm2vB
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 20/11/15 23:48, Arnd Bergmann wrote:
> The sm712fb framebuffer driver encloses the power-management
> functions in #ifdef CONFIG_PM, but the smtcfb_pci_suspend/resume
> functions are only really used when CONFIG_PM_SLEEP is also
> set, as a frequent gcc warning shows:
>=20
> fbdev/sm712fb.c:1549:12: warning: 'smtcfb_pci_suspend' defined but not =
used
> fbdev/sm712fb.c:1572:12: warning: 'smtcfb_pci_resume' defined but not u=
sed
>=20
> The driver also avoids using the SIMPLE_DEV_PM_OPS macro when
> CONFIG_PM is unset, which is redundant.
>=20
> This changes the driver to remove the #ifdef and instead mark
> the functions as __maybe_unused, which is a nicer anyway, as it
> provides build testing for all the code in all configurations
> and is harder to get wrong.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks, applied for 4.5.

 Tomi


--j4EL6rNIQkARcS6knj2kCrNKKq5uHm2vB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWZa/KAAoJEPo9qoy8lh71H2sQAJ6BUkW5QDDXZhfzUCIY8zoH
2t/3wOaHvU/SNVesbTX0QcLjtK6q64vvfmi5EkTGSMUjUtK3bz2u5rbC2GIaqqy1
xBuU9UHiITrugIuuuSUQ5JXkmUs20L3OPbN7pY1J7bD6XMzWBXRTdJzulctoO0LP
nYYYP2Bl/1unuRmdBCdcHgqTXd0FfnCRzDfYOJDQtW2uFT5dip3GWq5pME1nIsu3
yYkJRkxDw76yfyaHcMi/jfseX+f4o/t0hcCMWttaaEiCVDKyCbVdIleiS+LI5DJN
pe+rce1jrTN4IRsmhfoPiK+ufMBR/y93tqGbYGiosacu9XSD2QHaUxeA3M3XGoCe
Fc6oY+PYVGPVujvVyo6nBJvxpoAHAen19vvLQriA7UqNrV4bRhutib6j2ABrhd/I
OhxxLwiLfizEq6/lHoJ1XcQwIsSmKyjeepJ9HrtGz6JkJL7ionlM/AEPxg5fCeZ6
id/z8DBHfAJ6D7qRGFMZq30k/oIEv5qJk5rFQxTfL7Sej11MVbFM7faMlIoIelpz
hMuu7xAC/KD9XvZQVr0rGj0xGM/NriTr2vxnDoD7ceZa/Op5lVAncHfuHcTToMsP
tC1GZ+oxYJWUXWWwalteeAjRk2iKi/yuy7TRZ3IUoIFiCQwn2SMBd6gAkYiuz201
SUF43wErC9UrTSucbJJC
=g1MW
-----END PGP SIGNATURE-----

--j4EL6rNIQkARcS6knj2kCrNKKq5uHm2vB--
