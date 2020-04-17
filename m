From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 17 Apr 2020 14:07:46 +0000
Subject: Re: [PATCH v1 5/5] video: ssd1307fb: Remove redundant forward declaration
Message-Id: <cb6b7219-e9df-3f1a-dc25-67b0c52ed720@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200324170532.44384-1-andriy.shevchenko@linux.intel.com>
 <CGME20200324170539eucas1p19f81f8c31975734ab56e19d15033be77@eucas1p1.samsung.com>
 <20200324170532.44384-5-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20200324170532.44384-5-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-fbdev@vger.kernel.org, xllacyx@gmail.com, dri-devel@lists.freedesktop.org


[ added dri-devel ML to Cc: ]

On 3/24/20 6:05 PM, Andy Shevchenko wrote:
> There is no need to have forward declaration of struct ssd1307fb_par.
> Drop it for good.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Patch queued for v5.8, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/video/fbdev/ssd1307fb.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
> index 6e543396002a..509cab2c8b6c 100644
> --- a/drivers/video/fbdev/ssd1307fb.c
> +++ b/drivers/video/fbdev/ssd1307fb.c
> @@ -48,8 +48,6 @@
>  static u_int refreshrate = REFRESHRATE;
>  module_param(refreshrate, uint, 0);
>  
> -struct ssd1307fb_par;
> -
>  struct ssd1307fb_deviceinfo {
>  	u32 default_vcomh;
>  	u32 default_dclk_div;
> 
