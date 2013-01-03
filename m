From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 03 Jan 2013 02:31:35 +0000
Subject: Re: backlight_register_device can oops if name is null ?
Message-Id: <008401cde95a$733d7b70$59b87250$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAHdPZaMKfMA=Z6n-X+3NMR-CScfwQmKYuyoJHBeK2bYFn8EEdg@mail.gmail.com>
In-Reply-To: <CAHdPZaMKfMA=Z6n-X+3NMR-CScfwQmKYuyoJHBeK2bYFn8EEdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Thursday, January 03, 2013 1:41 AM, Devendra Naga wrote"
> On Tue, Jan 1, 2013 at 7:44 PM, Jingoo Han <jg1.han@samsung.com> wrote:
> > On Tuesday, January 01, 2013 6:05 AM, Devendra Naga wrote
> >> Hello,
> >>
> >> while reading through the backlight_register_device function, there
> >
> > backlight_register_device -> backlight_device_register
> >
> 
> i am sorry i would have really written correctly,
> 
> >> seems to be a problem if the new object name is null, the pr_debug
> >> print goes and dereferences a null pointer causing an oops,
> >>
> >> the print should be removed or the check must be placed to ensure that
> >> name is not null,
> >
> > Hi,
> >
> > If name is null in backlight_device_register(),
> > pr_debug() will work properly and won't cause an oops.
> >
> 
> so if i understand the code pr_debug code, i see a printk macro assignment,
> 
> is it something like printk or a wrapper macro around printk are
> making sure that the strings are non null ?

Sorry, I don't know how printk deals this null.

But I tested null by using ams369fg06 driver as below:

-	bd = backlight_device_register("ams369fg06-bl", &spi->dev, lcd,
+	bd = backlight_device_register(NULL, &spi->dev, lcd,

Also, I replaced pr_debug with printk as below:

-	pr_debug("backlight_device_register: name=%s\n", name);
+	printk("backlight_device_register: name=%s\n", name);

In this case, printk message is as below:

backlight_device_register: name=(null)

> 
> i am sorry to ask this as i dont have proper tags in vim ubuntu, its
> not allowing me to a tag list when i do in fedora :(,
> 
> > However, dev_set_name() will cause oops, instead of pr_debug().
> > In this case, NULL check would be better.
> >
> 
> the documentation of the backlight_device_register says that "name
> must be same as the name of the respected frame buffer device", but do
> we really add a check for the null to do dev_set_name? or fail the
> registering ?

"name must be same as the name of the respected frame buffer device" is
not correct. Most backlight drivers are using their driver name as 'name'.

Anyway, in my opinion, deference to null does not seem to happen.
Now, backlight_device_register() calls are using 'name' properly. 


However, if a check for the null is added, it will be added to
backlight_device_register() as below:


@@ -292,6 +292,11 @@ struct backlight_device *backlight_device_register(const char *name,
        struct backlight_device *new_bd;
        int rc;

+       if (name = NULL) {
+               pr_err(".....");
+               return -EINVAL
+       }
+

> 
> >
> > Best regards,
> > Jingoo Han
> >
> >>
> >> any ideas?
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >

