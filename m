From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 10 Mar 2015 12:38:23 +0000
Subject: Re: [PATCH 2/3 v3] hyperv: hyperv_fb.c: match wait_for_completion_timeout return type
Message-Id: <54FEE5BF.2010602@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="vk8qmrgQxi45D4t44SxlQnciNouSjpsHe"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1422527056-24929-1-git-send-email-der.herr@hofr.at>
In-Reply-To: <1422527056-24929-1-git-send-email-der.herr@hofr.at>
To: Nicholas Mc Guire <der.herr@hofr.at>, "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, devel@linuxdriverproject.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

--vk8qmrgQxi45D4t44SxlQnciNouSjpsHe
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 29/01/15 12:24, Nicholas Mc Guire wrote:
> The return type of wait_for_completion_timeout is unsigned long not
> int. This patch fixes up the declarations only.
>=20
> Signed-off-by: Nicholas Mc Guire <der.herr@hofr.at>
> ---
>=20
> v2: fixed subject line
> v3: fixed patch description as recommended by Dan Carpenter
>     <dan.carpenter@oracle.com>
>=20
> Patch was compile tested only for x86_64_defconfig + CONFIG_X86_VSMP=3D=
y
> CONFIG_HYPERV=3Dm, CONFIG_FB_HYPERV=3Dm
>=20
> Patch is against 3.19.0-rc5 -next-20150123
>=20
>  drivers/video/fbdev/hyperv_fb.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hype=
rv_fb.c
> index 4254336..807ee22 100644
> --- a/drivers/video/fbdev/hyperv_fb.c
> +++ b/drivers/video/fbdev/hyperv_fb.c
> @@ -415,7 +415,8 @@ static int synthvid_negotiate_ver(struct hv_device =
*hdev, u32 ver)
>  	struct fb_info *info =3D hv_get_drvdata(hdev);
>  	struct hvfb_par *par =3D info->par;
>  	struct synthvid_msg *msg =3D (struct synthvid_msg *)par->init_buf;
> -	int t, ret =3D 0;
> +	int ret =3D 0;
> +	unsigned long t;
> =20
>  	memset(msg, 0, sizeof(struct synthvid_msg));
>  	msg->vid_hdr.type =3D SYNTHVID_VERSION_REQUEST;
> @@ -488,7 +489,8 @@ static int synthvid_send_config(struct hv_device *h=
dev)
>  	struct fb_info *info =3D hv_get_drvdata(hdev);
>  	struct hvfb_par *par =3D info->par;
>  	struct synthvid_msg *msg =3D (struct synthvid_msg *)par->init_buf;
> -	int t, ret =3D 0;
> +	int ret =3D 0;
> +	unsigned long t;
> =20
>  	/* Send VRAM location */
>  	memset(msg, 0, sizeof(struct synthvid_msg));
>=20

Thanks, queued for 4.1.

 Tomi



--vk8qmrgQxi45D4t44SxlQnciNouSjpsHe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU/uW/AAoJEPo9qoy8lh71Ky4QAK7gyGlXp9hN5YQtBRt5+aXO
CtQv1WfxNb0jqkHWjnvtUv2m6vtH6lnjHgSP1qqKTelTHjrI/6dbV/tCZqjgIh/d
MjOQGZiGzkjgy8ncQdC43geZPgw+h7roySPRjr4e/zpFd+9lIYaHPlO6JgyniNd8
hf7gCpiolXMINjIedk8ror7rRAMnY1DmzD3qwYrXWXLY7fsBMFePe/p8UWbWlmqs
1axWf/PVquP41DyPnKaa5A17JqYyPzqViHs15X2W+HUHm5P+SP9kgIp84OtJgpNY
5A7W2OLd+gkh5Z8zmZn5Vhnmtlw9RRKbhF0ec6/3hSPrb7twq54EXk6tfK8lqd7v
yK3Zjem+9QY9fjh+a4vSx6eq6y404/w5xyWb1efZ14VcO9tlCPNis2KxNKSmOTyL
AEG1oAZyE1W5CO8rl+BZZ7W4Z7Aj8tmhVUH1lgJFcIOQ8fpj3M8mJ2GnV8Qdn+Ah
yAjEC4ZdUbyJx7YcG4wq5BulB056bkC9y7Gov1PnZDnC4po9cAAb9KYjJAkCk47X
CxCiYRYavXooa9ew0nKHfJ5hiCze10GU2CiYjuhHETtGWK+QukMCbETtk2yRz9Mb
sceIVymR5u+04D4Ltlth4wCvYbnQHtoJQDp9lJ+Nv0ADPGYuguuLG4J3VPFv+eaL
2zf64bPW0obMUkDsjzLf
=LbbE
-----END PGP SIGNATURE-----

--vk8qmrgQxi45D4t44SxlQnciNouSjpsHe--
