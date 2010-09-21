From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Tue, 21 Sep 2010 17:15:06 +0000
Subject: Re: [PATCH 2/2] viafb: Add OLPC XO-1.5 port configs
Message-Id: <4C98E81A.80309@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20100921153726.21D609D401B@zog.reactivated.net>
In-Reply-To: <20100921153726.21D609D401B@zog.reactivated.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Daniel Drake schrieb:
> The OLPC XO-1.5 does not use the standard port wiring suggested
> in the viafb driver.
> 
> This is required for the upcoming OLPC DCON and via-camera drivers,
> to be submitted soon.

Why? What happens if this patch is not applied?
Please understand, that I, as a maintainer, try to avoid platform specific code 
as much as possible so a little explanation would be good.


Thanks,

Florian Tobias Schandinat

> Signed-off-by: Daniel Drake <dsd@laptop.org>
> ---
>  drivers/video/via/via-core.c |   25 +++++++++++++++++++++++++
>  1 files changed, 25 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/video/via/via-core.c b/drivers/video/via/via-core.c
> index 08390fe..a0efb8f 100644
> --- a/drivers/video/via/via-core.c
> +++ b/drivers/video/via/via-core.c
> @@ -16,6 +16,10 @@
>  #include <linux/interrupt.h>
>  #include <linux/platform_device.h>
>  
> +#ifdef CONFIG_OLPC
> +#include <asm/olpc.h>
> +#endif
> +
>  /*
>   * The default port config.
>   */
> @@ -28,6 +32,21 @@ static const struct via_port_cfg adap_configs[] = {
>  	{ 0, 0, 0, 0 }
>  };
>  
> +#ifdef CONFIG_OLPC
> +/*
> + * The OLPC XO-1.5 puts the camera power and reset lines onto
> + * GPIO 2C.  The configuration for 26 is also modified.
> + */
> +static const struct via_port_cfg olpc_adap_configs[] = {
> +	[VIA_PORT_26]	= { VIA_PORT_I2C,  VIA_MODE_I2C, VIASR, 0x26 },
> +	[VIA_PORT_31]	= { VIA_PORT_I2C,  VIA_MODE_I2C, VIASR, 0x31 },
> +	[VIA_PORT_25]	= { VIA_PORT_GPIO, VIA_MODE_GPIO, VIASR, 0x25 },
> +	[VIA_PORT_2C]	= { VIA_PORT_GPIO, VIA_MODE_GPIO, VIASR, 0x2c },
> +	[VIA_PORT_3D]	= { VIA_PORT_GPIO, VIA_MODE_GPIO, VIASR, 0x3d },
> +	{ 0, 0, 0, 0 }
> +};
> +#endif
> +
>  /*
>   * We currently only support one viafb device (will there ever be
>   * more than one?), so just declare it globally here.
> @@ -575,6 +594,12 @@ static int __devinit via_pci_probe(struct pci_dev *pdev,
>  	global_dev.pdev = pdev;
>  	global_dev.chip_type = ent->driver_data;
>  	global_dev.port_cfg = adap_configs;
> +
> +#ifdef CONFIG_OLPC
> +	if (machine_is_olpc())
> +		global_dev.port_cfg = olpc_adap_configs;
> +#endif
> +
>  	spin_lock_init(&global_dev.reg_lock);
>  	ret = via_pci_setup_mmio(&global_dev);
>  	if (ret)

