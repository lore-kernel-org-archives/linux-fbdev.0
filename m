From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Fri, 21 Aug 2015 09:22:03 +0000
Subject: Re: [patch] fbdev: fix snprintf() limit in show_bl_curve()
Message-Id: <1440148923.23472.15.camel@linux.intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20150821085302.GE25369@mwanda>
In-Reply-To: <20150821085302.GE25369@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Fri, 2015-08-21 at 11:53 +0300, Dan Carpenter wrote:
> The limit should be "PAGE_SIZE - len" instead of PAGE_SIZE.
> 

Besides that was in the original code, the problem still might happen
when FB_BACKLIGHT_LEVELS is set to 171+ since snprintf() returns
desired length. I suppose you would change this to check len on each
iteration or change to scnprintf() if I get it correct.

 
> diff --git a/drivers/video/fbdev/core/fbsysfs.c 
> b/drivers/video/fbdev/core/fbsysfs.c
> index 60c3f0a..827098d 100644
> --- a/drivers/video/fbdev/core/fbsysfs.c
> +++ b/drivers/video/fbdev/core/fbsysfs.c
> @@ -485,7 +485,7 @@ static ssize_t show_bl_curve(struct device 
> *device,
>  
>  	mutex_lock(&fb_info->bl_curve_mutex);
>  	for (i = 0; i < FB_BACKLIGHT_LEVELS; i += 8)
> -		len += snprintf(&buf[len], PAGE_SIZE, "%8ph\n",
> +		len += snprintf(&buf[len], PAGE_SIZE - len, 
> "%8ph\n",
>  				fb_info->bl_curve + i);
>  	mutex_unlock(&fb_info->bl_curve_mutex);
>  

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
