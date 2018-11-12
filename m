From: Mikulas Patocka <mpatocka@redhat.com>
Date: Mon, 12 Nov 2018 14:24:35 +0000
Subject: Re: [PATCH] udlfb: fix NULL pointer dereference in dlfb_usb_probe()
Message-Id: <alpine.LRH.2.02.1811120923520.3272@file01.intranet.prod.int.rdu2.redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1541795110-3179-1-git-send-email-khoroshilov@ispras.ru>
In-Reply-To: <1541795110-3179-1-git-send-email-khoroshilov@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc: Bernie Thompson <bernie@plugable.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org



On Fri, 9 Nov 2018, Alexey Khoroshilov wrote:

> If memory allocation for dlfb fails, error handling code
> unconditionally dereference NULL pointer.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
> Fixes: 68a958a915ca ("udlfb: handle unplug properly")

Reviewed-by: Mikulas Patocka <mpatocka@redhat.com>

> ---
>  drivers/video/fbdev/udlfb.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/video/fbdev/udlfb.c b/drivers/video/fbdev/udlfb.c
> index 070026a7e55a..9643fe7c8349 100644
> --- a/drivers/video/fbdev/udlfb.c
> +++ b/drivers/video/fbdev/udlfb.c
> @@ -1590,7 +1590,7 @@ static int dlfb_usb_probe(struct usb_interface *intf,
>  	int i;
>  	const struct device_attribute *attr;
>  	struct dlfb_data *dlfb;
> -	struct fb_info *info;
> +	struct fb_info *info = NULL;
>  	int retval = -ENOMEM;
>  	struct usb_device *usbdev = interface_to_usbdev(intf);
>  
> @@ -1701,8 +1701,8 @@ static int dlfb_usb_probe(struct usb_interface *intf,
>  	return 0;
>  
>  error:
> -	if (dlfb->info) {
> -		dlfb_ops_destroy(dlfb->info);
> +	if (info) {
> +		dlfb_ops_destroy(info);
>  	} else if (dlfb) {
>  		usb_put_dev(dlfb->udev);
>  		kfree(dlfb);
> -- 
> 2.7.4
> 
