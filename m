From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Mon, 30 Jan 2012 05:25:04 +0000
Subject: Re: [patch v2] intelfb: remove some dead code
Message-Id: <4F2629B0.1020904@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20120127125833.GD3356@mwanda>
In-Reply-To: <20120127125833.GD3356@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 01/27/2012 12:58 PM, Dan Carpenter wrote:
> The goto on the line before means the return is unreachable.  The goto
> also returns -ENODEV so no changes are needed there.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied.


Thanks,

Florian Tobias Schandinat

> ---
> v2: fixed a typo in the commit message
> 
> diff --git a/drivers/video/intelfb/intelfbdrv.c b/drivers/video/intelfb/intelfbdrv.c
> index c6afa33..02fd226 100644
> --- a/drivers/video/intelfb/intelfbdrv.c
> +++ b/drivers/video/intelfb/intelfbdrv.c
> @@ -529,7 +529,6 @@ static int __devinit intelfb_pci_register(struct pci_dev *pdev,
>  	if (fb_alloc_cmap(&info->cmap, 256, 1) < 0) {
>  		ERR_MSG("Could not allocate cmap for intelfb_info.\n");
>  		goto err_out_cmap;
> -		return -ENODEV;
>  	}
>  
>  	dinfo = info->par;
> 

