From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 27 Sep 2016 08:45:30 +0000
Subject: Re: [PATCH] matroxfb: fix size of memcpy
Message-Id: <eafc2fdb-fd0b-1d60-f7d5-03fe169d43f3@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="uhNaBj2aPC0M4Mo1goUBeM24Wie2ONlj3"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1472147052-26921-1-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1472147052-26921-1-git-send-email-sudipm.mukherjee@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

--uhNaBj2aPC0M4Mo1goUBeM24Wie2ONlj3
Content-Type: multipart/mixed; boundary="0uKxo0FVH3lsCE7g7svmOpJuVqkAVcS14";
 protected-headers="v1"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
 Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org
Message-ID: <eafc2fdb-fd0b-1d60-f7d5-03fe169d43f3@ti.com>
Subject: Re: [PATCH] matroxfb: fix size of memcpy
References: <1472147052-26921-1-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1472147052-26921-1-git-send-email-sudipm.mukherjee@gmail.com>

--0uKxo0FVH3lsCE7g7svmOpJuVqkAVcS14
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 25/08/16 20:44, Sudip Mukherjee wrote:
> hw->DACreg has a size of 80 bytes and MGADACbpp32 has 21. So when
> memcpy copies MGADACbpp32 to hw->DACreg it copies 80 bytes but
> only 21 bytes are valid.
>=20
> Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
> ---
>  drivers/video/fbdev/matrox/matroxfb_Ti3026.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/video/fbdev/matrox/matroxfb_Ti3026.c b/drivers/vid=
eo/fbdev/matrox/matroxfb_Ti3026.c
> index 195ad7c..68fa037 100644
> --- a/drivers/video/fbdev/matrox/matroxfb_Ti3026.c
> +++ b/drivers/video/fbdev/matrox/matroxfb_Ti3026.c
> @@ -372,7 +372,7 @@ static int Ti3026_init(struct matrox_fb_info *minfo=
, struct my_timming *m)
> =20
>  	DBG(__func__)
> =20
> -	memcpy(hw->DACreg, MGADACbpp32, sizeof(hw->DACreg));
> +	memcpy(hw->DACreg, MGADACbpp32, sizeof(MGADACbpp32));
>  	switch (minfo->fbcon.var.bits_per_pixel) {
>  		case 4:	hw->DACreg[POS3026_XLATCHCTRL] =3D TVP3026_XLATCHCTRL_16_1;	=
/* or _8_1, they are same */
>  			hw->DACreg[POS3026_XTRUECOLORCTRL] =3D TVP3026_XTRUECOLORCTRL_PSEUD=
OCOLOR;
>=20

Thanks, queued for 4.9.

 Tomi


--0uKxo0FVH3lsCE7g7svmOpJuVqkAVcS14--

--uhNaBj2aPC0M4Mo1goUBeM24Wie2ONlj3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJX6jGqAAoJEPo9qoy8lh71IKoP/RanklVW1qIlnnjMFzrABbwa
8ptetnRY/9S56c34Bc9qhd5mAmtXL353GcOOzTy9ijV/t8Hy3sRMed33Ys4qOLlm
A48JjVkilSByiZJ81/2V7AXpIF6nAUgfUIxvURN27XJ5PixHZqrnxpobA9oW+82s
sVGf/DFm5bKWUdWvJV7QQ6Ca5+KfbUSnHjFtb/mRfyJLD8cZ9Epf1qHiVVVoKk11
Vow1rxBaW9mbJUvR7aerdBTxWE7MG+HmR953jFiJeLknc+wLL/Z2adHODBpDKGeD
T/qRr1jCuojo+WJomuXcBuezdKwzt2uvwaQ6q9ZMNttYE5qN9Yvb8bxYFyo7BI3C
fgcCNBtPIO8MP+pvf/SJWov+Ub1MF0A/KCQ2zLoezpFrHBB/Uzs0hLctKfQ60Zmd
ctgLo5tvfDYyrpDAKCd+m45kWldWEtk+M1VoCEvZbomuyl0o4penxvlUwv+olY1Z
PkHdg8yrC52hB+LrqeTA/i7uXM1SnYUh0nEjDW9fpYWZrEizE72rON00BCs95O2q
Y9aLTa0DgwUTNzKpRVDcOhAjoGM5wvKEBPsct3e4e/yDNwdFu2x843uudpXjYzIq
OLyrrp564vsOA7Hsafj49+h5ctycO+v7b88xXPwj9j/zQjeLqDNBiy+rFtHHgP2v
QiDE2o1djTrhCmYtvsxu
=zLyk
-----END PGP SIGNATURE-----

--uhNaBj2aPC0M4Mo1goUBeM24Wie2ONlj3--
