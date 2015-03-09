From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Mon, 09 Mar 2015 09:22:09 +0000
Subject: Re: [PATCH 1/4] staging: sm750fb: wrong type for print
Message-Id: <20150309092209.GB10964@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1425817886-14387-1-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1425817886-14387-1-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Mar 08, 2015 at 06:01:23PM +0530, Sudip Mukherjee wrote:
> diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
> index 711676c..2ab7b74 100644
> --- a/drivers/staging/sm750fb/sm750.h
> +++ b/drivers/staging/sm750fb/sm750.h
> @@ -59,10 +59,10 @@ struct lynx_share{
>  		}mtrr;
>  #endif
>  	/* all smi graphic adaptor got below attributes */
> -	resource_size_t vidmem_start;
> -	resource_size_t vidreg_start;
> -	resource_size_t vidmem_size;
> -	resource_size_t vidreg_size;
> +	unsigned long vidmem_start;
> +	unsigned long vidreg_start;
> +	unsigned long vidmem_size;
> +	unsigned long vidreg_size;
>  	volatile unsigned char __iomem * pvReg;
>  	unsigned char __iomem * pvMem;
>  	/* locks*/

This seems like a very risky sort of change.  It's not explained very
well in the changelog.  What's the deal?

regards,
dan carpenter

