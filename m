From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Date: Wed, 31 Jul 2013 03:28:10 +0000
Subject: Re: [PATCH] fbdev: fix build warning in vga16fb.c
Message-Id: <51F8844A.7080407@cn.fujitsu.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <51F8829E.4080605@huawei.com>
In-Reply-To: <51F8829E.4080605@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Xishi Qiu <qiuxishi@huawei.com>
Cc: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Hoho, Tomi has applied the patch from Lius to fix this warning.
And this is the sixth patch to fix the same issue since last week.

Thanks,
Gu


On 07/31/2013 11:21 AM, Xishi Qiu wrote:

> When building v3.11-rc3, I get the following warning:
> ...
> drivers/video/vga16fb.c: In function =91vga16fb_destroy=92:
> drivers/video/vga16fb.c:1268: warning: unused variable =91dev=92
> ...
>=20
> Signed-off-by: Xishi Qiu <qiuxishi@huawei.com>
> ---
>  drivers/video/vga16fb.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/video/vga16fb.c b/drivers/video/vga16fb.c
> index 830ded4..2827333 100644
> --- a/drivers/video/vga16fb.c
> +++ b/drivers/video/vga16fb.c
> @@ -1265,7 +1265,6 @@ static void vga16fb_imageblit(struct fb_info *info,=
 const struct fb_image *image
> =20
>  static void vga16fb_destroy(struct fb_info *info)
>  {
> -	struct platform_device *dev =3D container_of(info->device, struct platf=
orm_device, dev);
>  	iounmap(info->screen_base);
>  	fb_dealloc_cmap(&info->cmap);
>  	/* XXX unshare VGA regions */


