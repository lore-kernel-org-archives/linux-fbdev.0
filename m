From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 23 Jun 2014 11:31:00 +0000
Subject: Re: [PATCH] video: move Versatile CLCD helpers
Message-Id: <53A80FF4.7030909@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="xwGfA6ElFxCi8Hqna4C8A2QaWFCSg80k8"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1401283017-15386-1-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1401283017-15386-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org

--xwGfA6ElFxCi8Hqna4C8A2QaWFCSg80k8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 28/05/14 16:16, Linus Walleij wrote:
> This moves the Versatile-specific helper code and panel database
> down into the drivers/video folder next to the CLCD driver
> itself, preserving the config symbol but also moving the header
> to platform data.
>=20
> This is necessary to rid the Integrator of this final <plat/*>
> inclusion dependency and get us one less user of the
> plat-versatile folder.

I don't like those display controller specific panel lookup tables at
all, but... Maybe it's still better to have them in the driver itself
instead of the arch/arm/.

I presume it's easier to queue this via arm tree, as it touches quite
many files there, and only adds a new file in video/.

So my (grudging) ack:

Acked-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

 Tomi



--xwGfA6ElFxCi8Hqna4C8A2QaWFCSg80k8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTqA/0AAoJEPo9qoy8lh71+B4P/3dGDoa8g/K8+aA5piwGyK5l
EgKYu3gr0Xj7GS+X2FhC4+6ppgv3PWk1ZqgppuVChJpgmmwqoEQmPrCQ5ihc/IMF
/ScV3BioJ43iaEpZhtQh7sUR9zzj19qUR1z33acHz2NfMfD2PCnFDeIroIoLpHxn
j7vM8MRiVeU9In/WpBaGVNVIYngDWPNZkGJMaPJ+lFz8t65RfLHR/LUPA1fH2hoO
5yr6ywXlOQt4+eccXeb1oqFdQAmlmIFo0E7lC1yeF2efQrCL3uv5/QD6+aQcGxGW
oNwbfcogjn4qGt1YY1Mh1Z+JhMyj8q3znEqfmMHLRFuUOnqBCBTRLozzY5zOrNGR
Mrrgk5RMzVioXm1X79Tug8BP5bCGtVo2KBLjxh6Mweip4h75W8anBjD948tUcCR3
zF0csA3mqNKkTUxUYQlCxdPsP5T5u987qapx0knRoas7qfla6BW1cA3cPJpA8PhN
hYgHnGwHS1ffd+/kmlub8y2GnqXo5F2KS8aUILHrbifcQbXmSVf2a1FBiL+OfJuc
iocCsBwYbmkw0nd4CeguopKSya7cPy4/GmK1S+1SEGzKKWi/cXnD96pyKwLopmzi
VyWa36JVpbx2333Cw++gOokfdVf3IWxv50/6BtRFPDkfAuXw/gmNvsCKQ4ugkG9w
blVhDt4BlvA+0upWBwzy
=v2xP
-----END PGP SIGNATURE-----

--xwGfA6ElFxCi8Hqna4C8A2QaWFCSg80k8--
