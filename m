From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Mon, 24 Feb 2014 10:36:24 +0000
Subject: Re: [PATCH v2 1/5] Drivers: hv: vmbus: Extract the mmio information from DSDT
Message-Id: <20140224103623.GF26722@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1393237516-28545-1-git-send-email-kraxel@redhat.com>
 <1393237516-28545-2-git-send-email-kraxel@redhat.com>
In-Reply-To: <1393237516-28545-2-git-send-email-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: linux-fbdev@vger.kernel.org, gregkh@linuxfoundation.org, jasowang@redhat.com, linux-kernel@vger.kernel.org, tomi.valkeinen@ti.com, "open list:Hyper-V CORE AND..." <devel@linuxdriverproject.org>, haiyangz@microsoft.com

On Mon, Feb 24, 2014 at 11:25:12AM +0100, Gerd Hoffmann wrote:
> -static acpi_status vmbus_walk_resources(struct acpi_resource *res, void *irq)
> +static acpi_status vmbus_walk_resources(struct acpi_resource *res, void *ctx)
>  {
> +	switch (res->type) {
> +	case ACPI_RESOURCE_TYPE_IRQ:
> +		irq = res->data.irq.interrupts[0];
>  
> -	if (res->type = ACPI_RESOURCE_TYPE_IRQ) {
> -		struct acpi_resource_irq *irqp;
> -		irqp = &res->data.irq;
> -
> -		*((unsigned int *)irq) = irqp->interrupts[0];

Add a /* fall through */ comment here.

> +	case ACPI_RESOURCE_TYPE_ADDRESS64:
> +		hyperv_mmio_start = res->data.address64.minimum;
> +		hyperv_mmio_size = res->data.address64.address_length;
>  	}

regards,
dan carpenter

