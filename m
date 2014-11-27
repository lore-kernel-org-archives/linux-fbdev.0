From: Sean Paul <seanpaul@chromium.org>
Date: Thu, 27 Nov 2014 12:22:08 +0000
Subject: Re: [PATCH 1/2] backlight/lp855x: Refactor dt parsing code
Message-Id: <CAOw6vbKTsOJEV28XFmFumwmr2jzAUymxSWEZOkmNh1f+q778Rw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1417029064-12460-1-git-send-email-seanpaul@chromium.org> <54767F37.3020006@ti.com>
In-Reply-To: <54767F37.3020006-l0cyMroinI0@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: "Kim, Milo" <milo.kim-l0cyMroinI0@public.gmane.org>
Cc: Sean Paul <seanpaul-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-fbdev <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org

On Wed, Nov 26, 2014 at 5:32 PM, Kim, Milo <milo.kim@ti.com> wrote:
> (Looping backlight class subsystem maintainers)
>
> Hi Sean,
>
> Thanks for checking this. I'd like to describe why the original code is
> preferred.
>
> The original code is copying the values of the lp855x platform data from =
the
> DT in advance of allocating lp855x data.
> It guarantees returning quickly in case of invalid platform data.
> In other words, no memory allocation of lp855x proceeds if parsing the DT
> gets failed.
> However, this patch allocates the lp855x first and checking the DT.
> Of course, devm_kzalloc() will free allocated memory later but original c=
ode
> does NOT try to allocate it.
> So I'd prefer to keep this way.
>

Hi Milo,
Thanks for the quick response. The reason I'm changing the existing
code is that it causes problems in the probe deferral case.

A concrete example: In my follow-on patch, I call devm_regulator_get
in the parse_dt function. Assume that something later on in probe()
returns -EPROBEDEFER. If we didn't have this patch, dev->platform_data
would continue to be set the next time probe() was called. This would
causes us to skip the parse_dt() function (because pdata is non-null
from last time) and we would have an invalid pointer to the regulator
we got the last time.

Sean



> Best regards,
> Milo
>
>
> On 11/27/2014 4:11 AM, Sean Paul wrote:
>>
>> This patch refactors the dt parsing code to avoid setting platform_data,
>> instead just setting lp->pdata directly. This facilitates easier
>> probe deferral since the current scheme would require us to clear out
>> dev->platform_data before deferring.
>>
>> Cc: St=C3=A9phane Marchesin <marcheu@chromium.org>
>> Signed-off-by: Sean Paul <seanpaul@chromium.org>
>> ---
>>   drivers/video/backlight/lp855x_bl.c | 37
>> ++++++++++++++++++-------------------
>>   1 file changed, 18 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/video/backlight/lp855x_bl.c
>> b/drivers/video/backlight/lp855x_bl.c
>> index 25fb8e3..257b3ba 100644
>> --- a/drivers/video/backlight/lp855x_bl.c
>> +++ b/drivers/video/backlight/lp855x_bl.c
>> @@ -341,8 +341,10 @@ static const struct attribute_group lp855x_attr_gro=
up
>> =3D {
>>   };
>>
>>   #ifdef CONFIG_OF
>> -static int lp855x_parse_dt(struct device *dev, struct device_node *node)
>> +static int lp855x_parse_dt(struct lp855x *lp)
>>   {
>> +       struct device *dev =3D lp->dev;
>> +       struct device_node *node =3D dev->of_node;
>>         struct lp855x_platform_data *pdata;
>>         int rom_length;
>>
>> @@ -381,12 +383,12 @@ static int lp855x_parse_dt(struct device *dev,
>> struct device_node *node)
>>                 pdata->rom_data =3D &rom[0];
>>         }
>>
>> -       dev->platform_data =3D pdata;
>> +       lp->pdata =3D pdata;
>>
>>         return 0;
>>   }
>>   #else
>> -static int lp855x_parse_dt(struct device *dev, struct device_node *node)
>> +static int lp855x_parse_dt(struct lp855x *lp)
>>   {
>>         return -EINVAL;
>>   }
>> @@ -395,18 +397,8 @@ static int lp855x_parse_dt(struct device *dev, stru=
ct
>> device_node *node)
>>   static int lp855x_probe(struct i2c_client *cl, const struct
>> i2c_device_id *id)
>>   {
>>         struct lp855x *lp;
>> -       struct lp855x_platform_data *pdata =3D dev_get_platdata(&cl->dev=
);
>> -       struct device_node *node =3D cl->dev.of_node;
>>         int ret;
>>
>> -       if (!pdata) {
>> -               ret =3D lp855x_parse_dt(&cl->dev, node);
>> -               if (ret < 0)
>> -                       return ret;
>> -
>> -               pdata =3D dev_get_platdata(&cl->dev);
>> -       }
>> -
>>         if (!i2c_check_functionality(cl->adapter,
>> I2C_FUNC_SMBUS_I2C_BLOCK))
>>                 return -EIO;
>>
>> @@ -414,16 +406,23 @@ static int lp855x_probe(struct i2c_client *cl, con=
st
>> struct i2c_device_id *id)
>>         if (!lp)
>>                 return -ENOMEM;
>>
>> -       if (pdata->period_ns > 0)
>> -               lp->mode =3D PWM_BASED;
>> -       else
>> -               lp->mode =3D REGISTER_BASED;
>> -
>>         lp->client =3D cl;
>>         lp->dev =3D &cl->dev;
>> -       lp->pdata =3D pdata;
>>         lp->chipname =3D id->name;
>>         lp->chip_id =3D id->driver_data;
>> +       lp->pdata =3D dev_get_platdata(&cl->dev);
>> +
>> +       if (!lp->pdata) {
>> +               ret =3D lp855x_parse_dt(lp);
>> +               if (ret < 0)
>> +                       return ret;
>> +       }
>> +
>> +       if (lp->pdata->period_ns > 0)
>> +               lp->mode =3D PWM_BASED;
>> +       else
>> +               lp->mode =3D REGISTER_BASED;
>> +
>>         i2c_set_clientdata(cl, lp);
>>
>>         ret =3D lp855x_configure(lp);
>>
>
