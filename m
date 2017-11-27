From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Mon, 27 Nov 2017 09:46:22 +0000
Subject: Re: [PATCH 1/2] staging: sm750fb: Fix coding style in ddk750_sii164.h
Message-Id: <20171127094622.phmx4ej2fljcytce@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171125182636.15245-1-j.lacomis@gmail.com>
In-Reply-To: <20171125182636.15245-1-j.lacomis@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jeremy Lacomis <j.lacomis@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, Nov 25, 2017 at 01:26:35PM -0500, Jeremy Lacomis wrote:
> This patch to ddk750_sii164.h fixes line length warnings found by the
> checkpatch.pl script and reformats comments uniformly.
> 
> Signed-off-by: Jeremy Lacomis <j.lacomis@gmail.com>
> ---
>  drivers/staging/sm750fb/ddk750_sii164.h | 57 +++++++++++++--------------------
>  1 file changed, 22 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/ddk750_sii164.h b/drivers/staging/sm750fb/ddk750_sii164.h
> index 2e9a88cd6af3..393a3c5be3ae 100644
> --- a/drivers/staging/sm750fb/ddk750_sii164.h
> +++ b/drivers/staging/sm750fb/ddk750_sii164.h
> @@ -4,15 +4,20 @@
>  
>  #define USE_DVICHIP
>  
> -/* Hot Plug detection mode structure */
> +/*
> + * Hot Plug detection mode structure:
> + *      Disable Hot Plug output bit (always high).
> + *      Use Monitor Detect Interrupt bit.
> + *      Use Receiver Sense detect bit.
> + *      Use Hot Plug detect bit.
> + */
>  enum sii164_hot_plug_mode {
> -	SII164_HOTPLUG_DISABLE = 0,         /* Disable Hot Plug output bit (always high). */
> -	SII164_HOTPLUG_USE_MDI,             /* Use Monitor Detect Interrupt bit. */
> -	SII164_HOTPLUG_USE_RSEN,            /* Use Receiver Sense detect bit. */
> -	SII164_HOTPLUG_USE_HTPLG            /* Use Hot Plug detect bit. */
> +	SII164_HOTPLUG_DISABLE = 0,
> +	SII164_HOTPLUG_USE_MDI,
> +	SII164_HOTPLUG_USE_RSEN,
> +	SII164_HOTPLUG_USE_HTPLG
>  };

I feel like this makes it less readable.  The original was better.

regards,
dan carpenter

