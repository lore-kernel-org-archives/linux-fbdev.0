From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Mon, 20 Mar 2017 12:28:17 +0000
Subject: Re: [PATCH v4] staging: sm750fb: Code readability is improved
Message-Id: <20170320122817.GG4395@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170319154920.GA12736@arushi-HP-Pavilion-Notebook>
In-Reply-To: <20170319154920.GA12736@arushi-HP-Pavilion-Notebook>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arushi Singhal <arushisinghal19971997@gmail.com>
Cc: sudipm.mukherjee@gmail.com, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, Teddy Wang <teddy.wang@siliconmotion.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com

On Sun, Mar 19, 2017 at 09:19:20PM +0530, Arushi Singhal wrote:
> New variables are added to make the code more readable.
> 
> Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
> ---
>  changes in v4
>  -try to make the code much more readable.
>  - defined the variable at the top of a block.
> ---
>  drivers/staging/sm750fb/ddk750_mode.c | 57 +++++++++++++++++++----------------
>  1 file changed, 31 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/ddk750_mode.c b/drivers/staging/sm750fb/ddk750_mode.c
> index eea5aef2956f..6517e770e0a7 100644
> --- a/drivers/staging/sm750fb/ddk750_mode.c
> +++ b/drivers/staging/sm750fb/ddk750_mode.c
> @@ -76,38 +76,43 @@ static int programModeRegisters(mode_parameter_t *pModeParam, struct pll_value *
>  {
>  	int ret = 0;
>  	int cnt = 0;
> -	unsigned int tmp, reg;
> +	unsigned int tmp, reg, temp;

Let's not have "tmp" and "temp" both.  Generally "tmp" is better because
you can't confuse it with temperature.

>  
>  	if (pll->clockType = SECONDARY_PLL) {
>  		/* programe secondary pixel clock */
>  		poke32(CRT_PLL_CTRL, sm750_format_pll_reg(pll));
> -		poke32(CRT_HORIZONTAL_TOTAL,
> -		       (((pModeParam->horizontal_total - 1) <<
> -			 CRT_HORIZONTAL_TOTAL_TOTAL_SHIFT) &
> -			CRT_HORIZONTAL_TOTAL_TOTAL_MASK) |
> -		       ((pModeParam->horizontal_display_end - 1) &
> -			CRT_HORIZONTAL_TOTAL_DISPLAY_END_MASK));
> -
> -		poke32(CRT_HORIZONTAL_SYNC,
> -		       ((pModeParam->horizontal_sync_width <<
> -			 CRT_HORIZONTAL_SYNC_WIDTH_SHIFT) &
> -			CRT_HORIZONTAL_SYNC_WIDTH_MASK) |
> -		       ((pModeParam->horizontal_sync_start - 1) &
> -			CRT_HORIZONTAL_SYNC_START_MASK));
>  
> -		poke32(CRT_VERTICAL_TOTAL,
> -		       (((pModeParam->vertical_total - 1) <<
> -			 CRT_VERTICAL_TOTAL_TOTAL_SHIFT) &
> -			CRT_VERTICAL_TOTAL_TOTAL_MASK) |
> -		       ((pModeParam->vertical_display_end - 1) &
> -			CRT_VERTICAL_TOTAL_DISPLAY_END_MASK));
> +		temp = (pModeParam->horizontal_total - 1) <<
> +				CRT_HORIZONTAL_TOTAL_TOTAL_SHIFT;
> +		temp = temp & CRT_HORIZONTAL_TOTAL_TOTAL_MASK;


These two lines are really part of the same thing and they should be
done together.

		tmp = ((pModeParam->horizontal_total - 1) <<
		       CRT_HORIZONTAL_TOTAL_TOTAL_SHIFT) &
		      CRT_HORIZONTAL_TOTAL_TOTAL_MASK;

> +		temp = temp | ((pModeParam->horizontal_display_end - 1) &
> +				CRT_HORIZONTAL_TOTAL_DISPLAY_END_MASK);

		tmp |= (pModeParam->horizontal_display_end - 1) &
		       CRT_HORIZONTAL_TOTAL_DISPLAY_END_MASK;

Use |=.  Remove the extra parenthesis.

regards,
dan carpenter

