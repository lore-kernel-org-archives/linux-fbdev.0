From: Steven Price <steven.price@arm.com>
Date: Thu, 21 Nov 2019 10:18:58 +0000
Subject: Re: [PATCH v1 1/5] fbtft: Make sure string is NULL terminated
Message-Id: <da3a18a1-a5a1-52b5-20d6-c4ef2bf6a5fe@arm.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191120095716.26628-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20191120095716.26628-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, dri-devel@lists.freedesktop.org, =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>, linux-fbdev@vger.kernel.org, Nishad Kamdar <nishadkamdar@gmail.com>, devel@driverdev.osuosl.org

On 20/11/2019 09:57, Andy Shevchenko wrote:
> New GCC warns about inappropriate use of strncpy():
> 
> drivers/staging/fbtft/fbtft-core.c: In function ‘fbtft_framebuffer_alloc’:
> drivers/staging/fbtft/fbtft-core.c:665:2: warning: ‘strncpy’ specified bound 16 equals destination size [-Wstringop-truncation]
>   665 |  strncpy(info->fix.id, dev->driver->name, 16);
>       |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Later on the copy is being used with the assumption to be NULL terminated.
> Make sure string is NULL terminated by switching to snprintf().

Even better would be strscpy():

	strscpy(info->fix.id, dev->driver->name, sizeof(info->fix.id));

Steve

> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/staging/fbtft/fbtft-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
> index a0a67aa517f0..61f0286fb157 100644
> --- a/drivers/staging/fbtft/fbtft-core.c
> +++ b/drivers/staging/fbtft/fbtft-core.c
> @@ -666,7 +666,7 @@ struct fb_info *fbtft_framebuffer_alloc(struct fbtft_display *display,
>  	fbdefio->deferred_io =     fbtft_deferred_io;
>  	fb_deferred_io_init(info);
>  
> -	strncpy(info->fix.id, dev->driver->name, 16);
> +	snprintf(info->fix.id, sizeof(info->fix.id), "%s", dev->driver->name);
>  	info->fix.type =           FB_TYPE_PACKED_PIXELS;
>  	info->fix.visual =         FB_VISUAL_TRUECOLOR;
>  	info->fix.xpanstep =	   0;
> 
