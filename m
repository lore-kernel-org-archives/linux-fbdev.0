From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Tue, 10 Mar 2015 07:00:14 +0000
Subject: Re: [PATCH] staging: sm750fb: Fix sparse warning
Message-Id: <20150310070014.GM10964@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1425934628-3717-1-git-send-email-lstoakes@gmail.com>
In-Reply-To: <1425934628-3717-1-git-send-email-lstoakes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Mar 09, 2015 at 08:57:08PM +0000, Lorenzo Stoakes wrote:
> This patch fixes the following sparse warning:-
> 
> drivers/staging/sm750fb/ddk750_help.c: warning: incorrect type in assignment (different address spaces)
> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> ---
>  drivers/staging/sm750fb/ddk750_chip.h | 4 +++-
>  drivers/staging/sm750fb/ddk750_help.c | 2 +-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/ddk750_chip.h b/drivers/staging/sm750fb/ddk750_chip.h
> index 1c78875..a4e5bcc 100644
> --- a/drivers/staging/sm750fb/ddk750_chip.h
> +++ b/drivers/staging/sm750fb/ddk750_chip.h
> @@ -3,6 +3,8 @@
>  #define DEFAULT_INPUT_CLOCK 14318181 /* Default reference clock */
>  #define SM750LE_REVISION_ID (char)0xfe
>  
> +#include <asm/io.h>
> +
>  /* This is all the chips recognized by this library */
>  typedef enum _logical_chip_type_t
>  {
> @@ -70,7 +72,7 @@ logical_chip_type_t getChipType(void);
>  unsigned int calcPllValue(unsigned int request,pll_value_t *pll);
>  unsigned int calcPllValue2(unsigned int,pll_value_t *);
>  unsigned int formatPllReg(pll_value_t *pPLL);
> -void ddk750_set_mmio(volatile unsigned char *,unsigned short,char);
> +void ddk750_set_mmio(volatile unsigned char __iomem *,unsigned short,char);

No need for the volatile.  Really mmio750 should be a "void __iomem *"
it is declared as "unsigned char __iomem *" but it's not a char pointer
that's only to make the pointer math work.  It would work just as well
as a void and we could remove some ugly casting.

regards,
dan carpenter

