From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Date: Thu, 29 Apr 2010 18:19:02 +0000
Subject: Re: [PATCH 13/30] viafb: Separate global and fb-specific data
Message-Id: <20100429201902.6379f8d3@neptune.home>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1272493051-25380-1-git-send-email-corbet@lwn.net>
	<1272493051-25380-14-git-send-email-corbet@lwn.net>
In-Reply-To: <1272493051-25380-14-git-send-email-corbet@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, Harald Welte <laforge@gnumonks.org>, linux-fbdev@vger.kernel.org, JosephChan@via.com.tw, ScottFang@viatech.com.cn, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

On Wed, 28 April 2010 Jonathan Corbet <corbet@lwn.net> wrote:
> diff --git a/drivers/video/via/via-core.c b/drivers/video/via/via-core.c
> index cda4de4..6f8f8e2 100644
> --- a/drivers/video/via/via-core.c
> +++ b/drivers/video/via/via-core.c

<snip>

> +/*
> + * Figure out and map our MMIO regions.
> + */
> +static int __devinit via_pci_setup_mmio(struct viafb_dev *vdev)
> +{
> +	/*
> +	 * Hook up to the device registers.
> +	 */
> +	vdev->engine_start = pci_resource_start(vdev->pdev, 1);
> +	vdev->engine_len = pci_resource_len(vdev->pdev, 1);
> +	/* If this fails, others will notice later */
> +	vdev->engine_mmio = ioremap_nocache(vdev->engine_start,
> +			vdev->engine_len);

Shouldn't this ioremap_nocache() have error-checking
as the one below (instead of relying on later code to bail out)?

> +
> +	/*
> +	 * Likewise with I/O memory.
> +	 */
> +	vdev->fbmem_start = pci_resource_start(vdev->pdev, 0);
> +	vdev->fbmem_len = viafb_get_fb_size_from_pci(vdev->chip_type);
> +	if (vdev->fbmem_len < 0)
> +		return vdev->fbmem_len;
> +	vdev->fbmem = ioremap_nocache(vdev->fbmem_start, vdev->fbmem_len);
> +	if (vdev->fbmem = NULL)
> +		return -ENOMEM;

IMHO it would be better to iounmap(vdev->engine_mmio) here
instead of letting our caller run via_pci_teardown_mmio()

> +	return 0;
> +}
> +
> +static void __devexit via_pci_teardown_mmio(struct viafb_dev *vdev)
> +{
> +	iounmap(vdev->fbmem);
> +	iounmap(vdev->engine_mmio);
> +}
> +
> 
> static int __devinit via_pci_probe(struct pci_dev *pdev,
> 		const struct pci_device_id *ent)
> @@ -33,9 +199,19 @@ static int __devinit via_pci_probe(struct pci_dev *pdev,
>  	if (ret)
>  		return ret;
>  	/*
> +	 * Global device initialization.
> +	 */
> +	memset(&global_dev, 0, sizeof(global_dev));
> +	global_dev.pdev = pdev;
> +	global_dev.chip_type = ent->driver_data;
> +	spin_lock_init(&global_dev.reg_lock);
> +	ret = via_pci_setup_mmio(&global_dev);
> +	if (ret)
> +		goto out_teardown;

Why goto out_teardown here?
If via_pci_setup_mmio() failed it should undo its successful
actions itself... (see also above)

> +	/*
>  	 * Set up subsidiary devices
>  	 */
> -	ret = via_fb_pci_probe(pdev, ent);
> +	ret = via_fb_pci_probe(&global_dev);
>  	if (ret)
>  		return ret;

In this case we should goto out_teardown so the mmio setup earlier gets
undone.

>  	/*
> @@ -48,12 +224,17 @@ static int __devinit via_pci_probe(struct pci_dev *pdev,
>  		return ret;
>  	}
>  	return 0;
> +
> +out_teardown:
> +	via_pci_teardown_mmio(&global_dev);
> +	return ret;
>  }

Thanks,
Bruno
