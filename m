From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 24 Sep 2015 10:12:48 +0000
Subject: Re: [PATCH] fbdev: broadsheetfb: fix memory leak
Message-Id: <5603CCA0.6000702@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="17ouNXsG3OWPj3XgaAMgbL8Lv2sbGmSaU"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1442574992-31654-1-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1442574992-31654-1-git-send-email-sudipm.mukherjee@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

--17ouNXsG3OWPj3XgaAMgbL8Lv2sbGmSaU
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable


On 18/09/15 14:16, Sudip Mukherjee wrote:
> On the error path we have missed releasing the firmware.
>=20
> Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
> ---
>  drivers/video/fbdev/broadsheetfb.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/broadsheetfb.c b/drivers/video/fbdev/b=
roadsheetfb.c
> index 0e5fde1..ac1f41e 100644
> --- a/drivers/video/fbdev/broadsheetfb.c
> +++ b/drivers/video/fbdev/broadsheetfb.c
> @@ -752,7 +752,7 @@ static ssize_t broadsheet_loadstore_waveform(struct=
 device *dev,
>  	if ((fw_entry->size < 8*1024) || (fw_entry->size > 64*1024)) {
>  		dev_err(dev, "Invalid waveform\n");
>  		err =3D -EINVAL;
> -		goto err_failed;
> +		goto err_fw;
>  	}
> =20
>  	mutex_lock(&(par->io_lock));
> @@ -762,13 +762,15 @@ static ssize_t broadsheet_loadstore_waveform(stru=
ct device *dev,
>  	mutex_unlock(&(par->io_lock));
>  	if (err < 0) {
>  		dev_err(dev, "Failed to store broadsheet waveform\n");
> -		goto err_failed;
> +		goto err_fw;
>  	}
> =20
>  	dev_info(dev, "Stored broadsheet waveform, size %zd\n", fw_entry->siz=
e);
> =20
>  	return len;
> =20
> +err_fw:
> +	release_firmware(fw_entry);
>  err_failed:
>  	return err;
>  }

This looks like correct fix, but where is the firmware released when
there is no error?

 Tomi


--17ouNXsG3OWPj3XgaAMgbL8Lv2sbGmSaU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWA8ygAAoJEPo9qoy8lh71npUP/3DdjCiL6PzrOt59EyAf5cWo
6wvpRF9P9HtcTUMEcQB2qZeIPS7Nj5Gcc6wA1nJRSQGZzBVl0/sB/3QLPk7zcXdD
Aa6ON1ylZZVcHEu+KtxkW2PcItyDzk1GG/KjjTPjz4rFYw3kLSd6vI7DdLLnMb6u
Nl5yGC7OScD/GPG6RPPgugWEHM8XhVsUjQflN3oiSzKkDHWY6AY2UmFiAeTOoZtK
8RZf/7zWFvO3XXUIE2NHrKDboSbCtFphnhzHNr6Op1/EEuG1a23dD4hBk+DTNT3V
qCLJYTo3nyVKiKoVasAhJ+zlZMDCdcN3jIsRVhzMrRIYi2m/6Tn3PoRCdj8sDX09
/mlrd24Q+ZF5eOm6MPVjHj8RJyafJ/0gWXN8mqWDuMmx1NHIAN0DsElxdNG9AhXA
tDTE2m4SGx45mvmtz0L4cEjzvLbEJ6V8EfArXpDxMks1wfVmeNlqtOv9xJzT1j+2
225swp4jkBBRGgg3aoxJHZJdUjqh6Z4TxafM9fGPR/YmcUYpQxwIAOm8NRfIrZAa
sRrQMg2ajhEWtEw+0rmE5cMSJhxPcXrKmlRuaMsZD3/qcBtAcZ23ErHiverejSUI
9XyNhFL32abePKplsroH4AfngvqjoUNMnVAWUIoiZ4WW30uDRUDZ/y3JVBCofG9D
jNLGbhTxuChmd+CsEosR
=trlL
-----END PGP SIGNATURE-----

--17ouNXsG3OWPj3XgaAMgbL8Lv2sbGmSaU--
