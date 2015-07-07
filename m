From: Lee Jones <lee.jones@linaro.org>
Date: Tue, 07 Jul 2015 07:13:03 +0000
Subject: Re: [PATCH v3] video-lp8788: Delete a check before backlight_device_unregister()
Message-Id: <20150707071303.GL3182@x1>
List-Id: <linux-fbdev.vger.kernel.org>
References: <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net>
 <54720DEB.4060109@users.sourceforge.net>
 <20141124101006.GD4241@x1>
 <5473736F.8070705@users.sourceforge.net>
 <558FE386.7060704@users.sourceforge.net>
 <20150701080612.GG3210@x1>
 <5593C14A.8020700@users.sourceforge.net>
In-Reply-To: <5593C14A.8020700@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: Jingoo Han <jingoohan1@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>

On Wed, 01 Jul 2015, SF Markus Elfring wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 1 Jul 2015 12:08:31 +0200
>=20
> The backlight_device_unregister() function tests whether its argument
> is NULL and then returns immediately.
> Thus the test around the call is not needed.
>=20
> This issue was detected by using the Coccinelle software.
>=20
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/video/backlight/lp8788_bl.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied, thanks.

> diff --git a/drivers/video/backlight/lp8788_bl.c b/drivers/video/backligh=
t/lp8788_bl.c
> index e418d5b..5d583d7 100644
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
