From: Alexander Shishkin <virtuoso@slind.org>
Date: Mon, 05 Apr 2010 20:54:17 +0000
Subject: Re: [PATCH] mb862xxfb: fix acceleration module license
Message-Id: <20100405205417.GH30660@shisha.kicks-ass.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20100402115738.b7adabf0.randy.dunlap@oracle.com>
In-Reply-To: <20100402115738.b7adabf0.randy.dunlap@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Fri, Apr 02, 2010 at 11:57:38 -0700, Randy Dunlap wrote:

(adding Valentin's new email address to the loop)

> From: Randy Dunlap <randy.dunlap@oracle.com>
> 
> mb862xxfb_accel built as a separate module, but it does not
> have a MODULE_LICENSE, so it taints the kernel.  Add a
> MODULE_LICENSE to it (same as mb862xxfb license).
> 
> mb862xxfb_accel: module license 'unspecified' taints kernel.
> 
> or should mb862xxfb_accel be built into the mb862xxfb
> binary file instead?

It's ok to have this licensed GPLv2 as far I'm concerned. Valentin,
what do you say?

> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
> Cc: Alexander Shishkin <virtuoso@slind.org>
> Cc: Valentin Sitdikov <valentin.sitdikov@siemens.com>

Acked-by: Alexander Shishkin <virtuoso@slind.org>

> ---
>  drivers/video/mb862xx/mb862xxfb_accel.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> --- lnx-2634-rc3.orig/drivers/video/mb862xx/mb862xxfb_accel.c
> +++ lnx-2634-rc3/drivers/video/mb862xx/mb862xxfb_accel.c
> @@ -16,6 +16,7 @@
>  #include <linux/delay.h>
>  #include <linux/init.h>
>  #include <linux/interrupt.h>
> +#include <linux/module.h>
>  #include <linux/pci.h>
>  #if defined(CONFIG_OF)
>  #include <linux/of_platform.h>
> @@ -329,3 +330,5 @@ void mb862xxfb_init_accel(struct fb_info
>  	info->fix.accel = 0xff;	/*FIXME: add right define */
>  }
>  EXPORT_SYMBOL(mb862xxfb_init_accel);
> +
> +MODULE_LICENSE("GPL v2");
