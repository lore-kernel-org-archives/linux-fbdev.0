From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Thu, 12 Apr 2012 02:22:11 +0000
Subject: Re: [PATCH] video: pxa3xx-gcu: Simplify the logic to exit while loop in pxa3xx_gcu_wait_idle
Message-Id: <4F863C53.5060205@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1332818156.21855.4.camel@phoenix>
In-Reply-To: <1332818156.21855.4.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Daniel Mack <daniel@caiaq.de>, Sven Neumann <s.neumann@raumfeld.com>, Janine Kropp <nin@directfb.org>, Denis Oliver Kropp <dok@directfb.org>, linux-fbdev@vger.kernel.org

On 03/27/2012 03:15 AM, Axel Lin wrote:
> If wait_event_interruptible_timeout returns a positive value, it means
> the condition evaluated is true. Which means priv->shared->hw_running is false.
> And then we will exit the loop.
> 
> This patch simplifies the logic to exit the while loop.
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Applied.


Thanks,

Florian Tobias Schandinat

> ---
>  drivers/video/pxa3xx-gcu.c |    5 +----
>  1 files changed, 1 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/video/pxa3xx-gcu.c b/drivers/video/pxa3xx-gcu.c
> index 1d71c08..0b4ae0c 100644
> --- a/drivers/video/pxa3xx-gcu.c
> +++ b/drivers/video/pxa3xx-gcu.c
> @@ -316,12 +316,9 @@ pxa3xx_gcu_wait_idle(struct pxa3xx_gcu_priv *priv)
>  		ret = wait_event_interruptible_timeout(priv->wait_idle,
>  					!priv->shared->hw_running, HZ*4);
>  
> -		if (ret < 0)
> +		if (ret != 0)
>  			break;
>  
> -		if (ret > 0)
> -			continue;
> -
>  		if (gc_readl(priv, REG_GCRBEXHR) = rbexhr &&
>  		    priv->shared->num_interrupts = num) {
>  			QERROR("TIMEOUT");

