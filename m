From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 25 May 2015 05:57:34 +0000
Subject: Re: [RFC PATCH] video/logo: introduce new system state for checking if logos are freed
Message-Id: <5562B9CE.7050807@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nN4R54GNd7uuI0WbpRbnt9mjSbPReidAw"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1430896145-8887-1-git-send-email-hs@denx.de>
In-Reply-To: <1430896145-8887-1-git-send-email-hs@denx.de>
To: Heiko Schocher <hs@denx.de>, linux-kernel@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-fbdev@vger.kernel.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>

--nN4R54GNd7uuI0WbpRbnt9mjSbPReidAw
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 06/05/15 10:09, Heiko Schocher wrote:
> commit 92b004d1aa9f ("video/logo: prevent use of logos after they have =
been freed")
>=20
> added a late_initcall function to mark the logos as freed. In reality
> the logos are freed later, and fbdev probe may be ran between this
> late_initcall and the freeing of the logos. In that case the logos
> would not be drawn. To prevent this introduced a new system_state
> SYSTEM_FREEING_MEM and set this state before freeing memory. This
> state could be checked now in fb_find_logo(). This system state
> is maybe useful on other places too.
>=20
> Signed-off-by: Heiko Schocher <hs@denx.de>
>=20
> ---
> Found this issue on an imx6 based board with a display which needs
> a spi initialization. With 3.18.2 I see a perfect logo, but with
> current ml, bootlogo is missing, because drm gets probed before
> spi display, which leads in drm probing is deferred until the
> spi display is probed. After that drm is probed again ... but
> this is too late for showing the bootlogo.
> With this patch, bootlogo is drawn again. I am not sure, if it
> is so easy to add a new system state ... but we should have a
> possibility to detect if initdata is freed or not. this is maybe
> also for other modules interesting. Maybe we add a
> kernel_initdata_freed()
> function instead of a new system state?
>=20
>  drivers/video/logo/logo.c | 15 ++++-----------
>  include/linux/kernel.h    |  1 +
>  init/main.c               |  1 +
>  3 files changed, 6 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/video/logo/logo.c b/drivers/video/logo/logo.c
> index 10fbfd8..d798a9f 100644
> --- a/drivers/video/logo/logo.c
> +++ b/drivers/video/logo/logo.c
> @@ -26,16 +26,6 @@ MODULE_PARM_DESC(nologo, "Disables startup logo");
>   * Use late_init to mark the logos as freed to prevent any further use=
=2E
>   */
> =20
> -static bool logos_freed;
> -
> -static int __init fb_logo_late_init(void)
> -{
> -	logos_freed =3D true;
> -	return 0;
> -}
> -
> -late_initcall(fb_logo_late_init);
> -
>  /* logo's are marked __initdata. Use __init_refok to tell
>   * modpost that it is intended that this function uses data
>   * marked __initdata.
> @@ -44,7 +34,10 @@ const struct linux_logo * __init_refok fb_find_logo(=
int depth)
>  {
>  	const struct linux_logo *logo =3D NULL;
> =20
> -	if (nologo || logos_freed)
> +	if (system_state >=3D SYSTEM_FREEING_MEM)
> +		return NULL;
> +
> +	if (nologo)
>  		return NULL;
> =20
>  	if (depth >=3D 1) {
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index 3a5b48e..e5875bf 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -462,6 +462,7 @@ extern bool early_boot_irqs_disabled;
>  /* Values used for system_state */
>  extern enum system_states {
>  	SYSTEM_BOOTING,
> +	SYSTEM_FREEING_MEM,
>  	SYSTEM_RUNNING,
>  	SYSTEM_HALT,
>  	SYSTEM_POWER_OFF,
> diff --git a/init/main.c b/init/main.c
> index 2115055..4965ed0 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -931,6 +931,7 @@ static int __ref kernel_init(void *unused)
>  	kernel_init_freeable();
>  	/* need to finish all async __init code before freeing the memory */
>  	async_synchronize_full();
> +	system_state =3D SYSTEM_FREEING_MEM;
>  	free_initmem();
>  	mark_rodata_ro();
>  	system_state =3D SYSTEM_RUNNING;

Without locking, the initmem may be freed while fb_find_logo() is running=
=2E

 Tomi


--nN4R54GNd7uuI0WbpRbnt9mjSbPReidAw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVYrnOAAoJEPo9qoy8lh71b0QP/12S9LUJ6HVacdrwucgTM4NJ
+d4UxmxhsQhsCy7vITuhjn2DvzMVJVA9vbWN6Y+aO9L1fY0UAubkOGQHoq3qVSfa
SeW/3mEZOP62bUjB7ZI/Pt2Bh2NAvE3iN1prztdEBCTH2aqa3h12Ftj8VTE7FQ3n
V7KWtGV6MJN7AKq4TrEZz932qj232agut+PL5fXgDMMc8NhvLZF+0fJXa1VxAM00
7Ne3X4uYDgrF+5c8YJOLauEEXHOiBSopF5j7ZnsqGsESBRhDVQAvSOwMcGqIjho/
emoYij2ehgV5LrVFR2wqOqTcn6FS2W58npMpjmxsJByp1EEJZlxpYjmApvwuD/Zt
0zW74l7fQ/afpgHyYmnHomLa5WaMb/+RA8joPhr7nWliIYI/Y699GTs2E8gcfqtb
mzB1d2w/5eurat+dJeqXYIrTcUZlqhI5UX9W/7b4WA5QPGiwAnjIwWk0Y/qGRSkb
1tOHf+wdQIZ6lD8/DC6TTYm/pynP7K2cNPYxIbBKquDhPKA5FVjj1B1z8I8A4SAI
k1xvOFWdt+FyjjWXle1M/9VMTtSc9W4XWZVC3TCjMBrFhxpNnUY8vDFiMF0bLG8D
HVm6xJ+uExdogl4MlwWNdScMoVoMNvONw05+jKFSPzHCB/zUdW6IJuAoFTWg7b06
Pt+m8HSScWU7TT5CdKKQ
=drNw
-----END PGP SIGNATURE-----

--nN4R54GNd7uuI0WbpRbnt9mjSbPReidAw--
