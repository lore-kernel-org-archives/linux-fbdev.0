From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 05 May 2017 22:24:09 +0000
Subject: Re: [PATCH v2] backlight: report error on failure
Message-Id: <CAHp75Vf-Gd-+Jtoj-bVh+6a-2cLeDuuDLva98VU-E3dFMdjMfA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1494019985-5417-1-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1494019985-5417-1-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-fbdev@vger.kernel.org

On Sat, May 6, 2017 at 12:33 AM, Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
> It is possible to update the backlight power and the brightness using
> the sysfs and on writing it either returns the count or if the callback
> function does not exist then returns the error code 'ENXIO'.
>
> We have a situation where the userspace client is writing to the sysfs
> to update the power and since the callback function exists the client
> receives the return value as count and considers the operation to be
> successful. That is correct as the write to the sysfs was successful.
> But there is no way to know if the actual operation was done or not.
>
> backlight_update_status() returns the error code if it fails. Pass that
> to the userspace client who is trying to update the power so that the
> client knows that the operation failed.
>
> This is not a change of ABI as the userspace expects an error of ENXIO,
> after this patch the range of errors that are returned to the userspace
> will increase.

One nit.

> @@ -143,12 +143,16 @@ static ssize_t bl_power_store(struct device *dev, struct device_attribute *attr,
>         rc = -ENXIO;
>         mutex_lock(&bd->ops_lock);
>         if (bd->ops) {

> +               rc = 0;

You may remove this...

>                 pr_debug("set power to %lu\n", power);
>                 if (bd->props.power != power) {
> +                       old_power = bd->props.power;
>                         bd->props.power = power;
> -                       backlight_update_status(bd);
> +                       rc = backlight_update_status(bd);
> +                       if (rc)
> +                               bd->props.power = old_power;

>                 }
> -               rc = count;
> +               rc = rc ? rc : count;

... and replace this by
} else
 rc = count;

-- 
With Best Regards,
Andy Shevchenko
