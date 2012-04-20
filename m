From: Jingoo Han <jg1.han@samsung.com>
Date: Fri, 20 Apr 2012 04:52:29 +0000
Subject: RE: [PATCH] blackfin: fix compile error in bfin-lq035q1-fb.c
Message-Id: <003201cd1eb1$63ef6350$2bce29f0$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1334803401-26780-1-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <1334803401-26780-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org



> -----Original Message-----
> From: linux-fbdev-owner@vger.kernel.org [mailto:linux-fbdev-owner@vger.kernel.org] On Behalf Of Paul
> Gortmaker
> Sent: Thursday, April 19, 2012 11:43 AM
> To: linux-fbdev@vger.kernel.org
> Cc: uclinux-dist-devel@blackfin.uclinux.org; Paul Gortmaker; Florian Tobias Schandinat; Mike Frysinger
> Subject: [PATCH] blackfin: fix compile error in bfin-lq035q1-fb.c
> 
> This file has an implicit dependency on GPIO stuff, showing
> up as the following build failure:
> 
> drivers/video/bfin-lq035q1-fb.c:369:6: error: 'GPIOF_OUT_INIT_LOW' undeclared
> 
> Other more global bfin build issues prevent an automated bisect, but
> it really doesn't matter - simply add in the appropriate header.
> 
> Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
> Cc: Mike Frysinger <vapier@gentoo.org>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Acked-by: Jingoo Han <jg1.han@samsung.com>

It looks good.
This header file 'linux/gpio.h' is necessary for using 'GPIOF_OUT_INIT_LOW'.

> 
> diff --git a/drivers/video/bfin-lq035q1-fb.c b/drivers/video/bfin-lq035q1-fb.c
> index 86922ac..353c02f 100644
> --- a/drivers/video/bfin-lq035q1-fb.c
> +++ b/drivers/video/bfin-lq035q1-fb.c
> @@ -13,6 +13,7 @@
>  #include <linux/errno.h>
>  #include <linux/string.h>
>  #include <linux/fb.h>
> +#include <linux/gpio.h>
>  #include <linux/slab.h>
>  #include <linux/init.h>
>  #include <linux/types.h>
> --
> 1.7.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

