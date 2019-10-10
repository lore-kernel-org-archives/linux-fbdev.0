From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Thu, 10 Oct 2019 09:04:06 +0000
Subject: Re: [PATCH] staging: sm750fb: Potential uninitialized field in "pll"
Message-Id: <20191010090406.GA466733@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191010043809.27594-1-yzhai003@ucr.edu>
In-Reply-To: <20191010043809.27594-1-yzhai003@ucr.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yizhuo <yzhai003@ucr.edu>
Cc: devel@driverdev.osuosl.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, linux-fbdev@vger.kernel.org, Teddy Wang <teddy.wang@siliconmotion.com>, linux-kernel@vger.kernel.org

On Wed, Oct 09, 2019 at 09:38:08PM -0700, Yizhuo wrote:
> Inside function set_chip_clock(), struct pll is supposed to be
> initialized in sm750_calc_pll_value(), if condition
> "diff < mini_diff" in sm750_calc_pll_value() cannot be fulfilled,
> then some field of pll will not be initialized but used in
> function sm750_format_pll_reg(), which is potentially unsafe.
> 
> Signed-off-by: Yizhuo <yzhai003@ucr.edu>
> ---
>  drivers/staging/sm750fb/ddk750_chip.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/sm750fb/ddk750_chip.c b/drivers/staging/sm750fb/ddk750_chip.c
> index 5a317cc98a4b..31b3cf9c2d8b 100644
> --- a/drivers/staging/sm750fb/ddk750_chip.c
> +++ b/drivers/staging/sm750fb/ddk750_chip.c
> @@ -55,7 +55,7 @@ static unsigned int get_mxclk_freq(void)
>   */
>  static void set_chip_clock(unsigned int frequency)
>  {
> -	struct pll_value pll;
> +	struct pll_value pll = {};
>  	unsigned int actual_mx_clk;
>  
>  	/* Cheok_0509: For SM750LE, the chip clock is fixed. Nothing to set. */

This doesn't apply to my tree at all.  Please rebase it against the
staging-next branch of staging.git and resend.

thanks,

greg k-h
