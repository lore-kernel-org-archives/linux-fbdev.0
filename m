From: "devendra.aaru" <devendra.aaru@gmail.com>
Date: Thu, 03 Jan 2013 05:22:41 +0000
Subject: Re: backlight_register_device can oops if name is null ?
Message-Id: <CAHdPZaMubzyBXWb83qB9_CuFFqQprB4d+2XhzOoQeoN6fruRMg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAHdPZaMKfMA=Z6n-X+3NMR-CScfwQmKYuyoJHBeK2bYFn8EEdg@mail.gmail.com>
In-Reply-To: <CAHdPZaMKfMA=Z6n-X+3NMR-CScfwQmKYuyoJHBeK2bYFn8EEdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

>>>
>> so if i understand the code pr_debug code, i see a printk macro assignment,
>>
>> is it something like printk or a wrapper macro around printk are
>> making sure that the strings are non null ?
>
> Sorry, I don't know how printk deals this null.
>
> But I tested null by using ams369fg06 driver as below:
>
> -       bd = backlight_device_register("ams369fg06-bl", &spi->dev, lcd,
> +       bd = backlight_device_register(NULL, &spi->dev, lcd,
>
> Also, I replaced pr_debug with printk as below:
>
> -       pr_debug("backlight_device_register: name=%s\n", name);
> +       printk("backlight_device_register: name=%s\n", name);
>
> In this case, printk message is as below:
>
> backlight_device_register: name=(null)
>
>>

wow, you tested the code, i would have done it with a single module,
great and thanks for lot of information you are putting .

>> the documentation of the backlight_device_register says that "name
>> must be same as the name of the respected frame buffer device", but do
>> we really add a check for the null to do dev_set_name? or fail the
>> registering ?
>
> "name must be same as the name of the respected frame buffer device" is
> not correct. Most backlight drivers are using their driver name as 'name'.
>
> Anyway, in my opinion, deference to null does not seem to happen.
> Now, backlight_device_register() calls are using 'name' properly.
>
>
> However, if a check for the null is added, it will be added to
> backlight_device_register() as below:
>
>
> @@ -292,6 +292,11 @@ struct backlight_device *backlight_device_register(const char *name,
>         struct backlight_device *new_bd;
>         int rc;
>
> +       if (name = NULL) {
> +               pr_err(".....");
> +               return -EINVAL
> +       }
> +

This is what exactly i was thinking, thanks for making a patch too.

If you want to submit it then please take my

Acked-By: Devendra Naga <devendra.aaru@gmail.com>
