From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Date: Tue, 12 May 2015 20:40:12 +0000
Subject: Re: [PATCH v2 04/17] input: locomokbd: provide an Alt-SysRQ combination
Message-Id: <CALT56yO+fiPfm6hhx+E3dAyrE1G8SSdcX3VpXXqW4=UuTh-4qA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1430178954-11138-1-git-send-email-dbaryshkov@gmail.com>
	<1430178954-11138-5-git-send-email-dbaryshkov@gmail.com>
	<20150512201215.GD20725@dtor-ws>
In-Reply-To: <20150512201215.GD20725@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>, Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andrea Adami <andrea.adami-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-leds <linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

2015-05-12 23:12 GMT+03:00 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> Hi Dmitry,
>
> On Tue, Apr 28, 2015 at 02:55:41AM +0300, Dmitry Eremin-Solenikov wrote:
>> It is usefull sometimes to have an Alt-SysRQ combo on the keyboard to be
>> able to trigger sysrq functions directly. Add an option providing sysrq
>> mapping for Contact-Home keys.
>
> No, if you want to remap the keys please do it from usepspace; locomokbd
> supports it (EVIOCSKEYCODE ioctl).

OK, this was useful to boot kernels with minimal to no userspace (tiny
initramfs)
and still have the SysRQ at hand. I'll keep this as a local/OE patch instead.

-- 
With best wishes
Dmitry
