From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Sun, 13 May 2012 20:50:50 +0000
Subject: Re: [PATCH] drivers/video/intelfb/intelfbdrv.c: add missing agp_backend_release
Message-Id: <4FB01EAA.8040504@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1334854553-30067-1-git-send-email-Julia.Lawall@lip6.fr>
In-Reply-To: <1334854553-30067-1-git-send-email-Julia.Lawall@lip6.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Maik Broemme <mbroemme@plusserver.de>, kernel-janitors@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On 04/19/2012 04:55 PM, Julia Lawall wrote:
> From: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> Release bridge, as done on all other paths out of the function.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Looks good to me, applied.


Thanks,

Florian Tobias Schandinat

> 
> ---
>  drivers/video/intelfb/intelfbdrv.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/video/intelfb/intelfbdrv.c b/drivers/video/intelfb/intelfbdrv.c
> index 02fd226..bdcbfba 100644
> --- a/drivers/video/intelfb/intelfbdrv.c
> +++ b/drivers/video/intelfb/intelfbdrv.c
> @@ -680,6 +680,7 @@ static int __devinit intelfb_pci_register(struct pci_dev *pdev,
>  		 + dinfo->fb.size);
>  	if (!dinfo->aperture.virtual) {
>  		ERR_MSG("Cannot remap FB region.\n");
> +		agp_backend_release(bridge);
>  		cleanup(dinfo);
>  		return -ENODEV;
>  	}
> @@ -689,6 +690,7 @@ static int __devinit intelfb_pci_register(struct pci_dev *pdev,
>  					      INTEL_REG_SIZE);
>  	if (!dinfo->mmio_base) {
>  		ERR_MSG("Cannot remap MMIO region.\n");
> +		agp_backend_release(bridge);
>  		cleanup(dinfo);
>  		return -ENODEV;
>  	}
> 
> 

