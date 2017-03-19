From: Julia Lawall <julia.lawall@lip6.fr>
Date: Sun, 19 Mar 2017 13:53:18 +0000
Subject: Re: [Outreachy kernel] [PATCH v5] staging: sm750fb: Remove typedefs from structures and enum
Message-Id: <alpine.DEB.2.20.1703191452520.2108@hadrien>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170319135013.GA1349@arushi-HP-Pavilion-Notebook>
In-Reply-To: <20170319135013.GA1349@arushi-HP-Pavilion-Notebook>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arushi Singhal <arushisinghal19971997@gmail.com>
Cc: sudipm.mukherjee@gmail.com, Teddy Wang <teddy.wang@siliconmotion.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com



On Sun, 19 Mar 2017, Arushi Singhal wrote:

> This patch removes typedefs from structure and enum and renames them as per
> kernel coding standards.

Greg asked for one structure/enum to be done at a time.

julia

>
> Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
> ---
>  changes in v5
>  - make the commit message more relevant.
>  - remove prefix and suffix underscore.
>
>  drivers/staging/sm750fb/ddk750_mode.c |  6 +++---
>  drivers/staging/sm750fb/ddk750_mode.h | 18 ++++++++----------
>  drivers/staging/sm750fb/sm750_hw.c    |  2 +-
>  3 files changed, 12 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/staging/sm750fb/ddk750_mode.c b/drivers/staging/sm750fb/ddk750_mode.c
> index 5f18ce4d10de..61d339437764 100644
> --- a/drivers/staging/sm750fb/ddk750_mode.c
> +++ b/drivers/staging/sm750fb/ddk750_mode.c
> @@ -12,7 +12,7 @@
>   * HW only supports 7 predefined pixel clocks, and clock select is
>   * in bit 29:27 of Display Control register.
>   */
> -static unsigned long displayControlAdjust_SM750LE(mode_parameter_t *pModeParam, unsigned long dispControl)
> +static unsigned long displayControlAdjust_SM750LE(struct mode_parameter *pModeParam, unsigned long dispControl)
>  {
>  	unsigned long x, y;
>
> @@ -72,7 +72,7 @@ static unsigned long displayControlAdjust_SM750LE(mode_parameter_t *pModeParam,
>  }
>
>  /* only timing related registers will be  programed */
> -static int programModeRegisters(mode_parameter_t *pModeParam, struct pll_value *pll)
> +static int programModeRegisters(struct mode_parameter *pModeParam, struct pll_value *pll)
>  {
>  	int ret = 0;
>  	int cnt = 0;
> @@ -207,7 +207,7 @@ static int programModeRegisters(mode_parameter_t *pModeParam, struct pll_value *
>  	return ret;
>  }
>
> -int ddk750_setModeTiming(mode_parameter_t *parm, clock_type_t clock)
> +int ddk750_setModeTiming(struct mode_parameter *parm, clock_type_t clock)
>  {
>  	struct pll_value pll;
>  	unsigned int uiActualPixelClk;
> diff --git a/drivers/staging/sm750fb/ddk750_mode.h b/drivers/staging/sm750fb/ddk750_mode.h
> index 6d204b8b4a01..07cb3f14d1ce 100644
> --- a/drivers/staging/sm750fb/ddk750_mode.h
> +++ b/drivers/staging/sm750fb/ddk750_mode.h
> @@ -3,26 +3,25 @@
>
>  #include "ddk750_chip.h"
>
> -typedef enum _spolarity_t {
> +enum spolarity {
>  	POS = 0, /* positive */
>  	NEG, /* negative */
> -}
> -spolarity_t;
> +};
>
> -typedef struct _mode_parameter_t {
> +struct mode_parameter {
>  	/* Horizontal timing. */
>  	unsigned long horizontal_total;
>  	unsigned long horizontal_display_end;
>  	unsigned long horizontal_sync_start;
>  	unsigned long horizontal_sync_width;
> -	spolarity_t horizontal_sync_polarity;
> +	enum spolarity horizontal_sync_polarity;
>
>  	/* Vertical timing. */
>  	unsigned long vertical_total;
>  	unsigned long vertical_display_end;
>  	unsigned long vertical_sync_start;
>  	unsigned long vertical_sync_height;
> -	spolarity_t vertical_sync_polarity;
> +	enum spolarity vertical_sync_polarity;
>
>  	/* Refresh timing. */
>  	unsigned long pixel_clock;
> @@ -30,10 +29,9 @@ typedef struct _mode_parameter_t {
>  	unsigned long vertical_frequency;
>
>  	/* Clock Phase. This clock phase only applies to Panel. */
> -	spolarity_t clock_phase_polarity;
> -}
> -mode_parameter_t;
> +	enum spolarity clock_phase_polarity;
> +};
>
> -int ddk750_setModeTiming(mode_parameter_t *parm, clock_type_t clock);
> +int ddk750_setModeTiming(struct mode_parameter *parm, clock_type_t clock);
>
>  #endif
> diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
> index fab3fc9c8330..baf1bbdc92ff 100644
> --- a/drivers/staging/sm750fb/sm750_hw.c
> +++ b/drivers/staging/sm750fb/sm750_hw.c
> @@ -252,7 +252,7 @@ int hw_sm750_crtc_setMode(struct lynxfb_crtc *crtc,
>  {
>  	int ret, fmt;
>  	u32 reg;
> -	mode_parameter_t modparm;
> +	struct mode_parameter modparm;
>  	clock_type_t clock;
>  	struct sm750_dev *sm750_dev;
>  	struct lynxfb_par *par;
> --
> 2.11.0
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To post to this group, send email to outreachy-kernel@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20170319135013.GA1349%40arushi-HP-Pavilion-Notebook.
> For more options, visit https://groups.google.com/d/optout.
>
