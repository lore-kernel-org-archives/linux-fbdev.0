From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Tue, 24 Mar 2015 07:57:08 +0000
Subject: Re: [PATCH] staging: sm750fb: Fixed C99 comments warnings
Message-Id: <20150324075708.GM10964@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20150324045154.GA12298@localhost.localdomain>
In-Reply-To: <20150324045154.GA12298@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ragavendra Nagraj <ragavendra.bn@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

On Mon, Mar 23, 2015 at 09:51:54PM -0700, Ragavendra Nagraj wrote:
> diff --git a/drivers/staging/sm750fb/ddk750_chip.c b/drivers/staging/sm750fb/ddk750_chip.c
> index 02f9326..1fb00a4 100644
> --- a/drivers/staging/sm750fb/ddk750_chip.c
> +++ b/drivers/staging/sm750fb/ddk750_chip.c
> @@ -17,7 +17,7 @@ logical_chip_type_t getChipType(void)
>  	char physicalRev;
>  	logical_chip_type_t chip;
>  
> -	physicalID = devId750;//either 0x718 or 0x750
> +	physicalID = devId750;/*either 0x718 or 0x750*/

This should be:

	physicalID = devId750; /* either 0x718 or 0x750 */

> @@ -501,7 +501,7 @@ unsigned int calcPllValue(unsigned int request_orig,pll_value_t *pll)
>  		}
>  	}
>  
> -	//printk("Finally:  pll->n[%lu],m[%lu],od[%lu],pod[%lu]\n",pll->N,pll->M,pll->OD,pll->POD);
> +	/*printk("Finally:  pll->n[%lu],m[%lu],od[%lu],pod[%lu]\n",pll->N,pll->M,pll->OD,pll->POD);*/

Just delete this dead code.

Please redo.

regards,
dan carpenter

