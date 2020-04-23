From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 23 Apr 2020 21:23:31 +0000
Subject: Re: [PATCH v3] console: newport_con: fix an issue about leak related system resources
Message-Id: <CAHp75VdSv4AooA-hrgoQH-qs_8woFbzHJH99AKrYUrwae7xoZQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200423164251.3349-1-zhengdejin5@gmail.com>
In-Reply-To: <20200423164251.3349-1-zhengdejin5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dejin Zheng <zhengdejin5@gmail.com>
Cc: akpm@osdl.org, linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Thomas Gleixner <tglx@linutronix.de>

On Thu, Apr 23, 2020 at 7:42 PM Dejin Zheng <zhengdejin5@gmail.com> wrote:
>
> A call of the function do_take_over_console() can fail here.
> The corresponding system resources were not released then.
> Thus add a call of iounmap() and release_mem_region()
> together with the check of a failure predicate. and also
> add release_mem_region() on device removal.

FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Fixes: e86bb8acc0fdc ("[PATCH] VT binding: Make newport_con support binding")
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Suggested-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
> ---
> v2 -> v3:
>         - modify commit tag CC to Cc by Andy's suggestion.
>         - modify Subject 'console: console:' to 'console: newport_con:'
>           by Bartlomiej's suggestion.
>         - add missing release_mem_region() on error and on device removal
>           by Bartlomiej's suggestion.
>         - add correct fixes commit, before this patch, add a wrong 'Fixes:
>           e84de0c6190503 ("MIPS: GIO bus support for SGI IP22/28")'
>           thanks Bartlomiej again!
>
> v1 -> v2:
>         - modify the commit comments. The commit comments have some more
>           appropriate instructions by Markus'suggestion. here is my first
>           version commit comments:
>
>           if do_take_over_console() return an error in the newport_probe(),
>           due to the io virtual address is not released, it will cause a
>           leak.
>
>  drivers/video/console/newport_con.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/video/console/newport_con.c b/drivers/video/console/newport_con.c
> index 00dddf6e08b0..2d2ee17052e8 100644
> --- a/drivers/video/console/newport_con.c
> +++ b/drivers/video/console/newport_con.c
> @@ -32,6 +32,8 @@
>  #include <linux/linux_logo.h>
>  #include <linux/font.h>
>
> +#define NEWPORT_LEN    0x10000
> +
>  #define FONT_DATA ((unsigned char *)font_vga_8x16.data)
>
>  /* borrowed from fbcon.c */
> @@ -43,6 +45,7 @@
>  static unsigned char *font_data[MAX_NR_CONSOLES];
>
>  static struct newport_regs *npregs;
> +static unsigned long newport_addr;
>
>  static int logo_active;
>  static int topscan;
> @@ -702,7 +705,6 @@ const struct consw newport_con = {
>  static int newport_probe(struct gio_device *dev,
>                          const struct gio_device_id *id)
>  {
> -       unsigned long newport_addr;
>         int err;
>
>         if (!dev->resource.start)
> @@ -712,7 +714,7 @@ static int newport_probe(struct gio_device *dev,
>                 return -EBUSY; /* we only support one Newport as console */
>
>         newport_addr = dev->resource.start + 0xF0000;
> -       if (!request_mem_region(newport_addr, 0x10000, "Newport"))
> +       if (!request_mem_region(newport_addr, NEWPORT_LEN, "Newport"))
>                 return -ENODEV;
>
>         npregs = (struct newport_regs *)/* ioremap cannot fail */
> @@ -720,6 +722,11 @@ static int newport_probe(struct gio_device *dev,
>         console_lock();
>         err = do_take_over_console(&newport_con, 0, MAX_NR_CONSOLES - 1, 1);
>         console_unlock();
> +
> +       if (err) {
> +               iounmap((void *)npregs);
> +               release_mem_region(newport_addr, NEWPORT_LEN);
> +       }
>         return err;
>  }
>
> @@ -727,6 +734,7 @@ static void newport_remove(struct gio_device *dev)
>  {
>         give_up_console(&newport_con);
>         iounmap((void *)npregs);
> +       release_mem_region(newport_addr, NEWPORT_LEN);
>  }
>
>  static struct gio_device_id newport_ids[] = {
> --
> 2.25.0
>


-- 
With Best Regards,
Andy Shevchenko
