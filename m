From: Julia Lawall <julia.lawall@lip6.fr>
Date: Sun, 19 Mar 2017 13:11:01 +0000
Subject: Re: [Outreachy kernel] [PATCH v3] staging: sm750fb: Code readability is improved
Message-Id: <alpine.DEB.2.20.1703191409140.2108@hadrien>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170319130744.GA24605@arushi-HP-Pavilion-Notebook>
In-Reply-To: <20170319130744.GA24605@arushi-HP-Pavilion-Notebook>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arushi Singhal <arushisinghal19971997@gmail.com>
Cc: sudipm.mukherjee@gmail.com, Teddy Wang <teddy.wang@siliconmotion.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com



On Sun, 19 Mar 2017, Arushi Singhal wrote:

> New variables are added to make the code more readable.
>
> Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
> ---
>  changes in v3
>  -try to make the code much more readable.
>
>  drivers/staging/sm750fb/ddk750_mode.c | 61 ++++++++++++++++++++---------------
>  1 file changed, 35 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/staging/sm750fb/ddk750_mode.c b/drivers/staging/sm750fb/ddk750_mode.c
> index eea5aef2956f..5f18ce4d10de 100644
> --- a/drivers/staging/sm750fb/ddk750_mode.c
> +++ b/drivers/staging/sm750fb/ddk750_mode.c
> @@ -81,33 +81,42 @@ static int programModeRegisters(mode_parameter_t *pModeParam, struct pll_value *
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
> -
> -		poke32(CRT_VERTICAL_SYNC,
> -		       ((pModeParam->vertical_sync_height <<
> -			 CRT_VERTICAL_SYNC_HEIGHT_SHIFT) &
> -			CRT_VERTICAL_SYNC_HEIGHT_MASK) |
> -		       ((pModeParam->vertical_sync_start - 1) &
> -			CRT_VERTICAL_SYNC_START_MASK));
> +		unsigned int a = (pModeParam->horizontal_total - 1) <<
> +				CRT_HORIZONTAL_TOTAL_TOTAL_SHIFT;
> +		unsigned int b = a & CRT_HORIZONTAL_TOTAL_TOTAL_MASK;
> +		unsigned int c = (pModeParam->horizontal_display_end - 1) &
> +				CRT_HORIZONTAL_TOTAL_DISPLAY_END_MASK;
> +		unsigned int temp = b | c;
> +
> +		poke32(CRT_HORIZONTAL_TOTAL, temp);
> +
> +		unsigned int a = (pModeParam->horizontal_sync_width <<
> +				CRT_HORIZONTAL_SYNC_WIDTH_SHIFT);
> +		unsigned int b = a & CRT_HORIZONTAL_SYNC_WIDTH_MASK;
> +		unsigned int c = (pModeParam->horizontal_sync_start - 1) &
> +				CRT_HORIZONTAL_SYNC_START_MASK;
> +		unsigned int temp = b | c;

This is back to the original incorrect solution.  You can't declare
variables on the fly in Linux code.  Variables have to be declared at the
top of a block.

But you can reuse the same variables over and over, if no one cares about
their previous values.

julia


> +
> +		poke32(CRT_HORIZONTAL_SYNC, temp);
> +
> +		unsigned int a = (pModeParam->vertical_total - 1) <<
> +				CRT_VERTICAL_TOTAL_TOTAL_SHIFT;
> +		unsigned int b = a & CRT_VERTICAL_TOTAL_TOTAL_MASK;
> +		unsigned int c = (pModeParam->vertical_display_end - 1) &
> +				CRT_VERTICAL_TOTAL_DISPLAY_END_MASK;
> +		unsigned int temp = b | c;
> +
> +		poke32(CRT_VERTICAL_TOTAL, temp);
> +
> +		unsigned int a = pModeParam->vertical_sync_height <<
> +				CRT_VERTICAL_SYNC_HEIGHT_SHIFT;
> +		unsigned int b = a & CRT_VERTICAL_SYNC_HEIGHT_MASK;
> +		unsigned int c = (pModeParam->vertical_sync_start - 1) &
> +				CRT_VERTICAL_SYNC_START_MASK;
> +		unsigned int temp = b | c;
> +
> +		poke32(CRT_VERTICAL_SYNC, temp);
>
>  		tmp = DISPLAY_CTRL_TIMING | DISPLAY_CTRL_PLANE;
>  		if (pModeParam->vertical_sync_polarity)
> --
> 2.11.0
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To post to this group, send email to outreachy-kernel@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20170319130744.GA24605%40arushi-HP-Pavilion-Notebook.
> For more options, visit https://groups.google.com/d/optout.
>
