From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [Linux-fbdev-devel] [PATCH 3/9] viafb: VIA Frame Buffer Device
 Driver
Date: Wed, 7 May 2008 16:28:20 +0100
Message-ID: <20080507162820.4ecd1b55@core>
References: <C80EF34A3D2E494DBAF9AC29C7AE4EB806F67754@exchtp03.taipei.via.com.tw>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762012AbYEGPiz@vger.kernel.org>
In-Reply-To: <C80EF34A3D2E494DBAF9AC29C7AE4EB806F67754@exchtp03.taipei.via.com.tw>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Cc: JosephChan@via.com.tw, akpm@linux-foundation.org, geert@linux-m68k.org, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

> +	/* Indentify GFX Chip Name */
> +	pdev =
> +	    (struct pci_dev *)pci_get_device(PCI_VIA_VENDOR_ID,
> +					     UNICHROME_CLE266_DID, NULL);
> +	if (pdev != NULL)
> +		chip_info.gfx_chip_name = UNICHROME_CLE266;
> +
> +	pdev =
> +	    (struct pci_dev *)pci_get_device(PCI_VIA_VENDOR_ID,
> +					     UNICHROME_K400_DID, NULL);

pci_get_device takes a reference so you need to do a pci_dev_put() on the
result if you have finished with it. Alternatively you could make use of
pci_dev_present()

> +	case UNICHROME_CLE266:
> +		pdev =
> +		    (struct pci_dev *)pci_get_device(PCI_VIA_VENDOR_ID,
> +						     UNICHROME_CLE266_DID,

Similar issue here.


> +void get_fb_info(unsigned int *fb_base, unsigned int *fb_len)
> +{
> +	struct pci_dev *pdev = NULL;
> +
> +	switch (chip_info.gfx_chip_name) {
> +	case UNICHROME_CLE266:
> +		pdev =
> +		    (struct pci_dev *)pci_get_device(PCI_VIA_VENDOR_ID,
> +						     UNICHROME_CLE266_DID,
> +						     NULL);

And here

So it might be better to for example use an array of types and keep the
array reference in the probe function pci_device_id field (which is how a
lot of stuff like libata drivers avoid doing messy lookups)
