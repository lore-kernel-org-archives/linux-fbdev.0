From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 06 Dec 2016 09:15:37 +0000
Subject: Re: [PATCH] staging: sm750fb: Aligning Block comments
Message-Id: <20161206091537.GA12471@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CADeeJYBNp+kwS+wfCRPh2RF1ji1nR4rKf4=mBsDuBSwiJ+=Yrw@mail.gmail.com>
In-Reply-To: <CADeeJYBNp+kwS+wfCRPh2RF1ji1nR4rKf4=mBsDuBSwiJ+=Yrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Fri, Dec 02, 2016 at 12:04:39AM +0530, SRIKANT RITOLIA wrote:
> Fix checkpatch.pl warnings:-
> Block comments should align the * on each line
> 
> Signed-off-by: Srikant Ritolia <srikant.ritolia@gmail.com>
> ---
>  drivers/staging/sm750fb/ddk750.h       | 20 ++++++++++----------
>  drivers/staging/sm750fb/ddk750_chip.c  | 14 +++++++-------
>  drivers/staging/sm750fb/ddk750_chip.h  | 10 +++++-----
>  drivers/staging/sm750fb/ddk750_mode.c  | 12 ++++++------
>  drivers/staging/sm750fb/ddk750_swi2c.c | 22 +++++++++++-----------
>  drivers/staging/sm750fb/ddk750_swi2c.h | 22 +++++++++++-----------
>  6 files changed, 50 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/ddk750.h b/drivers/staging/sm750fb/ddk750.h
> index 2c10a08ed964..7ee371443e28 100644
> --- a/drivers/staging/sm750fb/ddk750.h
> +++ b/drivers/staging/sm750fb/ddk750.h
> @@ -1,16 +1,16 @@
>  #ifndef DDK750_H__
>  #define DDK750_H__
>  /*******************************************************************
> -*
> -*         Copyright (c) 2007 by Silicon Motion, Inc. (SMI)
> -*
> -*  All rights are reserved. Reproduction or in part is prohibited
> -*  without the written consent of the copyright owner.
> -*
> -*  RegSC.h --- SM718 SDK
> -*  This file contains the definitions for the System Configuration registers.
> -*
> -*******************************************************************/
> + *
> + *         Copyright (c) 2007 by Silicon Motion, Inc. (SMI)
> + *
> + *  All rights are reserved. Reproduction or in part is prohibited
> + *  without the written consent of the copyright owner.
> + *
> + *  RegSC.h --- SM718 SDK
> + *  This file contains the definitions for the System Configuration registers.
> + *
> + *******************************************************************/
>  #include "ddk750_reg.h"
>  #include "ddk750_mode.h"
>  #include "ddk750_chip.h"
> diff --git a/drivers/staging/sm750fb/ddk750_chip.c
> b/drivers/staging/sm750fb/ddk750_chip.c
> index 839d6730bde9..b7697ac206cf 100644
> --- a/drivers/staging/sm750fb/ddk750_chip.c
> +++ b/drivers/staging/sm750fb/ddk750_chip.c
> @@ -63,17 +63,17 @@ static void setChipClock(unsigned int frequency)
> 
>   if (frequency) {
>   /*
> - * Set up PLL, a structure to hold the value to be set in clocks.
> - */
> + * Set up PLL, a structure to hold the value to be set in clocks.
> + */
>   pll.inputFreq = DEFAULT_INPUT_CLOCK; /* Defined in CLOCK.H */
>   pll.clockType = MXCLK_PLL;
> 
>   /*
> - * Call calcPllValue() to fill the other fields of PLL structure.
> - * Sometime, the chip cannot set up the exact clock
> - * required by the User.
> - * Return value of calcPllValue gives the actual possible clock.
> - */
> + * Call calcPllValue() to fill the other fields of PLL structure.
> + * Sometime, the chip cannot set up the exact clock
> + * required by the User.
> + * Return value of calcPllValue gives the actual possible clock.
> + */
>   ulActualMxClk = calcPllValue(frequency, &pll);
> 
>   /* Master Clock Control: MXCLK_PLL */
> diff --git a/drivers/staging/sm750fb/ddk750_chip.h
> b/drivers/staging/sm750fb/ddk750_chip.h
> index 14357fd1cc6b..20031f4e03fa 100644
> --- a/drivers/staging/sm750fb/ddk750_chip.h
> +++ b/drivers/staging/sm750fb/ddk750_chip.h
> @@ -40,27 +40,27 @@ pll_value_t;
>  /* input struct to initChipParam() function */
>  typedef struct _initchip_param_t {
>   unsigned short powerMode;    /* Use power mode 0 or 1 */
> - unsigned short chipClock;    /**
> + unsigned short chipClock;    /*
>        * Speed of main chip clock in MHz unit
>        * 0 = keep the current clock setting
>        * Others = the new main chip clock
>        */

This change doesn't match up with your changelog comment :(

Please fix up and resend.

thanks,

greg k-h
