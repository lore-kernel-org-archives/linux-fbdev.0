From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Thu, 12 Mar 2015 09:50:37 +0000
Subject: Re: [PATCH] staging: sm750fb: moved open brace next to declaration
Message-Id: <20150312095037.GY10964@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20150312093155.GA28806@localhost.localdomain>
In-Reply-To: <20150312093155.GA28806@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ragavendra BN <ragavendra.bn@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

On Thu, Mar 12, 2015 at 02:31:55AM -0700, Ragavendra BN wrote:
> Signed-off-by: Ragavendra BN <ragavendra.bn@gmail.com [user]>

Don't include this.  Fix your From header so it has your legal name.
Remover the [user] part.

> 
> This patch fixes the coding style warning found by checkpath.pl for the
> open braces next to declaration.

No signed-off.

> ---
>  drivers/staging/sm750fb/ddk750_chip.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/ddk750_chip.c b/drivers/staging/sm750fb/ddk750_chip.c
> index b71169e..2c12dd0 100644
> --- a/drivers/staging/sm750fb/ddk750_chip.c
> +++ b/drivers/staging/sm750fb/ddk750_chip.c
> @@ -11,8 +11,7 @@ typedef struct _pllcalparam{
>  pllcalparam;
>  
>  
> -logical_chip_type_t getChipType()
> -{
> +logical_chip_type_t getChipType(){

This is not correct.  The braces were better in the original.

regards,
dan carpenter

