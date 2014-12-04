From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 04 Dec 2014 15:41:30 +0000
Subject: Re: [PATCH 2/3] video: fbdev: Check Standard Timing against DMT
Message-Id: <548080AA.6050705@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="w8A5LpLBGRJhmduLSX8Mrn5ip5ViDsV3B"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1417643369-20603-2-git-send-email-davidu@nvidia.com>
In-Reply-To: <1417643369-20603-2-git-send-email-davidu@nvidia.com>
To: linux-fbdev@vger.kernel.org

--w8A5LpLBGRJhmduLSX8Mrn5ip5ViDsV3B
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 03/12/14 23:49, David Ung wrote:
> Add the VESA Display Monitor Timing (DMT) table.
> During parsing of Standard Timings, it compare the 2 byte STD code
> with DMT to see what the VESA mode should be.  If there is no entry
> in the vesa_modes table or no match found, it fallsback to the
> GTF timings.
>=20
> Signed-off-by: David Ung <davidu@nvidia.com>
> ---
>  drivers/video/fbdev/core/fbmon.c  | 20 ++++++----
>  drivers/video/fbdev/core/modedb.c | 84 +++++++++++++++++++++++++++++++=
++++++++
>  include/linux/fb.h                | 10 +++++
>  3 files changed, 107 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/core/fbmon.c b/drivers/video/fbdev/cor=
e/fbmon.c
> index 5b0e313..aa1110a 100644
> --- a/drivers/video/fbdev/core/fbmon.c
> +++ b/drivers/video/fbdev/core/fbmon.c
> @@ -526,16 +526,22 @@ static int get_std_timing(unsigned char *block, s=
truct fb_videomode *mode,
>  	refresh =3D (block[1] & 0x3f) + 60;
> =20
>  	DPRINTK("      %dx%d@%dHz\n", xres, yres, refresh);
> -	for (i =3D 0; i < VESA_MODEDB_SIZE; i++) {
> -		if (vesa_modes[i].xres =3D=3D xres &&
> -		    vesa_modes[i].yres =3D=3D yres &&
> -		    vesa_modes[i].refresh =3D=3D refresh) {
> -			*mode =3D vesa_modes[i];
> +	for (i =3D 0; i < DMT_SIZE; i++) {
> +		u32 std_2byte_code =3D block[0] << 8 | block[1];
> +
> +		if (std_2byte_code =3D=3D dmt_modes[i].std_2byte_code) {
> +			if (!dmt_modes[i].mode)
> +				break;
> +			*mode =3D *dmt_modes[i].mode;
>  			mode->flag |=3D FB_MODE_IS_STANDARD;
> -			return 1;
> +			DPRINTK("        DMT id=3D%d\n", dmt_modes[i].dmt_id);
> +			break;
>  		}
>  	}
> -	calc_mode_timings(xres, yres, refresh, mode);
> +
> +	if (i =3D=3D DMT_SIZE || !dmt_modes[i].mode)
> +		calc_mode_timings(xres, yres, refresh, mode);
> +
>  	return 1;
>  }
> =20
> diff --git a/drivers/video/fbdev/core/modedb.c b/drivers/video/fbdev/co=
re/modedb.c
> index 0b57c1df..858a97e 100644
> --- a/drivers/video/fbdev/core/modedb.c
> +++ b/drivers/video/fbdev/core/modedb.c
> @@ -497,6 +497,90 @@ const struct fb_videomode vesa_modes[] =3D {
>  	  FB_SYNC_HOR_HIGH_ACT, FB_VMODE_NONINTERLACED, FB_MODE_IS_VESA },
>  };
>  EXPORT_SYMBOL(vesa_modes);
> +
> +const struct dmt_videomode dmt_modes[DMT_SIZE] =3D {
> +	{ 0x01, 0x0000, 0x000000, &vesa_modes[0] },
> +	{ 0x02, 0x3119, 0x000000, &vesa_modes[1] },
> +	{ 0x03, 0x0000, 0x000000, &vesa_modes[2] },
> +	{ 0x04, 0x3140, 0x000000, &vesa_modes[3] },
> +	{ 0x05, 0x314c, 0x000000, &vesa_modes[4] },
> +	{ 0x06, 0x314f, 0x000000, &vesa_modes[5] },
> +	{ 0x07, 0x3159, 0x000000, &vesa_modes[6] },
> +	{ 0x08, 0x0000, 0x000000, &vesa_modes[7] },
> +	{ 0x09, 0x4540, 0x000000, &vesa_modes[8] },
> +	{ 0x0a, 0x454c, 0x000000, &vesa_modes[9] },
> +	{ 0x0b, 0x454f, 0x000000, &vesa_modes[10] },
> +	{ 0x0c, 0x4559, 0x000000, &vesa_modes[11] },
> +	{ 0x0d, 0x0000, 0x000000, 0 },
> +	{ 0x0e, 0x0000, 0x000000, 0 },

You've filled only some of the modes in this table. What's the logic
which modes are left out?

 Tomi



--w8A5LpLBGRJhmduLSX8Mrn5ip5ViDsV3B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUgICqAAoJEPo9qoy8lh71zd8P/286tJk9sYpMNaPfO0UldliK
wGdUBOBj1D8AcEKuUskIgCGY0N7fBNy3eycuirokoeoVV0sSIx+0qL4du5yGU+ES
z2ooyBvi3VHYk/eAxsIPw1Io2cAYsQRfnHujxHa1LqInauHs6r6zxCu85ckCmYGq
iG8g6x65t9aM/6SNvl1ZkFnHc+dBDcvyCyj5SBluNujPkis+2mBUpchb1Jg/ciwp
ez4EJmFdQctX8gVm4yGQETX8NAY/Cbxy8dLF34d8QTSRZkef7Cy8f/u5QKohf0B+
58rI7oy1WqbkQHj4Fv8gO2MTO+RMzJVd9yF9fhiZLpBiwxhiiDCuVxESP/zz1RJr
NfjW66HIUlrdCVyyF/HMlEyQ0/yGIcbUCsflpFG26ZR0DYqHkp9x3xfuOJaHNeWg
JbwPthWSaM2HCw52Yh/vgFOoLwUCRo5GMsu+zpbKO2L3wktv7tlG4whmKkaEqDqi
qkNXMBDj5Tqy3ZwJ7hwXjopz/3SlQEAQjTsB8A5eJ2EpututH251xxknQnQ50pRk
Y0gUiiRHB9ORKp6wUaY8PRZiCp036+SDqrZcMUKmxe5+yMp3A+LaFEUN4ytK+cGn
TKNDQ+cslyfgmMAUA07cTmavkHHUNCxJpbQO6iXWqX0C3kSzrxU4cHMqikOGoUc2
/maegBOF+27I8QCGK/3E
=CC0q
-----END PGP SIGNATURE-----

--w8A5LpLBGRJhmduLSX8Mrn5ip5ViDsV3B--
