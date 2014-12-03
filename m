From: Bryan Wu <cooloney@gmail.com>
Date: Wed, 03 Dec 2014 01:49:39 +0000
Subject: Re: [PATCH v2 1/2] backlight/lp855x: Refactor dt parsing code
Message-Id: <CAK5ve-JjSKcuZ4gWC4vU4U6YyF5cU+MGn+EjUU0PYbF-wWFDSQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1417570752-23633-1-git-send-email-seanpaul@chromium.org>
In-Reply-To: <1417570752-23633-1-git-send-email-seanpaul-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Sean Paul <seanpaul-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: =?UTF-8?B?6rmA7Jqw6rK4?= <milo.kim-l0cyMroinI0@public.gmane.org>, FBDEV list <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>

On Tue, Dec 2, 2014 at 5:39 PM, Sean Paul <seanpaul@chromium.org> wrote:
> This patch refactors the dt parsing code to avoid setting platform_data,
> instead just setting lp->pdata directly. This facilitates easier
> probe deferral since the current scheme would require us to clear out
> dev->platform_data before deferring.
>

Looks good to me,
Acked-by: Bryan Wu <cooloney@gmail.com>

Please also wait for Milo to ack. Lee, can you take this patch?

Thanks,
-Bryan

> Cc: St=C3=A9phane Marchesin <marcheu@chromium.org>
> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> ---
>  drivers/video/backlight/lp855x_bl.c | 37 ++++++++++++++++++-------------=
------
>  1 file changed, 18 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/video/backlight/lp855x_bl.c b/drivers/video/backligh=
t/lp855x_bl.c
> index 25fb8e3..257b3ba 100644
> --- a/drivers/video/backlight/lp855x_bl.c
> +++ b/drivers/video/backlight/lp855x_bl.c
> @@ -341,8 +341,10 @@ static const struct attribute_group lp855x_attr_grou=
p =3D {
>  };
>
>  #ifdef CONFIG_OF
> -static int lp855x_parse_dt(struct device *dev, struct device_node *node)
> +static int lp855x_parse_dt(struct lp855x *lp)
>  {
> +       struct device *dev =3D lp->dev;
> +       struct device_node *node =3D dev->of_node;
>         struct lp855x_platform_data *pdata;
>         int rom_length;
>
> @@ -381,12 +383,12 @@ static int lp855x_parse_dt(struct device *dev, stru=
ct device_node *node)
>                 pdata->rom_data =3D &rom[0];
>         }
>
> -       dev->platform_data =3D pdata;
> +       lp->pdata =3D pdata;
>
>         return 0;
>  }
>  #else
> -static int lp855x_parse_dt(struct device *dev, struct device_node *node)
> +static int lp855x_parse_dt(struct lp855x *lp)
>  {
>         return -EINVAL;
>  }
> @@ -395,18 +397,8 @@ static int lp855x_parse_dt(struct device *dev, struc=
t device_node *node)
>  static int lp855x_probe(struct i2c_client *cl, const struct i2c_device_i=
d *id)
>  {
>         struct lp855x *lp;
> -       struct lp855x_platform_data *pdata =3D dev_get_platdata(&cl->dev);
> -       struct device_node *node =3D cl->dev.of_node;
>         int ret;
>
> -       if (!pdata) {
> -               ret =3D lp855x_parse_dt(&cl->dev, node);
> -               if (ret < 0)
> -                       return ret;
> -
> -               pdata =3D dev_get_platdata(&cl->dev);
> -       }
> -
>         if (!i2c_check_functionality(cl->adapter, I2C_FUNC_SMBUS_I2C_BLOC=
K))
>                 return -EIO;
>
> @@ -414,16 +406,23 @@ static int lp855x_probe(struct i2c_client *cl, cons=
t struct i2c_device_id *id)
>         if (!lp)
>                 return -ENOMEM;
>
> -       if (pdata->period_ns > 0)
> -               lp->mode =3D PWM_BASED;
> -       else
> -               lp->mode =3D REGISTER_BASED;
> -
>         lp->client =3D cl;
>         lp->dev =3D &cl->dev;
> -       lp->pdata =3D pdata;
>         lp->chipname =3D id->name;
>         lp->chip_id =3D id->driver_data;
> +       lp->pdata =3D dev_get_platdata(&cl->dev);
> +
> +       if (!lp->pdata) {
> +               ret =3D lp855x_parse_dt(lp);
> +               if (ret < 0)
> +                       return ret;
> +       }
> +
> +       if (lp->pdata->period_ns > 0)
> +               lp->mode =3D PWM_BASED;
> +       else
> +               lp->mode =3D REGISTER_BASED;
> +
>         i2c_set_clientdata(cl, lp);
>
>         ret =3D lp855x_configure(lp);
> --
> 2.1.1
>
