From: Michal Simek <monstr@monstr.eu>
Date: Mon, 28 Oct 2013 14:39:47 +0000
Subject: Re: linux-next: build failure after merge of the final tree (fbdev tree related)
Message-Id: <526E7733.6020509@monstr.eu>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="phaUscxRjMls7GwoljvDcqWqcqC4NI2ep"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20131029012317.b9ba8173dee5bac1a5bd2404@canb.auug.org.au>
In-Reply-To: <20131029012317.b9ba8173dee5bac1a5bd2404@canb.auug.org.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--phaUscxRjMls7GwoljvDcqWqcqC4NI2ep
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 10/28/2013 03:23 PM, Stephen Rothwell wrote:
> Hi all,
>=20
> After merging the final tree, today's linux-next build (powerpc
> ppc44x_defconfig) failed like this:
>=20
> drivers/video/xilinxfb.c: In function 'xilinxfb_of_probe':
> drivers/video/xilinxfb.c:431:30: error: 'op' undeclared (first use in t=
his function)
>=20
> Caused by commit 353846fb8bb7 ("video: xilinxfb: Use standard variable
> name convention") from the fbdev tree.
>=20
> I have applied the following fix patch for today:
>=20
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Tue, 29 Oct 2013 01:18:22 +1100
> Subject: [PATCH] video: xilinxfb: Fix for "Use standard variable name c=
onvention"
>=20
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/video/xilinxfb.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/video/xilinxfb.c b/drivers/video/xilinxfb.c
> index 9eedf9673b7f..6ff1a91e9dfd 100644
> --- a/drivers/video/xilinxfb.c
> +++ b/drivers/video/xilinxfb.c
> @@ -428,11 +428,11 @@ static int xilinxfb_of_probe(struct platform_devi=
ce *pdev)
>  #ifdef CONFIG_PPC_DCR
>  	else {
>  		int start;
> -		start =3D dcr_resource_start(op->dev.of_node, 0);
> -		drvdata->dcr_len =3D dcr_resource_len(op->dev.of_node, 0);
> -		drvdata->dcr_host =3D dcr_map(op->dev.of_node, start, drvdata->dcr_l=
en);
> +		start =3D dcr_resource_start(pdev->dev.of_node, 0);
> +		drvdata->dcr_len =3D dcr_resource_len(pdev->dev.of_node, 0);
> +		drvdata->dcr_host =3D dcr_map(pdev->dev.of_node, start, drvdata->dcr=
_len);
>  		if (!DCR_MAP_OK(drvdata->dcr_host)) {
> -			dev_err(&op->dev, "invalid DCR address\n");
> +			dev_err(&pdev->dev, "invalid DCR address\n");
>  			return -ENODEV;
>  		}
>  	}
>=20

Your fix is correct.

Tested-by: Michal Simek <monstr@monstr.eu>

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform



--phaUscxRjMls7GwoljvDcqWqcqC4NI2ep
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJudzMACgkQykllyylKDCGTPgCfdqzPmLHNXCgFeqNWC4YNz0z+
EmAAn0mpKPX/pL6295OqX/mryMC45WgX
=Nz5B
-----END PGP SIGNATURE-----

--phaUscxRjMls7GwoljvDcqWqcqC4NI2ep--
