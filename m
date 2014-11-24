From: Lee Jones <lee.jones@linaro.org>
Date: Mon, 24 Nov 2014 10:10:06 +0000
Subject: Re: [PATCH 1/1] backlight: lp8788: Deletion of an unnecessary check before the function call "backli
Message-Id: <20141124101006.GD4241@x1>
List-Id: <linux-fbdev.vger.kernel.org>
References: <530C5E18.1020800@users.sourceforge.net>
 <alpine.DEB.2.10.1402251014170.2080@hadrien>
 <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net>
 <54720DEB.4060109@users.sourceforge.net>
In-Reply-To: <54720DEB.4060109@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: Bryan Wu <cooloney@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Jingoo Han <jg1.han@samsung.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>

On Sun, 23 Nov 2014, SF Markus Elfring wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 23 Nov 2014 17:33:08 +0100
>=20
> The backlight_device_unregister() function tests whether its argument is =
NULL
> and then returns immediately. Thus the test around the call is not needed.

Also the $SUBJECT should be less than 75 chars.

> This issue was detected by using the Coccinelle software.
>=20
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/video/backlight/lp8788_bl.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/video/backlight/lp8788_bl.c b/drivers/video/backligh=
t/lp8788_bl.c
> index d6c4f6a..24a055c 100644
> --- a/drivers/video/backlight/lp8788_bl.c
> +++ b/drivers/video/backlight/lp8788_bl.c
> @@ -221,8 +221,7 @@ static void lp8788_backlight_unregister(struct lp8788=
_bl *bl)
>  {
>  	struct backlight_device *bl_dev =3D bl->bl_dev;
> =20
> -	if (bl_dev)
> -		backlight_device_unregister(bl_dev);
> +	backlight_device_unregister(bl_dev);
>  }
> =20
>  static ssize_t lp8788_get_bl_ctl_mode(struct device *dev,

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
