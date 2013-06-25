From: Josh Boyer <jwboyer@redhat.com>
Date: Tue, 25 Jun 2013 14:17:04 +0000
Subject: Re: [PATCH] Handle efifb with no lfb_base better.
Message-Id: <20130625141703.GB9410@hansolo.jdub.homelinux.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1366730598-13942-1-git-send-email-pjones@redhat.com>
In-Reply-To: <1366730598-13942-1-git-send-email-pjones@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Peter Jones <pjones@redhat.com>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Apr 23, 2013 at 11:23:18AM -0400, Peter Jones wrote:
> Right now we get a WARN from platform_device_unregister() because our
> platform_device has no ->release function.  This is clearly wrong, but
> we should be warning so we can figure out what happened, as this failure
> results in bug reports.  So WARN() about the real problem, and use the
> registration function that gives us a default release() function.
>=20
> This fixes the tracback reported at
> https://bugzilla.redhat.com/show_bug.cgi?id=840621 , though it does not
> fix the actual /problem/ the user is seeing.
>=20
> Signed-off-by: Peter Jones <pjones@redhat.com>

Is anyone in the fdbdev camp looking at this?  It's been 2 months since
this was sent out without any comments and I don't see it in the tree
anywhere.

josh

> ---
>  drivers/video/efifb.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/video/efifb.c b/drivers/video/efifb.c
> index 50fe668..390b61b 100644
> --- a/drivers/video/efifb.c
> +++ b/drivers/video/efifb.c
> @@ -285,6 +285,7 @@ static void efifb_destroy(struct fb_info *info)
>  {
>  	if (info->screen_base)
>  		iounmap(info->screen_base);
> +	fb_dealloc_cmap(&info->cmap);
>  	if (request_mem_succeeded)
>  		release_mem_region(info->apertures->ranges[0].base,
>  				   info->apertures->ranges[0].size);
> @@ -382,6 +383,8 @@ static int __init efifb_probe(struct platform_device =
*dev)
>  	if (!screen_info.pages)
>  		screen_info.pages =3D 1;
>  	if (!screen_info.lfb_base) {
> +		WARN(1, KERN_WARNING, "invalid framebuffer address for "
> +				      "device '%s'\n", dev_name(dev));
>  		printk(KERN_DEBUG "efifb: invalid framebuffer address\n");
>  		return -ENODEV;
>  	}
> @@ -544,9 +547,7 @@ static struct platform_driver efifb_driver =3D {
>  	},
>  };
> =20
> -static struct platform_device efifb_device =3D {
> -	.name	=3D "efifb",
> -};
> +static struct platform_device *efifb_device;
> =20
>  static int __init efifb_init(void)
>  {
> @@ -571,9 +572,9 @@ static int __init efifb_init(void)
>  	if (!screen_info.lfb_linelength)
>  		return -ENODEV;
> =20
> -	ret =3D platform_device_register(&efifb_device);
> -	if (ret)
> -		return ret;
> +	efifb_device =3D platform_device_register_simple("efifb", 0, NULL, 0);
> +	if (IS_ERROR(efifb_device))
> +		return PTR_ERR(efifb_device);
> =20
>  	/*
>  	 * This is not just an optimization.  We will interfere
> @@ -582,7 +583,7 @@ static int __init efifb_init(void)
>  	 */
>  	ret =3D platform_driver_probe(&efifb_driver, efifb_probe);
>  	if (ret) {
> -		platform_device_unregister(&efifb_device);
> +		platform_device_unregister(efifb_device);
>  		return ret;
>  	}
> =20
> --=20
> 1.8.1.4
>=20
