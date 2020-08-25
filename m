From: Mathieu Malaterre <malat@debian.org>
Date: Tue, 25 Aug 2020 07:47:56 +0000
Subject: Re: [PATCH] video: fbdev: radeon: Fix memleak in radeonfb_pci_register
Message-Id: <CA+7wUswtuOPqQ131F5LdH=7dH+sWZc+jmMHXpaYmTDUehvx5eQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200825062900.11210-1-dinghao.liu@zju.edu.cn>
In-Reply-To: <20200825062900.11210-1-dinghao.liu@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, kjlu@umn.edu, LKML <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>

On Tue, Aug 25, 2020 at 9:27 AM Dinghao Liu <dinghao.liu@zju.edu.cn> wrote:
>
> When radeon_kick_out_firmware_fb() fails, info should be
> freed just like the subsequent error paths.
>
> Fixes: 069ee21a82344 ("fbdev: Fix loading of module radeonfb on PowerMac")
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
>  drivers/video/fbdev/aty/radeon_base.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/video/fbdev/aty/radeon_base.c b/drivers/video/fbdev/aty/radeon_base.c
> index 3fe509cb9b87..13bd2bd5c043 100644
> --- a/drivers/video/fbdev/aty/radeon_base.c
> +++ b/drivers/video/fbdev/aty/radeon_base.c
> @@ -2307,7 +2307,7 @@ static int radeonfb_pci_register(struct pci_dev *pdev,
>
>         ret = radeon_kick_out_firmware_fb(pdev);
>         if (ret)
> -               return ret;
> +               goto err_release_fb;

Good catch ! Thanks

Reviewed-by: Mathieu Malaterre <malat@debian.org>

>         /* request the mem regions */
>         ret = pci_request_region(pdev, 0, "radeonfb framebuffer");
> --
> 2.17.1
>
