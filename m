From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Date: Tue, 20 Apr 2010 09:17:10 +0000
Subject: RE: [PATCH] fbdev: move FBIO_WAITFORVSYNC to linux/fb.h
Message-Id: <19F8576C6E063C45BE387C64729E7394044E137897@dbde02.ent.ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1271429829-23577-1-git-send-email-notasas@gmail.com>
In-Reply-To: <1271429829-23577-1-git-send-email-notasas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org


> -----Original Message-----
> From: linux-fbdev-owner@vger.kernel.org [mailto:linux-fbdev-
> owner@vger.kernel.org] On Behalf Of Grazvydas Ignotas
> Sent: Friday, April 16, 2010 8:27 PM
> To: linux-fbdev@vger.kernel.org
> Cc: Andrew Morton; Grazvydas Ignotas
> Subject: [PATCH] fbdev: move FBIO_WAITFORVSYNC to linux/fb.h
> 
> FBIO_WAITFORVSYNC is currently implemented by matroxfb, atyfb, intelfb
> and more. All of them keep redefining the same FBIO_WAITFORVSYNC macro
> over and over again, so move it to linux/fb.h and clean up those
> duplicate defines.
[Hiremath, Vaibhav] Thanks Grazvydas,

I was about to submit the patch for this. I think we need this ioctl tobe supported in standard FBDEV.

Minor comments in-lined below - 


