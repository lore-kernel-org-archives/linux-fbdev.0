From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 10 May 2016 10:32:49 +0000
Subject: Re: [PATCH v2] video: AMBA CLCD: Remove unncessary include in amba-clcd.c
Message-Id: <5731B8D1.3030200@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="mOH57IWaUTbdQqOV2EHHrXMLrxFsEjhXc"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1457922549-2610-1-git-send-email-annie.wang@amd.com>
In-Reply-To: <1457922549-2610-1-git-send-email-annie.wang@amd.com>
To: Wang Hongcheng <annie.wang@amd.com>, Russell King <linux@arm.linux.org.uk>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>, SPG_Linux_Kernel <SPG_Linux_Kernel@amd.com>

--mOH57IWaUTbdQqOV2EHHrXMLrxFsEjhXc
Content-Type: multipart/mixed; boundary="B73aSM3NXFtcFjQT3PAbhAP4pc2LePjea"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Wang Hongcheng <annie.wang@amd.com>, Russell King
 <linux@arm.linux.org.uk>,
 Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Borislav Petkov <bp@alien8.de>, SPG_Linux_Kernel <SPG_Linux_Kernel@amd.com>
Message-ID: <5731B8D1.3030200@ti.com>
Subject: Re: [PATCH v2] video: AMBA CLCD: Remove unncessary include in
 amba-clcd.c
References: <1457922549-2610-1-git-send-email-annie.wang@amd.com>
In-Reply-To: <1457922549-2610-1-git-send-email-annie.wang@amd.com>

--B73aSM3NXFtcFjQT3PAbhAP4pc2LePjea
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 14/03/16 04:29, Wang Hongcheng wrote:
> The header file asm/sizes.h is unnecessary.
> And it can also be compiled under X86 arch after the removal.
>=20
> Signed-off-by: Wang Hongcheng <annie.wang@amd.com>
> ---
>  drivers/video/fbdev/amba-clcd.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/amba-clcd.c b/drivers/video/fbdev/amba=
-clcd.c
> index 9362424..1a1ed80 100644
> --- a/drivers/video/fbdev/amba-clcd.c
> +++ b/drivers/video/fbdev/amba-clcd.c
> @@ -34,8 +34,6 @@
>  #include <video/of_display_timing.h>
>  #include <video/videomode.h>
> =20
> -#include <asm/sizes.h>
> -
>  #define to_clcd(info)	container_of(info, struct clcd_fb, fb)
> =20
>  /* This is limited to 16 characters when displayed by X startup */
>=20

Thanks, queued for 4.7.

 Tomi


--B73aSM3NXFtcFjQT3PAbhAP4pc2LePjea--

--mOH57IWaUTbdQqOV2EHHrXMLrxFsEjhXc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXMbjRAAoJEPo9qoy8lh71qRwQAIJGUzEFFVXEbywo5cdc0JBn
/r7PW/If88ziofFIVqdPPDnTrcrl9fQDty5qpRTZD/hJ4I8GySi598bu+q7jg0vk
TKiGTFRm6xoULjZo92VutRQbopwPe3K9VqHJXNTEiYhc7vrcVpA+fr7dWAx7kR3Q
FwgFNmR7+SD8jwtMww9dZM7FkthQEySIm5czEKHOM1a0bFploti/PiEpTBBxbzIl
t3K5Eg7raA/3OlB0DJ20FBh/mCUJnnDMJWo9PsUxr6V4RMEWUcikDlPj8qjnqRce
XlETQF3Ffm9xPu5vUQ6KkskoTHNKl8s2E1Mm23KVBNby9cqp9vy7XQkvUTrYZxpz
fQPg6VXs51OVt4dT0hbs8/5x1109kd8ldJ4jpVhaDmjCLLvEEbJBL4eg4UFEvX8K
Z5qg2UJLc/ANhYqD/QOInDhlg+abyFT+ydoml1Kr+s7i3RLN9wDNdh50nlY0b5EN
YWLt/093JwhAf4OUb9TdcZ3BTJiV/+cJpK/hcWsMCFTfJiXY6O+KAHkoU+mKy63e
Ew4OvssKIfx7bRZ73TQ6hu+JD1PHQMn9sImXkybI1DWpNdINE21fo0AuWcVoxo3I
L9Swsi3DpvRRl91jZ1HTpY4a035P1ojBP4IXoccKucoW/qayIQ9gYlqpOve0wUMf
/zl6XsrlvMXtmVzfP1it
=H//u
-----END PGP SIGNATURE-----

--mOH57IWaUTbdQqOV2EHHrXMLrxFsEjhXc--
