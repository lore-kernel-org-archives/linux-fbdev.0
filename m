From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 26 Jul 2013 07:46:24 +0000
Subject: Re: [PATCH RESEND] video: mxsfb: Let device core handle pinctrl
Message-Id: <51F22950.4010805@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="fJ1HEQQv05SpfuSkVEC1qR1paUDLqEKLn"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1373923884-13332-1-git-send-email-festevam@gmail.com>
In-Reply-To: <1373923884-13332-1-git-send-email-festevam@gmail.com>
To: linux-fbdev@vger.kernel.org

--fJ1HEQQv05SpfuSkVEC1qR1paUDLqEKLn
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 16/07/13 00:31, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>=20
> Since commit ab78029 (drivers/pinctrl: grab default handles from device=
 core)
> we can rely on device core for handling pinctrl, so remove=20
> devm_pinctrl_get_select_default() from the driver.
>=20
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> Acked-by: Shawn Guo <shawn.guo@linaro.org>

Thanks, I've applied this into my 3.12/fbdev branch.

 Tomi



--fJ1HEQQv05SpfuSkVEC1qR1paUDLqEKLn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJR8ilQAAoJEPo9qoy8lh71BQ0P/2jb89N74XCA9Vd7HiVhpRcB
pc0cuL8YLAlszE/Xq7j7pAmWxJm7Ju0N60V17wn+AsndytFd6HNGAmSQeUCZHnsI
eyEWJNvt9L6fK1vO4G1r6tpo35FDgM+A9NHw+8EVLpf+EQQsjnk0igWAVwxtdNGN
F8v4Ioo+5B9roPHsi45Z1fzoqK2gzQCDQ5zl4HCxuGSKyssChqa7cub1sc+XptI+
vgK2V7yJNfth0guX8zEFMljFDMEdnLwC/6p1t7wB57aYPsVVFu9+wJc7wI/vLxiP
fBPMpCuecZnCWXKN9dgJWEon8685AakzDttRnq0pAHbOktxBwpddebqdXORTI38x
QUxZ36IdW3Hl0E8rQTOGZvYbvk2+7q6TpLkvsMDHd/XLGKdUeLDGiKdeM/BbbvYv
0NiaPcI9I9zDZNjy4bRJnReIz76malN8iFTIxnbRFWMumZFcqYofL2z4jSr/R5tE
9afnmViK9bzJHqle8k7vuutMIZhDB38gmaKvDDSaoMp7PxOpYRU0j3edEOxkvOpg
mOugpAmxuEVlg5hQRKhR0f9PPTxEeZoSuIKkCNjK36Ri8bmbq/tEKy2HUGB1ZIDE
zEcaaV0hX+TmDujUQRw5AR8c7pvuVx6EgJLCwkTktBUZfvdJ/RemQveo33fKx7ip
GEveHs2sT8h31DK53YcA
=GiWt
-----END PGP SIGNATURE-----

--fJ1HEQQv05SpfuSkVEC1qR1paUDLqEKLn--
