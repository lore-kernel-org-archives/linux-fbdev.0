From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Date: Fri, 28 Apr 2017 10:33:47 +0000
Subject: Re: [PATCH] staging: sm750fb: Combine set GPIO 30 & 31 into one statement
Message-Id: <20170428103347.GA7868@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CO2PR07MB633E8089233A3B02B79D979931E0@CO2PR07MB633.namprd07.prod.outlook.com>
In-Reply-To: <CO2PR07MB633E8089233A3B02B79D979931E0@CO2PR07MB633.namprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lynn Lei <lynnl.jr@outlook.com>
Cc: "sudipm.mukherjee@gmail.com" <sudipm.mukherjee@gmail.com>, "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "teddy.wang@siliconmotion.com" <teddy.wang@siliconmotion.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Tue, Apr 25, 2017 at 03:53:02PM +0000, Lynn Lei wrote:
> Combine two separate set GPIO(30 & 31) operations into one statement.

Why?

> 
> Signed-off-by: Lynn Lei <lynnl.jr@outlook.com>
> ---
>  drivers/staging/sm750fb/ddk750_hwi2c.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/ddk750_hwi2c.c b/drivers/staging/sm750fb/ddk750_hwi2c.c
> index 68716ef7cb06..ddb7a6dc265a 100644
> --- a/drivers/staging/sm750fb/ddk750_hwi2c.c
> +++ b/drivers/staging/sm750fb/ddk750_hwi2c.c
> @@ -49,8 +49,7 @@ void sm750_hw_i2c_close(void)
>  
>  	/* Set GPIO 30 & 31 back as GPIO pins */
>  	value = peek32(GPIO_MUX);
> -	value &= ~GPIO_MUX_30;
> -	value &= ~GPIO_MUX_31;
> +	value &= ~(GPIO_MUX_30 | GPIO_MUX_31);

Why does this matter?

thanks,

greg k-h
