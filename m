From: Jingoo Han <jg1.han@samsung.com>
Date: Fri, 25 Jan 2013 02:22:06 +0000
Subject: Re: [patch] backlight: s6e63m0: report ->gamma_table_count correctly
Message-Id: <00c601cdfaa2$c52d03c0$4f870b40$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20130124070524.GD5611@elgon.mountain>
In-Reply-To: <20130124070524.GD5611@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Dan Carpenter' <dan.carpenter@oracle.com>
Cc: 'Andrew Morton' <akpm@linux-foundation.org>, 'Inki Dae' <inki.dae@samsung.com>, 'Richard Purdie' <rpurdie@rpsys.net>, 'Florian Tobias Schandinat' <FlorianSchandinat@gmx.de>, linux-fbdev@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>

On Thursday, January 24, 2013 10:45 PM, Dan Carpenter wrote

CC'ed Andrew Morton, Inki Dae.

> 
> gamma_table has 3 arrays which each hold MAX_GAMMA_LEVEL pointers to
> int.
> 
> The current code sets ->gamma_table_count to 6 on 64bit arches and to 3
> on 32 bit arches.  It should be 3 on everything.

Actually, I don't know it is right.
However, it is certain that this panel is currently used on 32 bit arches
such as ARM SoCs.

> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> This is from reading the code.  We use ->gamma_table_count in sysfs file
> but other than that I'm not sure what it's for.  I am not very familiar
> with this code.
> 
> diff --git a/drivers/video/backlight/s6e63m0.c b/drivers/video/backlight/s6e63m0.c
> index 2126b96..9c2677f 100644
> --- a/drivers/video/backlight/s6e63m0.c
> +++ b/drivers/video/backlight/s6e63m0.c
> @@ -766,7 +766,7 @@ static int s6e63m0_probe(struct spi_device *spi)
>  	 * know that.
>  	 */
>  	lcd->gamma_table_count > -	    sizeof(gamma_table) / (MAX_GAMMA_LEVEL * sizeof(int));
> +	    sizeof(gamma_table) / (MAX_GAMMA_LEVEL * sizeof(int *));
> 
>  	ret = device_create_file(&(spi->dev), &dev_attr_gamma_mode);
>  	if (ret < 0)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

