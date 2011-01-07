From: Ian Campbell <Ian.Campbell@eu.citrix.com>
Date: Fri, 07 Jan 2011 09:24:34 +0000
Subject: Re: [patch] xen-event: validate irq before get evtchn by irq
Message-Id: <1294392274.3831.3920.camel@zakaz.uk.xensource.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4D26B7A4.9000209@oracle.com>
In-Reply-To: <4D26B7A4.9000209@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Joe Jin <joe.jin@oracle.com>
Cc: "jeremy@goop.org" <jeremy@goop.org>, Andrew Morton <akpm@linux-foundation.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, "gurudas.pai@oracle.com" <gurudas.pai@oracle.com>, "guru.anbalagane@oracle.com" <guru.anbalagane@oracle.com>, "greg.marsden@oracle.com" <greg.marsden@oracle.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Fri, 2011-01-07 at 06:50 +0000, Joe Jin wrote:
> Hi,
> 
> When get event channel by irq by irq, may irq is not a valid one under
> some condition -- so far we found irq is -1 during suspend/resume, so
> worth to validate it rather than return incorrect data.

You've accidentally got "by irq" twice there and "may irq is not a valid
one" doesn't read quite right.

Perhaps something like:

"When getting an event channel from an IRQ if the IRQ is not valid then
warn and return an error in the form of the invalid event channel.

This catches errors such as trying to notify an IRQ before connecting to
the backend (e.g. during suspend/resume)."

> Please review and comment.
> 
> Signed-off-by: Joe Jin <joe.jin@oracle.com>
> Tested-by: Gurudas Pai <gurudas.pai@oracle.com>

Acked-by: Ian Campbell <ian.campbell@citrix.com>

Thanks,
Ian.

> Cc: Jeremy Fitzhardinge <jeremy@goop.org>
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> 
> ---
>  events.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/xen/events.c b/drivers/xen/events.c
> index ac7b42f..006dd7b 100644
> --- a/drivers/xen/events.c
> +++ b/drivers/xen/events.c
> @@ -175,6 +175,9 @@ static struct irq_info *info_for_irq(unsigned irq)
>  
>  static unsigned int evtchn_from_irq(unsigned irq)
>  {
> +	if (WARN(irq < 0 || irq >= nr_irqs, "Invalid irq %d!\n", irq))
> +		return 0;
> +
>  	return info_for_irq(irq)->evtchn;
>  }
>  
> 


