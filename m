From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 13 May 2016 12:15:14 +0000
Subject: Re: [PATCH] fbdev: Use IS_ENABLED() instead of checking for built-in or module
Message-Id: <5735C552.1000508@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="FBP8d8TtbnGdIeKX8n7k4DqaqKFrsdwMO"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1462982363-25389-1-git-send-email-javier@osg.samsung.com>
In-Reply-To: <1462982363-25389-1-git-send-email-javier@osg.samsung.com>
To: Javier Martinez Canillas <javier@osg.samsung.com>, linux-kernel@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>

--FBP8d8TtbnGdIeKX8n7k4DqaqKFrsdwMO
Content-Type: multipart/mixed; boundary="b34skKotuOrwcrfqRqem3kcf7RkTeXdiD"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Javier Martinez Canillas <javier@osg.samsung.com>,
 linux-kernel@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org,
 Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
 Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Message-ID: <5735C552.1000508@ti.com>
Subject: Re: [PATCH] fbdev: Use IS_ENABLED() instead of checking for built-in
 or module
References: <1462982363-25389-1-git-send-email-javier@osg.samsung.com>
In-Reply-To: <1462982363-25389-1-git-send-email-javier@osg.samsung.com>

--b34skKotuOrwcrfqRqem3kcf7RkTeXdiD
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/05/16 18:59, Javier Martinez Canillas wrote:
> The IS_ENABLED() macro checks if a Kconfig symbol has been enabled eith=
er
> built-in or as a module, use that macro instead of open coding the same=
=2E
>=20
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> ---
>=20
>  drivers/video/fbdev/via/accel.c    | 2 +-
>  drivers/video/fbdev/via/via-core.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/via/accel.c b/drivers/video/fbdev/via/=
accel.c
> index 4b67b8e6030a..eb3615c69987 100644
> --- a/drivers/video/fbdev/via/accel.c
> +++ b/drivers/video/fbdev/via/accel.c
> @@ -358,7 +358,7 @@ int viafb_setup_engine(struct fb_info *info)
>  	viapar->shared->vq_vram_addr =3D viapar->fbmem_free;
>  	viapar->fbmem_used +=3D VQ_SIZE;
> =20
> -#if defined(CONFIG_VIDEO_VIA_CAMERA) || defined(CONFIG_VIDEO_VIA_CAMER=
A_MODULE)
> +#if IS_ENABLED(CONFIG_VIDEO_VIA_CAMERA)
>  	/*
>  	 * Set aside a chunk of framebuffer memory for the camera
>  	 * driver.  Someday this driver probably needs a proper allocator
> diff --git a/drivers/video/fbdev/via/via-core.c b/drivers/video/fbdev/v=
ia/via-core.c
> index 6e274825fb31..1d28e16888e9 100644
> --- a/drivers/video/fbdev/via/via-core.c
> +++ b/drivers/video/fbdev/via/via-core.c
> @@ -116,7 +116,7 @@ EXPORT_SYMBOL_GPL(viafb_irq_disable);
>   * most viafb systems will not need to have this extra code for a whil=
e.
>   * As soon as another user comes long, the ifdef can be removed.
>   */
> -#if defined(CONFIG_VIDEO_VIA_CAMERA) || defined(CONFIG_VIDEO_VIA_CAMER=
A_MODULE)
> +#if IS_ENABLED(CONFIG_VIDEO_VIA_CAMERA)
>  /*
>   * Access to the DMA engine.  This currently provides what the camera
>   * driver needs (i.e. outgoing only) but is easily expandable if need
> @@ -542,7 +542,7 @@ static struct viafb_subdev_info {
>  	{
>  		.name =3D "viafb-i2c",
>  	},
> -#if defined(CONFIG_VIDEO_VIA_CAMERA) || defined(CONFIG_VIDEO_VIA_CAMER=
A_MODULE)
> +#if IS_ENABLED(CONFIG_VIDEO_VIA_CAMERA)
>  	{
>  		.name =3D "viafb-camera",
>  	},
>=20

Thanks, queued for 4.7.

 Tomi


--b34skKotuOrwcrfqRqem3kcf7RkTeXdiD--

--FBP8d8TtbnGdIeKX8n7k4DqaqKFrsdwMO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXNcVSAAoJEPo9qoy8lh71jSgQAItfCfyy0U12R+jPXeGXHhPl
Rrw3olbJWalaQ4HB245GK80z2aOMOH9sgiKo0mh0wjWtf0Dcr2zWEy1CjVngXZCN
G/SHG5EFH4DuMuEwi977vDI6sEU4seMPVo8FzG5ePVNHS79+vIGEHQ1vF+PVN5f7
Rb1Kh1HWyW8s4pfh1iZo3rCIhAETWd47mNOyAlXTG5xBFkl7WU8bqqA41lo855Lf
Ds5j7s7QneHLYHGxd5PezNK1wsaY2gxQbLw2vifKOrqKlLSUS29gqDzNUa4lZcvW
q4F5YqMhSXukWDML0UoHQz4p75upjzmXQHrmfjJQzkokwkOCz1KfU9LLT/WOXoJ7
KzizimCX617KL1zw1kjuIgwb6WBWGuPlj2txJTdZEkSceQBE/lwWHDmTCCX4UET0
Z0IqoU5HxH3wS322eZnn0Xp8AA8F7GaxymR5GowbgmWvgYGmWCC14/2q81C+cN/b
wD7e+IvjsK7Rn3T6tGd9HOB0UYzvZo9A6oThnBvNhVuvW2wyf7pPlFNuKXGOKkQO
uvQGid1rHUClU3xilfcOzY0ZDNYn4uM0iIVV+Mv+SL1wTbuemWd3atyprA8TMaN+
kzhQlOQRR34JnKq4lRzRzYoWJUlJT4f0XdJ3PbwDHlNbKF65KVEUhC/9lI3kgeQZ
OvbWQzygutXfnEMuI+/J
=419Y
-----END PGP SIGNATURE-----

--FBP8d8TtbnGdIeKX8n7k4DqaqKFrsdwMO--
