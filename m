From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 13 Aug 2019 12:48:32 +0000
Subject: Re: [PATCH 6/7] efifb: Use PCI_STD_NUM_BARS in loops instead of PCI_STD_RESOURCE_END
Message-Id: <6c4e491c-8afd-92b0-45b5-d915de399ccc@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190811150802.2418-1-efremov@linux.com>
        <CGME20190811151322epcas3p283d7a3293a12dfac23d13d8a16349d1f@epcas3p2.samsung.com>
        <20190811150802.2418-7-efremov@linux.com>
In-Reply-To: <20190811150802.2418-7-efremov@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Denis Efremov <efremov@linux.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Peter Jones <pjones@redhat.com>, linux-fbdev@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org


On 8/11/19 5:08 PM, Denis Efremov wrote:
> This patch refactors the loop condition scheme from
> 'i <= PCI_STD_RESOURCE_END' to 'i < PCI_STD_NUM_BARS'.
> 
> Signed-off-by: Denis Efremov <efremov@linux.com>

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

> ---
>  drivers/video/fbdev/efifb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
> index 04a22663b4fb..6c72b825e92a 100644
> --- a/drivers/video/fbdev/efifb.c
> +++ b/drivers/video/fbdev/efifb.c
> @@ -668,7 +668,7 @@ static void efifb_fixup_resources(struct pci_dev *dev)
>  	if (!base)
>  		return;
>  
> -	for (i = 0; i <= PCI_STD_RESOURCE_END; i++) {
> +	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
>  		struct resource *res = &dev->resource[i];
>  
>  		if (!(res->flags & IORESOURCE_MEM))

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
