From: "Tobin C. Harding" <me@tobin.cc>
Date: Wed, 24 May 2017 02:07:43 +0000
Subject: Re: staging: sm750fb: removed hungarian prfx and replace CamelCase variables
Message-Id: <20170524020743.GH8158@eros>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1495544859-2639-1-git-send-email-richaj@cdac.in>
In-Reply-To: <1495544859-2639-1-git-send-email-richaj@cdac.in>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Richa Jha <richaj@cdac.in>
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, teddy.wang@siliconmotion.com, linux-kernel@vger.kernel.org, sudipm.mukherjee@gmail.com

On Tue, May 23, 2017 at 06:37:39PM +0530, Richa Jha wrote:
> Replace CamelCase variable names with underscores and remove
>  hungarian prefixes to comply with the standard kernel coding style

Hi Richa,

Nice work. You may like to do all the camel case at the same
time. You could limit yourself to just this file and structures it
touches if it is easier. That way when reviewers are reviewing
your patch they will see nice clean lines added (instead of lines with
camel case in them still).

> 
> Signed-off-by: Richa Jha <richaj@cdac.in>
> ---
>  drivers/staging/sm750fb/ddk750_chip.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/ddk750_chip.c b/drivers/staging/sm750fb/ddk750_chip.c
> index 8e51f60..56b8d66 100644
> --- a/drivers/staging/sm750fb/ddk750_chip.c
> +++ b/drivers/staging/sm750fb/ddk750_chip.c
> @@ -55,7 +55,7 @@ static unsigned int get_mxclk_freq(void)
>  static void set_chip_clock(unsigned int frequency)
>  {
>  	struct pll_value pll;
> -	unsigned int ulActualMxClk;
> +	unsigned int actual_max_clk;
>  
>  	/* Cheok_0509: For SM750LE, the chip clock is fixed. Nothing to set. */
>  	if (sm750_get_chip_type() = SM750LE)
> @@ -75,7 +75,7 @@ static void set_chip_clock(unsigned int frequency)
>  		 * Return value of sm750_calc_pll_value gives the actual
>  		 * possible clock.
>  		 */
> -		ulActualMxClk = sm750_calc_pll_value(frequency, &pll);
> +		actual_max_clk = sm750_calc_pll_value(frequency, &pll);
>  
>  		/* Master Clock Control: MXCLK_PLL */
>  		poke32(MXCLK_PLL_CTRL, sm750_format_pll_reg(&pll));
> @@ -210,13 +210,13 @@ unsigned int ddk750_get_vm_size(void)
>  	return data;
>  }
>  
> -int ddk750_init_hw(struct initchip_param *pInitParam)
> +int ddk750_init_hw(struct initchip_param *init_param)
>  {
>  	unsigned int reg;
>  
> -	if (pInitParam->powerMode != 0)
> -		pInitParam->powerMode = 0;
> -	sm750_set_power_mode(pInitParam->powerMode);
> +	if (init_param->powerMode != 0)
> +		init_param->powerMode = 0;
> +	sm750_set_power_mode(init_param->powerMode);
>  
>  	/* Enable display power gate & LOCALMEM power gate*/
>  	reg = peek32(CURRENT_GATE);
> @@ -237,13 +237,13 @@ int ddk750_init_hw(struct initchip_param *pInitParam)
>  	}
>  
>  	/* Set the Main Chip Clock */
> -	set_chip_clock(MHz((unsigned int)pInitParam->chipClock));
> +	set_chip_clock(MHz((unsigned int)init_param->chipClock));
>  
>  	/* Set up memory clock. */
> -	set_memory_clock(MHz(pInitParam->memClock));
> +	set_memory_clock(MHz(init_param->memClock));
>  
>  	/* Set up master clock */
> -	set_master_clock(MHz(pInitParam->masterClock));
> +	set_master_clock(MHz(init_param->masterClock));
>  
>  	/*
>  	 * Reset the memory controller.
> @@ -251,7 +251,7 @@ int ddk750_init_hw(struct initchip_param *pInitParam)
>  	 * the system might hang when sw accesses the memory.
>  	 * The memory should be resetted after changing the MXCLK.
>  	 */
> -	if (pInitParam->resetMemory = 1) {
> +	if (init_param->resetMemory = 1) {
>  		reg = peek32(MISC_CTRL);
>  		reg &= ~MISC_CTRL_LOCALMEM_RESET;
>  		poke32(MISC_CTRL, reg);
> @@ -260,7 +260,7 @@ int ddk750_init_hw(struct initchip_param *pInitParam)
>  		poke32(MISC_CTRL, reg);
>  	}
>  
> -	if (pInitParam->setAllEngOff = 1) {
> +	if (init_param->setAllEngOff = 1) {

This would be nicer like this;

-	if (pInitParam->setAllEngOff = 1) {
+	if (init_param->set_all_eng_off = 1) {

Good luck,
Tobin.
