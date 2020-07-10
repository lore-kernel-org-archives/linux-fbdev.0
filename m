From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 10 Jul 2020 14:24:05 +0000
Subject: Re: [PATCH] fbdev: sm712fb: set error code in probe
Message-Id: <6f500a1e-96d8-2238-ad26-99a39dca61ec@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20200706155341eucas1p2081ccd8bd81c097272e13e7fe84244ee@eucas1p2.samsung.com>
 <20200706155328.8396-1-novikov@ispras.ru>
In-Reply-To: <20200706155328.8396-1-novikov@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Evgeny Novikov <novikov@ispras.ru>
Cc: ldv-project@linuxtesting.org, linux-fbdev@vger.kernel.org, Teddy Wang <teddy.wang@siliconmotion.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>


On 7/6/20 5:53 PM, Evgeny Novikov wrote:
> If smtcfb_pci_probe() does not detect a valid chip it cleans up
> everything and returns 0. This can result in various bad things later.
> The patch sets the error code on the corresponding path.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Evgeny Novikov <novikov@ispras.ru>

Applied to drm-misc-next tree, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/video/fbdev/sm712fb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/sm712fb.c b/drivers/video/fbdev/sm712fb.c
> index 6a1b4a853d9e..fbe97340b8e0 100644
> --- a/drivers/video/fbdev/sm712fb.c
> +++ b/drivers/video/fbdev/sm712fb.c
> @@ -1614,7 +1614,7 @@ static int smtcfb_pci_probe(struct pci_dev *pdev,
>  	default:
>  		dev_err(&pdev->dev,
>  			"No valid Silicon Motion display chip was detected!\n");
> -
> +		err = -ENODEV;
>  		goto failed_fb;
>  	}
>  
> 
