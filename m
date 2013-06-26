From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 26 Jun 2013 11:53:20 +0000
Subject: Re: [PATCH 1/1] video: imxfb: Make local symbols static
Message-Id: <51CAD630.1020208@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----enig2JRLVSIABAJNKUFKSVPLE"
List-Id: <linux-fbdev.vger.kernel.org>
To: linux-fbdev@vger.kernel.org

------enig2JRLVSIABAJNKUFKSVPLE
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 10/05/13 14:55, Sachin Kamat wrote:
> These symbols are used only in this file.
> Make them static.
>=20
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  drivers/video/imxfb.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

I've added this and the following three other small cleanups to my
fbdev-3.11 branch:

video: smscufx: Use NULL instead of 0
video: udlfb: Use NULL instead of 0
video: udlfb: Make local symbol static

 Tomi



------enig2JRLVSIABAJNKUFKSVPLE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJRytYwAAoJEPo9qoy8lh7127QP/jg4DVwZu5V4ccEZPdayevtb
bHUNf9dYSf+C2FZ0Ypg40vJ0vBK0l2FIzlL4kcbyvtiB5eZ1zuhUVUD7m28Danhh
97BP5xbeKLQYAchjK6MkpcWsf+3n6DqJWg67jqSkiRmmw4BFHd9DYpQFVBXoJXxn
zx0BBmiVzizajSYWGtV7POv249fGDJgGxgHrx8joIxo2REbA89nx+PAv/TJ9dcY/
mvizXidtgW2CADkJo0hm+h7kSiUvRun6M6gHsEJNDgnq+0fgQAnNH5TKLeygQe85
VLbGixdeAATSR5hdoJXeLZXJWCAjcQV7pxQ8s0U4BtQnpyIxM0vo7ruoRkEGyvno
xkBPF77oXdfxsK4/gaO8wZ2XcDF3WSAvfMfPKh/enLf2NEaw4Lx4KAaMH7zzA6cD
m9pB3z5RRDALq3E9OJ0B2KfzNPI4dca5fABHk9eulidWD/Dd/1Ac7t+y2HQShfN8
kY+93l32r1AnEWVA4I+hSBrdNK2tHJ9IU9xxT2A+X1huBwitOwbvSMTgw1jf4wO/
e0kbtx0qeiEovs8Em9aCIGwXoMD6RIoaFqU38FDZXEAqYN5gpAtH4Dhhj7TN7R84
VLO8pu6PbISwhG5rCYlzqw/frVMPngIeVmd/iNHFSiCknk2547ZkiBCJbt/LvNwQ
R6Jkv8Ye1e2K1CF7kbXO
=/VGK
-----END PGP SIGNATURE-----

------enig2JRLVSIABAJNKUFKSVPLE--