> 
> Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
> ---
>  drivers/video/aty/atyfb_base.c        |    4 ----
>  drivers/video/intelfb/intelfb.h       |    4 ----
>  drivers/video/matrox/matroxfb_base.c  |    1 +
>  drivers/video/matrox/matroxfb_crtc2.c |    1 +
>  include/linux/fb.h                    |    2 ++
>  include/linux/ivtvfb.h                |    1 -
>  include/linux/matroxfb.h              |    2 --
>  include/video/sh_mobile_lcdc.h        |    2 --
>  8 files changed, 4 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_base.c
> index 29d7285..f8d69ad 100644
> --- a/drivers/video/aty/atyfb_base.c
> +++ b/drivers/video/aty/atyfb_base.c
> @@ -1820,10 +1820,6 @@ struct atyclk {
>  #define ATYIO_FEATW		0x41545903	/* ATY\03 */
>  #endif
> 
> -#ifndef FBIO_WAITFORVSYNC
> -#define FBIO_WAITFORVSYNC _IOW('F', 0x20, __u32)
> -#endif
> -
>  static int atyfb_ioctl(struct fb_info *info, u_int cmd, u_long arg)
>  {
>  	struct atyfb_par *par = (struct atyfb_par *) info->par;
> diff --git a/drivers/video/intelfb/intelfb.h
> b/drivers/video/intelfb/intelfb.h
> index 4098455..6b51175 100644
> --- a/drivers/video/intelfb/intelfb.h
> +++ b/drivers/video/intelfb/intelfb.h
> @@ -371,10 +371,6 @@ struct intelfb_info {
>  			((dinfo)->chipset = INTEL_965G) ||	\
>  			((dinfo)->chipset = INTEL_965GM))
> 
> -#ifndef FBIO_WAITFORVSYNC
> -#define FBIO_WAITFORVSYNC	_IOW('F', 0x20, __u32)
> -#endif
> -
>  /*** function prototypes ***/
> 
>  extern int intelfb_var_to_depth(const struct fb_var_screeninfo *var);
> diff --git a/drivers/video/matrox/matroxfb_base.c
> b/drivers/video/matrox/matroxfb_base.c
> index 052dd9f..3a09978 100644
> --- a/drivers/video/matrox/matroxfb_base.c
> +++ b/drivers/video/matrox/matroxfb_base.c
> @@ -112,6 +112,7 @@
>  #include "matroxfb_crtc2.h"
>  #include "matroxfb_g450.h"
>  #include <linux/matroxfb.h>
> +#include <linux/fb.h>
>  #include <linux/interrupt.h>
>  #include <linux/slab.h>
>  #include <linux/uaccess.h>
> diff --git a/drivers/video/matrox/matroxfb_crtc2.c
> b/drivers/video/matrox/matroxfb_crtc2.c
> index d7112c3..aeb4e23 100644
> --- a/drivers/video/matrox/matroxfb_crtc2.c
> +++ b/drivers/video/matrox/matroxfb_crtc2.c
> @@ -15,6 +15,7 @@
>  #include "matroxfb_misc.h"
>  #include "matroxfb_DAC1064.h"
>  #include <linux/matroxfb.h>
> +#include <linux/fb.h>
>  #include <linux/slab.h>
>  #include <linux/uaccess.h>
> 
> diff --git a/include/linux/fb.h b/include/linux/fb.h
> index c10163b..c99a809 100644
> --- a/include/linux/fb.h
> +++ b/include/linux/fb.h
> @@ -23,6 +23,8 @@ struct dentry;
>  #else
>  #define FBIO_CURSOR            _IOWR('F', 0x08, struct fb_cursor)
>  #endif
> +#define FBIO_WAITFORVSYNC	_IOW('F', 0x20, __u32)
> +
[Hiremath, Vaibhav] Do not insert it in middle, lets follow the sequence and append it at last. Otherwise looks ok to me.

We should merge this patch.

There are some other drivers (like OMAP) which define WAITFORVSYNC ioctl with custom (OMAPFB_WAITFORVSYNC) way needs to be changed for this. 

I will change them and submit it to list.


Thanks,
Vaibhav

>  /* 0x4607-0x460B are defined below */
>  /* #define FBIOGET_MONITORSPEC	0x460C */
>  /* #define FBIOPUT_MONITORSPEC	0x460D */
> diff --git a/include/linux/ivtvfb.h b/include/linux/ivtvfb.h
> index 9d88b29..e8b92f6 100644
> --- a/include/linux/ivtvfb.h
> +++ b/include/linux/ivtvfb.h
> @@ -33,6 +33,5 @@ struct ivtvfb_dma_frame {
>  };
> 
>  #define IVTVFB_IOC_DMA_FRAME 	_IOW('V', BASE_VIDIOC_PRIVATE+0, struct
> ivtvfb_dma_frame)
> -#define FBIO_WAITFORVSYNC	_IOW('F', 0x20, __u32)
> 
>  #endif
> diff --git a/include/linux/matroxfb.h b/include/linux/matroxfb.h
> index 2203121..98b1374 100644
> --- a/include/linux/matroxfb.h
> +++ b/include/linux/matroxfb.h
> @@ -37,7 +37,5 @@ enum matroxfb_ctrl_id {
>    MATROXFB_CID_LAST
>  };
> 
> -#define FBIO_WAITFORVSYNC	_IOW('F', 0x20, __u32)
> -
>  #endif
> 
> diff --git a/include/video/sh_mobile_lcdc.h b/include/video/sh_mobile_lcdc.h
> index 2cc893f..2882054 100644
> --- a/include/video/sh_mobile_lcdc.h
> +++ b/include/video/sh_mobile_lcdc.h
> @@ -34,8 +34,6 @@ enum { LCDC_CLK_BUS, LCDC_CLK_PERIPHERAL,
> LCDC_CLK_EXTERNAL };
>  #define LCDC_FLAGS_HSCNT (1 << 3) /* Disable HSYNC during VBLANK */
>  #define LCDC_FLAGS_DWCNT (1 << 4) /* Disable dotclock during blanking */
> 
> -#define FBIO_WAITFORVSYNC _IOW('F', 0x20, __u32)
> -
>  struct sh_mobile_lcdc_sys_bus_cfg {
>  	unsigned long ldmt2r;
>  	unsigned long ldmt3r;
> --
> 1.6.3.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
