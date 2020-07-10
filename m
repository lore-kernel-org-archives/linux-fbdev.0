From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 10 Jul 2020 14:23:48 +0000
Subject: Re: [PATCH] video: fbdev: neofb: fix memory leak in neo_scan_monitor()
Message-Id: <c07a27c2-3171-3f3a-6029-ef523cf889c4@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20200630195458eucas1p2fc508a96f648c8af44d5ed5ff906a103@eucas1p2.samsung.com>
 <20200630195451.18675-1-novikov@ispras.ru>
In-Reply-To: <20200630195451.18675-1-novikov@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Evgeny Novikov <novikov@ispras.ru>
Cc: ldv-project@linuxtesting.org, linux-fbdev@vger.kernel.org, Jani Nikula <jani.nikula@intel.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Mike Rapoport <rppt@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>


On 6/30/20 9:54 PM, Evgeny Novikov wrote:
> neofb_probe() calls neo_scan_monitor() that can successfully allocate a
> memory for info->monspecs.modedb and proceed to case 0x03. There it does
> not free the memory and returns -1. neofb_probe() goes to label
> err_scan_monitor, thus, it does not free this memory through calling
> fb_destroy_modedb() as well. We can not go to label err_init_hw since
> neo_scan_monitor() can fail during memory allocation. So, the patch frees
> the memory directly for case 0x03.
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
>  drivers/video/fbdev/neofb.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/video/fbdev/neofb.c b/drivers/video/fbdev/neofb.c
> index f5a676bfd67a..09a20d4ab35f 100644
> --- a/drivers/video/fbdev/neofb.c
> +++ b/drivers/video/fbdev/neofb.c
> @@ -1819,6 +1819,7 @@ static int neo_scan_monitor(struct fb_info *info)
>  #else
>  		printk(KERN_ERR
>  		       "neofb: Only 640x480, 800x600/480 and 1024x768 panels are currently supported\n");
> +		kfree(info->monspecs.modedb);
>  		return -1;
>  #endif
>  	default:
> 
