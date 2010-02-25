From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Date: Thu, 25 Feb 2010 22:32:50 +0000
Subject: Re: [PATCH] Add sysfs support for fbdefio delay
Message-Id: <20100225233250.241e7d6d@neptune.home>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201002252215.o1PMFnoP011425@mustang.cs.nmsu.edu>
In-Reply-To: <201002252215.o1PMFnoP011425@mustang.cs.nmsu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Rick L. Vinyard Jr." <rvinyard@cs.nmsu.edu>
Cc: linux-kernel@vger.kernel.org, npavel@ituner.com, tomi.valkeinen@nokia.com, tony@atomide.com, FlorianSchandinat@gmx.de, krzysztof.h1@wp.pl, akpm@linux-foundation.org, linux-fbdev@vger.kernel.org, jkosina@suse.cz

On Thu, 25 February 2010 "Rick L. Vinyard Jr." <rvinyard@cs.nmsu.edu> wrote:
> This patch adds support for examining and modifying the fbdefio delay
> parameter through sysfs. It also adds two driver definable minimum
> and maximum bounds.
> 
> The default behavior is to not permit modifications if delay_max is 0,
> thus preventing modification of the delay if the driver does not
> explicitly permit modification.
> 

...

> @@ -503,6 +584,12 @@ static struct device_attribute device_attrs[] = {
>  #ifdef CONFIG_FB_BACKLIGHT
>  	__ATTR(bl_curve, S_IRUGO|S_IWUSR, show_bl_curve, store_bl_curve),
>  #endif
> +#ifdef CONFIG_FB_DEFERRED_IO
> +	__ATTR(defio_delay, S_IRUGO|S_IWUSR,
> +	       show_defio_delay, store_defio_delay),
> +	__ATTR(defio_delay_min, S_IRUGO, show_defio_delay_min, NULL),
> +	__ATTR(defio_delay_max, S_IRUGO, show_defio_delay_max, NULL),
> +#endif
>  };
>  
>  int fb_init_device(struct fb_info *fb_info)

Would it be reasonable to add these attributes in
fb_deferred_io_init() and remove them in fb_deferred_io_cleanup()?
This would also make it possible to add write permission to delay
attribute only when it effectively can be modified.

IMHO having only attributes pertinent to the features supported by the
framebuffer is better than having all the possible ones and those of
unsupported features returning -ENODEV.

Bruno
