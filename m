From: Greg KH <gregkh@linuxfoundation.org>
Date: Mon, 27 Aug 2018 17:49:40 +0000
Subject: Re: [PATCH] ddk750_mode.c: Wraps line to 80 charecters
Message-Id: <20180827174940.GC27089@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180808093552.2248-1-abishekvashok@gmail.com>
In-Reply-To: <20180808093552.2248-1-abishekvashok@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Abishek V Ashok <abishekvashok@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

On Wed, Aug 08, 2018 at 03:05:52PM +0530, Abishek V Ashok wrote:
> Splits definition of function programModeRegisters into two lines such
> that each line is less than 80 characters.
> 
> Signed-off-by: Abishek V Ashok <abishekvashok@gmail.com>
> ---
>  drivers/staging/sm750fb/ddk750_mode.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/ddk750_mode.c b/drivers/staging/sm750fb/ddk750_mode.c
> index 7e22d093b..57cf9e6a5 100644
> --- a/drivers/staging/sm750fb/ddk750_mode.c
> +++ b/drivers/staging/sm750fb/ddk750_mode.c
> @@ -13,8 +13,8 @@
>   * HW only supports 7 predefined pixel clocks, and clock select is
>   * in bit 29:27 of Display Control register.
>   */
> -static unsigned long displayControlAdjust_SM750LE(struct mode_parameter *pModeParam,
> -						  unsigned long dispControl)
> +static unsigned long displayControlAdjust_SM750LE(
> +		struct mode_parameter *pModeParam, unsigned long dispControl)

Ick, actually the original code is just fine here, please leave it
as-is.

thanks,,

greg k-h
