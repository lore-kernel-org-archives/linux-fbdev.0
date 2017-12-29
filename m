From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 29 Dec 2017 17:53:29 +0000
Subject: Re: [PATCH] video/fbdev/vt8500lcdfb: Delete an error message for a failed memory allocation in vt850
Message-Id: <3740850.4D0mjicDMo@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20171124195318epcas2p1b030ce8d47da92659b3c6068c0810778@epcas2p1.samsung.com>
 <d229eccd-ab20-d594-caa1-55fb464357ac@users.sourceforge.net>
In-Reply-To: <d229eccd-ab20-d594-caa1-55fb464357ac@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-fbdev@vger.kernel.org, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, Tony Prisk <linux@prisktech.co.nz>, linux-arm-kernel@lists.infradead.org

On Friday, November 24, 2017 08:53:02 PM SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 24 Nov 2017 20:42:08 +0100
> 
> Omit an extra message for a memory allocation failure in this function.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/video/fbdev/vt8500lcdfb.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/video/fbdev/vt8500lcdfb.c b/drivers/video/fbdev/vt8500lcdfb.c
> index 1a1176bf0906..5c5cd2923041 100644
> --- a/drivers/video/fbdev/vt8500lcdfb.c
> +++ b/drivers/video/fbdev/vt8500lcdfb.c
> @@ -289,10 +289,8 @@ static int vt8500lcd_probe(struct platform_device *pdev)
>  
>  	fbi = devm_kzalloc(&pdev->dev, sizeof(struct vt8500lcd_info)
>  			+ sizeof(u32) * 16, GFP_KERNEL);
> -	if (!fbi) {
> -		dev_err(&pdev->dev, "Failed to initialize framebuffer device\n");
> +	if (!fbi)
>  		return -ENOMEM;
> -	}
>  

This removes the information about the device for which the allocation
fails (but as there can be only one vt8500lcdfb device in the system this
change is okay).

Patch queued for 4.16, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

