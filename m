From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Thu, 10 May 2012 00:12:16 +0000
Subject: Re: [PATCH] video: mb862xx-i2c: local functions should not be exposed globally
Message-Id: <4FAB07E0.5070209@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201205021734.16988.hartleys@visionengravers.com>
In-Reply-To: <201205021734.16988.hartleys@visionengravers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: H Hartley Sweeten <hartleys@visionengravers.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-fbdev@vger.kernel.org, agust@denx.de

On 05/03/2012 12:34 AM, H Hartley Sweeten wrote:
> Functions not referenced outside of a source file should be marked
> static to prevent them from being exposed globally.
> 
> Quiets the sparse warnings:
> 
> warning: symbol 'mb862xx_i2c_stop' was not declared. Should it be static?
> 
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
> Cc: Anatolij Gustschin <agust@denx.de>

Applied.


Thanks,

Florian Tobias Schandinat

> 
> ---
> 
> diff --git a/drivers/video/mb862xx/mb862xx-i2c.c b/drivers/video/mb862xx/mb862xx-i2c.c
> index 273769b..c87e17a 100644
> --- a/drivers/video/mb862xx/mb862xx-i2c.c
> +++ b/drivers/video/mb862xx/mb862xx-i2c.c
> @@ -68,7 +68,7 @@ static int mb862xx_i2c_read_byte(struct i2c_adapter *adap, u8 *byte, int last)
>  	return 1;
>  }
>  
> -void mb862xx_i2c_stop(struct i2c_adapter *adap)
> +static void mb862xx_i2c_stop(struct i2c_adapter *adap)
>  {
>  	struct mb862xxfb_par *par = adap->algo_data;
>  
> 

