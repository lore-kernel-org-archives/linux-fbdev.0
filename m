From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 21 Aug 2020 13:38:49 +0000
Subject: Re: [PATCH] video: fbdev: controlfb: Fix build for COMPILE_TEST=y && PPC_PMAC=n
Message-Id: <cd4324bb-67f7-5ae0-af7b-42681d72d85f@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20200821104924eucas1p1e4b848e88fe460b9b7063669714a36f3@eucas1p1.samsung.com>
 <20200821104910.3363818-1-mpe@ellerman.id.au>
In-Reply-To: <20200821104910.3363818-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-fbdev@vger.kernel.org, daniel.vetter@ffwll.ch, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linuxppc-dev@ozlabs.org, sam@ravnborg.org


On 8/21/20 12:49 PM, Michael Ellerman wrote:
> The build is currently broken, if COMPILE_TEST=y and PPC_PMAC=n:
> 
>   linux/drivers/video/fbdev/controlfb.c: In function ‘control_set_hardware’:
>   linux/drivers/video/fbdev/controlfb.c:276:2: error: implicit declaration of function ‘btext_update_display’
>     276 |  btext_update_display(p->frame_buffer_phys + CTRLFB_OFF,
>         |  ^~~~~~~~~~~~~~~~~~~~
> 
> Fix it by including btext.h whenever CONFIG_BOOTX_TEXT is enabled.
> 
> Fixes: a07a63b0e24d ("video: fbdev: controlfb: add COMPILE_TEST support")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Thanks for fixing this.

> ---
>  drivers/video/fbdev/controlfb.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> Does anyone mind if I apply this via the powerpc tree for v5.9?
> 
> It would be nice to get the build clean.

No objections from my side.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> cheers
> 
> diff --git a/drivers/video/fbdev/controlfb.c b/drivers/video/fbdev/controlfb.c
> index 9c4f1be856ec..547abeb39f87 100644
> --- a/drivers/video/fbdev/controlfb.c
> +++ b/drivers/video/fbdev/controlfb.c
> @@ -49,6 +49,8 @@
>  #include <linux/cuda.h>
>  #ifdef CONFIG_PPC_PMAC
>  #include <asm/prom.h>
> +#endif
> +#ifdef CONFIG_BOOTX_TEXT
>  #include <asm/btext.h>
>  #endif
>  
