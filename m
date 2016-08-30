From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 30 Aug 2016 08:57:43 +0000
Subject: Re: [PATCH] mx3fb: Fix print format string
Message-Id: <fac6d05d-02d8-d5df-109f-f572ed15a0e5@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="SVTfK0rLcHHoahtl80T7HGttww8cpirK3"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1472267137-810445-1-git-send-email-green@linuxhacker.ru>
In-Reply-To: <1472267137-810445-1-git-send-email-green@linuxhacker.ru>
To: Oleg Drokin <green@linuxhacker.ru>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, "Luis R. Rodriguez" <mcgrof@suse.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

--SVTfK0rLcHHoahtl80T7HGttww8cpirK3
Content-Type: multipart/mixed; boundary="LC6kff9FrdRXMcxecuuk5X5hUgJJ8pP1l";
 protected-headers="v1"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Oleg Drokin <green@linuxhacker.ru>,
 Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
 "Luis R. Rodriguez" <mcgrof@suse.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <fac6d05d-02d8-d5df-109f-f572ed15a0e5@ti.com>
Subject: Re: [PATCH] mx3fb: Fix print format string
References: <1472267137-810445-1-git-send-email-green@linuxhacker.ru>
In-Reply-To: <1472267137-810445-1-git-send-email-green@linuxhacker.ru>

--LC6kff9FrdRXMcxecuuk5X5hUgJJ8pP1l
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 27/08/16 06:05, Oleg Drokin wrote:
> %ul was probably meant as %lu since the former would print
> an unsigned value and a letter l.
>=20
> But in fact the whole value we are printing in u32 anyway, so
> we don't need the format to be long. Therefore just drop the l
> altogether.
>=20
> Signed-off-by: Oleg Drokin <green@linuxhacker.ru>
> ---
> Also do we really need 1000UL specification if we
> cast to u32 anyway? Or should we drop away the cast instead?
> Are pixelclocks over 4GHz possible here?
>=20
>  drivers/video/fbdev/mx3fb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/video/fbdev/mx3fb.c b/drivers/video/fbdev/mx3fb.c
> index f91b1db..8778e01 100644
> --- a/drivers/video/fbdev/mx3fb.c
> +++ b/drivers/video/fbdev/mx3fb.c
> @@ -845,7 +845,7 @@ static int __set_par(struct fb_info *fbi, bool lock=
)
>  		if (fbi->var.sync & FB_SYNC_SHARP_MODE)
>  			mode =3D IPU_PANEL_SHARP_TFT;
> =20
> -		dev_dbg(fbi->device, "pixclock =3D %ul Hz\n",
> +		dev_dbg(fbi->device, "pixclock =3D %u Hz\n",
>  			(u32) (PICOS2KHZ(fbi->var.pixclock) * 1000UL));
> =20
>  		if (sdc_init_panel(mx3fb, mode,
>=20

Thanks, queued for 4.9.

 Tomi


--LC6kff9FrdRXMcxecuuk5X5hUgJJ8pP1l--

--SVTfK0rLcHHoahtl80T7HGttww8cpirK3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXxUqHAAoJEPo9qoy8lh71baYP/0u4igpSRLGCk4rGT2zm89Z9
15fbQc+RhTPvin2tWccJwFdYnVXKzEnBOqZ34h3gDN/bLrSsrLsd9Vlwdw2fKGb/
uRDtfm6TIBSBBkqeRwNymXGg5uYCqc+R5EjSVhdB5fmD4faMeMUnq2AIbdkaZNZF
SDf2T2VBlqdlj6anZfvu53da/IuaXP1EinoTH1CVY6qBOB5zl22sscoRW/vknNk8
dVFVGqHa151eirtOnuCejYk0HnqPSy2wPr/jfJ3f7/3Poh4PbUNgBNwYrneCFHp1
dUWGDRkASc7up8QaJeqazwJcEvY3apgPp5TH5cUybqsxFbFgykC7FX5gc70/EwHk
D/YVg+gFT1JvJaoDpMoE1WiayantVttP61tP9/MZJzYan2UdJmVIsEN1+RTpqdvO
WkJXM5+OrDzbDpZO7nnoOzcea1Ks39+O9cASM0k9mEfuST+yaOxKXSs7r+uV7K2A
5UKQtzgOM8mEFsc5/7Bc4JXh7PntT03x0Wz6Z0s6ho5rllJMovtzqMLVi9dIBj3h
Y/IQiJd6ZYb0nCX2sNQraouApnCIslgqLwIzwNuj2ScX3F7Ny4y8du9EfTDEnopf
VwLODTugztbuGqgPP0ZYvX/VFYLiV313A8UBQdtBRFCQ2HPMiw7vQTvpiVJH7cTe
nd1HXlTeDrTcZ2RWaUcE
=zJU9
-----END PGP SIGNATURE-----

--SVTfK0rLcHHoahtl80T7HGttww8cpirK3--
