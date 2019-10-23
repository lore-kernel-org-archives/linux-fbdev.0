From: "hch@lst.de" <hch@lst.de>
Date: Wed, 23 Oct 2019 09:10:37 +0000
Subject: Re: [PATCH] video: hyperv: hyperv_fb: Use physical memory for fb on HyperV Gen 1 VMs.
Message-Id: <20191023091037.GB21910@lst.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191022110905.4032-1-weh@microsoft.com>
In-Reply-To: <20191022110905.4032-1-weh@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Wei Hu <weh@microsoft.com>
Cc: "b.zolnierkie@samsung.com" <b.zolnierkie@samsung.com>, KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, "sashal@kernel.org" <sashal@kernel.org>, "hch@lst.de" <hch@lst.de>, "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>, "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>, "sam@ravnborg.org" <sam@ravnborg.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>, "info@metux.net" <info@metux.net>, "arnd@arndb.de" <arnd@arndb.de>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, linux-kernel@vger.k

> +	select DMA_CMA

Th=D1=96s needs to be

	select DMA_CMA if HAVE_DMA_CONTIGUOUS

> +#include <linux/dma-contiguous.h>

> +	/* Allocate from CMA */
> +	// request_pages =3D (request_size >> PAGE_SHIFT) + 1;
> +	request_pages =3D (round_up(request_size, PAGE_SIZE) >> PAGE_SHIFT);
> +	page =3D dma_alloc_from_contiguous(NULL, request_pages, 0, false);

dma_alloc_from_contiguous is an internal helper, you must use it
through dma_alloc_coherent and pass a struct device to that function.

> +	if (!gen2vm) {
> +		pdev =3D pci_get_device(PCI_VENDOR_ID_MICROSOFT,
> +			PCI_DEVICE_ID_HYPERV_VIDEO, NULL);
> +		if (!pdev) {
> +			pr_err("Unable to find PCI Hyper-V video\n");
> +			return -ENODEV;
> +		}
> +	}

Please actually implement a pci_driver instead of hacks like this.

> +			par->need_docopy =3D false;
> +			goto getmem1;
> +		} else {

No need for an else after a goto.
