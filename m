From: Joe Perches <joe@perches.com>
Date: Mon, 06 Nov 2017 18:32:33 +0000
Subject: Re: [PATCH v2] video: atmel_lcdfb: Use unique error messages in atmel_lcdfb_of_init()
Message-Id: <1509993153.2431.48.camel@perches.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <2db677d2-ad4e-1f79-344b-dfa38ce948c9@users.sourceforge.net>
         <5477205e-2067-de4f-8736-71a2c9dc1653@microchip.com>
         <8d297cae-5dd1-d345-8d9d-9bf3ec32d4f8@users.sourceforge.net>
         <2d650d87-034c-d05b-b3aa-f689f25ab184@microchip.com>
         <a768c806-8c15-5d74-02ac-38724482ac67@users.sourceforge.net>
In-Reply-To: <a768c806-8c15-5d74-02ac-38724482ac67@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: SF Markus Elfring <elfring@users.sourceforge.net>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

On Mon, 2017-11-06 at 19:14 +0100, SF Markus Elfring wrote:
> A duplicate error message was used so far in this function implementation.
> Thus use a consistent message format instead together with property names
> where constant merging can be applied by the compiler in four cases.
[]
> diff --git a/drivers/video/fbdev/atmel_lcdfb.c b/drivers/video/fbdev/atmel_lcdfb.c
[]
> @@ -1021,6 +1021,8 @@ static void atmel_lcdfb_power_control_gpio(struct atmel_lcdfb_pdata *pdata, int
>  		gpio_set_value(og->gpio, on);
>  }
>  
> +static char const property_failure[] = "failed to get property %s\n";

Yuck.  This makes it harder to grep the sources.
Just use the normal format string in each place.

> +
>  static int atmel_lcdfb_of_init(struct atmel_lcdfb_info *sinfo)
>  {
>  	struct fb_info *info = sinfo->info;
> @@ -1048,25 +1050,25 @@ static int atmel_lcdfb_of_init(struct atmel_lcdfb_info *sinfo)
>  
>  	ret = of_property_read_u32(display_np, "bits-per-pixel", &var->bits_per_pixel);
>  	if (ret < 0) {
> -		dev_err(dev, "failed to get property bits-per-pixel\n");
> +		dev_err(dev, property_failure, "bits-per-pixel");

This likely doesn't even save any code size.
