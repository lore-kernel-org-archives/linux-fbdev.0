From: Jingoo Han <jg1.han@samsung.com>
Date: Wed, 02 Jan 2013 00:44:39 +0000
Subject: Re: backlight_register_device can oops if name is null ?
Message-Id: <005301cde882$590d0370$0b270a50$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAHdPZaMKfMA=Z6n-X+3NMR-CScfwQmKYuyoJHBeK2bYFn8EEdg@mail.gmail.com>
In-Reply-To: <CAHdPZaMKfMA=Z6n-X+3NMR-CScfwQmKYuyoJHBeK2bYFn8EEdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Tuesday, January 01, 2013 6:05 AM, Devendra Naga wrote
> Hello,
> 
> while reading through the backlight_register_device function, there

backlight_register_device -> backlight_device_register

> seems to be a problem if the new object name is null, the pr_debug
> print goes and dereferences a null pointer causing an oops,
> 
> the print should be removed or the check must be placed to ensure that
> name is not null,

Hi,

If name is null in backlight_device_register(),
pr_debug() will work properly and won't cause an oops.

However, dev_set_name() will cause oops, instead of pr_debug().
In this case, NULL check would be better.


Best regards,
Jingoo Han

> 
> any ideas?
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

