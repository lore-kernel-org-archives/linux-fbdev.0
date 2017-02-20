From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 20 Feb 2017 12:34:46 +0000
Subject: Re: [PATCH] video: remove incorrect __exit markups
Message-Id: <1817491.0a94zKjNFl@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20170213001411epcas3p41b3d269696ff8d0ad93cd57ce2d76581@epcas3p4.samsung.com>
 <20170213001349.GA1839@dtor-ws>
In-Reply-To: <20170213001349.GA1839@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Maciej W. Rozycki" <macro@linux-mips.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org


Hi,

On Sunday, February 12, 2017 04:13:49 PM Dmitry Torokhov wrote:
> Even if bus is not hot-pluggable, the devices can be unbound from the
> driver via sysfs, so we should not be using __exit annotations on
> remove() methods. The only exception is drivers registered with
> platform_driver_probe() which specifically disables sysfs bind/unbind
> attributes.

Please split your patch on pmag-ba-fb and pmagb-b-fb
parts and fix patch subjects while at it ("video: fbdev:
pmag-ba-fb: remove incorrect __exit markup" and "video:
fbdev: pmagb-b-fb: remove incorrect __exit markup").

> Also pmagb(a|b)fb_erase_cursor() are called from non __init codepaths,
> so they should not be marked as __init either.

'__init' annotations have already been fixed by Maciej
(patches are in fbdev-for-next branch of my tree) so
please drop these changes from your patches.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/video/fbdev/pmag-ba-fb.c | 6 +++---
>  drivers/video/fbdev/pmagb-b-fb.c | 6 +++---
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/video/fbdev/pmag-ba-fb.c b/drivers/video/fbdev/pmag-ba-fb.c
> index 5872bc4af3ce..1fd02f40708e 100644
> --- a/drivers/video/fbdev/pmag-ba-fb.c
> +++ b/drivers/video/fbdev/pmag-ba-fb.c
> @@ -129,7 +129,7 @@ static struct fb_ops pmagbafb_ops = {
>  /*
>   * Turn the hardware cursor off.
>   */
> -static void __init pmagbafb_erase_cursor(struct fb_info *info)
> +static void pmagbafb_erase_cursor(struct fb_info *info)
>  {
>  	struct pmagbafb_par *par = info->par;
>  
> @@ -235,7 +235,7 @@ static int pmagbafb_probe(struct device *dev)
>  	return err;
>  }
>  
> -static int __exit pmagbafb_remove(struct device *dev)
> +static int pmagbafb_remove(struct device *dev)
>  {
>  	struct tc_dev *tdev = to_tc_dev(dev);
>  	struct fb_info *info = dev_get_drvdata(dev);
> @@ -270,7 +270,7 @@ static struct tc_driver pmagbafb_driver = {
>  		.name	= "pmagbafb",
>  		.bus	= &tc_bus_type,
>  		.probe	= pmagbafb_probe,
> -		.remove	= __exit_p(pmagbafb_remove),
> +		.remove	= pmagbafb_remove,
>  	},
>  };
>  
> diff --git a/drivers/video/fbdev/pmagb-b-fb.c b/drivers/video/fbdev/pmagb-b-fb.c
> index 0822b6f8dddc..46e96c451506 100644
> --- a/drivers/video/fbdev/pmagb-b-fb.c
> +++ b/drivers/video/fbdev/pmagb-b-fb.c
> @@ -133,7 +133,7 @@ static struct fb_ops pmagbbfb_ops = {
>  /*
>   * Turn the hardware cursor off.
>   */
> -static void __init pmagbbfb_erase_cursor(struct fb_info *info)
> +static void pmagbbfb_erase_cursor(struct fb_info *info)
>  {
>  	struct pmagbbfb_par *par = info->par;
>  
> @@ -353,7 +353,7 @@ static int pmagbbfb_probe(struct device *dev)
>  	return err;
>  }
>  
> -static int __exit pmagbbfb_remove(struct device *dev)
> +static int pmagbbfb_remove(struct device *dev)
>  {
>  	struct tc_dev *tdev = to_tc_dev(dev);
>  	struct fb_info *info = dev_get_drvdata(dev);
> @@ -388,7 +388,7 @@ static struct tc_driver pmagbbfb_driver = {
>  		.name	= "pmagbbfb",
>  		.bus	= &tc_bus_type,
>  		.probe	= pmagbbfb_probe,
> -		.remove	= __exit_p(pmagbbfb_remove),
> +		.remove	= pmagbbfb_remove,
>  	},
>  };

