From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 07 Mar 2014 12:20:51 +0000
Subject: Re: [patch -resend] sisfb: fix 1280x720 resolution support
Message-Id: <5319B9A3.7050100@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="SH0Qr9Ipr94LXUCjVEOrMXFn7xnb31buA"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140307111853.GB2351@elgon.mountain>
In-Reply-To: <20140307111853.GB2351@elgon.mountain>
To: linux-fbdev@vger.kernel.org

--SH0Qr9Ipr94LXUCjVEOrMXFn7xnb31buA
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 07/03/14 13:18, Dan Carpenter wrote:
> It uses the wrong mode index because there is no break statement.
>=20
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>=20
> diff --git a/drivers/video/fbdev/sis/init.c b/drivers/video/fbdev/sis/i=
nit.c
> index 4f26bc28e60b..bd40f5ecd901 100644
> --- a/drivers/video/fbdev/sis/init.c
> +++ b/drivers/video/fbdev/sis/init.c
> @@ -651,6 +651,7 @@ SiS_GetModeID_LCD(int VGAEngine, unsigned int VBFla=
gs, int HDisplay, int VDispla
>  	     switch(VDisplay) {
>  	     case 720:
>  		ModeIndex =3D ModeIndex_1280x720[Depth];
> +		break;
>  	     case 768:
>  		if(VGAEngine =3D=3D SIS_300_VGA) {
>  		   ModeIndex =3D ModeIndex_300_1280x768[Depth];
>=20

Thanks, queued for 3.15.

 Tomi



--SH0Qr9Ipr94LXUCjVEOrMXFn7xnb31buA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTGbmjAAoJEPo9qoy8lh71QkUP/1HR2d1mlrXeoewb1AViqny+
xBrEz7pNY1qlB70nRM6PJkjBvqOmTs83b0fNc0r1nEDHDE/fn4LEPnc7u3xlLHKm
OhXbEOMrp4z8QCYiUxlCB3E97Ced+XpOyAx5SDC0F9D60znpwVGuKnVgDh119pZZ
dQqDKBZzaBrHu7BJqOGb2tKRnc/4R1qwWnMjvYI8qKbodDCDiSfgGRmmfDinhda+
9oMjGa4tS/vspSS75SE8s88heVFdnJd63UyqchflFyT9qS16o6riMEPs/CSMTsb6
eV8E2hHDo4nNUr1KzqNCFC4p805Tj51KIjNE/GCc0JCV6NvxSspBxT66DX62RrdE
zTdbPKtnUQ30Vhs3AoWB4J1nz748VChzMv+sEW3uyDDlE6XjF80/08mzIZWjuWo+
RITZkXuDhx2hQMQF5iSMjQJpL+52vMquYrjRihAcJXiddvmLRrDfxP/tXt4z+Gla
Za8vlncdB/gE9WMSoPDSZZLtBuBasQCHw66V/GnRJ6zMhRVj+GaV6Z56G4+OEcds
yp332gsoc5KQ5I4TnMGq1VYBj3qOsofeN7ewiJKTokSJ6DxVJOeq36HTNmPdfJiE
IwXtfpf9vDtwkS/+1mM69qIj1a5K3QQTlMaVJ3sh1uDyK0SBjakMesgeoVqnU2C1
mBgOruU3wxrICuQYQd//
=ciT5
-----END PGP SIGNATURE-----

--SH0Qr9Ipr94LXUCjVEOrMXFn7xnb31buA--
